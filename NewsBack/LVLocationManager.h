//
//  LVLocationManager.h
//  NewsBack
//
//  Created by LV on 15/8/1.
//  Copyright (c) 2015年 linkdow. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

@interface LVLocationManager : CLLocationManager

+ (instancetype)shareInstance;

/// 最小速度
@property (nonatomic, assign) CGFloat minSpeed;
/// 最小范围
@property (nonatomic, assign) CGFloat minFilter;
/// 更新间隔
@property (nonatomic, assign) CGFloat minInteval;

@end
