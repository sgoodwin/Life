//
//  GOWorldView.m
//  Life
//
//  Created by Samuel Goodwin on 11/19/11.
//  Copyright (c) 2011 SNAP Interactive. All rights reserved.
//

#import "GOWorldView.h"

@interface GOWorldView()
- (void)drawBoxAtRow:(NSInteger)row andColumn:(NSInteger)column;
@end

@implementation GOWorldView
@synthesize onColor = _onColor, offColor = _offColor;
@synthesize width = _width, height = _height;
@synthesize rows = _rows, columns = _columns;
@synthesize delegate = _delegate;

- (NSColor*)offColor{
    if(_offColor){
        return _offColor;
    }
    
    _offColor = [NSColor blackColor];
    return _offColor;
}

- (NSColor*)onColor{
    if(_onColor){
        return _onColor;
    }
    
    _onColor = [NSColor orangeColor];
    return _onColor;
}

- (void)reloadData{
    self.rows = [self.delegate rows];
    self.columns = [self.delegate columns];
    self.width = self.bounds.size.width/(CGFloat)self.columns;
    self.height = self.bounds.size.height/(CGFloat)self.rows;
    
    [self setNeedsDisplay:YES];
}

- (void)drawRect:(NSRect)dirtyRect{
    for(NSUInteger x = 0;x<self.rows;x++){
        for(NSUInteger y = 0;y<self.columns;y++){
            [self drawBoxAtRow:x andColumn:y];
        }
    }
}

- (void)drawBoxAtRow:(NSInteger)row andColumn:(NSInteger)column{
    CGRect dirtyRect = CGRectMake(row*self.width, column*self.height, self.width, self.height);
    NSBezierPath *fullPath = [NSBezierPath bezierPathWithRect:dirtyRect];
    if([self.delegate isCellLivingAtRow:row andColumn:column]){
        [self.onColor set];
    }else{
        [self.offColor set];
    }
    [fullPath fill];
}

- (void)mouseDown:(NSEvent *)theEvent {
    NSPoint point = [theEvent locationInWindow];
    NSInteger row = floorf(point.x/self.width);
    NSInteger column = floorf(point.y/self.height);
    [self.delegate toggleCellAtRow:row andColumn:column];
}

@end
