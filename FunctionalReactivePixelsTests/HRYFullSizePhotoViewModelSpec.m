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

@interface HRYFullSizePhotoViewModel ()

// A private method
- (HRYPhotoModel *)initialPhotoModel;

@end

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

    it(@"should return nil for an out-of-bounds photo index", ^{
        NSArray *model = @[[NSObject new]];
        NSInteger initialPhotoIndex = 0;

        HRYFullSizePhotoViewModel *viewModel =
        [[HRYFullSizePhotoViewModel alloc] initWithPhotoArray:model
                                            initialPhotoIndex:initialPhotoIndex];
        id subzeroModel = [viewModel photoModelAtIndex:-1];
        EXP_expect(subzeroModel).to.beNil();

        id aboveBoundsModel = [viewModel photoModelAtIndex:model.count];
        EXP_expect(aboveBoundsModel).to.beNil();
    });

    it(@"should return the correct model for photoModelAtIndex", ^{
        id photoModel = [NSObject new];
        NSArray *model = @[photoModel];
        NSInteger initialPhotoIndex = 0;

        HRYFullSizePhotoViewModel *viewModel =
        [[HRYFullSizePhotoViewModel alloc] initWithPhotoArray:model
                                            initialPhotoIndex:initialPhotoIndex];
        id returnModel = [viewModel photoModelAtIndex:0];
        EXP_expect(returnModel).to.equal(photoModel);
    });

    it(@"should return the correct initial photo model", ^{
        NSArray *model = @[[NSObject new]];
        NSInteger initialPhotoIndex = 0;

        HRYFullSizePhotoViewModel *viewModel =
        [[HRYFullSizePhotoViewModel alloc] initWithPhotoArray:model
                                            initialPhotoIndex:initialPhotoIndex];

        id mockViewModel = [OCMockObject partialMockForObject:viewModel];
        [[[mockViewModel expect] andReturn:model[0]] photoModelAtIndex:initialPhotoIndex];

        id returnedObject = [mockViewModel initialPhotoModel];
        EXP_expect(returnedObject).to.equal([model firstObject]);
        
        [mockViewModel verify];
    });
});

SpecEnd