//
//  SDConstants.h
//  SixDegrees
//
//  Created by Steven Wu on 2014-10-18.
//  Copyright (c) 2014 Steven Wu. All rights reserved.
//

#pragma mark - Storyboard Names

#define MAIN_STORYBOARD @"Main"
#define DREAM_STORYBOARD @"Dream"
#define AUTHN_STORYBOARD @"AuthN"

#pragma mark - Constants

#define AUTHN_TOKEN_KEY @"SixDegreesAuthNTokenKey"
#define SD_PROVIDER_KEY @"SixDegreesProviderKey"
# define DUPLICATE_EMAIL_ERROR @"Email has already been taken."

# pragma mark - Providers

#define SD_PROVIDER_FACEBOOK @"facebook"
#define PROVIDER_FB @"facebook"

#define UIColorFromRGB(rgbValue) [UIColor \
colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]