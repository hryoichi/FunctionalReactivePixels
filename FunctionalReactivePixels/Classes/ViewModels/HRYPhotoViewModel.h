//
//  HRYPhotoViewModel.h
//  FunctionalReactivePixels
//
//  Created by Ryoichi Hara on 2014/02/05.
//  Copyright (c) 2014年 Ryoichi Hara. All rights reserved.
//

#import "RVMViewModel.h"

@class HRYPhotoModel;

@interface HRYPhotoViewModel : RVMViewModel

@property (nonatomic, strong, readonly) HRYPhotoModel *model;
@property (nonatomic, strong, readonly) UIImage *photoImage;
@property (nonatomic, assign, readonly, getter = isLoading) BOOL loading;

- (NSString *)photoName;

@end
