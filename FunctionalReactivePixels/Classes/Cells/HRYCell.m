//
//  HRYCell.m
//  FunctionalReactivePixels
//
//  Created by Ryoichi Hara on 2014/02/05.
//  Copyright (c) 2014年 Ryoichi Hara. All rights reserved.
//

#import "HRYCell.h"
#import "HRYPhotoModel.h"

@interface HRYCell ()

// The image view is a weak property, since it will belong to its superview.
@property (nonatomic, weak) UIImageView *imageView;

@end

@implementation HRYCell

#pragma mark - Lifecycle

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor darkGrayColor];
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:self.bounds];
        imageView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
        [self.contentView addSubview:imageView];
        self.imageView = imageView;

        RAC(self.imageView, image) =
        [[RACObserve(self, photoModel.thumbnailData) ignore:nil] map:^id(NSData *data) {
            return [UIImage imageWithData:data];
        }];
    }
    return self;
}

#pragma mark - Public

#pragma mark - Public (Override)

@end
