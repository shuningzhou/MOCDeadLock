//
//  TestThread.h
//  MOCDeadLock
//
//  Created by shuning zhou on 2015-06-15.
//  Copyright (c) 2015 Intrahealth. All rights reserved.
//

#import <Foundation/Foundation.h>

extern NSString * const DEALLOC_LOCK;

@interface TestThread : NSThread

- (instancetype)initWithName:(NSString*)name;

@end
