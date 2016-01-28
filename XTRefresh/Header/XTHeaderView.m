//
//  XTHeaderView.m
//  XTRefresh
//
//  Created by imchenglibin on 16/1/27.
//  Copyright © 2016年 xt. All rights reserved.
//

#import "XTHeaderView.h"
#import "XTRefreshDefine.h"

@interface XTHeaderView()

@property (assign, nonatomic) BOOL isRefreshing;
@property (assign, nonatomic) BOOL refreshFlag;
@property (assign, nonatomic) BOOL startRefreshWithAnimation;

@end

@implementation XTHeaderView

static char kXTHeaderViewContextContentOffset;

- (void)beginRefresh {
    if (!self.isRefreshing) {
        dispatch_async(dispatch_get_main_queue(), ^{
            self.startRefreshWithAnimation = YES;
            [self startRefresh];
        });
    }
}

- (void)startRefresh {
    [self onRreshStateChanged:XTRefreshStateRefreshing];
    self.isRefreshing = YES;
    self.scrollView.scrollEnabled = NO;
    UIEdgeInsets insets = self.scrollView.contentInset;
    insets.top += [self height];
    [self.scrollView setContentInset:insets];
    if (self.startRefreshWithAnimation) {
        [self.scrollView setContentOffset:CGPointMake(self.scrollView.contentOffset.x, -insets.top) animated:YES];
        self.frame = CGRectMake(0, -[self height], self.scrollView.bounds.size.width, [self height]);
        [self startAnimation];
        if (self.refreshBlock) {
            self.refreshBlock(self);
        }
    } else {
        self.frame = CGRectMake(0, -[self height], self.scrollView.bounds.size.width, [self height]);
        [self startAnimation];
        if (self.refreshBlock) {
            self.refreshBlock(self);
        }
    }
    
    self.startRefreshWithAnimation = NO;
}

- (void)endRefresh {
    [self onRreshStateChanged:XTRefreshStateEnd];
    [self stopAnimation];
    XTWeakify(self);
    [UIView animateWithDuration:.35 animations:^{
        XTStrongify(self);
        self.frame = CGRectMake(0, -2 * [self height], self.scrollView.bounds.size.width, [self height]);
        UIEdgeInsets insets = self.scrollView.contentInset;
        insets.top -= [self height];
        [self.scrollView setContentInset:insets];
    } completion:^(BOOL finished) {
        XTStrongify(self);
        self.isRefreshing = NO;
        self.scrollView.scrollEnabled = YES;
    }];
}

- (void)willMoveToSuperview:(UIView *)newSuperview {
    if (newSuperview && [newSuperview isKindOfClass:[UIScrollView class]]) {
        UIScrollView *scrollView = (UIScrollView*)newSuperview;
        [scrollView addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew context:&kXTHeaderViewContextContentOffset];
    }
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context {
    if (context == &kXTHeaderViewContextContentOffset) {
        if (!self.isRefreshing && self.scrollView.contentOffset.y < -self.scrollView.contentInset.top) {
            CGFloat height = -self.scrollView.contentInset.top - self.scrollView.contentOffset.y;
            self.frame = CGRectMake(0, -[self height], self.scrollView.bounds.size.width, [self height]);
            if (height/ [self height] < 1) {
                [self onRreshStateChanged:XTRefreshStatePullToRefresh];
            } else {
                [self onRreshStateChanged:XTRefreshStateReadyToRefresh];
            }
            
            if (!self.scrollView.dragging && self.refreshFlag) {
                self.refreshFlag = NO;
                [self startRefresh];
            }
            
            if (height >= [self height]) {
                self.refreshFlag = YES;
            } else {
                self.refreshFlag = NO;
            }
        } else {
            self.refreshFlag = NO;
        }
    } else {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}

- (UIScrollView*)scrollView {
    return (UIScrollView*)self.superview;
}

- (void)dealloc {
    [self.scrollView removeObserver:self forKeyPath:@"contentOffset"];
}

@end
