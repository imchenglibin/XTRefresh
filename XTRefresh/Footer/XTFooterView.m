//
//  XTFooterView.m
//  XTRefresh
//
//  Created by imchenglibin on 16/1/27.
//  Copyright © 2016年 xt. All rights reserved.
//

#import "XTFooterView.h"
#import "XTRefreshDefine.h"

@interface XTFooterView()
@property (assign, nonatomic) BOOL isLoadingMore;
@property (assign, nonatomic) BOOL loadMoreFlag;
@end

@implementation XTFooterView

static char kXTFooterViewContextContentOffset;

- (void)startRefresh {
    [self onRreshStateChanged:XTRefreshStateRefreshing];
    [self startAnimation];
    self.isLoadingMore = YES;
    self.scrollView.scrollEnabled = NO;
    self.hidden = NO;
    UIEdgeInsets insets = self.scrollView.contentInset;
    insets.bottom += [self height];
    [self.scrollView setContentInset:insets];
    
    CGPoint offsetPoint = CGPointMake(self.scrollView.contentOffset.x, self.scrollView.contentSize.height - self.scrollView.bounds.size.height + insets.bottom);
    [self.scrollView setContentOffset:offsetPoint
                             animated:NO];
    self.frame = CGRectMake(0, self.scrollView.contentSize.height, self.scrollView.bounds.size.width, [self height]);
    if (self.refreshBlock) {
        self.refreshBlock(self);
    }
}

- (void)endRefresh {
    [self onRreshStateChanged:XTRefreshStateEnd];
    [self stopAnimation];
    XTWeakify(self);
    [UIView animateWithDuration:.35 animations:^{
        XTStrongify(self);
        UIEdgeInsets insets = self.scrollView.contentInset;
        self.frame = CGRectMake(0, self.scrollView.contentSize.height + [self height], self.scrollView.bounds.size.width, [self height]);
        insets.bottom -= [self height];
        [self.scrollView setContentInset:insets];
    } completion:^(BOOL finished) {
        XTStrongify(self);
        self.isLoadingMore = NO;
        self.scrollView.scrollEnabled = YES;
        self.hidden = YES;
    }];
}

- (UIScrollView*)scrollView {
    return (UIScrollView*)self.superview;
}

- (void)willMoveToSuperview:(UIView *)newSuperview {
    if (newSuperview && [newSuperview isKindOfClass:[UIScrollView class]]) {
        UIScrollView *scrollView = (UIScrollView*)newSuperview;
        [scrollView addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew context:&kXTFooterViewContextContentOffset];
        self.hidden = YES;
    }
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context {
    if (context == &kXTFooterViewContextContentOffset) {
        CGFloat scrollableHeight = self.scrollView.bounds.size.height - self.scrollView.contentInset.top - self.scrollView.contentInset.bottom;
        CGFloat currentOffset = self.scrollView.contentOffset.y + self.scrollView.contentInset.top;
        self.frame = CGRectMake(0, self.scrollView.contentSize.height + [self height], self.scrollView.bounds.size.width, [self height]);
        
        if (!self.isLoadingMore && scrollableHeight < self.scrollView.contentSize.height) {
            if (!self.scrollView.dragging && self.loadMoreFlag) {
                self.loadMoreFlag = NO;
                [self startRefresh];
            }
            
            if (currentOffset + scrollableHeight > self.scrollView.contentSize.height - 10) {
                self.loadMoreFlag = YES;
            } else {
                self.loadMoreFlag = NO;
            }
        } else {
            self.loadMoreFlag = NO;
        }
    } else {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}

- (void)dealloc {
    [self.scrollView removeObserver:self forKeyPath:@"contentOffset"];
}

@end
