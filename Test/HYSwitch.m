//
//  HYSwitch.m
//  Test
//
//  Created by Shadow on 14-5-17.
//  Copyright (c) 2014年 Shadow. All rights reserved.
//

#import "HYSwitch.h"

#define DEFAULT_ON_COLOR [UIColor colorWithRed:76/255.f green:216/255.f blue:100/255.f alpha:1]

@interface HYSwitch ()

@property (nonatomic, strong) UIView *circleView;

@property (nonatomic, getter = isOn) BOOL on;

@end

@implementation HYSwitch

#pragma mark - 初始化相关

- (id)initWithFrame:(CGRect)frame
{
    
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self setDefaultValue];
        
        self.backgroundColor = self.offColor;
        self.circleView = [[UIView alloc]initWithFrame:CGRectMake(1,
                                                                  1,
                                                                  CGRectGetHeight(frame)-2,
                                                                  CGRectGetHeight(frame)-2)];
        self.circleView.layer.cornerRadius = CGRectGetHeight(frame)/2-1;
        self.circleView.layer.masksToBounds = YES;
        self.circleView.backgroundColor = self.buttonColor;
        [self addSubview:self.circleView];
        
        self.layer.cornerRadius = CGRectGetHeight(frame)/2;
        self.layer.masksToBounds = YES;
        
        [self setupGestures];
    }
    return self;
}

- (void)setDefaultValue
{
    self.onColor = DEFAULT_ON_COLOR;
    self.offColor = [UIColor lightGrayColor];
    self.buttonColor = [UIColor whiteColor];
}

- (void)setupGestures
{
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapHandler:)];
    [self addGestureRecognizer:tap];
    
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(panHandler:)];
    [self addGestureRecognizer:pan];
}

#pragma mark - setter

- (void)setButtonColor:(UIColor *)buttonColor
{
    _buttonColor = buttonColor;
    self.circleView.backgroundColor = buttonColor;
}

- (void)setOnColor:(UIColor *)onColor
{
    _onColor = onColor;
    if (self.isOn) {
        self.backgroundColor = onColor;
    }
}

- (void)setOffColor:(UIColor *)offColor
{
    _offColor = offColor;
    if (!self.isOn) {
        self.backgroundColor = offColor;
    }
}

#pragma mark - 设置开关方法

- (void)setSwitchOn:(BOOL)on animated:(BOOL)animated
{
    self.on = on;
    if (on) {
        [self onAnimationWithAnimated:animated];
    } else {
        [self offAnimationWithAnimated:animated];
    }
}

- (void)setSwitchOn:(BOOL)on animated:(BOOL)animated doAction:(BOOL)action
{
    [self setSwitchOn:on animated:animated];
    if (action) {
        [self performAction];
    }
}

#pragma mark - 手势处理

static BOOL oldOn = NO;
- (void)panHandler:(UIPanGestureRecognizer *)pan
{
    if (pan.state == UIGestureRecognizerStateBegan) {
        //手势开始的时候记录开关的当前状态.
        oldOn = self.isOn;
    }
    
    if (pan.state != UIGestureRecognizerStateEnded) {
        CGPoint point = [pan translationInView:self];
        if (point.x > 0) {
            [self setSwitchOn:YES animated:YES];
        } else if (point.x < 0) {
            [self setSwitchOn:NO animated:YES];
        }
    } else {
        //如果pan手势结束后的开关状态与开始记录的旧状态不同, 则执行action.
        if (oldOn != self.isOn) {
            [self performAction];
        }
    }
    
    [pan setTranslation:CGPointZero inView:self];
}

- (void)tapHandler:(UITapGestureRecognizer *)tap
{
    [self setSwitchOn:!self.isOn animated:YES];
    [self performAction];
}

#pragma mark - 其他

- (void)performAction
{
    if (self.action) {
        self.action(self.isOn);
    }
}

- (void)onAnimationWithAnimated:(BOOL)animated
{
    if (animated) {
        [UIView animateWithDuration:0.25f animations:^{
            self.backgroundColor = self.onColor;
            self.circleView.center = CGPointMake(CGRectGetWidth(self.frame)-CGRectGetHeight(self.frame)/2,
                                                 CGRectGetHeight(self.frame)/2);
        } completion:^(BOOL finished) {
            
        }];
    } else {
        self.backgroundColor = self.onColor;
        self.circleView.center = CGPointMake(CGRectGetWidth(self.frame)-CGRectGetHeight(self.frame)/2,
                                             CGRectGetHeight(self.frame)/2);
    }
    
}

- (void)offAnimationWithAnimated:(BOOL)animated
{
    if (animated) {
        [UIView animateWithDuration:0.25f animations:^{
            self.backgroundColor = self.offColor;
            self.circleView.center = CGPointMake(CGRectGetHeight(self.frame)/2,
                                                 CGRectGetHeight(self.frame)/2);
        } completion:^(BOOL finished) {
            
        }];
    } else {
        self.backgroundColor = self.offColor;
        self.circleView.center = CGPointMake(CGRectGetHeight(self.frame)/2,
                                             CGRectGetHeight(self.frame)/2);
    }
}

@end
