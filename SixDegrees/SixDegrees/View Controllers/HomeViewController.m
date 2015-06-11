//
//  HomeViewController.m
//  SixDegrees
//
//  Created by Steven Wu on 2014-10-18.
//  Copyright (c) 2014 Steven Wu. All rights reserved.
//

#import "HomeViewController.h"
#import "iCarousel.h"

@interface HomeViewController () <iCarouselDataSource, iCarouselDelegate>

@property (weak, nonatomic) IBOutlet iCarousel *carousel;
@property (weak, nonatomic) IBOutlet UIPageControl *pageControl;


@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupCarousel];
    [self setupPageControl];
}

#pragma mark - Setup

- (void)setupCarousel {
    self.carousel.dataSource = self;
    self.carousel.delegate = self;
    self.carousel.pagingEnabled = YES;
    self.carousel.bounces = NO;
    self.carousel.backgroundColor = [UIColor whiteColor];
}

- (void)setupPageControl {
    self.pageControl.numberOfPages = [[self carouselItems] count];
    self.pageControl.currentPage = 0;
    self.pageControl.pageIndicatorTintColor = [UIColor lightGrayColor];
    self.pageControl.currentPageIndicatorTintColor = [UIColor blackColor];
    self.pageControl.backgroundColor = [UIColor clearColor];
}

#pragma mark - iCarouselDataSource

- (NSInteger)numberOfItemsInCarousel:(iCarousel *)carousel {
    return [[self carouselItems] count];
}

- (UIView *)carousel:(iCarousel *)carousel viewForItemAtIndex:(NSInteger)index reusingView:(UIView *)view {
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0,
                                                                           carousel.frame.size.width * 0.65,
                                                                           carousel.frame.size.height * 0.85)];
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    imageView.image = [self carouselItems][index];
    return imageView;
}

#pragma mark - iCarouselDelegate

- (CGFloat)carousel:(iCarousel *)carousel valueForOption:(iCarouselOption)option withDefault:(CGFloat)value {
    switch (option) {
        case iCarouselOptionFadeMax:
            return 0.1;
        case iCarouselOptionFadeMin:
            return -0.1;
        case iCarouselOptionFadeRange:
            return 1.0;
        case iCarouselOptionWrap:
            return YES;
        default:
            return value;
    }
}

-(void)carouselCurrentItemIndexDidChange:(iCarousel *)carousel {
    [self.pageControl setCurrentPage:carousel.currentItemIndex];
}

#pragma mark - IBAction

- (IBAction)bottomViewSwiped:(id)sender {
    [self.delegate didSwipeRightToContinue];
}

#pragma mark -

- (NSArray *)carouselItems {
    return @[
             [UIImage imageNamed:@"SDIntro1"],
             [UIImage imageNamed:@"SDIntro2"],
             [UIImage imageNamed:@"SDIntro3"],
             [UIImage imageNamed:@"SDIntro4"],
             ];
}

@end
