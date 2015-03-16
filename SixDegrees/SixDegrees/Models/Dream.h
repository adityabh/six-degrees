//
//  Dream.h
//  SixDegrees
//
//  Created by Steven Wu on 2015-02-21.
//  Copyright (c) 2015 Steven Wu. All rights reserved.
//

#import "SDModel.h"

typedef NS_ENUM(NSInteger, DreamType) {
    DreamTypePersonal,
    DreamTypeProfessional
};

@interface Dream : SDModel

@property (strong, nonatomic, readonly) NSNumber *dreamId;
@property (strong, nonatomic, readonly) NSNumber *userId;
@property (strong, nonatomic, readonly) NSString *dreamType;
@property (strong, nonatomic, readonly) NSString *dreamDescription;
@property (strong, nonatomic, readonly) NSDate *createdAt;
@property (strong, nonatomic, readonly) NSDate *updatedAt;

- (DreamType)dreamTypeEnum;

//"created_at" = "2014-11-16T22:12:51.374Z";
//description = "I want to climb Mount Everest";
//"dream_type" = Personal;
//id = 1;
//"updated_at" = "2014-11-16T22:12:51.374Z";
//"user_id" = 5;

@end
