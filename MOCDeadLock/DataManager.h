//
//  DataManager.h
//  MOCDeadLock
//
//  Created by shuning zhou on 2015-06-15.
//  Copyright (c) 2015 Intrahealth. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@interface DataManager : NSObject

@property (nonatomic, readonly) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, strong) NSString *name;

- (id)initWithName:(NSString*)name;

@end
