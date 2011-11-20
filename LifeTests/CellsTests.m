//
//  LifeTests.m
//  LifeTests
//
//  Created by Samuel Goodwin on 11/19/11.
//  Copyright (c) 2011 SNAP Interactive. All rights reserved.
//

#import "CellsTests.h"
#import "GOWorld.h"

@implementation CellsTests
@synthesize world = _world;

- (void)setUp
{
    [super setUp];
    self.world = [[GOWorld alloc] initWithSize:CGSizeMake(3.0f, 3.0f)];
}

- (void)tearDown
{
    // Tear-down code here.
    
    [super tearDown];
    self.world = nil;
}

@end
