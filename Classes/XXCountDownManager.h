//
//  XXCountDownManager.h
//  XXCountDownLabel
//
//  Created by Shawn on 2019/1/21.
//  Copyright © 2019 Shawn. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XXCountDown.h"

@interface XXCountDownManager : NSObject

+ (instancetype)sharedCountDownManager;

- (void)registerObserver:(id<XXCountDown>)observer;

- (void)unregisterObserver:(id<XXCountDown>)observer;

@end
