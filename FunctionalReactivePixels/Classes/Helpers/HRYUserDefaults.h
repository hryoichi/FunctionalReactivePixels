//
//  HRYUserDefaults.h
//  FunctionalReactivePixels
//
//  Created by Ryoichi Hara on 2014/02/04.
//  Copyright (c) 2014年 Ryoichi Hara. All rights reserved.
//

@import Foundation;

@interface HRYUserDefaults : NSUserDefaults

+ (void)configureDefaults;
+ (instancetype)standardUserDefaults;

@end
