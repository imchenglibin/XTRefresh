//
//  XTTextFooterView.h
//  XTRefresh
//
//  Created by imchenglibin on 16/1/28.
//  Copyright © 2016年 xt. All rights reserved.
//

#import "XTFooterView.h"

@interface XTTextFooterView : XTFooterView

@property (assign, nonatomic) CGFloat textFontSize;
@property (strong, nonatomic) UIColor *textColor;
@property (copy, nonatomic) NSString *refreshingText;

@end
