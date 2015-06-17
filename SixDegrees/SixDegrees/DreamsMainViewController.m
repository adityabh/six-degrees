//
//  DreamsMainViewController.m
//  SixDegrees
//
//  Created by Bhalla, Aditya on 6/7/15.
//  Copyright (c) 2015 Steven Wu. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#define CORNER_RADIUS 4

#import "DreamsMainViewController.h"
#import "AllDreamsViewControllerTableViewController.h"
#define CENTER_TAG 1

#import "LeftPanelViewController.h"
#define LEFT_PANEL_TAG 2

#import "ViewControllerFactory.h"

#define SLIDE_TIMING .25
#define PANEL_WIDTH 60


@interface DreamsMainViewController () <AllDreamsViewControllerTableViewControllerDelegate>

    @property (strong, nonatomic) id<BSInjector> injector;
    @property (strong, nonatomic) ViewControllerFactory *vcFactory;
    @property (nonatomic, assign) BOOL showingLeftPanel;

@end

@implementation DreamsMainViewController

#pragma mark - Blindside Initializer

+ (BSInitializer *)bsInitializer {
    return [BSInitializer initializerWithClass:self
                                      selector:@selector(initWithViewControllerFactory:)
                                  argumentKeys:[ViewControllerFactory class], nil];
}

- (instancetype)initWithViewControllerFactory:(ViewControllerFactory *)viewControllerFactory {
    self = [super init];
    if (self) {
        _vcFactory = viewControllerFactory;
    }
    return self;
}


#pragma mark -
#pragma mark View Did Load/Unload

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupView];
}

- (void)viewDidUnload {
    [super viewDidUnload];
}

#pragma mark -
#pragma mark View Will/Did Appear

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:animated];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

#pragma mark -
#pragma mark View Will/Did Disappear

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:animated];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
}

#pragma mark -
#pragma mark Setup View

- (void)setupView {
    
    self.centerViewController.view.tag = CENTER_TAG;
    
    [self.view addSubview:self.centerViewController.view];
    
    UINavigationController *childNavController = [[UINavigationController alloc] initWithRootViewController:_centerViewController];
    childNavController.view.frame = _centerViewController.view.frame;
    
    [self addChildViewController:_centerViewController];
    
    [_centerViewController didMoveToParentViewController:self];
    [childNavController didMoveToParentViewController:self];
}

- (void)showCenterViewWithShadow:(BOOL)value withOffset:(double)offset {
    if (value)
    {
        [_centerViewController.view.layer setCornerRadius:CORNER_RADIUS];
        [_centerViewController.view.layer setShadowColor:[UIColor blackColor].CGColor];
        [_centerViewController.view.layer setShadowOpacity:0.8];
        [_centerViewController.view.layer setShadowOffset:CGSizeMake(offset, offset)];
        
    }
    else
    {
        [_centerViewController.view.layer setCornerRadius:0.0f];
        [_centerViewController.view.layer setShadowOffset:CGSizeMake(offset, offset)];
    }
}

- (void)resetMainView {
    // remove left view and reset variables, if needed
    if (_leftPanelViewController != nil)
    {
        [self.leftPanelViewController.view removeFromSuperview];
        self.leftPanelViewController = nil;
        
        self.centerViewController.leftBarButton.tag = 1;
        self.showingLeftPanel = NO;
    }
    
    // remove view shadows
    [self showCenterViewWithShadow:NO withOffset:0];
}

- (UIView *)getLeftView {
    // init view if it doesn't already exist
    if (_leftPanelViewController == nil)
    {
        // this is where you define the view for the left panel
        self.leftPanelViewController = [[LeftPanelViewController alloc] initWithNibName:@"LeftPanelViewController" bundle:nil];
        self.leftPanelViewController.view.tag = LEFT_PANEL_TAG;
        self.leftPanelViewController.delegate = _centerViewController;
        
        [self.view addSubview:self.leftPanelViewController.view];
        
        [self addChildViewController:_leftPanelViewController];
        [_leftPanelViewController didMoveToParentViewController:self];
        
        _leftPanelViewController.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
        
        _leftPanelViewController.nameLabel.text = [NSString stringWithFormat:@"%@ %@", self.user.firstName, self.user.lastName];
        _leftPanelViewController.profileImage.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:self.user.largeAvatar]]];;
    }
    
    self.showingLeftPanel = YES;
    
    // set up view shadows
    [self showCenterViewWithShadow:YES withOffset:-2];
    
    UIView *view = self.leftPanelViewController.view;
    return view;
}

#pragma mark -
#pragma mark Swipe Gesture Setup/Actions

#pragma mark - setup

- (void)setupGestures {
}

-(void)movePanel:(id)sender {
}

#pragma mark -
#pragma mark Delegate Actions

- (void)movePanelRight { // to show left panel
    UIView *childView = [self getLeftView];
    [self.view sendSubviewToBack:childView];
    
    [UIView animateWithDuration:SLIDE_TIMING delay:0 options:UIViewAnimationOptionBeginFromCurrentState
                     animations:^{
                         _centerViewController.view.frame = CGRectMake(self.view.frame.size.width - PANEL_WIDTH, 0, self.view.frame.size.width, self.view.frame.size.height);
                     }
                     completion:^(BOOL finished) {
                         if (finished) {
                             
                             self.centerViewController.leftBarButton.tag = 0;
                         }
                     }];
}

- (void)movePanelToOriginalPosition {
    [UIView animateWithDuration:SLIDE_TIMING delay:0 options:UIViewAnimationOptionBeginFromCurrentState
                     animations:^{
                         _centerViewController.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
                     }
                     completion:^(BOOL finished) {
                         if (finished) {
                             
                             [self resetMainView];
                         }
                     }];
}

#pragma mark -
#pragma mark Default System Code

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
    }
    return self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)didLogout {
    [self.delegate didLogout];
}

#pragma mark - Navigation

- (IBAction)unwindToAllDreams:(UIStoryboardSegue *)segue {
    
}

- (void)optionSelected:(NSString *)option {
    if ([option isEqualToString:@"Logout"]) {
        [self.delegate didLogout];
    };
    
    if ([option isEqualToString:@"How it works"]) {
        [self.delegate showHowItWorks];
    };
}

@end
