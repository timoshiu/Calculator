//
//  CalculatorTests.m
//  CalculatorTests
//
//  Created by Timothy Shiu on 5/14/12.
//  Copyright (c) 2012 Shiu. All rights reserved.
//

#import "CalculatorTests.h"
#import "CalculatorModel.h"

@implementation CalculatorTests

- (void)setUp
{
    [super setUp];
    
    // Set-up code here.
}

- (void)tearDown
{
    // Tear-down code here.
    
    [super tearDown];
}


- (void) testModel01
{
    CalculatorModel* model = [[CalculatorModel alloc] init];
    [model push:[NSString stringWithString:@"+"]];
    NSNumber* tmp = (NSNumber*) [model pop];
    int value = [tmp intValue];
    STAssertTrue(value == 0, @"must equal to 0");
}

- (void) testModel02
{
    CalculatorModel* model = [[CalculatorModel alloc] init];
    [model push:[NSNumber numberWithInt:1]];
    [model push:[NSString stringWithString:@"+"]];
    NSNumber* tmp = (NSNumber*) [model pop];
    int value = [tmp intValue];
    STAssertTrue(value == 1, @"must equal to 1");
}

- (void) testModel03
{
    CalculatorModel* model = [[CalculatorModel alloc] init];
    [model push:[NSNumber numberWithInt:1]];
    [model push:[NSNumber numberWithInt:2]];
    [model push:[NSString stringWithString:@"+"]];
    NSNumber* tmp = (NSNumber*) [model pop];
    int value = [tmp intValue];
    STAssertTrue(value == 3, @"must equal to 3");
}

@end
