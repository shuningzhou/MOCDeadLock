//
//  TestObject.m
//  
//
//  Created by shuning zhou on 2015-06-03.
//
//

#import "TestObject.h"


@implementation TestObject

+ (id)insertedInContext:(NSManagedObjectContext *)context;
{
    if (!context)
    {
        NSException *exception = [NSException exceptionWithName:@"No context exception" reason:@"Tried to insert an object with a nil context" userInfo:nil];
        
        [exception raise];
        
    }
    
    return [NSEntityDescription insertNewObjectForEntityForName:NSStringFromClass([self class]) inManagedObjectContext:context];
}

@end
