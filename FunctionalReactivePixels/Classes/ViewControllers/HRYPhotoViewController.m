//
//  HRYPhotoViewController.m
//  FunctionalReactivePixels
//
//  Created by Ryoichi Hara on 2014/02/05.
//  Copyright (c) 2014年 Ryoichi Hara. All rights reserved.
//

#import "HRYPhotoViewController.h"
#import "HRYPhotoViewModel.h"
#import <SVProgressHUD/SVProgressHUD.h>

@interface HRYPhotoViewController ()

@property (nonatomic, assign, readwrite) NSInteger photoIndex;
@property (nonatomic, strong, readwrite) HRYPhotoViewModel *viewModel;
@property (nonatomic, weak) UIImageView *imageView;

@end

@implementation HRYPhotoViewController

#pragma mark - Lifecycle

- (instancetype)initWithViewModel:(HRYPhotoViewModel *)viewModel index:(NSInteger)photoIndex
{
    if (self = [super initWithNibName:nil bundle:nil]) {
        self.photoIndex = photoIndex;
        self.viewModel = viewModel;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor blackColor];

    UIImageView *imageView = [[UIImageView alloc] initWithFrame:self.view.bounds];
    RAC(imageView, image) = RACObserve(self.viewModel, photoImage);
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    [self.view addSubview:imageView];
    self.imageView = imageView;

    [RACObserve(self.viewModel, loading) subscribeNext:^(NSNumber *loading) {
        if ([loading boolValue]) {
            [SVProgressHUD show];
        }
        else {
            [SVProgressHUD dismiss];
        }
    }];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

    self.viewModel.active = YES;
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];

    self.viewModel.active = NO;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - Public

#pragma mark - Private

@end
