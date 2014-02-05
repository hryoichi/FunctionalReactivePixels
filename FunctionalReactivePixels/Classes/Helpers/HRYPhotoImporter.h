//
//  HRYPhotoImporter.h
//  FunctionalReactivePixels
//
//  Created by Ryoichi Hara on 2014/02/04.
//  Copyright (c) 2014年 Ryoichi Hara. All rights reserved.
//

@import Foundation;

@class HRYPhotoModel;

@interface HRYPhotoImporter : NSObject

+ (RACSignal *)importPhotos;
+ (RACSignal *)fetchPhotoDetails:(HRYPhotoModel *)photoModel;

@end
