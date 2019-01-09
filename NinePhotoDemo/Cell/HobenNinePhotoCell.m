//
//  HobenNinePhotoCell.m
//  NinePhotoDemo
//
//  Created by 黄洪彬 on 2018/7/27.
//  Copyright © 2018年 黄洪彬. All rights reserved.
//

#import "HobenNinePhotoCell.h"
#import <Masonry.h>

@interface HobenNinePhotoCell()

@property (nonatomic, strong) UIView *gridView;

@end

@implementation HobenNinePhotoCell

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setup];
    }
    return self;
}

- (void) setup {
    [self addSubview: self.gridView];
}

- (void)layoutSubviews {
    [self.gridView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.size.equalTo(self);
        make.top.equalTo(self);
        make.left.equalTo(self);
    }];
    
}

- (void) setColor:(UIColor *)color {
    self.gridView.backgroundColor = color;
}

- (UIView *)gridView {
    if (!_gridView) {
        _gridView = ({
            UIView *view = [[UIView alloc] init];
            view;
        });
    }
    return _gridView;
}

@end
