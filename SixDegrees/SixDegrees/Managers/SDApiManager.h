//
//  SDApiManager.h
//  SixDegrees
//
//  Created by Steven Wu on 2014-10-18.
//  Copyright (c) 2014 Steven Wu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SDApiManager : NSObject

#pragma mark - Authentication

- (void)authenticateWithFacebookId:(NSString *)facebookId
                     facebookToken:(NSString *)facebookToken
                         userEmail:(NSString *)userEmail
                           success:(VoidBlock)success
                           failure:(ErrorBlock)failure;

#pragma mark - Dreams

- (void)fetchDreamsWithSuccess:(VoidBlock)success
                       failure:(ErrorBlock)failure;

- (KSPromise *)createDreamForUser:(NSString *)userId
                 dreamType:(NSString *)dreamType
          dreamDescription:(NSString *)dreamDescription;
- (KSPromise *)fetchDream:(NSString *)dreamId;
- (KSPromise *)updateDream:(NSString *)dreamId
               user:(NSString *)userId
          dreamType:(NSString *)dreamType
   dreamDescription:(NSString *)dreamDescription;
- (KSPromise *)deleteDream:(NSString *)dreamId;

@end
