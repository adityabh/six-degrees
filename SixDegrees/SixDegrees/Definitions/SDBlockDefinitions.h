//
//  SDBlockDefinitions.h
//  SixDegrees
//
//  Created by Steven Wu on 2014-10-18.
//  Copyright (c) 2014 Steven Wu. All rights reserved.
//

#import "ApiError.h"
#import <FacebookSDK/FacebookSDK.h>

#pragma mark -

typedef void(^VoidBlock)();
typedef void(^ErrorBlock)(NSError *error);
typedef void(^ApiErrorBlock)(ApiError *apiError);

#pragma mark - Facebook

typedef void(^FbSessionStateChangeHandler)(FBSession *session, FBSessionState state, NSError *error);