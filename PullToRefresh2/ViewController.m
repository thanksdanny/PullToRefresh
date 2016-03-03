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
        _navBar = [[UINavigationBar alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 64)];
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
    cell.textLabel.textAlignment = NSTextAlignmentCenter;
    cell.textLabel.font = [UIFont systemFontOfSize:50];
    cell.backgroundColor = [UIColor clearColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
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
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, self.view.bounds.size.width, self.view.bounds.size.height - 64) style:UITableViewStylePlain];
    self.tableView.backgroundColor = [UIColor colorWithRed:0.092 green:0.096 blue:0.116 alpha:1];
    [self.tableView registerClass:[UITableViewCell self] forCellReuseIdentifier:@"MyCells"]; // 没有这句程序一直蹦，但看别的demo又没用这个，有点奇怪
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 60.0;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    // refreshControl
    [self.refreshControl addTarget:self action:@selector(refreshEmoji) forControlEvents:UIControlEventValueChanged];
    NSDictionary *attributes = @{NSForegroundColorAttributeName : [UIColor whiteColor]};
    self.refreshControl.attributedTitle = [[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"Last updated on \%@", [NSDate date]] attributes:attributes];
    self.refreshControl.backgroundColor = [UIColor colorWithRed:0.113 green:0.113 blue:0.145 alpha:1];
    self.refreshControl.tintColor = [UIColor whiteColor];
    
    // nav
    self.navBar.barStyle = UIBarStyleBlackTranslucent;
    UINavigationItem *navItem = [UINavigationItem alloc];
    navItem.title = @"emoji🤗";
    [self.navBar pushNavigationItem:navItem animated:false];
    
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.navBar];
    [self.tableView addSubview:self.refreshControl];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
