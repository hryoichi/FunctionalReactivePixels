//
//  HRYGalleryViewController.m
//  FunctionalReactivePixels
//
//  Created by Ryoichi Hara on 2014/02/04.
//  Copyright (c) 2014年 Ryoichi Hara. All rights reserved.
//

#import "HRYGalleryViewController.h"
#import "HRYGalleryFlowLayout.h"
#import "HRYCell.h"
#import "HRYFullSizePhotoViewController.h"
#import "HRYFullSizePhotoViewModel.h"
#import "HRYGalleryViewModel.h"

static NSString * const kCellIdentifier = @"Cell";

@interface HRYGalleryViewController ()

@property (nonatomic, strong) HRYGalleryViewModel *viewModel;

@end

@implementation HRYGalleryViewController

#pragma mark - Lifecycle

- (id)init
{
    if (self = [super initWithCollectionViewLayout:[HRYGalleryFlowLayout new]]) {
        self.viewModel = [HRYGalleryViewModel new];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.title = @"Popular on 500px";

    [self.collectionView registerClass:[HRYCell class] forCellWithReuseIdentifier:kCellIdentifier];

    @weakify(self);
    [RACObserve(self.viewModel, model) subscribeNext:^(id x) {
        @strongify(self);
        [self.collectionView reloadData];
    }];

    [[self rac_signalForSelector:@selector(userDidScroll:toPhotoAtIndex:) fromProtocol:@protocol(HRYFullSizePhotoViewControllerDelegate)] subscribeNext:^(RACTuple *value) {
        @strongify(self);
        [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:[value.second  integerValue] inSection:0] atScrollPosition:UICollectionViewScrollPositionCenteredVertically animated:NO];
    }];

    [[self rac_signalForSelector:@selector(collectionView:didSelectItemAtIndexPath:) fromProtocol:@protocol(UICollectionViewDelegate)] subscribeNext:^(RACTuple *arguments) {
        @strongify(self);

        NSIndexPath *indexPath = arguments.second;
        HRYFullSizePhotoViewModel *viewModel =
        [[HRYFullSizePhotoViewModel alloc] initWithPhotoArray:self.viewModel.model initialPhotoIndex:indexPath.item];

        HRYFullSizePhotoViewController *viewController = [HRYFullSizePhotoViewController new];
        viewController.viewModel = viewModel;
        viewController.delegate = (id<HRYFullSizePhotoViewControllerDelegate>)self;
        [self.navigationController pushViewController:viewController animated:YES];
    }];

    // NOTE: Need to "reset" the cached values of respondsToSelector: of UIKit
    self.collectionView.delegate = self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - Public

#pragma mark - Private

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [self.viewModel.model count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    HRYCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kCellIdentifier forIndexPath:indexPath];

    [cell setPhotoModel:self.viewModel.model[indexPath.row]];

    return cell;
}

@end
