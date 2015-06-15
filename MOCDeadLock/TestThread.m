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
    NSLog(@"Dealloc %@", self.name);
}

- (void)main;
{
    @autoreleasepool
    {
        for (int x = 0; x < 5; x++)
        {
            [TestObject insertedInContext:[DataManager sharedManager].managedObjectContext];
        }
        
        [[DataManager sharedManager].managedObjectContext save:nil];
    }
}

@end
