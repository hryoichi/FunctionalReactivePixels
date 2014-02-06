//
//  HRYGalleryViewModelSpec.m
//  FunctionalReactivePixels
//
//  Created by Ryoichi Hara on 2014/02/06.
//  Copyright (c) 2014年 Ryoichi Hara. All rights reserved.
//

#import <Specta/Specta.h>
#import <OCMock/OCMock.h>
#import "HRYGalleryViewModel.h"

@interface HRYGalleryViewModel ()

// A private method
- (RACSignal *)importPhotosSignal;

@end

SpecBegin(HRYGalleryViewModel)

describe(NSStringFromClass([HRYGalleryViewModel class]), ^{
    it(@"should be initialized and call importPhotos", ^{
        id mockObject = [OCMockObject mockForClass:[HRYGalleryViewModel class]];
        [[[mockObject expect] andReturn:[RACSignal empty]] importPhotosSignal];

        mockObject = [mockObject init];
        [mockObject verify];
        [mockObject stopMocking];
    });
});

SpecEnd

