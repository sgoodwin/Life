//
//  NSArray+ArrayConveniences.m
//  Life
//
//  Created by Samuel Goodwin on 11/19/11.
//  Copyright (c) 2011 SNAP Interactive. All rights reserved.
//

#import "NSArray+ArrayConveniences.h"

@implementation NSArray (ArrayConveniences)
+ (id)emptyArrayWithLength:(NSUInteger)length{
    NSMutableArray *newArray = [NSMutableArray arrayWithCapacity:length];
    for(NSUInteger i = 0;i<length;i++){
        [newArray insertObject:[NSNull null] atIndex:i];
    }
    return newArray;
}
@end
