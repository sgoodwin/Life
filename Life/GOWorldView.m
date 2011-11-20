//
//  GOWorldView.m
//  Life
//
//  Created by Samuel Goodwin on 11/19/11.
//  Copyright (c) 2011 SNAP Interactive. All rights reserved.
//

#import "GOWorldView.h"
#import "GOGridLayer.h"

@interface GOWorldView()
- (void)initialize;
@end

@implementation GOWorldView
@synthesize rows = _rows, columns = _columns;
@synthesize delegate = _delegate;

- (id)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if(self){
        [self initialize];
    }
    return self;
}

- (id)initWithFrame:(NSRect)frameRect{
    self = [super initWithFrame:frameRect];
    if(self){
        [self initialize];
    }
    return self;
}

- (void)initialize{
    [self setWantsLayer:YES];
    self.layer = [[GOGridLayer alloc] init];
    self.layer.frame = self.bounds;
}

- (void)reloadData{
    dispatch_async(dispatch_get_main_queue(), ^{
        NSAssert(self.delegate, @"You gotta have a delegate!");
        self.rows = [self.delegate rows];
        self.columns = [self.delegate columns];
        
        GOGridLayer *layer = (GOGridLayer*)self.layer;
        [layer setNumberOfRows:self.rows andColumns:self.columns];
    });
}

- (void)reloadInfo{
    dispatch_async(dispatch_get_main_queue(), ^{
        GOGridLayer *layer = (GOGridLayer*)self.layer;
        for(NSUInteger x = 0;x<self.rows;x++){
            for(NSUInteger y = 0;y<self.columns;y++){
                if([self.delegate isCellLivingAtRow:x andColumn:y]){
                    [layer enableCellAtRow:x andColumn:y];
                }else{
                    [layer disableCellAtRow:x andColumn:y];
                }
            }
        }
    });
}

//- (void)drawRect:(NSRect)dirtyRect{
//    for(NSUInteger x = 0;x<self.rows;x++){
//        for(NSUInteger y = 0;y<self.columns;y++){
//            [self drawBoxAtRow:x andColumn:y];
//        }
//    }
//}

//- (void)mouseDown:(NSEvent *)theEvent {
//    [self.delegate toggleCellAtRow:0 andColumn:0];
//}

@end
