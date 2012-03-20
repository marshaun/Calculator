//
//  CalculatorViewController.m
//  Calculator
//
//  Created by SHAUN MARTIN on 2/7/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CalculatorViewController.h"
#import "CalculatorBrain.h"

@interface CalculatorViewController()
@property (nonatomic) BOOL userIsInTheMiddle;
@property (nonatomic, strong) CalculatorBrain *brain;
@end

@implementation CalculatorViewController

@synthesize display = _display;
@synthesize userIsInTheMiddle = _userIsInTheMiddle;
@synthesize brain = _brain;

- (CalculatorBrain *) brain
{
    if(!_brain) 
        _brain = [[CalculatorBrain alloc] init];
    
    return _brain;
}

- (IBAction)digitPressed:(UIButton *)sender 
{
    NSString *digit = [sender currentTitle];
    
    if (self.userIsInTheMiddle)
    {
        if([digit compare:@"."] != NSOrderedSame || [self.display.text rangeOfString:@"."].location == NSNotFound)
        {        
            self.display.text = [self.display.text stringByAppendingString:digit];
        }            
    } 
    else        
    {
        // starts a new number in the enter field
        self.display.text = digit;
        self.userIsInTheMiddle = YES;
    }
}

- (IBAction)enterPressed 
{
    [self.brain pushOperand:[self.display.text doubleValue]];
    self.userIsInTheMiddle = NO;
}

- (IBAction)operationPressed:(UIButton *)sender 
{   
    if (self.userIsInTheMiddle) 
        [self enterPressed];

    double result = [self.brain performOperation:sender.currentTitle];
    
    NSString * resultString  = [NSString stringWithFormat:@"%g", result];
    
    self.display.text = resultString;
}


@end
