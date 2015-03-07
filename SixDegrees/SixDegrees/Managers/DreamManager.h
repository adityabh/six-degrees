//
//  DreamManager.h
//  SixDegrees
//
//  Created by David Wen on 2014-11-16.
//  Copyright (c) 2014 Steven Wu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DreamManager : NSObject

- (KSPromise *)fetchDreamsPromise;
- (NSDictionary *)nextDream;

@property (strong, nonatomic, readonly) NSArray *dreams;

@end
