//
//  ViewController.m
//  PullToRefresh2
//
//  Created by Danny Ho on 3/3/16.
//  Copyright © 2016 thanksdanny. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIRefreshControl *refreshControl;
@property (nonatomic, strong) UINavigationBar *navBar;
@property (nonatomic, strong) NSArray *nowEmoji;

@end

@implementation ViewController

#pragma mark - lazy init
- (NSArray *)nowEmoji {
    if (!_nowEmoji) {
        _nowEmoji = [self currentEmoji];
    }
    return _nowEmoji;
}
- (UINavigationBar *)navBar {
    if (!_navBar) {
        _navBar = [[UINavigationBar alloc] initWithFrame:CGRectMake(0, 0, 375, 64)];
    }
    return _navBar;
}

- (UIRefreshControl *)refreshControl {
    if (!_refreshControl) {
        _refreshControl = [[UIRefreshControl alloc] init];
    }
    return _refreshControl;
}
#pragma mark - action
- (void)refreshEmoji {
    NSLog(@"%s", __func__);
    self.refreshControl.attributedTitle = [[NSAttributedString alloc] initWithString:@"下拉刷新"];
    self.nowEmoji = [self newEmoji];
    [self.tableView reloadData];
    [self.refreshControl endRefreshing];
}

#pragma mark - 数据源
- (NSArray *)currentEmoji {
    return @[@"🤗🤗🤗🤗🤗", @"😅😅😅😅😅", @"😆😆😆😆😆"];
}

- (NSArray *)newEmoji {
    return @[@"🏃🏃🏃🏃🏃", @"💩💩💩💩💩", @"👸👸👸👸👸", @"🤗🤗🤗🤗🤗", @"😅😅😅😅😅", @"😆😆😆😆😆"];
}

#pragma mark - tableview
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = nil;
    static NSString *tableViewCellIdentifier = @"MyCells";
    if (cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:tableViewCellIdentifier];
    }
    cell = [tableView dequeueReusableCellWithIdentifier:tableViewCellIdentifier];
    cell.textLabel.text = [NSString stringWithFormat:@"%@", [self nowEmoji][indexPath.row]];
    
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[self nowEmoji] count];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

#pragma mark - view
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    // tableview
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, 375, 603) style:UITableViewStylePlain];
    [self.tableView registerClass:[UITableViewCell self] forCellReuseIdentifier:@"MyCells"]; // 没有这句程序一直蹦，但看别的demo又没用这个，有点奇怪
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
//    self.tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    
    // refreshControl
//    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.refreshControl addTarget:self action:@selector(refreshEmoji) forControlEvents:UIControlEventValueChanged];
    self.refreshControl.backgroundColor = [UIColor colorWithRed:0.113 green:0.113 blue:0.145 alpha:1];
    self.refreshControl.tintColor = [UIColor whiteColor];
    
    // nav
    self.navBar.barStyle = UIBarStyleBlackTranslucent;

    
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.navBar];
    [self.tableView addSubview:self.refreshControl];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
