//
//  NumberKeyboard.m
//  Mark Calculator
//
//  Created by Ryan Wilson on 2013-02-07.
//
//

#import "NumberKeyboard.h"
#import <QuartzCore/QuartzCore.h> // For accessing the layer property
#import "UIColor+MCColors.h"

#define kKeyTagDecimal  10
#define kKeyTagBack     11

@interface NumberKeyboard ()

@end

@implementation NumberKeyboard

#pragma mark - Actions

- (IBAction)numberButtonHit:(id)sender {
    NSUInteger buttonTag = [sender tag];

    if ( buttonTag == kKeyTagBack )
        [self sendBackspace];
    else if ( buttonTag == kKeyTagDecimal )
        [self sendTextToFirstResponder: @"."];
    else
        [self sendTextToFirstResponder: [NSString stringWithFormat: @"%d", buttonTag]];
}

#pragma mark - VCM

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        // Prevents from having to link up properties to each button. Change background and stroke though
        for (UIView *view in self.view.subviews)
        {
            if ([view isKindOfClass:[UIButton class]])
            {
                view.backgroundColor = [UIColor lightColor];
                view.layer.borderColor = [UIColor darkColor].CGColor;
                view.layer.borderWidth = 1;
            }
        }
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
