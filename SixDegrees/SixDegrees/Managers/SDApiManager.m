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
#import "User.h"
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

- (void) loginUser: (NSString *) email
          password: (NSString *) password
           success:(VoidBlock)success
           failure:(VoidBlock)failure {
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setValue:email forKey:@"email"];
    [params setValue:password forKey:@"password"];
    
    [self.sessionManager POST:[SDEndpoints loginUser] parameters:params success:^(NSURLSessionDataTask *task, id responseObject) {
        long status = [responseObject[@"status"] longValue];
        if (success) {
            if (status == 200l) {
                User *user = [MTLJSONAdapter modelOfClass:User.class fromJSONDictionary:responseObject[@"user"] error:nil];
                success(user);
            } else {
                failure(responseObject[@"message"]);
            }
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        if (failure) {
            failure(error.description);
        }
    }];
}

- (void) loginFacebookUser: (NSString *) uid
                   success:(VoidBlock)success
                   failure:(VoidBlock)failure {
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setValue:uid forKey:@"uid"];
    
    [self.sessionManager POST:[SDEndpoints loginUser] parameters:params success:^(NSURLSessionDataTask *task, id responseObject) {
        long status = [responseObject[@"status"] longValue];
        if (success) {
            if (status == 200l) {
                User *user = [MTLJSONAdapter modelOfClass:User.class fromJSONDictionary:responseObject[@"user"] error:nil];
                success(user);
            } else {
                failure(responseObject[@"message"]);
            }
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        if (failure) {
            failure(error.description);
        }
    }];
}

- (void) signupUser: (NSString *) firstName
          lastName: (NSString *) lastName
             email: (NSString *) email
          password: (NSString *) password
           success:(VoidBlock)success
           failure:(VoidBlock)failure {
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setValue:email forKey:@"email"];
    [params setValue:password forKey:@"password"];
    [params setValue:firstName forKey:@"first_name"];
    [params setValue:lastName forKey:@"last_name"];
    
    [self.sessionManager POST:[SDEndpoints createUser] parameters:params success:^(NSURLSessionDataTask *task, id responseObject) {
        long status = [responseObject[@"status"] longValue];
        if (success) {
            if (status == 200l) {
                User *user = [MTLJSONAdapter modelOfClass:User.class fromJSONDictionary:responseObject[@"user"] error:nil];
                success(user);
            } else {
                failure(responseObject[@"message"]);
            }
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        if (failure) {
            failure(error.description);
        }
    }];

}

- (void) signupFacebookUser: (NSString *) uid
                  firstName: (NSString *) firstName
                   lastName: (NSString *) lastName
                      email: (NSString *) email
                       name: (NSString *) name
                     gender: (NSString *) gender
                   timezone: (NSString *) timezone
                    success:(VoidBlock)success
                    failure:(VoidBlock)failure {
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setValue:uid forKey:@"uid"];
    [params setValue:email forKey:@"email"];
    [params setValue:name forKey:@"name"];
    [params setValue:firstName forKey:@"first_name"];
    [params setValue:lastName forKey:@"last_name"];
    [params setValue:gender forKey:@"gender"];
    [params setValue:timezone forKey:@"timezone"];
    
    [self.sessionManager POST:[SDEndpoints createUser] parameters:params success:^(NSURLSessionDataTask *task, id responseObject) {
        long status = [responseObject[@"status"] longValue];
        if (success) {
            if (status == 200l) {
                User *user = [MTLJSONAdapter modelOfClass:User.class fromJSONDictionary:responseObject[@"user"] error:nil];
                success(user);
            } else {
                failure(responseObject[@"message"]);
            }
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        if (failure) {
            failure(error.description);
        }
    }];
}


- (void) getUser: (NSString *) authenticationToken
         success:(VoidBlock)success
         failure:(VoidBlock)failure {
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setValue:authenticationToken forKey:@"authentication_token"];
    
    [self.sessionManager GET:[SDEndpoints getUser] parameters:params success:^(NSURLSessionDataTask *task, id responseObject) {
        long status = [responseObject[@"status"] longValue];
        if (success) {
            if (status == 200l) {
                User *user = [MTLJSONAdapter modelOfClass:User.class fromJSONDictionary:responseObject[@"user"] error:nil];
                user.smallAvatar = responseObject[@"small_avatar"];
                user.largeAvatar = responseObject[@"large_avatar"];
                success(user);
            } else {
                failure(responseObject[@"message"]);
            }
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        if (failure) {
            failure(error.description);
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

- (KSPromise *)createDreamForUser:(NSString *)authenticationToken
                 dreamType:(NSString *)dreamType
          dreamDescription:(NSString *)dreamDescription {
    KSDeferred *createDreamDeferred = [KSDeferred defer];
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setValue:dreamType forKey:@"dream_type"];
    [params setValue:dreamDescription forKey:@"description"];
    
    NSMutableDictionary *parameteres = [NSMutableDictionary dictionary];
    [parameteres setValue:params forKey:@"dream"];
    [parameteres setValue:authenticationToken forKey:@"authentication_token"];
    
    [self.sessionManager POST:[SDEndpoints createDream] parameters:parameteres success:^(NSURLSessionDataTask *task, id responseObject) {
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
