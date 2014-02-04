//
//  HRYUserDefaults.h
//  FunctionalReactivePixels
//
//  Created by Ryoichi Hara on 2014/02/04.
//  Copyright (c) 2014年 Ryoichi Hara. All rights reserved.
//

@import Foundation;

UIKIT_EXTERN NSString * const HRYUserDefaultsConsumerKey;
UIKIT_EXTERN NSString * const HRYUserDefualtsConsumerSecret;

@interface HRYUserDefaults : NSUserDefaults

+ (void)configureDefaults;
+ (instancetype)standardUserDefaults;

@end
