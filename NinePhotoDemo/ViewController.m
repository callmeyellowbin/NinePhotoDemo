//
//  ViewController.m
//  NinePhotoDemo
//
//  Created by 黄洪彬 on 2018/7/27.
//  Copyright © 2018年 黄洪彬. All rights reserved.
//

#import "ViewController.h"
#import "HobenNinePhotoCell.h"
#import "HobenNinePhotoView.h"
#import "HobenInfoCell.h"
#import <Masonry.h>

static NSString *const HobenInfoCellID = @"HobenInfoCellID";

@interface ViewController() <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView       *infoView;

@property (nonatomic, strong) NSMutableArray    *colorArrayArray;

@property (nonatomic, strong) UITableViewCell   *infoCell;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setup];
}

- (void) setup {
    [self.view addSubview: self.infoView];
    self.view.backgroundColor = [UIColor clearColor];
    [self.infoView setSeparatorStyle: UITableViewCellSeparatorStyleNone];
}

- (void)viewDidLayoutSubviews {
    [self.infoView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view);
        make.left.equalTo(self.view);
        make.size.equalTo(self.view);
    }];
}

- (NSMutableArray *)colorArrayArray {
    if (!_colorArrayArray) {
        _colorArrayArray = ({
            NSMutableArray *arrays = [[NSMutableArray alloc] init];
            UIColor *black = [UIColor blackColor];
            UIColor *yellow = [UIColor yellowColor];
            UIColor *red = [UIColor redColor];
            UIColor *green = [UIColor greenColor];
            UIColor *gray = [UIColor grayColor];
            UIColor *orange = [UIColor orangeColor];
            UIColor *darkGray = [UIColor darkGrayColor];
            UIColor *brown = [UIColor brownColor];
            UIColor *blue = [UIColor blueColor];
            
            NSArray *totalColorArray = @[black, yellow, red, green, gray, orange, darkGray, brown, blue];
            
            for (int i = 1; i <= 9; i++) {
                NSArray *array = [totalColorArray subarrayWithRange: NSMakeRange(0, i)];
                [arrays addObject: array];
            }
            arrays;
        });
    };
    return _colorArrayArray;
}

- (UITableView *)infoView {
    if (!_infoView) {
        _infoView = ({
            UITableView *tableView = [[UITableView alloc] initWithFrame: CGRectMake(0, 0,
                                                                               self.view.frame.size.width,
                                                                               self.view.frame.size.height)];
            [tableView registerClass: [HobenInfoCell class] forCellReuseIdentifier: HobenInfoCellID];
            tableView.delegate = self;
            tableView.dataSource = self;
            tableView;
        });
    }
    return _infoView;
}


#pragma mark - <UITableViewDelegate>
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.colorArrayArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    HobenInfoCell *cell = [tableView dequeueReusableCellWithIdentifier: HobenInfoCellID forIndexPath: indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell setColorArray: self.colorArrayArray[indexPath.item]];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat height = [HobenNinePhotoView heightWithWidth: self.view.frame.size.width - 20 colorArray: self.colorArrayArray[indexPath.item]];
    return height + 20.f;
}

@end
