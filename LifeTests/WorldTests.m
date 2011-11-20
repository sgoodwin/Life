//
//  LifeTests.m
//  LifeTests
//
//  Created by Samuel Goodwin on 11/19/11.
//  Copyright (c) 2011 SNAP Interactive. All rights reserved.
//

#import "WorldTests.h"
#import "GOWorld.h"

@implementation WorldTests
@synthesize world = _world;

#define WORLD_HEIGHT (NSUInteger)3
#define WORLD_WIDTH (NSUInteger)3

- (void)setUp{
    [super setUp];
    self.world = [[GOWorld alloc] initWithRows:3 columns:3];
}

- (void)tearDown{
    [super tearDown];
    self.world = nil;
}

- (void)testWorldSize{
    STAssertTrue([self.world rows] == WORLD_HEIGHT, @"Testing for valid world height.");
    STAssertTrue([self.world columns] == WORLD_WIDTH, @"Testing for valid world height.");
}

- (void)testNoLiveCellsYet{
    STAssertFalse([self.world isCellLivingAtRow:0 andColumn:0], @"Testing for dead cells");
    STAssertFalse([self.world isCellLivingAtRow:0 andColumn:1], @"Testing for dead cells");
    STAssertFalse([self.world isCellLivingAtRow:0 andColumn:2], @"Testing for dead cells");
    STAssertFalse([self.world isCellLivingAtRow:1 andColumn:0], @"Testing for dead cells");
    STAssertFalse([self.world isCellLivingAtRow:1 andColumn:1], @"Testing for dead cells");
    STAssertFalse([self.world isCellLivingAtRow:1 andColumn:2], @"Testing for dead cells");
    STAssertFalse([self.world isCellLivingAtRow:2 andColumn:0], @"Testing for dead cells");
    STAssertFalse([self.world isCellLivingAtRow:2 andColumn:1], @"Testing for dead cells");
    STAssertFalse([self.world isCellLivingAtRow:2 andColumn:2], @"Testing for dead cells");
}

- (void)testLivingCellBeforeTicks{
    [self.world birthCellAtRow:0 andColumn:0];
    STAssertTrue([self.world isCellLivingAtRow:0 andColumn:0], @"Testing for live cell");
    STAssertFalse([self.world isCellLivingAtRow:0 andColumn:1], @"Testing for dead cells");
    STAssertFalse([self.world isCellLivingAtRow:0 andColumn:2], @"Testing for dead cells");
    STAssertFalse([self.world isCellLivingAtRow:1 andColumn:0], @"Testing for dead cells");
    STAssertFalse([self.world isCellLivingAtRow:1 andColumn:1], @"Testing for dead cells");
    STAssertFalse([self.world isCellLivingAtRow:1 andColumn:2], @"Testing for dead cells");
    STAssertFalse([self.world isCellLivingAtRow:2 andColumn:0], @"Testing for dead cells");
    STAssertFalse([self.world isCellLivingAtRow:2 andColumn:1], @"Testing for dead cells");
    STAssertFalse([self.world isCellLivingAtRow:2 andColumn:2], @"Testing for dead cells");
}

- (void)testRuleNumberOne{
    [self.world birthCellAtRow:0 andColumn:0];
    [self.world stepWithCompletion:^{
        STAssertFalse([self.world isCellLivingAtRow:0 andColumn:0], @"Testing for dead cells");
        STAssertFalse([self.world isCellLivingAtRow:0 andColumn:1], @"Testing for dead cells");
        STAssertFalse([self.world isCellLivingAtRow:0 andColumn:2], @"Testing for dead cells");
        STAssertFalse([self.world isCellLivingAtRow:1 andColumn:0], @"Testing for dead cells");
        STAssertFalse([self.world isCellLivingAtRow:1 andColumn:1], @"Testing for dead cells");
        STAssertFalse([self.world isCellLivingAtRow:1 andColumn:2], @"Testing for dead cells");
        STAssertFalse([self.world isCellLivingAtRow:2 andColumn:0], @"Testing for dead cells");
        STAssertFalse([self.world isCellLivingAtRow:2 andColumn:1], @"Testing for dead cells");
        STAssertFalse([self.world isCellLivingAtRow:2 andColumn:2], @"Testing for dead cells");
    }];
}

