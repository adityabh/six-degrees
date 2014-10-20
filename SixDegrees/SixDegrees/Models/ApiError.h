//
//  ApiError.h
//  SixDegrees
//
//  Created by Steven Wu on 2014-10-19.
//  Copyright (c) 2014 Steven Wu. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, ApiErrorType) {
    kUnknown,
    kFbOther,
    kFbExternalActionRequired,
    kFbCancelledLogin,
    kFbSessionExpired,
    kFbMissingPermission
};

@interface ApiError : NSObject

@property (nonatomic, readonly) ApiErrorType type;
@property (strong, nonatomic, readonly) NSString *userMessage;

+ (instancetype)errorWithType:(ApiErrorType)type userMessage:(NSString *)userMessage;

@end
