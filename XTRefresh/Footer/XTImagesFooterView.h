//
//  XTImagesFooterView.h
//  XTRefresh
//
//  Created by imchenglibin on 16/1/28.
//  Copyright © 2016年 xt. All rights reserved.
//

#import "XTFooterView.h"

@interface XTImagesFooterView : XTFooterView

//set animation images with animation duration
- (void)setImages:(NSArray*)images animationDuration:(CGFloat)animationDuration;

//set animation images with default animation duration 0.35
- (void)setImages:(NSArray*)images;

@end
