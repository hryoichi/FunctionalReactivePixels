//
//  HRYUserDefaults.m
//  FunctionalReactivePixels
//
//  Created by Ryoichi Hara on 2014/02/04.
//  Copyright (c) 2014年 Ryoichi Hara. All rights reserved.
//

#import "HRYUserDefaults.h"

@implementation HRYUserDefaults

+ (void)configureDefaults
{
    NSString *pathForResource = [[NSBundle mainBundle] pathForResource:@"ConsumerKeySecret" ofType:@"plist"];

    if (pathForResource) {
        NSDictionary *defaultValues = [NSDictionary dictionaryWithContentsOfFile:pathForResource];
        [[NSUserDefaults standardUserDefaults] registerDefaults:defaultValues];
    }
}

+ (instancetype)standardUserDefaults
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    return (HRYUserDefaults *)userDefaults;
}

@end
