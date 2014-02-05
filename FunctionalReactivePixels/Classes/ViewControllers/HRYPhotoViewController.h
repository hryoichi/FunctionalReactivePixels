//
//  HRYPhotoViewController.h
//  FunctionalReactivePixels
//
//  Created by Ryoichi Hara on 2014/02/05.
//  Copyright (c) 2014年 Ryoichi Hara. All rights reserved.
//

@import UIKit;

@class HRYPhotoViewModel;

@interface HRYPhotoViewController : UIViewController

@property (nonatomic, assign, readonly) NSInteger photoIndex;
@property (nonatomic, strong, readonly) HRYPhotoViewModel *viewModel;

- (instancetype)initWithViewModel:(HRYPhotoViewModel *)viewModel index:(NSInteger)photoIndex;


@end
