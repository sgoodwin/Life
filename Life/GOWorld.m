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
- (NSArray*)neighborsAtRow:(NSInteger)row andColumn:(NSInteger)column;

@end

@implementation GOWorld
@synthesize cells = _cells, queue = _queue;

- (id)initWithRows:(NSInteger)rows columns:(NSInteger)columns{
    self = [super init];
    if(self){
        _cells = [NSMutableArray arrayWithCapacity:rows];
        for(NSUInteger i = 0;i<rows;i++){
            [_cells insertObject:[NSMutableArray emptyArrayWithLength:columns] atIndex:i];
        }
        self.queue = dispatch_queue_create("com.goodwinlabs.steppingQueue", DISPATCH_QUEUE_SERIAL);
    }
    return self;
}

- (CGFloat)rows{
    return [self.cells count];
}

- (CGFloat)columns{
    return [[self.cells lastObject] count];
}

- (void)birthCellAtRow:(NSInteger)row andColumn:(NSInteger)column{
    if(row < 0 || row > [self rows]-1 || column < 0 || column > [self columns]-1){
        return;
    }
    NSMutableArray *columnArray = [self.cells objectAtIndex:row];
    NSObject *object = [[NSObject alloc] init];
    [columnArray replaceObjectAtIndex:column withObject:object];
}

- (void)killCellAtRow:(NSInteger)row andColumn:(NSInteger)column{
    if(row < 0 || row > [self rows]-1 || column < 0 || column > [self columns]-1){
        return;
    }
    NSMutableArray *columnArray = [self.cells objectAtIndex:row];
    [columnArray replaceObjectAtIndex:column withObject:[NSNull null]];
}

- (BOOL)isCellLivingAtRow:(NSInteger)row andColumn:(NSInteger)column{
    if(row < 0 || row > [self rows]-1 || column < 0 || column > [self columns]-1){
        return NO;
    }
    NSMutableArray *columnArray = [self.cells objectAtIndex:row];
    return ![[columnArray objectAtIndex:column] isEqual:[NSNull null]];
}

- (NSArray*)neighborsAtRow:(NSInteger)row andColumn:(NSInteger)column{
    NSMutableArray *neighbors = [NSMutableArray array];
    if([self isCellLivingAtRow:row-1 andColumn:column-1]){
        [neighbors addObject:[[NSObject alloc] init]];
    }
    if([self isCellLivingAtRow:row-1 andColumn:column]){
        [neighbors addObject:[[NSObject alloc] init]];
    }
    if([self isCellLivingAtRow:row-1 andColumn:column+1]){
        [neighbors addObject:[[NSObject alloc] init]];
    }
    
    if([self isCellLivingAtRow:row andColumn:column-1]){
        [neighbors addObject:[[NSObject alloc] init]];
    }
    if([self isCellLivingAtRow:row andColumn:column+1]){
        [neighbors addObject:[[NSObject alloc] init]];
    }
    
    if([self isCellLivingAtRow:row+1 andColumn:column-1]){
        [neighbors addObject:[[NSObject alloc] init]];
    }
    if([self isCellLivingAtRow:row+1 andColumn:column]){
        [neighbors addObject:[[NSObject alloc] init]];
    }
    if([self isCellLivingAtRow:row+1 andColumn:column+1]){
        [neighbors addObject:[[NSObject alloc] init]];
    }
    return neighbors;
}

- (void)stepWithCompletion:(WNCompletionBlock)block{
    dispatch_async(self.queue, ^{
        for(NSUInteger rowNumber = 0;rowNumber < [self rows];rowNumber++){
            for(NSUInteger colNumber = 0;colNumber < [self columns];colNumber++){                
                // Rule 1: Any cell with fewer than 2 live neighbors dies.
                // Rule 2: Any live cell with 2-3 neighbors lives.
                // Rule 3: Any live cell with more than 3 dies.
                // Rule 4: Dead cells with exactly 3 live neighbors become alive.
                NSArray *neighbors = [self neighborsAtRow:rowNumber andColumn:colNumber];
                dispatch_async(self.queue, ^{
                    switch([neighbors count]){
                        case 0:
                            [self killCellAtRow:rowNumber andColumn:colNumber];
                            break;
                        case 1:
                            [self killCellAtRow:rowNumber andColumn:colNumber];
                            break;
                        case 2:
                            break;
                        case 3:
                            if(![self isCellLivingAtRow:rowNumber andColumn:colNumber]){
                                [self birthCellAtRow:rowNumber andColumn:colNumber];
                            }
                            break;
                        default:
                            [self killCellAtRow:rowNumber andColumn:colNumber];
                            break;
                    }
                });
            }
        }
    });
    dispatch_async(self.queue, ^{
        block();
    });
}

@end
