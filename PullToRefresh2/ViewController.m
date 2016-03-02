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

@end

@implementation ViewController

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
    cell.textLabel.text = [NSString stringWithFormat:@"%@", [self currentEmoji][indexPath.row]];
    
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[self currentEmoji] count];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

#pragma mark - view
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    [self.tableView registerClass:[UITableViewCell self] forCellReuseIdentifier:@"MyCells"]; // 没有这句程序一直蹦，但看别的demo又没用这个，有点奇怪
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    
    [self.view addSubview:self.tableView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
