//
//  HobenNinePhotoView.m
//  NinePhotoDemo
//
//  Created by 黄洪彬 on 2018/7/27.
//  Copyright © 2018年 黄洪彬. All rights reserved.
//

#import "HobenNinePhotoView.h"
#import "HobenNinePhotoCell.h"
#import <Masonry.h>

#define kHobenNinePhotoViewSpacing 5.f

static NSString *const HobenNinePhotoID = @"HobenNinePhotoID";

@interface HobenNinePhotoView() <UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) UICollectionView  *ninePhotoView;

@end

@implementation HobenNinePhotoView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setup];
    }
    return self;
}

- (void) setup {
    [self addSubview: self.ninePhotoView];
}

- (void)layoutSubviews {
    [self.ninePhotoView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self);
        make.top.equalTo(self);
        make.height.equalTo(self);
        if (self.colorArray.count == 4)
            make.width.mas_equalTo(self.mas_width).multipliedBy(2.f / 3);
        else
            make.width.equalTo(self);
    }];
}

- (UICollectionView *)ninePhotoView {
    if (!_ninePhotoView) {
        _ninePhotoView = ({
            UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
            [layout setMinimumLineSpacing:2.f];
            [layout setMinimumInteritemSpacing:2.f];
            [layout setScrollDirection:UICollectionViewScrollDirectionVertical];
            [layout setSectionInset:UIEdgeInsetsZero];
            UICollectionView *view = [[UICollectionView alloc] initWithFrame: self.bounds
                                                        collectionViewLayout: layout];
            view.dataSource = self;
            view.delegate = self;
            view.alwaysBounceVertical = YES;
            view.scrollEnabled = NO;
            view.backgroundColor = [UIColor clearColor];
            [view registerClass: [HobenNinePhotoCell class] forCellWithReuseIdentifier: HobenNinePhotoID];
            view;
        });
    }
    return _ninePhotoView;
}

- (void)setColorArray:(NSArray *)colorArray {
    if (_colorArray != colorArray) {
        _colorArray = colorArray;
        [self.ninePhotoView reloadData];
    }
}

+ (CGFloat) getImageWidthWithWidth:(CGFloat)width index:(NSInteger)i count:(NSInteger) cnt {
    CGFloat spacing = kHobenNinePhotoViewSpacing;
    if (cnt == 2) {
        return (width - spacing) / 2;
    } else if (cnt % 3 == 0 || cnt == 4) {
        return (width - 2 * spacing) / 3;
    } else if (cnt == 8) {
        return (width - 3 * spacing) / 4;
    } else if (cnt == 5) {
        if (i <= 1) {
            return (width - spacing) / 2;
        } else {
            return (width - 2 * spacing) / 3;
        }
    } else if (cnt == 7) {
        if (i <= 2) {
            return (width - 2 * spacing) / 3;
        } else {
            return (width - 3 * spacing) / 4;
        }
    } else
        return 200.f;
}

+ (CGFloat) heightWithWidth: (CGFloat) width colorArray: (NSArray *) colorArray {
    CGFloat imageHeight = 0.f;
    if(colorArray.count > 1) {
        if (colorArray.count == 2) {
            imageHeight = (width - kHobenNinePhotoViewSpacing) / 2;
        } else if (colorArray.count % 3 == 0) {
            NSInteger imageLine = colorArray.count / 3;
            imageHeight = imageLine * ((width - 2 * kHobenNinePhotoViewSpacing) / 3 + kHobenNinePhotoViewSpacing);
        } else if (colorArray.count == 4) {
            imageHeight = 2 * width / 3;
        } else if (colorArray.count == 5) {
            imageHeight = (width - kHobenNinePhotoViewSpacing) / 2 + (width - 2 * kHobenNinePhotoViewSpacing) / 3 + kHobenNinePhotoViewSpacing;
        } else if (colorArray.count == 7) {
            imageHeight = (width - 2 * kHobenNinePhotoViewSpacing) / 3 + (width - 3 * kHobenNinePhotoViewSpacing) / 4 + kHobenNinePhotoViewSpacing;
        } else if (colorArray.count == 8) {
            imageHeight = 2 * (width - 3 * kHobenNinePhotoViewSpacing) / 4 + kHobenNinePhotoViewSpacing;
        }
    }
    else {
        return 200.f;
    }
    return imageHeight;
}
#pragma mark - UICollectionViewDelegate
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    if (self.colorArray.count == 5 || self.colorArray.count == 7)
        return 2;
    else
        return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (self.colorArray.count == 5) {
        if (section == 0)
            return 2;
        else
            return 3;
    }
    else if (self.colorArray.count == 7) {
        if (section == 0)
            return 3;
        else
            return 4;
    }
    else
        return self.colorArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    HobenNinePhotoCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier: HobenNinePhotoID forIndexPath: indexPath];
    
    NSInteger currentItem = 0;
    if (self.colorArray.count == 5)
        currentItem = 2 * indexPath.section + indexPath.item;
    else if (self.colorArray.count == 7)
        currentItem = 3 * indexPath.section + indexPath.item;
    else
        currentItem = indexPath.item;
    
    [cell setColor: [self.colorArray objectAtIndex: currentItem]];
    
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger currentItem = 0;
    if (self.colorArray.count == 5)
        currentItem = 2 * indexPath.section + indexPath.item;
    else if (self.colorArray.count == 7)
        currentItem = 3 * indexPath.section + indexPath.item;
    else
        currentItem = indexPath.item;

    CGFloat width = [HobenNinePhotoView getImageWidthWithWidth: self.frame.size.width index: currentItem count: self.colorArray.count];
    
    return CGSizeMake(width, width);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger currentItem = 0;
    if (self.colorArray.count == 5)
        currentItem = 2 * indexPath.section + indexPath.item;
    else if (self.colorArray.count == 7)
        currentItem = 3 * indexPath.section + indexPath.item;
    else
        currentItem = indexPath.item;
    
    NSLog(@"You clicked %ld", currentItem);
}

#pragma mark - UICollectionViewDelegateFlowLayout
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(0, 0, kHobenNinePhotoViewSpacing, 0);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return kHobenNinePhotoViewSpacing;
}

@end
