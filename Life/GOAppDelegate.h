//
//  GOAppDelegate.h
//  Life
//
//  Created by Samuel Goodwin on 11/19/11.
//  Copyright (c) 2011 SNAP Interactive. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "GOWorldView.h"

@class GOWorld;
@interface GOAppDelegate : NSObject <NSApplicationDelegate, GOWorldViewDataSource>
@property (strong) GOWorld *world;
@property (assign) IBOutlet NSWindow *window;
@property (assign) IBOutlet GOWorldView *worldView;

- (IBAction)step:(id)sender;
@end
