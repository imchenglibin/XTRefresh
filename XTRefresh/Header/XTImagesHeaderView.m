//
//  XTImagesHeaderView.m
//  XTRefresh
//
//  Created by imchenglibin on 16/1/28.
//  Copyright © 2016年 xt. All rights reserved.
//

#import "XTImagesHeaderView.h"
#import "XTRefreshConsts.h"

@interface XTImagesHeaderView()
@property (strong, nonatomic) UILabel *label;
@property (strong, nonatomic) UIImageView *imageView;
@property (strong, nonatomic) NSArray *images;

@end

@implementation XTImagesHeaderView

- (instancetype)init {
    if (self = [super init]) {
        [self setup];
    }
    return self;
}

- (void)setup {
    _pullToRefreshText = kXTRefreshPullToRefreshString;
    _readyToRefreshText = kXTRefreshReadyToRefreshString;
    _refreshingText = kXTRefreshRefreshingString;
    
    self.label = [[UILabel alloc] init];
    self.label.font = [UIFont systemFontOfSize:14];
    self.label.textColor = [UIColor darkGrayColor];
    [self addSubview:self.label];
    
    self.label.translatesAutoresizingMaskIntoConstraints = NO;
    NSLayoutConstraint *heightConstraint = [NSLayoutConstraint constraintWithItem:self.label
                                                                        attribute:NSLayoutAttributeHeight
                                                                        relatedBy:NSLayoutRelationEqual
                                                                           toItem:nil
                                                                        attribute:NSLayoutAttributeNotAnAttribute
                                                                       multiplier:1.0
                                                                         constant:15];
    
    NSLayoutConstraint *hCenterConstraint = [NSLayoutConstraint constraintWithItem:self.label
                                                                   attribute:NSLayoutAttributeCenterX
                                                                   relatedBy:NSLayoutRelationEqual
                                                                      toItem:self
                                                                   attribute:NSLayoutAttributeCenterX
                                                                  multiplier:1.0
                                                                    constant:0];
    
    NSLayoutConstraint *bottomConstraint = [NSLayoutConstraint constraintWithItem:self.label
                                                                   attribute:NSLayoutAttributeBottom
                                                                   relatedBy:NSLayoutRelationEqual
                                                                      toItem:self
                                                                   attribute:NSLayoutAttributeBottom
                                                                  multiplier:1.0
                                                                    constant:0];
    [self addConstraints:@[heightConstraint, hCenterConstraint, bottomConstraint]];
    
    
    
    self.imageView = [[UIImageView alloc] init];
    [self addSubview:self.imageView];
    self.imageView.translatesAutoresizingMaskIntoConstraints = NO;
    heightConstraint = [NSLayoutConstraint constraintWithItem:self.imageView
                                                    attribute:NSLayoutAttributeHeight
                                                    relatedBy:NSLayoutRelationEqual
                                                       toItem:nil
                                                    attribute:NSLayoutAttributeNotAnAttribute
                                                   multiplier:1.0
                                                     constant:35];
    
    NSLayoutConstraint *vCenterConstraint = [NSLayoutConstraint constraintWithItem:self.imageView
                                                                         attribute:NSLayoutAttributeTop
                                                                         relatedBy:NSLayoutRelationEqual
                                                                            toItem:self
                                                                         attribute:NSLayoutAttributeTop
                                                                        multiplier:1.0
                                                                          constant:5];
    
    hCenterConstraint = [NSLayoutConstraint constraintWithItem:self.imageView
                                                     attribute:NSLayoutAttributeCenterX
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:self
                                                     attribute:NSLayoutAttributeCenterX
                                                    multiplier:1.0
                                                      constant:0];
    
    [self addConstraints:@[heightConstraint, vCenterConstraint, hCenterConstraint]];
    
}

- (void)startAnimation {
    if (self.images && self.images.count > 1) {
        [self.imageView startAnimating];
    }
}

- (void)stopAnimation {
    if (self.images && self.images.count > 1) {
        [self.imageView stopAnimating];
    }
}

- (void)setImages:(NSArray*)images animationDuration:(CGFloat)animationDuration {
    _images = images;
    if (images && images.count > 0) {
        self.imageView.animationDuration = animationDuration;
        self.imageView.animationRepeatCount = INT32_MAX;
        self.imageView.animationImages = images;
        
        UIImage *firstImage = [images firstObject];
        if (firstImage.size.height > 70.0) {
            self.imageView.contentMode = UIViewContentModeScaleAspectFit;
        } else {
            self.imageView.contentMode = UIViewContentModeCenter;
        }
        
        [self.imageView setImage:[images firstObject]];
        [self.imageView sizeToFit];
    }
}

- (void)setImages:(NSArray*)images {
    [self setImages:images animationDuration:0.35];
}

- (CGFloat)height {
    return 60;
}

- (void)onRreshStateChanged:(XTRefreshState)state {
    if (state == XTRefreshStatePullToRefresh) {
        self.label.text = self.pullToRefreshText;
    } else if (state == XTRefreshStateReadyToRefresh) {
        self.label.text = self.readyToRefreshText;
    } else if (state == XTRefreshStateRefreshing) {
        self.label.text = self.refreshingText;
    }
    [self.label sizeToFit];
}

@end
