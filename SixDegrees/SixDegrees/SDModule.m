//
//  SDModule.m
//  SixDegrees
//
//  Created by Steven Wu on 2014-10-18.
//  Copyright (c) 2014 Steven Wu. All rights reserved.
//

#import "SDModule.h"

#import "SDAPIManager.h"
#import "UserManager.h"

@implementation SDModule

- (void)configure:(id<BSBinder>)binder {
    [binder bind:@"sdApiUrl" toInstance:[NSURL URLWithString:@"http://six-degrees-app.herokuapp.com/"]];
    [binder bind:[SDAPIManager class] withScope:[BSSingleton scope]];
    [binder bind:[UserManager class] withScope:[BSSingleton scope]];
}

@end
