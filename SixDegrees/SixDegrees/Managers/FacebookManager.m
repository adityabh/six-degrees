//
//  FacebookManager.m
//  SixDegrees
//
//  Created by Steven Wu on 2014-10-18.
//  Copyright (c) 2014 Steven Wu. All rights reserved.
//

#import "FacebookManager.h"
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import "FacebookAccount.h"
#import "ApiError.h"

@interface FacebookManager ()

@property (strong, nonatomic) FacebookAccount *facebookAccount;

@end

@implementation FacebookManager

+ (BSInitializer *)bsInitializer {
    return [BSInitializer initializerWithClass:self
                                      selector:@selector(init)
                                  argumentKeys:nil];
}

#pragma mark - Public Properties

- (BOOL)hasOpenSession {
    return FBSession.activeSession.state == FBSessionStateOpen;
}

- (NSArray *)readPermissions {
    return @[@"public_profile", @"email"];
}

- (NSString *)accessToken {
    if (self.hasOpenSession) {
        return FBSession.activeSession.accessTokenData.accessToken;
    }
    return nil;
}

- (FbSessionStateChangeHandler)stateChangeHandler {
    return [self stateChangeHandlerWithOpenedBlock:nil closedBlock:nil errorBlock:nil];
}

#pragma mark - Public Methods

- (void)openSession {
    [self openSessionWithStateChangeHandler:self.stateChangeHandler];
}

- (void)closeSession {
    FBSessionState state = FBSession.activeSession.state;
    if (state == FBSessionStateOpen || state == FBSessionStateOpenTokenExtended) {
        [FBSession.activeSession closeAndClearTokenInformation];
    }
}

- (void)fetchFbUserWithSuccess:(VoidBlock)success failure:(ApiErrorBlock)failure {
    
    VoidBlock fetchUserBlock = ^ {
        [[FBRequest requestForMe] startWithCompletionHandler:^(FBRequestConnection *connection, NSDictionary<FBGraphUser> *user, NSError *error) {
            if (!error) {
                self.facebookAccount = [MTLJSONAdapter modelOfClass:FacebookAccount.class fromJSONDictionary:user error:nil];
                if (success) {
                    success();
                }
            } else {
#warning ERROR-HANDLING:  handle failed fb graph user fetch request
                failure(nil);
            }
        }];
    };
    
    if (self.hasOpenSession) {
        fetchUserBlock();
    } else {
        [self openSessionWithStateChangeHandler:[self stateChangeHandlerWithOpenedBlock:fetchUserBlock closedBlock:fetchUserBlock errorBlock:failure]];
    }
}

#pragma mark - Helpers

- (void)openSessionWithStateChangeHandler:(FbSessionStateChangeHandler)stateChangeHandler {
    FBSessionState state = FBSession.activeSession.state;
    if (state == FBSessionStateCreatedTokenLoaded) {
        [self attemptOpenActiveSessionWithUiPrompt:NO stateChangeHandler:stateChangeHandler];
    } else if (state != FBSessionStateOpen && state != FBSessionStateOpenTokenExtended) {
        [self attemptOpenActiveSessionWithUiPrompt:YES stateChangeHandler:stateChangeHandler];
    }
}

- (void)attemptOpenActiveSessionWithUiPrompt:(BOOL)withUiPrompt stateChangeHandler:(FbSessionStateChangeHandler)stateChangeHandler {
    [FBSession openActiveSessionWithReadPermissions:self.readPermissions
                                       allowLoginUI:withUiPrompt
                                  completionHandler:stateChangeHandler];
}

- (FbSessionStateChangeHandler)stateChangeHandlerWithOpenedBlock:(VoidBlock)openedBlock closedBlock:(VoidBlock)closedBlock errorBlock:(ApiErrorBlock)errorBlock {
    return ^ (FBSession *session, FBSessionState state, NSError *error) {
        if (!error && state == FBSessionStateOpen) {
            if (openedBlock) {
                openedBlock();
            }
            return;
        }
        
        if (state == FBSessionStateClosed || state == FBSessionStateClosedLoginFailed) {
            if (closedBlock) {
                closedBlock();
            }
        }
        
        if (error) {
            if (errorBlock) {
                errorBlock([self apiErrorFromSessionStateChangeError:error]);
            }
            [FBSession.activeSession closeAndClearTokenInformation];
        }
    };
}

#pragma mark - Error Handling

- (ApiError *)apiErrorFromSessionStateChangeError:(NSError *)error
{
    ApiError *apiError;
    if ([FBErrorUtility shouldNotifyUserForError:error] == YES) {
        apiError = [ApiError errorWithType:kFbExternalActionRequired userMessage:kErrorFbExternalActionRequired];
    } else {
        apiError = [self apiErrorForFbErrorCategory:[FBErrorUtility errorCategoryForError:error]];;
    }
    return apiError;
}

- (ApiError *)apiErrorForFbErrorCategory:(FBErrorCategory)fbErrorCategory {
    ApiError *apiError;
    switch (fbErrorCategory) {
        case FBErrorCategoryUserCancelled:
            apiError = [ApiError errorWithType:kFbCancelledLogin userMessage:kErrorFbCancelledLogin];
            break;
        case FBErrorCategoryAuthenticationReopenSession:
            apiError = [ApiError errorWithType:kFbSessionExpired userMessage:kErrorFbSessionExpired];
            break;
        case FBErrorCategoryPermissions:
            apiError = [ApiError errorWithType:kFbMissingPermission userMessage:kErrorFbMissingPermission];
            break;
        case FBErrorCategoryRetry:
            // retry x number of times?
            break;
        default:
            apiError = [ApiError errorWithType:kFbOther userMessage:kErrorFbOther];
            break;
    }
    return apiError;
}

@end
