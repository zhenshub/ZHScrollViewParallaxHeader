//
//  ViewController.m
//  ParallaxTableView
//
//  Created by aleck on 2018/7/28.
//  Copyright © 2018年 Xmly. All rights reserved.
//

#import "ViewController.h"
#import "ZHParallaxHeader.h"
#import "MJRefresh.h"
#import "KKGFakeNavigationBar.h"

@interface ViewController () <UITableViewDelegate, UITableViewDataSource, ZHParallaxHeaderDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, weak) KKGFakeNavigationBar *naviBar;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.tableView.scrollEnabled = NO;
    if (@available(iOS 11, *)) {
        self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
//    self.tableView.bounces = YES;
    [self.view addSubview:self.tableView];
    self.tableView.rowHeight = 100;
    [self.navigationController setNavigationBarHidden:YES];
    KKGFakeNavigationBar *naviBar = [KKGFakeNavigationBar new];
    [self.view addSubview:naviBar];
    self.naviBar = naviBar;
    self.tableView.parallaxHeader.height = 100.f;
    self.tableView.parallaxHeader.delegate = self;
//    self.tableView.mj_header = [MJRefreshNormalHeader new];
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"stars"]];
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    self.tableView.parallaxHeader.contentView = imageView;
//    self.tableView.parallaxHeader.ratio = 0.5;
    __weak typeof(self) weakSelf = self;
//    [self.tableView.mj_header setRefreshingBlock:^{
//        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//            __strong typeof(self) strongSelf = weakSelf;
//            [strongSelf.tableView.mj_header endRefreshing];
//        });
//    }];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [UITableViewCell new];
    cell.backgroundView = [UIView new];
    cell.backgroundView.backgroundColor = [UIColor redColor];
    cell.textLabel.text = [NSString stringWithFormat:@"---第%zd行---", indexPath.row];
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 30;
}

- (void)parallaxHeaderDidScroll:(ZHParallaxHeader *)parallaxHeader {
    
    NSLog(@"CGFloat:%lf", parallaxHeader.progress);
    
    CGFloat threshold = 0.6;
    CGFloat progress = parallaxHeader.progress;
    if (progress > threshold) {
        self.naviBar.alpha = 0;
        return;
    }
    
    self.naviBar.alpha = 1 - parallaxHeader.progress / threshold;
}

- (UITableView *)tableView {
    if (!_tableView) {
        CGRect frame = self.view.frame;
        _tableView.backgroundColor = [UIColor clearColor];
//        frame.origin.y = self.parallaxViewHeight;
        _tableView = [[UITableView alloc] initWithFrame:frame style:UITableViewStylePlain];
//        _tableView.contentInset = UIEdgeInsetsMake(self.parallaxViewHeight, 0, 0, 0);
        _tableView.delegate = self;
        _tableView.dataSource = self;
        UIView *view = [UIView new];
        _tableView.backgroundView = view;
        view.backgroundColor = [UIColor clearColor];
    }
    return _tableView;
}

@end
