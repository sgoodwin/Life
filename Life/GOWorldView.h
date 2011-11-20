//
//  GOWorldView.h
//  Life
//
//  Created by Samuel Goodwin on 11/19/11.
//  Copyright (c) 2011 SNAP Interactive. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@protocol GOWorldViewDataSource;
@interface GOWorldView : NSView
@property(assign) NSUInteger rows;
@property(assign) NSUInteger columns;
@property(weak) id<GOWorldViewDataSource> delegate;

- (void)reloadData;
- (void)reloadInfo;
@end

@protocol GOWorldViewDataSource
- (BOOL)isCellLivingAtRow:(NSUInteger)row andColumn:(NSUInteger)column;
- (void)toggleCellAtRow:(NSUInteger)row andColumn:(NSUInteger)column;
- (NSUInteger)rows;
- (NSUInteger)columns;
@end