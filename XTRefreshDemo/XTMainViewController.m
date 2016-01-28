//
//  ViewController.m
//  XTRefresh
//
//  Created by admin on 16/1/27.
//  Copyright © 2016年 xt. All rights reserved.
//

#import "XTMainViewController.h"
#import "XTRefresh.h"

@interface XTMainViewController () <UITableViewDataSource>
@property (strong, nonatomic) UITableView *tableView;
@property (assign, nonatomic) NSInteger numberOfRows;
@end

@implementation XTMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.title = @"XTRefresh";
    
    self.tableView = [[UITableView alloc] init];
    
    [self.view addSubview:self.tableView];
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    
    self.tableView.dataSource = self;
    
    self.numberOfRows = 20;
    
    XTWeakify(self);
    XTImagesHeaderView *imagesHeaderView = [XTImagesHeaderView refreshView:^(XTRefreshView *refreshView) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [refreshView endRefresh];
            XTStrongify(self);
            self.numberOfRows = 20;
            [self.tableView reloadData];
        });
    }];
    [imagesHeaderView setImages:@[[UIImage imageNamed:@"Loading_0"], [UIImage imageNamed:@"Loading_1"], [UIImage imageNamed:@"Loading_2"], [UIImage imageNamed:@"Loading_3"]]];
    self.tableView.xt_header = imagesHeaderView;
    
    XTImagesFooterView *imagesFooterView = [XTImagesFooterView refreshView:^(XTRefreshView *refreshView) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [refreshView endRefresh];
            XTStrongify(self);
            self.numberOfRows += 10;
            [self.tableView reloadData];
        });
    }];
    [imagesFooterView setImages:@[[UIImage imageNamed:@"Loading_0"], [UIImage imageNamed:@"Loading_1"], [UIImage imageNamed:@"Loading_2"], [UIImage imageNamed:@"Loading_3"]]];
    self.tableView.xt_footer = imagesFooterView;
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    self.tableView.frame = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.textLabel.text = @"我是一个数据";
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.numberOfRows;
}

@end
