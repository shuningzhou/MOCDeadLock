//
//  TestThread.m
//  MOCDeadLock
//
//  Created by shuning zhou on 2015-06-15.
//  Copyright (c) 2015 Intrahealth. All rights reserved.
//

#import "TestThread.h"
#import "TestObject.h"
#import "DataManager.h"

NSString * const DEALLOC_LOCK = @"DEALLOC_LOCK";

@interface TestThread ()

@property (nonatomic, strong) DataManager *dataManager;

@end


@implementation TestThread

- (instancetype)initWithName:(NSString*)name;
{
    self = [super initWithTarget:self selector:@selector(main) object:nil];
    
    if (self)
    {
        [self setName:name];

    }
    return self;
}

- (void)dealloc;
{
    @synchronized(DEALLOC_LOCK)
    {
        self.dataManager = nil;
    }
}

- (void)main;
{
    NSLog(@"Started = %@", self.name);
    
    self.dataManager = [[DataManager alloc] initWithName:self.name];

    @autoreleasepool
    {
        for (int x = 0; x < 5; x++)
        {
            [TestObject insertedInContext:self.dataManager.managedObjectContext];
        }
        
        @synchronized(DEALLOC_LOCK)
        {
            [self.dataManager.managedObjectContext save:nil];
        }

    }
}

@end
