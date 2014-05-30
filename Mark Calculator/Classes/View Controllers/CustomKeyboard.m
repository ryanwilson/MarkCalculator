//
//  CustomKeyboard.m
//  Mark Calculator
//
//  Created by Ryan Wilson on 2013-02-07.
//
//

#import "CustomKeyboard.h"
#import "UIView+FindFirstResponder.h"

@interface CustomKeyboard ()

@end

@implementation CustomKeyboard

-(BOOL) sendTextToFirstResponder:(NSString *) text{
    
    id field = [self.delegate customKeyboardWantsFirstResponder];
    if (field != nil && [field respondsToSelector:@selector(insertText:)]){
        [field insertText: text];
        return YES;
    }
    else{
        return NO;
    }
}

-(BOOL) sendBackspace{

    id field = [self.delegate customKeyboardWantsFirstResponder];
    if (field != nil && [field respondsToSelector:@selector(deleteBackward)]){
        [field deleteBackward];
        return YES;
    }
    else{
        return NO;
    }
}

#pragma mark - View Controller Methods

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    DLog(@"CUSTOM KEYBOARD LOADED WHA HWA");
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
