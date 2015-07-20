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

- (void) loginUser: (NSString *) email
          password: (NSString *) password
           success:(VoidBlock)success
           failure:(VoidBlock)failure;

- (void) loginFacebookUser: (NSString *) uid
                   success:(VoidBlock)success
                   failure:(VoidBlock)failure;

- (void) signupUser: (NSString *) firstName
           lastName: (NSString *) lastName
              email: (NSString *) email
           password: (NSString *) password
            success:(VoidBlock)success
            failure:(VoidBlock)failure;

- (void) signupFacebookUser: (NSString *) uid
                  firstName: (NSString *) firstName
                   lastName: (NSString *) lastName
                      email: (NSString *) email
                       name: (NSString *) name
                     gender: (NSString *) gender
                   timezone: (NSString *) timezone
                    success:(VoidBlock)success
                    failure:(VoidBlock)failure;

- (void) getUser: (NSString *) authenticationToken
         success:(VoidBlock)success
         failure:(VoidBlock)failure;

#pragma mark - Dreams

- (void)fetchDreamsWithSuccess:(NSString *)authenticationToken
                       success:(VoidBlock)success
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

#pragma mark - Messages

- (KSPromise *)helpDream:(NSString *)message
                 dreamId:(NSNumber *)dreamId
             recipientId:(NSNumber *)recipientId
                 success:(VoidBlock)success
                 failure:(VoidBlock)failure;

@end
