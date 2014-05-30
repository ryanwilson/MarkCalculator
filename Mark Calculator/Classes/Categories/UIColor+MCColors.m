//
//  UIColor+MCColors.m
//  Mark Calculator
//
//  Created by Ryan Wilson on 2013-01-24.
//
//

#import "UIColor+MCColors.h"

@implementation UIColor (MCColors)

+(UIColor *) lightColor{
    return [UIColor colorWithRed: 240.0 /255.0f
                           green: 246.0 /255.0f
                            blue: 251.0 /255.0f
                           alpha: 1.0];
}


+(UIColor *) darkColor{
    return [UIColor colorWithRed: 41.0 /255.0f
                           green: 48.0 /255.0f
                            blue: 52.0 /255.0f
                           alpha: 1.0];
}

+(UIColor *) keyboardColor{

    return [UIColor colorWithRed: 155.0 /255.0f
                           green: 204.0 /255.0f
                            blue: 233.0 /255.0f
                           alpha: 1];
}

@end
