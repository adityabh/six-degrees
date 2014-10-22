//
//  FacebookManager.h
//  SixDegrees
//
//  Created by Steven Wu on 2014-10-18.
//  Copyright (c) 2014 Steven Wu. All rights reserved.
//

#import <Foundation/Foundation.h>

@class FacebookAccount;

@interface FacebookManager : NSObject

@property (strong, nonatomic, readonly) FacebookAccount *facebookAccount;
@property (nonatomic, readonly) BOOL hasOpenSession;
@property (nonatomic, readonly) NSArray *readPermissions;
@property (nonatomic, readonly) NSString *accessToken;
@property (nonatomic, readonly) FbSessionStateChangeHandler stateChangeHandler;

- (void)openSession;
- (void)closeSession;
- (void)fetchFbUserWithSuccess:(VoidBlock)success failure:(ApiErrorBlock)failure;

@end
