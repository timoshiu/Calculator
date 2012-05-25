//
//  CalculatorTests.m
//  CalculatorTests
//
//  Created by Timothy Shiu on 5/14/12.
//  Copyright (c) 2012 Shiu. All rights reserved.
//

#import "CalculatorTests.h"
#import "CalculatorModel.h"

@interface CalculatorTests()

@property (nonatomic,strong) CalculatorModel* model;

@end

@implementation CalculatorTests

@synthesize model = _model;

- (CalculatorModel*) model
{
    if (_model != nil) { return _model; }
    _model = [[CalculatorModel alloc] init];
    return _model;
}

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

- (void) testMode00
{
    CalculatorModel* model = self.model;
    STAssertTrue(model != nil, @"must equal to 0");
}

- (void) testModel01
{
    CalculatorModel* model = self.model;
    [model push:[NSString stringWithString:@"+"]];
    NSNumber* tmp = (NSNumber*) [model pop];
    int value = [tmp intValue];
    STAssertTrue(value == 0, @"must equal to 0");
}

- (void) testModel02
{
    CalculatorModel* model = self.model;
    [model push:[NSNumber numberWithInt:1]];
    [model push:[NSString stringWithString:@"+"]];
    NSNumber* tmp = (NSNumber*) [model pop];
    STAssertTrue(tmp != nil, @"must not nil");
    int value = [tmp intValue];
    STAssertTrue(value == 1, @"must equal to 1");
}

- (void) testModel03
{
    CalculatorModel* model = self.model;
    [model push:[NSNumber numberWithInt:1]];
    [model push:[NSNumber numberWithInt:2]];
    [model push:[NSString stringWithString:@"+"]];
    NSNumber* tmp = (NSNumber*) [model pop];
    int value = [tmp intValue];
    STAssertTrue(value == 3, @"must equal to 3");
}

- (void) testModel04
{
    CalculatorModel* model = self.model;
    [model push:[NSNumber numberWithInt:0]];
    [model push:[NSNumber numberWithInt:1]];
    [model push:[NSNumber numberWithInt:2]];
    [model push:[NSNumber numberWithInt:3]];
    [model push:[NSNumber numberWithInt:4]];
    [model push:[NSNumber numberWithInt:5]];
    [model push:[NSNumber numberWithInt:6]];
    [model push:[NSNumber numberWithInt:7]];
    [model push:[NSNumber numberWithInt:8]];
    [model push:[NSNumber numberWithInt:9]];
    int ten = [model count];
    STAssertTrue(ten == 10, @"should be 10");
    [model clear];
    int zero = [model count];
    STAssertTrue(zero == 0, @"should be 0");
}

@end
