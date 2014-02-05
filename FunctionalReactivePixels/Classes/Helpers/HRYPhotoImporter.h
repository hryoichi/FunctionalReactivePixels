//
//  HRYPhotoImporter.h
//  FunctionalReactivePixels
//
//  Created by Ryoichi Hara on 2014/02/04.
//  Copyright (c) 2014年 Ryoichi Hara. All rights reserved.
//

@import Foundation;

@interface HRYPhotoImporter : NSObject

+ (RACSignal *)importPhotos;

@end
