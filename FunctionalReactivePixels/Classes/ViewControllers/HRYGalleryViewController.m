//
//  HRYGalleryViewController.m
//  FunctionalReactivePixels
//
//  Created by Ryoichi Hara on 2014/02/04.
//  Copyright (c) 2014年 Ryoichi Hara. All rights reserved.
//

#import "HRYGalleryViewController.h"
#import "HRYGalleryFlowLayout.h"

@interface HRYGalleryViewController ()

@end

@implementation HRYGalleryViewController

- (id)init
{
    if (self = [super initWithCollectionViewLayout:[HRYGalleryFlowLayout new]]) {
        // Custom Initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
