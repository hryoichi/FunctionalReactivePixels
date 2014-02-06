//
//  HRYFullSizePhotoViewModelSpec.m
//  FunctionalReactivePixels
//
//  Created by Ryoichi Hara on 2014/02/06.
//  Copyright (c) 2014年 Ryoichi Hara. All rights reserved.
//

#import <Specta/Specta.h>
#import <Expecta/Expecta.h>
#import <OCMock/OCMock.h>
#import "HRYPhotoModel.h"
#import "HRYFullSizePhotoViewModel.h"

SpecBegin(HRYFullSizePhotoViewModel)

describe(NSStringFromClass([HRYFullSizePhotoViewModel class]), ^{
    it(@"should assign correct attributes when initialized.", ^{
        NSArray *model = @[];
        NSInteger initialPhotoIndex = 1337;

        HRYFullSizePhotoViewModel *viewModel =
        [[HRYFullSizePhotoViewModel alloc] initWithPhotoArray:model
                                            initialPhotoIndex:initialPhotoIndex];
        EXP_expect(model).to.equal(viewModel.model);
        EXP_expect(initialPhotoIndex).to.equal(viewModel.initialPhotoIndex);
    });
});

SpecEnd