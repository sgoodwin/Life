//
//  GOGridLayer.m
//  Life
//
//  Created by Samuel Goodwin on 11/20/11.
//  Copyright (c) 2011 SNAP Interactive. All rights reserved.
//

#import "GOGridLayer.h"

@implementation GOGridLayer
@synthesize rows = _rows;
@synthesize columns = _columns;

- (void)setNumberOfRows:(NSUInteger)rows andColumns:(NSUInteger)columns{
    self.rows = rows;
    self.columns = columns;
    
    NSArray *sublayers = [super sublayers];
    [sublayers enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        [obj removeFromSuperlayer];
    }];
    
    CGFloat width = self.bounds.size.width/(CGFloat)columns;
    CGFloat height = self.bounds.size.height/(CGFloat)rows;
    for(NSUInteger x=0;x<rows;x++){
        for(NSUInteger y=0;y<columns;y++){
            CALayer *layer = [[CALayer alloc] init];
            layer.delegate = self;
            [layer removeAllAnimations];
            layer.frame = CGRectMake(x*width, y*height, width, height);
            layer.backgroundColor = CGColorCreateGenericRGB(1.0f, 0.0f, 0.0f, 1.0f);
            [self addSublayer:layer];
        }
    }
}

- (void)layoutSublayers{
    return;
}

- (id<CAAction>)actionForLayer:(CALayer *)layer forKey:(NSString *)event{
    return nil;
}

- (void)disableCellAtRow:(NSUInteger)row andColumn:(NSUInteger)column{
    CALayer *layer = [self.sublayers objectAtIndex:(row*self.columns)+column];
    [layer setBackgroundColor:CGColorCreateGenericRGB(1.0f, 0.0f, 0.0f, 1.0f)];
}

- (void)enableCellAtRow:(NSUInteger)row andColumn:(NSUInteger)column{
    CALayer *layer = [self.sublayers objectAtIndex:(row*self.columns)+column];
    [layer setBackgroundColor:CGColorCreateGenericRGB(0.0f, 1.0f, 0.0f, 1.0f)];
}

@end
