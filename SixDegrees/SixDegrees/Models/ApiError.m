//
//  ApiError.m
//  SixDegrees
//
//  Created by Steven Wu on 2014-10-19.
//  Copyright (c) 2014 Steven Wu. All rights reserved.
//

#import "ApiError.h"

@interface ApiError ()

@property (nonatomic) ApiErrorType type;
@property (strong, nonatomic) NSString *userMessage;

@end

@implementation ApiError

+ (instancetype)errorWithType:(ApiErrorType)type userMessage:(NSString *)userMessage {
    ApiError *apiError = [ApiError new];
    apiError.type = type;
    apiError.userMessage = userMessage;
    return apiError;
}

@end
