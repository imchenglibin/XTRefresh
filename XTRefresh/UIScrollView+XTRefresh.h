//
//  UIScrollView+SYPullToRefresh.h
//  SYPullToRefresh
//
//  Created by imchenglibin on 16/1/24.
//  Copyright © 2016年 sy. All rights reserved.
//

#import <UIKit/UIKit.h>

@class XTRefreshView;

@interface UIScrollView(XTRefresh)

//pull to refresh header
@property (strong, nonatomic) XTRefreshView *xt_header;

//load more footer
@property (strong, nonatomic) XTRefreshView *xt_footer;

@end
