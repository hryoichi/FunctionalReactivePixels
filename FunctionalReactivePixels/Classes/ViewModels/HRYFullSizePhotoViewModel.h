//
//  HRYFullSizePhotoViewModel.h
//  FunctionalReactivePixels
//
//  Created by Ryoichi Hara on 2014/02/05.
//  Copyright (c) 2014年 Ryoichi Hara. All rights reserved.
//

#import "RVMViewModel.h"

@class HRYPhotoModel;

@interface HRYFullSizePhotoViewModel : RVMViewModel

// Override property type of super class
@property (nonatomic, strong, readonly) NSArray *model;
@property (nonatomic, assign, readonly) NSInteger initialPhotoIndex;
@property (nonatomic, strong, readonly) NSString *initialPhotoName;

- (instancetype)initWithPhotoArray:(NSArray *)photoArray initialPhotoIndex:(NSInteger)initialPhotoIndex;
- (HRYPhotoModel *)photoModelAtIndex:(NSInteger)index;

@end
