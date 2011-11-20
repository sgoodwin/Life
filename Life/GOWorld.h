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
- (id)initWithRows:(NSInteger)rows columns:(NSInteger)columns;
- (void)birthCellAtRow:(NSInteger)row andColumn:(NSInteger)column;
- (void)killCellAtRow:(NSInteger)row andColumn:(NSInteger)column;
    
- (BOOL)isCellLivingAtRow:(NSInteger)row andColumn:(NSInteger)column;
- (CGFloat)rows;
- (CGFloat)columns;

- (void)stepWithCompletion:(WNCompletionBlock)block;
@end
