//
//  SDModule.m
//  SixDegrees
//
//  Created by Steven Wu on 2014-10-18.
//  Copyright (c) 2014 Steven Wu. All rights reserved.
//

#import "SDModule.h"

#import "ViewControllerFactory.h"
#import "MainNavigationRouter.h"
#import "AuthNavigationRouter.h"
#import "DreamViewController.h"

#import "SDApiManager.h"
#import "UserManager.h"
#import "FacebookManager.h"
#import "DreamManager.h"

@implementation SDModule

- (void)configure:(id<BSBinder>)binder {
    
    [binder bind:@"sdApiUrl" toInstance:[NSURL URLWithString:@"http://six-degrees-app.herokuapp.com/"]];
//    [binder bind:@"sdApiUrl" toInstance:[NSURL URLWithString:@"http://localhost:3000/"]];
    
    [binder bind:[ViewControllerFactory class] withScope:[BSSingleton scope]];
    [binder bind:[MainNavigationRouter class] withScope:[BSSingleton scope]];
    [binder bind:[AuthNavigationRouter class] withScope:[BSSingleton scope]];
    [binder bind:[DreamViewController class] withScope:[BSSingleton scope]];
    
    [binder bind:[SDApiManager class] withScope:[BSSingleton scope]];
    [binder bind:[UserManager class] withScope:[BSSingleton scope]];
    [binder bind:[FacebookManager class] withScope:[BSSingleton scope]];
    [binder bind:[DreamManager class] withScope:[BSSingleton scope]];
}

@end
