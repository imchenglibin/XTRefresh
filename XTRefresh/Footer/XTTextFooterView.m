//
//  XTTextFooterView.m
//  XTRefresh
//
//  Created by imchenglibin on 16/1/28.
//  Copyright © 2016年 xt. All rights reserved.
//

#import "XTTextFooterView.h"
#import "XTRefreshConsts.h"

@interface XTTextFooterView()

@property (strong, nonatomic) UILabel *label;
@property (strong, nonatomic) UIActivityIndicatorView *indicatorView;

@end


@implementation XTTextFooterView

- (instancetype)init {
    if (self = [super init]) {
        [self setup];
    }
    return self;
}

- (void)setup {
    _refreshingText = kXTRefreshLoadingMoreString;
    
    self.label = [[UILabel alloc] init];
    self.label.font = [UIFont systemFontOfSize:14];
    self.label.textColor = [UIColor darkGrayColor];
    [self addSubview:self.label];
    
    self.label.translatesAutoresizingMaskIntoConstraints = NO;
    NSLayoutConstraint *hConstraint = [NSLayoutConstraint constraintWithItem:self.label
                                                                   attribute:NSLayoutAttributeCenterX
                                                                   relatedBy:NSLayoutRelationEqual
                                                                      toItem:self
                                                                   attribute:NSLayoutAttributeCenterX
                                                                  multiplier:1.0
                                                                    constant:0];
    
    NSLayoutConstraint *vConstraint = [NSLayoutConstraint constraintWithItem:self.label
                                                                   attribute:NSLayoutAttributeCenterY
                                                                   relatedBy:NSLayoutRelationEqual
                                                                      toItem:self
                                                                   attribute:NSLayoutAttributeCenterY
                                                                  multiplier:1.0
                                                                    constant:0];
    [self addConstraints:@[hConstraint, vConstraint]];
    
    
    
    
    self.indicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    [self addSubview:self.indicatorView];
    
    self.indicatorView.translatesAutoresizingMaskIntoConstraints = NO;
    hConstraint = [NSLayoutConstraint constraintWithItem:self.indicatorView
                                               attribute:NSLayoutAttributeLeading
                                               relatedBy:NSLayoutRelationEqual
                                                  toItem:self.label
                                               attribute:NSLayoutAttributeTrailing
                                              multiplier:1.0
                                                constant:5];
    
    vConstraint = [NSLayoutConstraint constraintWithItem:self.indicatorView
                                               attribute:NSLayoutAttributeCenterY
                                               relatedBy:NSLayoutRelationEqual
                                                  toItem:self.label
                                               attribute:NSLayoutAttributeCenterY
                                              multiplier:1.0
                                                constant:0];
    
    [self addConstraints:@[hConstraint, vConstraint]];
}

- (void)setTextFontSize:(CGFloat)textFontSize {
    _textFontSize = textFontSize;
    self.label.font = [UIFont systemFontOfSize:textFontSize];
}

- (void)setTextColor:(UIColor *)textColor {
    _textColor = textColor;
    self.label.textColor = textColor;
}

- (void)startAnimation {
    self.indicatorView.hidden = NO;
    [self.indicatorView startAnimating];
}

- (void)stopAnimation {
    self.indicatorView.hidden = YES;
    [self.indicatorView stopAnimating];
}

- (void)onRreshStateChanged:(XTRefreshState)state {
    if (state == XTRefreshStateRefreshing) {
        self.label.text = self.refreshingText;
    }
    [self.label sizeToFit];
}

@end
