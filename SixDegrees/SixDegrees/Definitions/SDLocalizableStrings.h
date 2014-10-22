//
//  SDLocalizableStrings.h
//  SixDegrees
//
//  Created by Steven Wu on 2014-10-19.
//  Copyright (c) 2014 Steven Wu. All rights reserved.
//

// Facebook error messages
#define kErrorFbOther NSLocalizedString(@"Unable to sign in via Facebook.", @"error message for when an unknown facebook error occurs")
#define kErrorFbExternalActionRequired NSLocalizedString(@"Unable to sign in via Facebook.  Please make sure that you have verified your Facebook account.", @"error message for when facebook error requires an action outside of the app in order to recover")
#define kErrorFbCancelledLogin NSLocalizedString(@"Facebook login cancelled.", @"error message for when user cancelled facebook login")
#define kErrorFbSessionExpired NSLocalizedString(@"Your facebook session has expired, please sign in again.", @"error message for when facebook session closed outside the app")
#define kErrorFbMissingPermission NSLocalizedString(@"You have not granted Facebook access permissions.", @"error for when user removed a previously granted facebook permission")
