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
#import "HRYFullSizePhotoViewModel.h"
#import "HRYPhotoViewModel.h"

@interface HRYFullSizePhotoViewController () <UIPageViewControllerDataSource, UIPageViewControllerDelegate>

@property (nonatomic, strong) UIPageViewController *pageViewController;

@end

@implementation HRYFullSizePhotoViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.pageViewController =
        [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll
                                        navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal
                                                      options:@{UIPageViewControllerOptionInterPageSpacingKey: @(30)}];
        self.pageViewController.dataSource = self;
        self.pageViewController.delegate   = self;
        [self addChildViewController:self.pageViewController];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor blackColor];
    self.pageViewController.view.frame = self.view.bounds;
    [self.view addSubview:self.pageViewController.view];

    [self.pageViewController setViewControllers:@[[self photoViewControllerForIndex:self.viewModel.initialPhotoIndex]]
                                      direction:UIPageViewControllerNavigationDirectionForward
                                       animated:NO completion:nil];
    self.title = self.viewModel.initialPhotoName;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - Public

#pragma mark - Public (Override)

#pragma mark - Private

- (HRYPhotoViewController *)photoViewControllerForIndex:(NSInteger)index
{
    HRYPhotoModel *photoModel = [self.viewModel photoModelAtIndex:index];
    if (photoModel) {
        HRYPhotoViewModel *photoViewModel = [[HRYPhotoViewModel alloc] initWithModel:photoModel];
        HRYPhotoViewController *photoVC = [[HRYPhotoViewController alloc] initWithViewModel:photoViewModel index:index];
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
    self.title = [((HRYPhotoViewController *)self.pageViewController.viewControllers.firstObject).viewModel photoName];

    if ([self.delegate respondsToSelector:@selector(userDidScroll:toPhotoAtIndex:)]) {
        [self.delegate userDidScroll:self
                      toPhotoAtIndex:[self.pageViewController.viewControllers.firstObject photoIndex]];
    }
}

@end
