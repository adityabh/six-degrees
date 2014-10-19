//
//  SDAPIManager.m
//  SixDegrees
//
//  Created by Steven Wu on 2014-10-18.
//  Copyright (c) 2014 Steven Wu. All rights reserved.
//

#import "SDAPIManager.h"
#import "SDSessionManager.h"
#import "SDEndpoints.h"

@interface SDAPIManager ()

@property (strong, nonatomic) SDSessionManager *sessionManager;

@end

@implementation SDAPIManager

+ (BSInitializer *)bsInitializer {
    return [BSInitializer initializerWithClass:self
                                      selector:@selector(initWithBaseURL:)
                                  argumentKeys:@"sdApiUrl", nil];
}

- (instancetype)initWithBaseUrl:(NSURL *)baseUrl
{
    self = [super init];
    if (self) {
        _sessionManager = [[SDSessionManager alloc] initWithBaseURL:baseUrl];
    }
    return self;
}

#pragma mark - Authentication

- (void)authenticateWithFacebookId:(NSString *)facebookId
                     facebookToken:(NSString *)facebookToken
                         userEmail:(NSString *)userEmail
                           success:(VoidBlock)success
                           failure:(ErrorBlock)failure
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setValue:facebookId forKey:@"facebook_id"];
    [params setValue:facebookToken forKey:@"facebook_token"];
    [params setValue:userEmail forKey:@"user_email"];
    
    [self.sessionManager POST:[SDEndpoints authWithFacebook] parameters:params success:^(NSURLSessionDataTask *task, id responseObject) {
        if (success) {
            success();
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

@end
