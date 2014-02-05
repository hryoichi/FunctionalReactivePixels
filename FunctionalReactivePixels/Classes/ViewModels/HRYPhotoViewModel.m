//
//  HRYPhotoViewModel.m
//  FunctionalReactivePixels
//
//  Created by Ryoichi Hara on 2014/02/05.
//  Copyright (c) 2014年 Ryoichi Hara. All rights reserved.
//

#import "HRYPhotoViewModel.h"
#import "HRYPhotoImporter.h"
#import "HRYPhotoModel.h"

@interface HRYPhotoViewModel ()

@property (nonatomic, strong, readwrite) UIImage *photoImage;
@property (nonatomic, assign, readwrite, getter = isLoading) BOOL loading;

@end

@implementation HRYPhotoViewModel

- (instancetype)initWithModel:(HRYPhotoViewModel *)photoModel
{
    if (self = [super initWithModel:photoModel]) {
        @weakify(self);
        [self.didBecomeActiveSignal subscribeNext:^(id x) {
            @strongify(self);
            self.loading = YES;
            [[HRYPhotoImporter fetchPhotoDetails:self.model] subscribeError:^(NSError *error) {
                NSLog(@"Could not fetch photo details: %@", error);
            } completed:^{
                self.loading = NO;
                NSLog(@"Fetched photo details");
            }];
        }];

        RAC(self, photoImage) = [RACObserve(self.model, fullsizedData) map:^id(id value) {
            return [UIImage imageWithData:value];
        }];
    }
    return self;
}

- (NSString *)photoName
{
    return self.model.photoName;
}

@end
