//
//  HobenNinePhotoView.m
//  NinePhotoDemo
//
//  Created by 黄洪彬 on 2018/7/27.
//  Copyright © 2018年 黄洪彬. All rights reserved.
//

#import "HobenNinePhotoView.h"
#import "HobenNinePhotoCell.h"

#define kHobenNinePhotoViewSpacing 5.f

static NSString *const HobenNinePhotoID = @"HobenNinePhotoID";

@interface HobenNinePhotoView() <UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) UICollectionView *ninePhotoView;

@end

@implementation HobenNinePhotoView

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
        return 0;
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
            return 2;
        else
            return 3;
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
    
    cell.color = [self.colorArray objectAtIndex: currentItem];
    
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

- (UICollectionView *)ninePhotoView {
    if (_ninePhotoView) {
        _ninePhotoView = ({
            UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
            layout.scrollDirection = UICollectionViewScrollDirectionVertical;
            UICollectionView *view = [[UICollectionView alloc] initWithFrame: CGRectMake(10.f, 0,
                                                                                         self.frame.size.width - 20.f,
                                                                                         self.frame.size.height)
                                                        collectionViewLayout: layout];
            view.dataSource = self;
            view.delegate = self;
            [view registerClass: [HobenNinePhotoCell class] forCellWithReuseIdentifier: HobenNinePhotoID];
            view;
        });
    }
    return _ninePhotoView;
}
@end
