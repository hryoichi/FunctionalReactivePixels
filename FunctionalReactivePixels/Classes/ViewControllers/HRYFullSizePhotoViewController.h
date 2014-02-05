//
//  HRYFullSizePhotoViewController.h
//  FunctionalReactivePixels
//
//  Created by Ryoichi Hara on 2014/02/05.
//  Copyright (c) 2014年 Ryoichi Hara. All rights reserved.
//

@import UIKit;

@class HRYFullSizePhotoViewModel;

@protocol HRYFullSizePhotoViewControllerDelegate;

@interface HRYFullSizePhotoViewController : UIViewController

@property (nonatomic, weak) id <HRYFullSizePhotoViewControllerDelegate> delegate;
@property (nonatomic, strong) HRYFullSizePhotoViewModel *viewModel;

@end

@protocol HRYFullSizePhotoViewControllerDelegate <NSObject>

- (void)userDidScroll:(HRYFullSizePhotoViewController *)viewController toPhotoAtIndex:(NSInteger)index;

@end
