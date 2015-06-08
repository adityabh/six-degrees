//
//  SDEndpoints.h
//  SixDegrees
//
//  Created by Steven Wu on 2014-10-18.
//  Copyright (c) 2014 Steven Wu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SDEndpoints : NSObject

#pragma mark - Authentication

+ (NSString *)authWithFacebook;
+ (NSString *)loginUser;
+ (NSString *)createUser;
+ (NSString *)logoutUser;

#pragma mark - Dreams

+ (NSString *)fetchDreams;
+ (NSString *)createDream;
+ (NSString *)fetchDreamWithId:(NSString *)dreamId;
+ (NSString *)updateDreamWithId:(NSString *)dreamId;
+ (NSString *)deleteDreamWithId:(NSString *)dreamId;

@end
