//
//  SDApiManager.m
//  SixDegrees
//
//  Created by Steven Wu on 2014-10-18.
//  Copyright (c) 2014 Steven Wu. All rights reserved.
//

#import "SDApiManager.h"
#import "SDSessionManager.h"
#import "SDEndpoints.h"

#import "UserDream.h"

@interface SDApiManager ()

@property (strong, nonatomic) SDSessionManager *sessionManager;

@end

@implementation SDApiManager

+ (BSInitializer *)bsInitializer {
    return [BSInitializer initializerWithClass:self
                                      selector:@selector(initWithBaseUrl:)
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

- (void)fetchDreamsWithSuccess:(VoidBlock)success
                       failure:(ErrorBlock)failure
{
    [self.sessionManager GET:[SDEndpoints fetchDreams] parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        NSMutableArray *dreams = [NSMutableArray array];
        for (id item in responseObject) {
            UserDream *userDream = [MTLJSONAdapter modelOfClass:UserDream.class fromJSONDictionary:item error:nil];
            [dreams addObject:userDream];
        }
        if (success) {
            success(dreams);
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

@end
