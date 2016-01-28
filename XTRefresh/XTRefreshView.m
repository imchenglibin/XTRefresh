//
//  XTRefreshView.m
//  XTRefresh
//
//  Created by imchenglibin on 16/1/27.
//  Copyright © 2016年 xt. All rights reserved.
//

#import "XTRefreshView.h"

@interface XTRefreshView() {
    void(^_refreshBlock)(XTRefreshView *refreshView);
}
@end

@implementation XTRefreshView

+ (instancetype)refreshView:(void(^)(XTRefreshView *refreshView))refreshBlock {
    XTRefreshView *refreshView = [[self alloc] init];
    refreshView->_refreshBlock = refreshBlock;
    return refreshView;
}

- (void)endRefresh {
}

- (void)startAnimation {
}

- (void)stopAnimation {
}

- (CGFloat)height {
    return 40;
}

- (void)onRreshStateChanged:(XTRefreshState)state {
}

- (void(^)(XTRefreshView *refreshView))refreshBlock {
    return _refreshBlock;
}


@end
