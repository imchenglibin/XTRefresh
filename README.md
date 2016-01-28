## XTRefresh
UIScrollView extension for pull to refresh and auto load more and it's easily to customize refresh view

## Overview

## Usage
Drag the folder to your project<br>
<img height=250 src="https://github.com/imchenglibin/XTRefresh/blob/master/Images/Folder.png"><br>

or just use pod<br>
pod 'XTRefresh', :git => 'https://github.com/imchenglibin/XTRefresh.git'
```objective-c
#import "XTRefresh.h"
```
Set xt_header and xt_footer to support refresh<br>
```objective-c
XTImagesHeaderView *imagesHeaderView = [XTImagesHeaderView refreshView:^(XTRefreshView *refreshView) {
      //to refresh data
      //use [refreshView endRefresh] to end refresh
}];
[imagesHeaderView setImages:@[[UIImage imageNamed:@"Loading_0"], [UIImage imageNamed:@"Loading_1"], [UIImage imageNamed:@"Loading_2"], [UIImage imageNamed:@"Loading_3"]]];
self.tableView.xt_header = imagesHeaderView;
    
XTImagesFooterView *imagesFooterView = [XTImagesFooterView refreshView:^(XTRefreshView *refreshView) {
    //to load more data
    //use [refreshView endRefresh] to end refresh
}];
[imagesFooterView setImages:@[[UIImage imageNamed:@"Loading_0"], [UIImage imageNamed:@"Loading_1"], [UIImage imageNamed:@"Loading_2"], [UIImage imageNamed:@"Loading_3"]]];
self.tableView.xt_footer = imagesFooterView;

[imagesHeaderView beginRefresh];//auto reload data
```
## Apis
```objective-c
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

@interface XTHeaderView : XTRefreshView

//invoke header refresh
- (void)beginRefresh;

@end

@interface XTTextHeaderView : XTHeaderView

@property (assign, nonatomic) CGFloat textFontSize;
@property (strong, nonatomic) UIColor *textColor;
@property (copy, nonatomic) NSString *pullToRefreshText;
@property (copy, nonatomic) NSString *readyToRefreshText;
@property (copy, nonatomic) NSString *refreshingText;

@end

@interface XTImagesHeaderView : XTHeaderView

@property (copy, nonatomic) NSString *pullToRefreshText;
@property (copy, nonatomic) NSString *readyToRefreshText;
@property (copy, nonatomic) NSString *refreshingText;

//set animation images with animation duration
- (void)setImages:(NSArray*)images animationDuration:(CGFloat)animationDuration;

//set animation images with default animation duration 0.35
- (void)setImages:(NSArray*)images;

@end

@interface XTTextFooterView : XTFooterView

@property (assign, nonatomic) CGFloat textFontSize;
@property (strong, nonatomic) UIColor *textColor;
@property (copy, nonatomic) NSString *refreshingText;

@end

@interface XTImagesFooterView : XTFooterView

//set animation images with animation duration
- (void)setImages:(NSArray*)images animationDuration:(CGFloat)animationDuration;

//set animation images with default animation duration 0.35
- (void)setImages:(NSArray*)images;

@end

```

## Customize header view and footer view
XTRefresh is easy to customize, you just need to extends XTHeaderView for header view or XTFooterView for footer view and you can customize you own UI and animations, for more details refer to the demo in this project

## License
This project use `MIT` license, for more details refer to `LICENSE` file
