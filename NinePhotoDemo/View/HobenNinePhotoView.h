//
//  HobenNinePhotoView.h
//  NinePhotoDemo
//
//  Created by 黄洪彬 on 2018/7/27.
//  Copyright © 2018年 黄洪彬. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HobenNinePhotoView : UIView

@property (nonatomic, strong) NSArray *colorArray;

+ (CGFloat) heightWithWidth: (CGFloat) width colorArray: (NSArray *) colorArray;

@end