- (void)testRuleNumber2{
    [self.world birthCellAtRow:0 andColumn:0];
    [self.world birthCellAtRow:0 andColumn:1];
    [self.world birthCellAtRow:1 andColumn:0];
    [self.world stepWithCompletion:^{
        STAssertTrue([self.world isCellLivingAtRow:0 andColumn:0], @"Testing for dead cells");
        STAssertTrue([self.world isCellLivingAtRow:0 andColumn:1], @"Testing for dead cells");
        STAssertFalse([self.world isCellLivingAtRow:0 andColumn:2], @"Testing for dead cells");
        STAssertTrue([self.world isCellLivingAtRow:1 andColumn:0], @"Testing for dead cells");
        STAssertFalse([self.world isCellLivingAtRow:1 andColumn:1], @"Testing for dead cells");
        STAssertFalse([self.world isCellLivingAtRow:1 andColumn:2], @"Testing for dead cells");
        STAssertFalse([self.world isCellLivingAtRow:2 andColumn:0], @"Testing for dead cells");
        STAssertFalse([self.world isCellLivingAtRow:2 andColumn:1], @"Testing for dead cells");
        STAssertFalse([self.world isCellLivingAtRow:2 andColumn:2], @"Testing for dead cells");
    }];
}

- (void)testRuleNumber2Again{
    [self.world birthCellAtRow:0 andColumn:0];
    [self.world birthCellAtRow:0 andColumn:1];
    [self.world stepWithCompletion:^{
        STAssertFalse([self.world isCellLivingAtRow:0 andColumn:0], @"Testing for dead cells");
        STAssertFalse([self.world isCellLivingAtRow:0 andColumn:1], @"Testing for dead cells");
        STAssertFalse([self.world isCellLivingAtRow:0 andColumn:2], @"Testing for dead cells");
        STAssertFalse([self.world isCellLivingAtRow:1 andColumn:0], @"Testing for dead cells");
        STAssertFalse([self.world isCellLivingAtRow:1 andColumn:1], @"Testing for dead cells");
        STAssertFalse([self.world isCellLivingAtRow:1 andColumn:2], @"Testing for dead cells");
        STAssertFalse([self.world isCellLivingAtRow:2 andColumn:0], @"Testing for dead cells");
        STAssertFalse([self.world isCellLivingAtRow:2 andColumn:1], @"Testing for dead cells");
        STAssertFalse([self.world isCellLivingAtRow:2 andColumn:2], @"Testing for dead cells");
    }];
}

- (void)testRuleNumber3{
    [self.world birthCellAtRow:0 andColumn:0];
    [self.world birthCellAtRow:0 andColumn:1];
    [self.world birthCellAtRow:1 andColumn:0];
    [self.world birthCellAtRow:1 andColumn:1];
    [self.world stepWithCompletion:^{
        STAssertTrue([self.world isCellLivingAtRow:0 andColumn:0], @"Testing for dead cells");
        STAssertTrue([self.world isCellLivingAtRow:0 andColumn:1], @"Testing for dead cells");
        STAssertFalse([self.world isCellLivingAtRow:0 andColumn:2], @"Testing for dead cells");
        STAssertTrue([self.world isCellLivingAtRow:1 andColumn:0], @"Testing for dead cells");
        STAssertTrue([self.world isCellLivingAtRow:1 andColumn:1], @"Testing for dead cells");
        STAssertFalse([self.world isCellLivingAtRow:1 andColumn:2], @"Testing for dead cells");
        STAssertFalse([self.world isCellLivingAtRow:2 andColumn:0], @"Testing for dead cells");
        STAssertFalse([self.world isCellLivingAtRow:2 andColumn:1], @"Testing for dead cells");
        STAssertFalse([self.world isCellLivingAtRow:2 andColumn:2], @"Testing for dead cells");
    }];

}

@end
