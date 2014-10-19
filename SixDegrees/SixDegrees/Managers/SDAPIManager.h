//
//  SDAPIManager.h
//  SixDegrees
//
//  Created by Steven Wu on 2014-10-18.
//  Copyright (c) 2014 Steven Wu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SDAPIManager : NSObject

- (void)authenticateWithFacebookId:(NSString *)facebookId
                     facebookToken:(NSString *)facebookToken
                         userEmail:(NSString *)userEmail
                           success:(VoidBlock)success
                           failure:(ErrorBlock)failure;

@end
