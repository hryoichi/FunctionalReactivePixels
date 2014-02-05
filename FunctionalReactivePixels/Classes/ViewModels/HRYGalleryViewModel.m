//
//  HRYGalleryViewModel.m
//  FunctionalReactivePixels
//
//  Created by Ryoichi Hara on 2014/02/05.
//  Copyright (c) 2014年 Ryoichi Hara. All rights reserved.
//

#import "HRYGalleryViewModel.h"
#import "HRYPhotoImporter.h"

@interface HRYGalleryViewModel ()

@end

@implementation HRYGalleryViewModel

- (instancetype)init
{
    if (self = [super init]) {
        RAC(self, model) = [[[HRYPhotoImporter importPhotos] logError] catchTo:[RACSignal empty]];
    }
    return self;
}

@end
