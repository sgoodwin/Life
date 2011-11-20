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
@synthesize rows = _rows, columns = _columns;
@synthesize delegate = _delegate;

- (NSColor*)offColor{
    if(_offColor){
        return _offColor;
    }
    
    _offColor = [NSColor blackColor];
    return _offColor;
}

- (NSColor*)onCOlor{
    if(_onColor){
        return _onColor;
    }
    
    _onColor = [NSColor orangeColor];
    return _onColor;
}

- (void)reloadData{
    self.rows = [self.delegate rows];
    self.columns = [self.delegate columns];
    
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
    CGFloat width = self.bounds.size.width/(CGFloat)self.columns;
    CGFloat height = self.bounds.size.height/(CGFloat)self.rows;
    CGRect dirtyRect = CGRectMake(row*width, column*height, width, height);
    
    NSBezierPath *fullPath = [NSBezierPath bezierPathWithRect:dirtyRect];
    [[NSColor whiteColor] set];
    [fullPath fill];
    
    if([self.delegate isCellLivingAtRow:row andColumn:column]){
        [self.onColor set];
    }else{
        [self.offColor set];
    }
    [fullPath fill];
}

- (void)mouseDown:(NSEvent *)theEvent {
    NSPoint point = [theEvent locationInWindow];
    NSInteger row = (point.x/self.bounds.size.width)*[self rows];
    NSInteger column = (point.y/self.bounds.size.height)*[self columns];
    [self.delegate toggleCellAtRow:row andColumn:column];
}

@end
