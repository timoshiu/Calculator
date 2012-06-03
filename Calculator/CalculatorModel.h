//
//  CalculatorModel.h
//  Calculator
//
//  Created by Timothy Shiu on 5/14/12.
//  Copyright (c) 2012 Shiu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CalculatorModel : NSObject

- (id) push:(id) obj;
- (id) pop;
- (id) objAtIndex:(NSInteger) ith;
- (NSUInteger) count;
- (void) clear;

@end
