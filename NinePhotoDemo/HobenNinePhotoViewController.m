//
//  ViewController.m
//  NinePhotoDemo
//
//  Created by 黄洪彬 on 2018/7/27.
//  Copyright © 2018年 黄洪彬. All rights reserved.
//

#import "HobenNinePhotoViewController.h"
#import "HobenNinePhotoCell.h"

static NSString *const HobenNinePhotoID = @"HobenNinePhotoID";

@interface HobenNinePhotoViewController () <UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) UICollectionView *ninePhotoView;

@end

@implementation HobenNinePhotoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setup];
}

- (void) setup {
    [self.view addSubview: self.ninePhotoView];
}

#pragma mark UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    
}


- (UICollectionView *)ninePhotoView {
    if (_ninePhotoView) {
        _ninePhotoView = ({
            UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
            layout.scrollDirection = UICollectionViewScrollDirectionVertical;
            UICollectionView *view = [[UICollectionView alloc] initWithFrame: CGRectMake(10, 0,
                                                                                         self.view.frame.size.width - 20,
                                                                                         self.view.frame.size.height)
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
