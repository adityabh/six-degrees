//
//  UserManager.m
//  SixDegrees
//
//  Created by Steven Wu on 2014-10-18.
//  Copyright (c) 2014 Steven Wu. All rights reserved.
//

#import "UserManager.h"

@implementation UserManager

+ (BSInitializer *)bsInitializer {
    return [BSInitializer initializerWithClass:self
                                      selector:@selector(init)
                                  argumentKeys:nil];
}

@end
