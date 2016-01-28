//
//  UIScrollView+SYPullToRefresh.m
//  SYPullToRefresh
//
//  Created by imchenglibin on 16/1/24.
//  Copyright © 2016年 sy. All rights reserved.
//

#import "UIScrollView+XTRefresh.h"
#import "XTRefreshView.h"
#import <objc/runtime.h>

static char kXTHeaderKey;
static char kXTFooterKey;

@implementation UIScrollView(XTRefresh)

@dynamic xt_header;
@dynamic xt_footer;

- (XTRefreshView*)xt_header {
    return objc_getAssociatedObject(self, &kXTHeaderKey);
}

- (void)setXt_header:(XTRefreshView *)xt_header {
    
    if (self.xt_header) {
        [self.xt_header removeFromSuperview];
    }
    
    [self addSubview:xt_header];
    
    objc_setAssociatedObject(self, &kXTHeaderKey, xt_header, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (XTRefreshView*)xt_footer {
    return objc_getAssociatedObject(self, &kXTFooterKey);
}

- (void)setXt_footer:(XTRefreshView *)xt_footer {
    
    if (self.xt_footer) {
        [self.xt_footer removeFromSuperview];
    }
    
    [self addSubview:xt_footer];
    
    objc_setAssociatedObject(self, &kXTFooterKey, xt_footer, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end
