//
//  HRYGalleryViewModel.h
//  FunctionalReactivePixels
//
//  Created by Ryoichi Hara on 2014/02/05.
//  Copyright (c) 2014年 Ryoichi Hara. All rights reserved.
//

#import "RVMViewModel.h"

@interface HRYGalleryViewModel : RVMViewModel

// Override property type of super class
@property (nonatomic, strong, readonly) NSArray *model;

@end
