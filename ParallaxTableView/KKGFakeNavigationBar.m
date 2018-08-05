//
//  KKGFakeNavigationBar.m
//  ParallaxTableView
//
//  Created by aleck on 2018/7/30.
//  Copyright © 2018年 Xmly. All rights reserved.
//

#import "KKGFakeNavigationBar.h"

@implementation KKGFakeNavigationBar {
    UILabel *_titleLabel;
    __weak UIViewController *_viewController;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.frame = frame;
        [self setup];
    }
    return self;
}

- (void)setup {
    self.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.titleView];
    [self addSubview:self.leftButton];
    
    self.titleView.frame = CGRectMake(0, 44, self.frame.size.width, 44);
    
}

- (void)setFrame:(CGRect)frame {
    super.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 88);
}

- (UIView *)titleView {
    if (!_titleView) {
        _titleLabel = [UILabel new];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
//        _titleLabel.font = [UINavigationBar appearance].titleTextAttributes;
        _titleView = _titleLabel;
    }
    return _titleView;
}

- (UIButton *)leftButton {
    if (!_leftButton) {
        _leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_leftButton addTarget:self action:@selector(leftButtonDidTapped:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _leftButton;
}

- (void)leftButtonDidTapped:(UIButton *)button {
    [_viewController.navigationController popViewControllerAnimated:YES];
}

- (void)didMoveToSuperview {
    UIResponder *nextResponder = self.superview.nextResponder;
    while (![nextResponder isKindOfClass:[UIViewController class]]) {
        _viewController = (UIViewController *)nextResponder;
        UINavigationController *nav = _viewController.navigationController;
        if (nav && nav.childViewControllers.firstObject == _viewController) {
            self.leftButton.hidden = YES;
        } else {
            self.leftButton.hidden = NO;
        }
    }
}

@end
