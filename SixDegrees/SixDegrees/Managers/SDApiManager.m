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
#import "DreamResponse.h"

@interface SDApiManager ()

@property (strong, nonatomic) SDSessionManager *sessionManager;

@end

@implementation SDApiManager

+ (BSInitializer *)bsInitializer {
    return [BSInitializer initializerWithClass:self
                                      selector:@selector(initWithBaseUrl:)
                                  argumentKeys:@"sdApiUrl", nil];
}

- (instancetype)initWithBaseUrl:(NSURL *)baseUrl {
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
                           failure:(ErrorBlock)failure {
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

#pragma mark - Dreams

- (void)fetchDreamsWithSuccess:(VoidBlock)success
                       failure:(ErrorBlock)failure {
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

- (KSPromise *)createDreamForUser:(NSString *)userId
                 dreamType:(NSString *)dreamType
          dreamDescription:(NSString *)dreamDescription {
    KSDeferred *createDreamDeferred = [KSDeferred defer];
    [self.sessionManager POST:[SDEndpoints createDream] parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        DreamResponse *dreamResponse = [MTLJSONAdapter modelOfClass:DreamResponse.class fromJSONDictionary:responseObject error:nil];
        [createDreamDeferred resolveWithValue:dreamResponse.dream];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [createDreamDeferred rejectWithError:error];
    }];
    return createDreamDeferred.promise;
}

- (KSPromise *)fetchDream:(NSString *)dreamId {
    KSDeferred *fetchDreamDeferred = [KSDeferred defer];
    [self.sessionManager GET:[SDEndpoints fetchDreamWithId:dreamId] parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        DreamResponse *dreamResponse = [MTLJSONAdapter modelOfClass:DreamResponse.class fromJSONDictionary:responseObject error:nil];
        [fetchDreamDeferred resolveWithValue:dreamResponse.dream];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [fetchDreamDeferred rejectWithError:error];
    }];
    return fetchDreamDeferred.promise;
}

- (KSPromise *)updateDream:(NSString *)dreamId
               user:(NSString *)userId
          dreamType:(NSString *)dreamType
   dreamDescription:(NSString *)dreamDescription {
    KSDeferred *updateDreamDeferred = [KSDeferred defer];
    [self.sessionManager PUT:[SDEndpoints updateDreamWithId:dreamId] parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        DreamResponse *dreamResponse = [MTLJSONAdapter modelOfClass:DreamResponse.class fromJSONDictionary:responseObject error:nil];
        [updateDreamDeferred resolveWithValue:dreamResponse.dream];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [updateDreamDeferred rejectWithError:error];
    }];
    return updateDreamDeferred.promise;
}

- (KSPromise *)deleteDream:(NSString *)dreamId {
    KSDeferred *deleteDreamDeferred = [KSDeferred defer];
    [self.sessionManager DELETE:[SDEndpoints deleteDreamWithId:dreamId] parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        DreamResponse *dreamResponse = [MTLJSONAdapter modelOfClass:DreamResponse.class fromJSONDictionary:responseObject error:nil];
        [deleteDreamDeferred resolveWithValue:dreamResponse.dream];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [deleteDreamDeferred rejectWithError:error];
    }];
    return deleteDreamDeferred.promise;
}

@end
