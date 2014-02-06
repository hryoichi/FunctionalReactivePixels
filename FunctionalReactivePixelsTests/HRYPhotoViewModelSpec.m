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

@interface HRYPhotoViewModel ()

- (void)downloadPhotoModelDetails;

@end

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

    it (@"should correctly map image data to UIImage", ^{
        UIImage *image = [UIImage new];
        NSData *imageData = [NSData data];

        id mockImage = [OCMockObject mockForClass:[UIImage class]];
        [[[mockImage stub] andReturn:image] imageWithData:imageData];

        HRYPhotoModel *photoModel = [[HRYPhotoModel alloc] init];
        photoModel.fullsizedData = imageData;

        __unused HRYPhotoViewModel *viewModel = [[HRYPhotoViewModel alloc] initWithModel:photoModel];

        [mockImage verify];
        [mockImage stopMocking];
    });

    it(@"should download photo model details when it becomes active", ^{
        HRYPhotoViewModel *viewModel = [[HRYPhotoViewModel alloc] initWithModel:nil];

        id mockViewModel = [OCMockObject partialMockForObject:viewModel];
        [[mockViewModel expect] downloadPhotoModelDetails];

        [mockViewModel setActive:YES];

        [mockViewModel verify];
    });

    it (@"should return the correct photo name", ^{
        NSString *name = @"Ash";

        HRYPhotoModel *photoModel = [[HRYPhotoModel alloc] init];
        photoModel.photoName = name;

        HRYPhotoViewModel *viewModel = [[HRYPhotoViewModel alloc] initWithModel:photoModel];

        NSString *returnedName = [viewModel photoName];

        EXP_expect(name).to.equal(returnedName);
    });
});

SpecEnd
