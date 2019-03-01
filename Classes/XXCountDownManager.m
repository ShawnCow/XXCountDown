//
//  XXCountDownManager.m
//  XXCountDownLabel
//
//  Created by Shawn on 2019/1/21.
//  Copyright © 2019 Shawn. All rights reserved.
//

#import "XXCountDownManager.h"

@interface XXCountDownManager ()
{
    NSLock *lock;
    NSHashTable *table;
    NSTimer *timer;
}
@end

@implementation XXCountDownManager

+ (instancetype)sharedCountDownManager
{
    static dispatch_once_t onceToken;
    static XXCountDownManager *mgr;
    dispatch_once(&onceToken, ^{
        mgr = [XXCountDownManager new];
    });
    return mgr;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        lock = [NSLock new];
        table = [NSHashTable weakObjectsHashTable];
        timer = [NSTimer scheduledTimerWithTimeInterval:1. target:self selector:@selector(_timerFire) userInfo:nil repeats:YES];
    }
    return self;
}

- (void)registerObserver:(id<XXCountDown>)observer
{
    if (observer == nil) {
        return;
    }
    if ([observer respondsToSelector:@selector(xx_countDownFire)] == NO) {
#ifdef DEBUG
        NSException *ex = [NSException exceptionWithName:@"XXCountDownManagerExceptionName" reason:@"observer must implementat xx_countDownFire " userInfo:nil];
        [ex raise];
#endif
        return;
    }
    [lock lock];
    if ([table containsObject:observer] == NO) {
        [table addObject:observer];
    }
    [lock unlock];
}

- (void)unregisterObserver:(id<XXCountDown>)observer
{
    if (observer == nil) {
        return;
    }
    [lock lock];
    [table removeObject:observer];
    [lock unlock];
}

- (void)_timerFire
{
    [lock lock];
    NSArray *items = [table allObjects];
    [lock unlock];
    dispatch_async(dispatch_get_main_queue(), ^{
        for (id<XXCountDown> tempObserver in items) {
            [tempObserver xx_countDownFire];
        }
    });
}

@end
