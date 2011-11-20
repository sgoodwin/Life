//
//  GOWorld.h
//  Life
//
//  Created by Samuel Goodwin on 11/19/11.
//  Copyright (c) 2011 SNAP Interactive. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^WNCompletionBlock)();

@interface GOWorld : NSObject
@property(strong) NSMutableArray *cells;
- (id)initWithRows:(NSUInteger)rows columns:(NSUInteger)columns;
- (void)birthCellAtRow:(NSUInteger)row andColumn:(NSUInteger)column;
- (void)killCellAtRow:(NSUInteger)row andColumn:(NSUInteger)column;
    
- (BOOL)isCellLivingAtRow:(NSUInteger)row andColumn:(NSUInteger)column;
- (CGFloat)rows;
- (CGFloat)columns;

- (void)stepWithCompletion:(WNCompletionBlock)block;
@end
