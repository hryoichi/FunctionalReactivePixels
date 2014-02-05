//
//  HRYGalleryViewController.m
//  FunctionalReactivePixels
//
//  Created by Ryoichi Hara on 2014/02/04.
//  Copyright (c) 2014年 Ryoichi Hara. All rights reserved.
//

#import "HRYGalleryViewController.h"
#import "HRYGalleryFlowLayout.h"
#import "HRYPhotoImporter.h"
#import "HRYCell.h"
#import "HRYFullSizePhotoViewController.h"

static NSString * const kCellIdentifier = @"Cell";

@interface HRYGalleryViewController () <HRYFullSizePhotoViewControllerDelegate>

@property (nonatomic, strong) NSArray *photosArray;

@end

@implementation HRYGalleryViewController

#pragma mark - Lifecycle

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

    self.title = @"Popular on 500px";

    [self.collectionView registerClass:[HRYCell class] forCellWithReuseIdentifier:kCellIdentifier];

    @weakify(self);
    [RACObserve(self, photosArray) subscribeNext:^(id x) {
        @strongify(self);
        [self.collectionView reloadData];
    }];

    [self loadPopularPhotos];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - Public

#pragma mark - Private

- (void)loadPopularPhotos
{
    [[HRYPhotoImporter importPhotos] subscribeNext:^(id x) {
        self.photosArray = x;
    } error:^(NSError *error) {
        NSLog(@"Couldn't fetch photos from 500px: %@", error);
    }];
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [self.photosArray count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    HRYCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kCellIdentifier forIndexPath:indexPath];

    [cell setPhotoModel:self.photosArray[indexPath.row]];

    return cell;
}

#pragma mark - UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    HRYFullSizePhotoViewController *viewController =
    [[HRYFullSizePhotoViewController alloc] initWithPhotoModels:self.photosArray
                                              currentPhotoIndex:indexPath.item];
    viewController.delegate = self;
    [self.navigationController pushViewController:viewController animated:YES];
}

#pragma mark - HRYFullSizePhotoViewControllerDelegate

- (void)userDidScroll:(HRYFullSizePhotoViewController *)viewController toPhotoAtIndex:(NSInteger)index
{
    [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:index inSection:0]
                                atScrollPosition:UICollectionViewScrollPositionCenteredVertically
                                        animated:NO];
}

@end
