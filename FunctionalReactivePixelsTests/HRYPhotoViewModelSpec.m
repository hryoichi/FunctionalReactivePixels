//
//  HRYPhotoViewModelSpec.m
//  FunctionalReactivePixels
//
//  Created by Ryoichi Hara on 2014/02/06.
//  Copyright (c) 2014年 Ryoichi Hara. All rights reserved.
//

#import <Specta/Specta.h>
#import <Expecta/Expecta.h>
#import <OCMock/OCMock.h>
#import "HRYPhotoViewModel.h"
#import "HRYPhotoModel.h"

SpecBegin(HRYPhotoViewModel)

describe(NSStringFromClass([HRYPhotoViewModel class]), ^{
    it(@"should return the photo's name property when photoName is invoked", ^{
        NSString *name = @"Ash";

        id mockPhotoModel = [OCMockObject mockForClass:[HRYPhotoModel class]];
        [[[mockPhotoModel stub] andReturn:name] photoName];

        HRYPhotoViewModel *viewModel = [[HRYPhotoViewModel alloc] initWithModel:nil];
        id mockViewModel = [OCMockObject partialMockForObject:viewModel];
        [[[mockViewModel stub] andReturn:mockPhotoModel] model];

        id returnedName = [mockViewModel photoName];

        EXP_expect(returnedName).to.equal(name);
        [mockPhotoModel stopMocking];
    });
});

SpecEnd
