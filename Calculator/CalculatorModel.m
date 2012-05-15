
//
//  CalculatorModel.m
//  Calculator
//
//  Created by Timothy Shiu on 5/14/12.
//  Copyright (c) 2012 Shiu. All rights reserved.
//

#import "CalculatorModel.h"

@interface CalculatorModel()

@property (nonatomic,strong) NSMutableArray* stack;

- (BOOL) isOp:(id) operator;
- (id) eval;
- (int) eval: (char) op A: (int) a B: (int) b;

@end

@implementation CalculatorModel

@synthesize stack = _stack;

- (NSMutableArray*) getStack
{
    if (_stack) { return _stack; }
    _stack = [NSMutableArray array];
    return _stack;
}

- (void) setStack: (NSMutableArray *) stack
{
    if (_stack) {
        NSUInteger size = [_stack count];
        if (size != 0) {
            _stack = nil;
        }
    }
    _stack = stack;
}

- (NSUInteger) count
{
    NSMutableArray *array = [self getStack];
    return [array count];
}

- (id) pop
{
 
    NSMutableArray *array = [self getStack];
    if (array == nil) { return nil; }
    NSUInteger size = [array count];
    if (size == 0) { return nil; }   
    id obj = [array objectAtIndex:0];
    [array removeObjectAtIndex:0];
    return obj;
}

- (id) push: (id) obj
{
    if (obj == nil) { return nil; }
    NSMutableArray* array = [self getStack];
    [array insertObject:obj atIndex:0];
    id result = [self eval];
    [array insertObject:result atIndex:0];
    return result;
}

- (BOOL) isOp:(id) operator
{
    if (operator == nil) { return NO; }
    NSLog(@"%@", [operator class]);
    BOOL string = [[operator class] isSubclassOfClass:[NSString class]];
    if (!string) { return NO; }

    char op0 = [(NSString*) operator characterAtIndex:0];
    char ops[] = {'+', '-', '*', '/', 0};
    char *c = ops;
    while (c) {
        if (*c == op0) { 
            return YES; 
        }
    }
    return NO;
}

- (int) eval: (char) op A: (int) a B: (int) b
{
    int result = 0;
    if (op == '+') {
        result = a + b;
    } else if (op == '-') {
        result = a - b;
    } else if (op == '*') {
        result = a * b;        
    } else if ((op == '/') && (b == 0)) {
        result = NAN;
    } else if ((op == '/') && (b != 0)) {
        result = a / b;
    }
    return result;
}

- (id) eval
{
    id top = [self pop];
    if (top == nil) { return nil; }

    BOOL op = [self isOp:top];
    if (!op) { return top; } 
    
    char opr = [(NSString*) top characterAtIndex:0];
    int op1 = [(NSNumber*) [self eval] intValue];
    int op2 = [(NSNumber*) [self eval] intValue];
    int ans = [self eval:opr A:op1 B:op2];
    NSNumber* value = [NSNumber numberWithInt:ans];
    return value;
}

@end
