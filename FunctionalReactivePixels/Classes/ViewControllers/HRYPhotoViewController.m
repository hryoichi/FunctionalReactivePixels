//
//  HRYPhotoViewController.m
//  FunctionalReactivePixels
//
//  Created by Ryoichi Hara on 2014/02/05.
//  Copyright (c) 2014年 Ryoichi Hara. All rights reserved.
//

#import "HRYPhotoViewController.h"
#import "HRYPhotoModel.h"
#import "HRYPhotoImporter.h"
#import <SVProgressHUD/SVProgressHUD.h>

@interface HRYPhotoViewController ()

@property (nonatomic, assign, readwrite) NSInteger photoIndex;
@property (nonatomic, strong, readwrite) HRYPhotoModel *photoModel;
@property (nonatomic, weak) UIImageView *imageView;

@end

@implementation HRYPhotoViewController

#pragma mark - Lifecycle

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (instancetype)initWithPhotoModel:(HRYPhotoModel *)photoModel index:(NSInteger)photoIndex
{
    if (self = [super initWithNibName:nil bundle:nil]) {
        self.photoIndex = photoIndex;
        self.photoModel = photoModel;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor blackColor];

    UIImageView *imageView = [[UIImageView alloc] initWithFrame:self.view.bounds];
    RAC(imageView, image) = [RACObserve(self.photoModel, fullsizedData) map:^id(id value) {
        return [UIImage imageWithData:value];
    }];
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    [self.view addSubview:imageView];
    self.imageView = imageView;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

    [SVProgressHUD show];
    [[HRYPhotoImporter fetchPhotoDetails:self.photoModel] subscribeError:^(NSError *error) {
        [SVProgressHUD showErrorWithStatus:@"Error"];
    } completed:^{
        [SVProgressHUD dismiss];
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - Public

#pragma mark - Private

@end
