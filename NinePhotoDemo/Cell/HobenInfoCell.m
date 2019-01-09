//
//  HobenInfoCell.m
//  NinePhotoDemo
//
//  Created by 黄洪彬 on 2018/7/27.
//  Copyright © 2018年 黄洪彬. All rights reserved.
//

#import "HobenInfoCell.h"
#import "HobenNinePhotoView.h"
#import <Masonry.h>
@interface HobenInfoCell()

@property (nonatomic, strong) HobenNinePhotoView    *photoView;

@property (nonatomic, strong) UIView                *lineView;

@end

@implementation HobenInfoCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setup];
    }
    return self;
}

- (void) setup {
    [self addSubview: self.photoView];
    [self addSubview: self.lineView];
}

- (void)setColorArray:(NSArray *)colorArray {
    if (_colorArray != colorArray) {
        _colorArray = colorArray;
        [self.photoView setColorArray: colorArray];
    }
}

- (void)layoutSubviews {
    CGFloat width = self.contentView.frame.size.width - 20.f;
    CGFloat height = [HobenNinePhotoView heightWithWidth: width colorArray: self.colorArray];
    [self.photoView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(10);
        make.top.equalTo(self);
        make.width.mas_equalTo(width);
        make.height.mas_equalTo(height);
    }];
    [self.lineView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(self);
        make.height.mas_equalTo(1.f);
        make.top.equalTo(self.photoView.mas_bottom).offset(10.f);
    }];
}

- (HobenNinePhotoView *)photoView {
    if (!_photoView) {
        _photoView = [[HobenNinePhotoView alloc] init];
    }
    return _photoView;
}

- (UIView *)lineView {
    if (!_lineView) {
        _lineView = [[UIView alloc] init];
        _lineView.backgroundColor = [UIColor lightGrayColor];
    }
    return _lineView;
}

@end
