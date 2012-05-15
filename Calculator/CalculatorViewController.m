//
//  CalculatorViewController.m
//  Calculator
//
//  Created by Timothy Shiu on 5/14/12.
//  Copyright (c) 2012 Shiu. All rights reserved.
//

#import "CalculatorViewController.h"
#import "CalculatorModel.h"

@interface CalculatorViewController()

@property (nonatomic,strong) CalculatorModel* model;

@property (weak, nonatomic) IBOutlet UILabel *display;

@end

@implementation CalculatorViewController

@synthesize model = _model;
@synthesize display = _display;

- (void) setModel:(CalculatorModel *)model
{
    _model = model;
}

- (CalculatorModel*) getModel
{
    if (_model != nil) { return _model; }
    _model = [[CalculatorModel alloc] init];
    return _model;
}

- (void) updateDisplay:(id) obj
{
    if (obj == nil) { return; }
    BOOL ok = [[obj class] isSubclassOfClass:[NSNumber class]];
    if (!ok) { return; }
    NSNumber* num = (NSNumber*) obj;
    UILabel *label = self.display;
    [label setText:[num stringValue]];
}

- (IBAction)pressOperator:(id)sender 
{
    if (sender == nil) { return; }
    NSLog(@"%@ is pressed\n", sender);
    BOOL ok = [[sender class] isSubclassOfClass:[UIButton class]];
    if (!ok) { return; }
    UIButton* button = (UIButton*) sender;
    UILabel* label = [button titleLabel];
    NSString* operator = [label text];
    id result = [[self getModel] push:operator];
    [self updateDisplay:result];
}

- (IBAction)pressDigit:(id)sender 
{
    NSLog(@"%@ is pressed\n", sender);
    if ([[sender class] isSubclassOfClass:[UIButton class]]) {
        UIButton* button = (UIButton*) sender;
        UILabel* label = [button titleLabel];
        NSString* string = [label text];
        int value = [string intValue];
        NSNumber* digit = [NSNumber numberWithInt:value];
        [[self getModel] push:digit];
        [self updateDisplay:digit];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidUnload
{
    [self setDisplay:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

@end
