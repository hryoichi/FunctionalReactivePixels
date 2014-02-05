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
#import <ReactiveCocoa/ReactiveCocoa/RACDelegateProxy.h>

static NSString * const kCellIdentifier = @"Cell";

@interface HRYGalleryViewController ()

// NOTE: You must retain the delegate object
@property (nonatomic, strong) id collectionViewDelegate;
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

    RACDelegateProxy *viewControllerDelegate = [[RACDelegateProxy alloc] initWithProtocol:@protocol(HRYFullSizePhotoViewControllerDelegate)];

    [[viewControllerDelegate
      rac_signalForSelector:@selector(userDidScroll:toPhotoAtIndex:)
      fromProtocol:@protocol(HRYFullSizePhotoViewControllerDelegate)] subscribeNext:^(RACTuple *value) {
        @strongify(self);
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:[value.second integerValue] inSection:0];
        [self.collectionView scrollToItemAtIndexPath:indexPath
                                    atScrollPosition:UICollectionViewScrollPositionCenteredVertically
                                            animated:NO];
    }];

    self.collectionViewDelegate = [[RACDelegateProxy alloc] initWithProtocol:@protocol(UICollectionViewDelegate)];
    [[self.collectionViewDelegate rac_signalForSelector:@selector(collectionView:didSelectItemAtIndexPath:)]subscribeNext:^(RACTuple *arguments) {
        @strongify(self);
        HRYFullSizePhotoViewController *viewController =
        [[HRYFullSizePhotoViewController alloc] initWithPhotoModels:self.photosArray
                                                  currentPhotoIndex:[(NSIndexPath *)arguments.second item]];
        viewController.delegate = (id <HRYFullSizePhotoViewControllerDelegate>)viewControllerDelegate;
        [self.navigationController pushViewController:viewController animated:YES];
    }];

    RAC(self, photosArray) = [[[[HRYPhotoImporter importPhotos] doCompleted:^{
        @strongify(self);
        [self.collectionView reloadData];
    }] logError] catchTo:[RACSignal empty]];
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
    return [self.photosArray count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    HRYCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kCellIdentifier forIndexPath:indexPath];

    [cell setPhotoModel:self.photosArray[indexPath.row]];

    return cell;
}

@end
