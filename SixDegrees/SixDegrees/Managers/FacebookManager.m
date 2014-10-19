//
//  FacebookManager.m
//  SixDegrees
//
//  Created by Steven Wu on 2014-10-18.
//  Copyright (c) 2014 Steven Wu. All rights reserved.
//

#import "FacebookManager.h"
#import <Social/Social.h>
#import <Accounts/Accounts.h>
#import <FacebookSDK/FacebookSDK.h>

@interface FacebookManager () <FBLoginViewDelegate>

@end

@implementation FacebookManager

+ (BSInitializer *)bsInitializer {
    return [BSInitializer initializerWithClass:self
                                      selector:@selector(init)
                                  argumentKeys:nil];
}

- (instancetype)init {
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (UIView *)fbLoginView {
    FBLoginView *loginView = [[FBLoginView alloc] initWithReadPermissions:@[@"public_profile", @"email"]];
    loginView.delegate = self;
    return loginView;
}

#pragma mark - FBLoginViewDelegate

- (void)loginViewFetchedUserInfo:(FBLoginView *)loginView user:(id<FBGraphUser>)user {
    
}

- (void)loginViewShowingLoggedInUser:(FBLoginView *)loginView {
    
}

- (void)loginViewShowingLoggedOutUser:(FBLoginView *)loginView {
    
}

- (void)loginView:(FBLoginView *)loginView handleError:(NSError *)error {
    
}

@end
