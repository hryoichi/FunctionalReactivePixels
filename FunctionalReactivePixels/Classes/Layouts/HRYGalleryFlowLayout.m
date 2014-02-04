//
//  HRYGalleryFlowLayout.m
//  FunctionalReactivePixels
//
//  Created by Ryoichi Hara on 2014/02/04.
//  Copyright (c) 2014年 Ryoichi Hara. All rights reserved.
//

#import "HRYGalleryFlowLayout.h"

@implementation HRYGalleryFlowLayout

- (id)init
{
    if (self = [super init]) {
        self.itemSize = CGSizeMake(145.0f, 145.0f);
        self.minimumInteritemSpacing = 10.0f;
        self.minimumLineSpacing = 10.0f;
        self.sectionInset = UIEdgeInsetsMake(10.0f, 10.0f, 10.0f, 10.0f);
    }
    return self;
}

@end
