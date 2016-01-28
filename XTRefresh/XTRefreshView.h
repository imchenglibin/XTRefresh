//
//  XTRefreshView.h
//  XTRefresh
//
//  Created by imchenglibin on 16/1/27.
//  Copyright © 2016年 xt. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, XTRefreshState) {
    XTRefreshStatePullToRefresh = 0,
    XTRefreshStateReadyToRefresh = 1,
    XTRefreshStateRefreshing = 2,
    XTRefreshStateEnd = 3
};

@interface XTRefreshView : UIView

//create the refresh view with refresh block
//this class method use init to initialize instance
//so if you want to customize refreshview you need to override the init method
+ (instancetype)refreshView:(void(^)(XTRefreshView *refreshView))refreshBlock;

//the method to notify the end of refresh, user should call this to end refresh
- (void)endRefresh;

//implement this method to start customized animation.
- (void)startAnimation;

//implement this method to stop customized animation.
- (void)stopAnimation;

//implement this method to customize the refresh view height
- (CGFloat)height;

//implement this method to listen refresh state
- (void)onRreshStateChanged:(XTRefreshState)state;

//the method to get refresh block
- (void(^)(XTRefreshView *refreshView))refreshBlock;

@end
