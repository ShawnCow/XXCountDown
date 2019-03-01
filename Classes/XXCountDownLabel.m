//
//  XXCountDownLabel.m
//  XXCountDownLabel
//
//  Created by Shawn on 2019/1/21.
//  Copyright © 2019 Shawn. All rights reserved.
//

#import "XXCountDownLabel.h"
#import "XXCountDownManager.h"

@implementation XXCountDownLabel

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
    [self xx_countDownFire];
}

- (void)setDisplayType:(XXCountDownLabelDateType)displayType
{
    if (_displayType == displayType) {
        return;
    }
    _displayType = displayType;
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
            //do nothing
            if (self.countDownloadCompletion) {
                self.countDownloadCompletion(self);
            }
            self.countDownloadCompletion = nil;
            return;
        }
        if (self.displayType == XXCountDownLabelSecound) {
            self.text = [NSString stringWithFormat:@"%ld",(long)sec];
        }else if (self.displayType == XXCountDownLabelHourMinSecound)
        {
            NSInteger hour = (NSInteger)(sec / (60. * 60.));
            NSInteger min = (NSInteger)((sec - (double)hour * (60. * 60.))/60.);
            NSInteger lessSec = (NSInteger)(sec - (double)hour * (60. * 60.) - (double)min*60.);
            self.text = [NSString stringWithFormat:@"%02ld:%02ld:%02ld",(long)hour,(long)min,(long)lessSec];
        }
    }
}

@end
