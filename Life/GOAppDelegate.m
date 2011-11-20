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
    self.world = [[GOWorld alloc] initWithRows:100 columns:100];
    
    // Basic oscillator/blinker
    [self.world birthCellAtRow:10 andColumn:20];
    [self.world birthCellAtRow:10 andColumn:21];
    [self.world birthCellAtRow:10 andColumn:22];
    
    // Toad period
    [self.world birthCellAtRow:30 andColumn:20];
    [self.world birthCellAtRow:31 andColumn:20];
    [self.world birthCellAtRow:32 andColumn:20];
    [self.world birthCellAtRow:31 andColumn:21];
    [self.world birthCellAtRow:32 andColumn:21];
    [self.world birthCellAtRow:33 andColumn:21];
    
    // Beacon (I read this as Bacon on wikipedia, less excited when I realized it was beacon)
    [self.world birthCellAtRow:30 andColumn:50];
    [self.world birthCellAtRow:31 andColumn:50];
    [self.world birthCellAtRow:30 andColumn:51];
    [self.world birthCellAtRow:31 andColumn:51];
    [self.world birthCellAtRow:32 andColumn:52];
    [self.world birthCellAtRow:33 andColumn:52];
    [self.world birthCellAtRow:32 andColumn:53];
    [self.world birthCellAtRow:33 andColumn:53];
    
    self.worldView.delegate = self;
    [self.worldView reloadData];
    [self.worldView reloadInfo];
}

- (IBAction)step:(id)sender{
    [self.world stepWithCompletion:^{
        [self.worldView reloadInfo];
        double delayInSeconds = 0.1;
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            [self step:nil];
        });
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
    [self.worldView reloadInfo];
}

@end
