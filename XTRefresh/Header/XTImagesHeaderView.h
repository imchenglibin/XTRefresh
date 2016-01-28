//
//  XTImagesHeaderView.h
//  XTRefresh
//
//  Created by imchenglibin on 16/1/28.
//  Copyright © 2016年 xt. All rights reserved.
//

#import "XTHeaderView.h"

@interface XTImagesHeaderView : XTHeaderView

@property (copy, nonatomic) NSString *pullToRefreshText;
@property (copy, nonatomic) NSString *readyToRefreshText;
@property (copy, nonatomic) NSString *refreshingText;

- (void)setImages:(NSArray*)images animationDuration:(CGFloat)animationDuration;
- (void)setImages:(NSArray*)images;

@end
