//
//  HRYFullSizePhotoViewController.h
//  FunctionalReactivePixels
//
//  Created by Ryoichi Hara on 2014/02/05.
//  Copyright (c) 2014年 Ryoichi Hara. All rights reserved.
//

@import UIKit;

@protocol HRYFullSizePhotoViewControllerDelegate;

@interface HRYFullSizePhotoViewController : UIViewController

@property (nonatomic, copy, readonly) NSArray *photoModelArray;
@property (nonatomic, weak) id <HRYFullSizePhotoViewControllerDelegate> delegate;

- (instancetype)initWithPhotoModels:(NSArray *)photoModelArray
                  currentPhotoIndex:(NSInteger)photoIndex;

@end

@protocol HRYFullSizePhotoViewControllerDelegate <NSObject>

- (void)userDidScroll:(HRYFullSizePhotoViewController *)viewController toPhotoAtIndex:(NSInteger)index;

@end
