//
//  XTTextHeaderView.h
//  XTRefresh
//
//  Created by imchenglibin on 16/1/28.
//  Copyright © 2016年 xt. All rights reserved.
//

#import "XTHeaderView.h"

@interface XTTextHeaderView : XTHeaderView

@property (assign, nonatomic) CGFloat textFontSize;
@property (strong, nonatomic) UIColor *textColor;
@property (copy, nonatomic) NSString *pullToRefreshText;
@property (copy, nonatomic) NSString *readyToRefreshText;
@property (copy, nonatomic) NSString *refreshingText;

@end
