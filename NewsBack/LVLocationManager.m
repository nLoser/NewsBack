//
//  LVLocationManager.m
//  NewsBack
//
//  Created by LV on 15/8/1.
//  Copyright (c) 2015年 linkdow. All rights reserved.
//

#import "LVLocationManager.h"

@interface LVLocationManager ()<CLLocationManagerDelegate>

@end

@implementation LVLocationManager

+ (instancetype)shareInstance
{
    static LVLocationManager * manager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[LVLocationManager alloc] init];
    });
    return manager;
}

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        self.minSpeed = 3;
        self.minFilter = 50;
        self.minInteval = 10;
        self.delegate = self;
        self.distanceFilter = self.minFilter;
        self.desiredAccuracy = kCLLocationAccuracyBest;
    }
    return self;
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    CLLocation * location = locations[0];
    NSLog(@"%@",location);
    
    // 根据实际情况来调整出发范围
    [self adjustDistanceFilter:location];
    // 上传数据
    [self upLoadLocation:location];
}
/**
 *  规则： 如果速度小于minSpeed m/s  则把触发范围设定为50m
 *  否则将触发范围设定为minSeed*minInteval
 **/
- (void)adjustDistanceFilter:(CLLocation *)location
{
    if (location.speed < self.minSpeed)
    {
        if (fabs(self.distanceFilter - self.minFilter) > 0.1f)
        {
            self.distanceFilter = self.minFilter;
        }
    }else
    {
        CGFloat lastSpeed = self.distanceFilter/self.minInteval;
        
        if (fabs(lastSpeed - location.speed)/lastSpeed > 0.1f)
        {
            CGFloat newSpeed = (int)(location.speed + 0.5f);
            CGFloat newFilter = newSpeed * self.minInteval;
            
            self.distanceFilter = newFilter;
        }
    }
}

- (void)upLoadLocation:(CLLocation *)location
{
    
}

@end
