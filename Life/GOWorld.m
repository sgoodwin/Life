//
//  GOWorld.m
//  Life
//
//  Created by Samuel Goodwin on 11/19/11.
//  Copyright (c) 2011 SNAP Interactive. All rights reserved.
//

#import "GOWorld.h"
#import "NSArray+ArrayConveniences.h"

@interface GOWorld()
- (NSArray*)neighborsAtRow:(NSUInteger)row andColumn:(NSUInteger)column;

@end

@implementation GOWorld
@synthesize cells = _cells;

- (id)initWithRows:(NSUInteger)rows columns:(NSUInteger)columns{
    self = [super init];
    if(self){
        _cells = [NSMutableArray arrayWithCapacity:rows];
        for(NSUInteger i = 0;i<rows;i++){
            [_cells insertObject:[NSMutableArray emptyArrayWithLength:columns] atIndex:i];
        }
    }
    return self;
}

- (CGFloat)rows{
    return [self.cells count];
}

- (CGFloat)columns{
    return [[self.cells lastObject] count];
}

- (void)birthCellAtRow:(NSUInteger)row andColumn:(NSUInteger)column{
    NSMutableArray *columnArray = [self.cells objectAtIndex:row];
    NSObject *object = [[NSObject alloc] init];
    [columnArray replaceObjectAtIndex:column withObject:object];
}

- (void)killCellAtRow:(NSUInteger)row andColumn:(NSUInteger)column{
    NSMutableArray *columnArray = [self.cells objectAtIndex:row];
    [columnArray replaceObjectAtIndex:column withObject:[NSNull null]];
}

- (BOOL)isCellLivingAtRow:(NSUInteger)row andColumn:(NSUInteger)column{
    NSMutableArray *columnArray = [self.cells objectAtIndex:row];
    return ![[columnArray objectAtIndex:column] isEqual:[NSNull null]];
}

- (NSArray*)neighborsAtRow:(NSUInteger)row andColumn:(NSUInteger)column{
    return [NSArray array];
}

- (void)stepWithCompletion:(WNCompletionBlock)block{
    dispatch_queue_t queue = dispatch_queue_create("com.goodwinlabs.steppingQueue", DISPATCH_QUEUE_SERIAL);
    dispatch_async(queue, ^{
        for(NSUInteger rowNumber = 0;rowNumber < [self rows];rowNumber++){
            for(NSUInteger colNumber = 0;colNumber < [self columns];colNumber++){
                // Rule 1: Any cell with fewer than 2 live neighbors dies.
                // Rule 2: Any live cell with 2-3 neighbors lives.
                // Rule 3: Any live cell with more than 3 dies.
                // Rule 4: Dead cells with exactly 3 live neighbors become alive.
                NSArray *neighbors = [self neighborsAtRow:rowNumber andColumn:colNumber];
                dispatch_async(queue, ^{
                    switch([neighbors count]){
                        case 0:
                        case 1:
                            NSLog(@"Killing cell at (%lu, %lu) because it has %lu neighbors", rowNumber, colNumber, [neighbors count]);
                            [self killCellAtRow:rowNumber andColumn:colNumber];
                            break;
                        case 2:
                            break;
                        case 3:
                            if([self isCellLivingAtRow:rowNumber andColumn:colNumber]){
                                NSLog(@"Birthing cell at (%lu, %lu) because it was dead and has %lu neighbors", rowNumber, colNumber, [neighbors count]);
                                [self birthCellAtRow:rowNumber andColumn:colNumber];
                            }
                            break;
                        default:
                            NSLog(@"Killing cell at (%lu, %lu) because it has %lu neighbors", rowNumber, colNumber, [neighbors count]);
                            [self killCellAtRow:rowNumber andColumn:colNumber];
                            break;
                    }
                });
            }
        }
    });
    dispatch_async(queue, ^{
        block();
    });
}

@end
