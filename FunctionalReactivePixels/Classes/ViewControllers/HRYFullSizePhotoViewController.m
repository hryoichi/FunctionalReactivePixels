//
//  HRYFullSizePhotoViewController.m
//  FunctionalReactivePixels
//
//  Created by Ryoichi Hara on 2014/02/05.
//  Copyright (c) 2014年 Ryoichi Hara. All rights reserved.
//

#import "HRYFullSizePhotoViewController.h"
#import "HRYPhotoModel.h"
#import "HRYPhotoViewController.h"

@interface HRYFullSizePhotoViewController () <UIPageViewControllerDataSource, UIPageViewControllerDelegate>

@property (nonatomic, copy, readwrite) NSArray *photoModelArray;
@property (nonatomic, strong) UIPageViewController *pageViewController;

@end

@implementation HRYFullSizePhotoViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (instancetype)initWithPhotoModels:(NSArray *)photoModelArray currentPhotoIndex:(NSInteger)photoIndex
{
    if (self = [super initWithNibName:nil bundle:nil]) {
        self.photoModelArray = photoModelArray;
        self.title = [self.photoModelArray[photoIndex] photoName];
        self.pageViewController =
        [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll
                                        navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal
                                                      options:@{UIPageViewControllerOptionInterPageSpacingKey: @(30)}];
        self.pageViewController.dataSource = self;
        self.pageViewController.delegate   = self;
        [self addChildViewController:self.pageViewController];

        [self.pageViewController setViewControllers:@[[self photoViewControllerForIndex:photoIndex]]
                                          direction:UIPageViewControllerNavigationDirectionForward
                                           animated:NO
                                         completion:nil];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor blackColor];
    self.pageViewController.view.frame = self.view.bounds;
    [self.view addSubview:self.pageViewController.view];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Public

#pragma mark - Public (Override)

#pragma mark - Private

- (HRYPhotoViewController *)photoViewControllerForIndex:(NSInteger)index
{
    if (index >= 0 && index < [self.photoModelArray count]) {
        HRYPhotoModel *photoModel = self.photoModelArray[index];
        HRYPhotoViewController *photoVC = [[HRYPhotoViewController alloc] initWithPhotoModel:photoModel index:index];
        return photoVC;
    }
    return nil;
}

#pragma mark - UIPageViewControllerDataSource

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(HRYPhotoViewController *)viewController
{
    return [self photoViewControllerForIndex:(viewController.photoIndex - 1)];
}
- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(HRYPhotoViewController *)viewController
{
    return [self photoViewControllerForIndex:(viewController.photoIndex + 1)];
}

#pragma mark - UIPageViewControllerDelegate

- (void)pageViewController:(UIPageViewController *)pageViewController didFinishAnimating:(BOOL)finished previousViewControllers:(NSArray *)previousViewControllers transitionCompleted:(BOOL)completed
{
    self.title = [[self.pageViewController.viewControllers.firstObject photoModel] photoName];

    if ([self.delegate respondsToSelector:@selector(userDidScroll:toPhotoAtIndex:)]) {
        [self.delegate userDidScroll:self
                      toPhotoAtIndex:[self.pageViewController.viewControllers.firstObject photoIndex]];
    }
}

@end
