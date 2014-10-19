//
//  SDSessionManager.m
//  SixDegrees
//
//  Created by Steven Wu on 2014-10-18.
//  Copyright (c) 2014 Steven Wu. All rights reserved.
//

#import "SDSessionManager.h"

@implementation SDSessionManager

- (instancetype)initWithBaseURL:(NSURL *)url
{
    self = [super initWithBaseURL:url];
    if (self) {
        self.requestSerializer = [AFJSONRequestSerializer serializer];
        self.responseSerializer = [AFJSONResponseSerializer serializer];
        [self.securityPolicy setAllowInvalidCertificates:YES];
    }
    return self;
}

@end
