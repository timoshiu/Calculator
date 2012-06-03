//
//  CalculatorViewController.m
//  Calculator
//
//  Created by Timothy Shiu on 5/14/12.
//  Copyright (c) 2012 Shiu. All rights reserved.
//

#import "CalculatorViewController.h"
#import "CalculatorModel.h"
#import <UIKit/UITableView.h>

@interface CalculatorViewController() <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSNumber* number;
@property (nonatomic, strong) CalculatorModel* model;
@property (nonatomic, weak) IBOutlet UILabel *display;

@end

@implementation CalculatorViewController

@synthesize tableView = _tableView;
@synthesize number = _number;
@synthesize model = _model;
@synthesize display = _display;

- (CalculatorModel*) model
{
    if (_model != nil) { return _model; }
    _model = [[CalculatorModel alloc] init];
    return _model;
}

- (void) updateDisplay
{
    UILabel *label = self.display;
    NSNumber* num = self.number;
    NSString* val = nil;
    if (num) {
        val = [num stringValue];
    } else {
        val = [NSString stringWithString:@"0"];
    }
    [self.tableView reloadData];
    [label setText:val];
}

- (void) clearDisplay
{
    UILabel *label = self.display;
    [label setText:[NSString stringWithString:@"0"]];  
    [self.tableView reloadData];
}

- (void) clearNumber
{
    self.number = nil;
}

- (NSNumber*) appendInt: (int) low
{
    NSNumber* num = self.number;
    int high = [num intValue];
    
    int value = high * 10 + low;
    NSNumber* ans = [NSNumber numberWithInt:value];
    self.number = ans;
    return ans;    
}

- (NSNumber*) appendNumber: (NSNumber*) tail
{
    int low = [tail intValue];
    NSNumber* ans = [self appendInt:low];
    return ans;
}

- (int) intFromButton:(UIButton*) button
{
    UILabel* label = [button titleLabel];
    NSString* string = [label text];
    int value = [string intValue];
    return value;
}

- (NSNumber*) numberFromButton: (UIButton*) button
{   
    int value = [self intFromButton:button];
    NSNumber* digit = [NSNumber numberWithInt:value];
    return digit;
}

- (NSString*) operatorFromButton: (UIButton*) button
{
    UILabel* label = [button titleLabel];
    NSString* operator = [label text];
    return operator;
}

- (IBAction)pressOperator:(id)sender 
{
    if (sender == nil) { return; }
    NSLog(@"%@ is pressed\n", sender);
    [self.model push:self.number];
    [self clearNumber];
    NSString* op = [self operatorFromButton:sender];
    NSNumber* ans = [self.model push:op];
    [self appendNumber:ans];
    [self updateDisplay];
    [self clearNumber];
}

- (IBAction)pressClear:(id)sender 
{
    [self.model clear];
    [self clearNumber];
    [self clearDisplay];
}

- (IBAction)pressEnter:(id)sender 
{
    [self.model push:self.number];
    [self clearNumber];
    [self updateDisplay];
}

- (IBAction)pressDigit:(id)sender 
{
    if (sender == nil) { return; }
    NSLog(@"%@ is pressed\n", sender);
    int digit = [self intFromButton:sender];
    [self appendInt:digit];
    [self updateDisplay];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - DataSource Delegate for UITableView

- (UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"cellID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    NSNumber* number = [self.model objAtIndex:indexPath.row];
    cell.textLabel.text = [number stringValue];
    return cell;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.model count];
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
        
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
    [self setTableView:nil];
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
