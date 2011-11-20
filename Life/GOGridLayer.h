//
//  GOGridLayer.h
//  Life
//
//  Created by Samuel Goodwin on 11/20/11.
//  Copyright (c) 2011 SNAP Interactive. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

@interface GOGridLayer : CALayer
@property(assign)NSUInteger rows;
@property(assign)NSUInteger columns;

- (void)setNumberOfRows:(NSUInteger)rows andColumns:(NSUInteger)columns;
- (void)disableCellAtRow:(NSUInteger)row andColumn:(NSUInteger)column;
- (void)enableCellAtRow:(NSUInteger)row andColumn:(NSUInteger)column;
@end
