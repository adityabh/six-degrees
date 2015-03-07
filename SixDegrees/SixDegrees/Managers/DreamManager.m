//
//  DreamManager.m
//  SixDegrees
//
//  Created by David Wen on 2014-11-16.
//  Copyright (c) 2014 Steven Wu. All rights reserved.
//

#import "DreamManager.h"
#import "SDApiManager.h"
#import "UserDream.h"

@interface DreamManager ()

@property (strong, nonatomic) SDApiManager *apiManager;
@property (strong, nonatomic) NSArray *dreams;
@property (assign) int currentDreamIndex;

@end

@implementation DreamManager

+ (BSInitializer *)bsInitializer {
    return [BSInitializer initializerWithClass:self
                                      selector:@selector(initWithApiManager:)
                                  argumentKeys:[SDApiManager class], nil];
}

- (instancetype)initWithApiManager:(SDApiManager *)apiManager {
    self = [super init];
    if (self) {
        _apiManager = apiManager;
        self.currentDreamIndex = 0;
    }
    return self;
}

- (KSPromise *)fetchDreamsPromise {
    KSDeferred *fetchDreamsPromiseDeferred = [KSDeferred defer];
    [self.apiManager fetchDreamsWithSuccess:^(NSArray *dreams) {
        self.dreams = dreams;
        [fetchDreamsPromiseDeferred resolveWithValue:dreams];
    } failure:^(NSError *error) {
        [fetchDreamsPromiseDeferred rejectWithError:error];
    }];
    return fetchDreamsPromiseDeferred.promise;
}

- (NSDictionary *)nextDream {
    int numDreams = (int)[self.dreams count] - 1;
    if (self.currentDreamIndex == numDreams) {
        self.currentDreamIndex = 0;
    } else {
        self.currentDreamIndex += 1;
    }
    return self.dreams[self.currentDreamIndex];
}

@end
