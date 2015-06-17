//
//  DataManager.m
//  MOCDeadLock
//
//  Created by shuning zhou on 2015-06-15.
//  Copyright (c) 2015 Intrahealth. All rights reserved.
//

#import "DataManager.h"

static NSPersistentStoreCoordinator *sPersistentStoreCoordinator;

@interface DataManager ()

-(NSPersistentStoreCoordinator*) persistentStoreCoordinator;
@property (nonatomic) NSManagedObjectModel *managedObjectModel;
@property (nonatomic, readwrite) NSManagedObjectContext *managedObjectContext;

@end


@implementation DataManager

- (void)removeMOC;
{
    [[[NSThread currentThread] threadDictionary] removeObjectForKey:@"DataManager"];
}

- (id)initWithName:(NSString*)name;
{
    self = [super init];
    
    if (self)
    {  
        self.name = name;
        [self managedObjectContext];
        
    }
    return self;
}

- (void)dealloc;
{
    NSLog(@"Removing dataManager %@", self.name);
}

- (NSManagedObjectContext *) managedObjectContext;
{
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    
    if (coordinator != nil)
    {
        
        _managedObjectContext = [NSManagedObjectContext new];
        
        [_managedObjectContext setPersistentStoreCoordinator: coordinator];
        [_managedObjectContext setMergePolicy:NSMergeByPropertyObjectTrumpMergePolicy];
    }
    
    return _managedObjectContext;
}

- (NSManagedObjectModel *)managedObjectModel;
{
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"MOCDeadLock" withExtension:@"momd"];
    
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    
    return _managedObjectModel;
}

- (NSURL *)applicationDocumentsDirectory {
    // The directory the application uses to store the Core Data store file. This code uses a directory named "com.intrahealth.com.MOCDeadLock" in the application's documents directory.
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

- (NSPersistentStoreCoordinator *)persistentStoreCoordinator;
{
    @synchronized([self class])
    {
        
        if (sPersistentStoreCoordinator != nil) {
            return sPersistentStoreCoordinator;
        }
        
        sPersistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel: [self managedObjectModel]];
        NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"MOCDeadLock.sqlite"];
        NSError *error = nil;
        NSString *failureReason = @"There was an error creating or loading the application's saved data.";
        
        if (![sPersistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
            // Report any error we got.
            NSMutableDictionary *dict = [NSMutableDictionary dictionary];
            dict[NSLocalizedDescriptionKey] = @"Failed to initialize the application's saved data";
            dict[NSLocalizedFailureReasonErrorKey] = failureReason;
            dict[NSUnderlyingErrorKey] = error;
            error = [NSError errorWithDomain:@"YOUR_ERROR_DOMAIN" code:9999 userInfo:dict];
            // Replace this with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
        
        return sPersistentStoreCoordinator;
    }
}


@end
