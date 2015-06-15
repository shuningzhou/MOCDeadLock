//
//  TestObject.h
//  
//
//  Created by shuning zhou on 2015-06-03.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface TestObject : NSManagedObject

+ (id)insertedInContext:(NSManagedObjectContext *)context;

@end
