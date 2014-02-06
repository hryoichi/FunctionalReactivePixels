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

#pragma mark - Lifecycle

- (instancetype)init
{
    if (self = [super init]) {
        RAC(self, model) = [self importPhotosSignal];
    }
    return self;
}

#pragma mark - Private

- (RACSignal *)importPhotosSignal
{
    return [[[HRYPhotoImporter importPhotos] logError] catchTo:[RACSignal empty]];
}

@end
