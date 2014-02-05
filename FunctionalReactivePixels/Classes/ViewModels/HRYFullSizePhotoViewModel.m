//
//  HRYFullSizePhotoViewModel.m
//  FunctionalReactivePixels
//
//  Created by Ryoichi Hara on 2014/02/05.
//  Copyright (c) 2014年 Ryoichi Hara. All rights reserved.
//

#import "HRYFullSizePhotoViewModel.h"
#import "HRYPhotoModel.h"

@interface HRYFullSizePhotoViewModel ()

@property (nonatomic, assign, readwrite) NSInteger initialPhotoIndex;

@end

@implementation HRYFullSizePhotoViewModel

- (instancetype)initWithPhotoArray:(NSArray *)photoArray initialPhotoIndex:(NSInteger)initialPhotoIndex
{
    if (self = [super initWithModel:photoArray]) {
        self.initialPhotoIndex = initialPhotoIndex;
    }
    return self;
}

- (NSString *)initialPhotoName
{
    return [[self photoModelAtIndex:self.initialPhotoIndex] photoName];
}

- (HRYPhotoModel *)photoModelAtIndex:(NSInteger)index
{
    if (index < 0 || index > ([self.model count] - 1)) {
        return nil;
    }
    else {
        return self.model[index];
    }
}

@end
