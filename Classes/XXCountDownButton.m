//
//  XXCountDownButton.m
//  XXCountDownLabel
//
//  Created by Shawn on 2019/2/13.
//  Copyright © 2019 Shawn. All rights reserved.
//

#import "XXCountDownButton.h"
#import "XXCountDownManager.h"

@interface XXCountDownButton ()
{
    BOOL exeCountDownBlock;
}
@end

@implementation XXCountDownButton

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [[XXCountDownManager sharedCountDownManager]registerObserver:self];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [[XXCountDownManager sharedCountDownManager]registerObserver:self];
    }
    return self;
}

- (void)dealloc
{
    [[XXCountDownManager sharedCountDownManager]unregisterObserver:self];
}

- (void)setExpiredDate:(NSDate *)expiredDate
{
    if ([_expiredDate isEqualToDate:expiredDate]) {
        return;
    }
    _expiredDate = expiredDate;
    exeCountDownBlock = NO;
    [self xx_countDownFire];
}

- (void)xx_countDownFire
{
    if (self.expiredDate == nil) {
        return;
    }
    if (self.fireBlock) {
        self.fireBlock(self);
    }else
    {
        NSTimeInterval sec = [self.expiredDate timeIntervalSinceNow];
        if (sec < 0) {
            if (exeCountDownBlock == NO) {
                exeCountDownBlock = YES;
                if (self.countDownCompletion) {
                    self.countDownCompletion(self);
                    self.countDownCompletion = nil;
                }else
                {
                    self.enabled = YES;
                }
            }
            
            return;
        }
        if (self.enabled) {
            self.enabled = NO;
        }
        [self setTitle:[NSString stringWithFormat:@"%ld",(long)sec] forState:UIControlStateDisabled];
    }
}

@end

