//
//  PadGroupCalculationViewController.m
//  Mark Calculator
//
//  Created by Ryan Wilson on 2013-02-08.
//
//

#import "PadGroupCalculationViewController.h"
#import "UIView+FindFirstResponder.h"

@interface PadGroupCalculationViewController ()

@end

@implementation PadGroupCalculationViewController

#pragma mark - Custom Keyboard

-(id) customKeyboardWantsFirstResponder{
    return [self.view findFirstResponder];
}

#pragma mark - View Controller Methods

-(void) viewDidLoad{
    
    [super viewDidLoad];
    
    _numKeyboard = [[NumberKeyboard alloc] initWithNibName: @"NumberKeyboard"
                                                    bundle: nil];
    _numKeyboard.delegate = self;
    
    self.markField.inputView = _numKeyboard.view;
    self.markDenominator.inputView = _numKeyboard.view;
    self.weightField.inputView = _numKeyboard.view;
}

@end
