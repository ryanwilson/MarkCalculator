//
//  UIFont+MCFonts.m
//  Mark Calculator
//
//  Created by Ryan Wilson on 2013-03-12.
//
//

#import "UIFont+MCFonts.h"

#define kFontName       @"Helvetica Neue"
#define kFontNameBold   @"Helvetica Neue Bold"

@implementation UIFont (MCFonts)

+(UIFont *) mcFontWithSize:(CGFloat) size{
    return [UIFont fontWithName: kFontName
                           size: size];
}

+(UIFont *) mcBoldFontWithSize:(CGFloat) size{
    return [UIFont fontWithName: kFontNameBold
                           size: size];
}

@end
