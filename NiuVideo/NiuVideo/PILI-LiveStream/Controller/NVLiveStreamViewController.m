//
//  NVLiveStreamViewController.m
//  NiuVideo
//
//  Created by 冯文秀 on 2017/12/5.
//  Copyright © 2017年 Pili Engineering, Qiniu Inc. All rights reserved.
//

#import "NVLiveStreamViewController.h"
#import "NVLiveStreamTableViewCell.h"

@interface NVLiveStreamViewController ()
<
UITableViewDelegate,
UITableViewDataSource,
NVLiveStreamTableViewCellDelegate
>

@property (nonatomic, strong) UITableView       *tableView;
@property (nonatomic, strong) NSMutableArray    *liveUserArray;

@end

@implementation NVLiveStreamViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setupNavigationItem];
    
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:(UITableViewStyleGrouped)];
    self.tableView.delegate     = self;
    self.tableView.dataSource   = self;
    [self.view addSubview:self.tableView];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    [self requestLiveUser];
}

- (void)setupNavigationItem {
    self.navigationItem.title = @"直播";
    
    UIBarButtonItem *leftBarButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"qr_code"] style:UIBarButtonItemStylePlain target:self action:@selector(leftBarButtonAction)];
    self.navigationItem.leftBarButtonItem = leftBarButton;
    self.navigationItem.leftBarButtonItem.tintColor = NV_BLACK_COLOR;
    
    UIBarButtonItem *rightBarButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"url_link"] style:UIBarButtonItemStylePlain target:self action:@selector(rightBarButtonAction)];
    self.navigationItem.rightBarButtonItem = rightBarButton;
    self.navigationItem.rightBarButtonItem.tintColor = NV_BLACK_COLOR;
}

#pragma mark ---- leftBarButton ----

- (void)leftBarButtonAction {
    
}

#pragma mark ---- rightBarButton ----

- (void)rightBarButtonAction {
    
}

- (void)dealloc {
    NSLog(@"dealloc: %@", [[self class] description]);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark -------- network ---------
- (void)requestLiveUser {
    if (!self.liveUserArray) {
        self.liveUserArray = [[NSMutableArray alloc] init];
    }
    
    // doing request ....
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


#pragma mark - tableView DataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.liveUserArray.count;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellReuseID = @"liveTableCell";
    NVLiveStreamTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellReuseID];
    if (!cell) {
        cell = [[NVLiveStreamTableViewCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:cellReuseID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.liveUserModel = [self.liveUserArray objectAtIndex:indexPath.row];
    
    return cell;
}

#pragma mark - tableView Delegate

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewAutomaticDimension;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

#pragma mark - NVLiveStreamTableViewCellDelegate

- (void)liveStreamTableViewCellShareButtonClick:(NVLiveStreamTableViewCell *)liveCell {
    
}

@end
