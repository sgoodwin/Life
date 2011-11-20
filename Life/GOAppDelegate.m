//
//  GOAppDelegate.m
//  Life
//
//  Created by Samuel Goodwin on 11/19/11.
//  Copyright (c) 2011 SNAP Interactive. All rights reserved.
//

#import "GOAppDelegate.h"
#import "GOWorld.h"

@implementation GOAppDelegate

@synthesize window = _window, world = _world, worldView = _worldView;

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    self.world = [[GOWorld alloc] initWithRows:10 columns:10];
    self.worldView.delegate = self;
    [self.worldView reloadData];
}

- (IBAction)step:(id)sender{
    NSTimeInterval start = [[NSProcessInfo processInfo] systemUptime];
    [self.world stepWithCompletion:^{
        [self.worldView setNeedsDisplay:YES];
        NSLog(@"took %f seconds to step.", [[NSProcessInfo processInfo] systemUptime]-start); 
    }];
}

#pragma mark -
#pragma mark GOWorldViewDataSource

- (BOOL)isCellLivingAtRow:(NSUInteger)row andColumn:(NSUInteger)column{
    return [self.world isCellLivingAtRow:row andColumn:column];
}

- (NSUInteger)rows{
    return [self.world rows];
}

- (NSUInteger)columns{
    return [self.world columns];
}

- (void)toggleCellAtRow:(NSUInteger)row andColumn:(NSUInteger)column{
    if([self.world isCellLivingAtRow:row andColumn:column]){
        [self.world killCellAtRow:row andColumn:column];
    }else{
        [self.world birthCellAtRow:row andColumn:column];
    }
    [self.worldView setNeedsDisplay:YES];
}

@end
