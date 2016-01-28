//
//  XTImagesFooterView.m
//  XTRefresh
//
//  Created by imchenglibin on 16/1/28.
//  Copyright © 2016年 xt. All rights reserved.
//

#import "XTImagesFooterView.h"

@interface XTImagesFooterView()

@property (strong, nonatomic) UIImageView *imageView;
@property (strong, nonatomic) NSArray *images;

@end

@implementation XTImagesFooterView

- (instancetype)init {
    if (self = [super init]) {
        [self setup];
    }
    return self;
}

- (void)setup {
    self.imageView = [[UIImageView alloc] init];
    [self addSubview:self.imageView];
    self.imageView.translatesAutoresizingMaskIntoConstraints = NO;
    NSLayoutConstraint *heightConstraint = [NSLayoutConstraint constraintWithItem:self.imageView
                                                                       attribute:NSLayoutAttributeHeight
                                                                       relatedBy:NSLayoutRelationEqual
                                                                          toItem:nil
                                                                       attribute:NSLayoutAttributeNotAnAttribute
                                                                      multiplier:1.0
                                                                        constant:35];
    
    NSLayoutConstraint *vCenterConstraint = [NSLayoutConstraint constraintWithItem:self.imageView
                                                                                attribute:NSLayoutAttributeCenterY
                                                                                relatedBy:NSLayoutRelationEqual
                                                                                   toItem:self
                                                                                attribute:NSLayoutAttributeCenterY
                                                                               multiplier:1.0
                                                                                 constant:0];
    
    NSLayoutConstraint *hCenterConstraint = [NSLayoutConstraint constraintWithItem:self.imageView
                                                                                attribute:NSLayoutAttributeCenterX
                                                                                relatedBy:NSLayoutRelationEqual
                                                                                   toItem:self
                                                                                attribute:NSLayoutAttributeCenterX
                                                                               multiplier:1.0
                                                                                 constant:0];
    
    [self addConstraints:@[heightConstraint, vCenterConstraint, hCenterConstraint]];
}

- (CGFloat)height {
    return 40;
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

@end
