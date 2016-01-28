## XTRefresh
UIScrollView extension for pull to refresh and auto load more and it's easily to customize refresh view

## Overview

## Usage
Drag the folder to your project<br>

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

## License
This project use `MIT` license, for more details refer to `LICENSE` file
