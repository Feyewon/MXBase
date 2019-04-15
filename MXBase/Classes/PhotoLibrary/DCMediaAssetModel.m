//
//  DCMediaAssetModel.m
//  梦想旅行
//
//  Created by FEI on 2018/11/2.
//  Copyright © 2018年 北京梦想智联科技有限公司. All rights reserved.
//

#import "DCMediaAssetModel.h"
#import <Photos/Photos.h>

@implementation DCMediaAssetModel
+ (instancetype)modelWithAsset:(PHAsset *)asset type:(DCMediaAssetModelMediaType)type{
    DCMediaAssetModel *model = [[DCMediaAssetModel alloc] init];
    model.asset = asset;
    model.type = type;
    model.selectedIndex = -1;
    NSInteger duration = type == DCMediaAssetModelMediaTypeVideo ? asset.duration : 0;
    model.assetDuration = duration;
    model.timeLength = [self getNewTimeFromDurationSecond:duration];
    model.enableSelect = YES;
    return model;
}

+ (NSString *)getNewTimeFromDurationSecond:(NSInteger)duration {
    NSString *newTime;
    if (duration < 10) {
        newTime = [NSString stringWithFormat:@"0:0%zd",duration];
    } else if (duration < 60) {
        newTime = [NSString stringWithFormat:@"0:%zd",duration];
    } else {
        NSInteger min = duration / 60;
        NSInteger sec = duration - (min * 60);
        if (sec < 10) {
            newTime = [NSString stringWithFormat:@"%zd:0%zd",min,sec];
        } else {
            newTime = [NSString stringWithFormat:@"%zd:%zd",min,sec];
        }
    }
    return newTime;
}
@end


@implementation DCMediaAlbumModel

- (instancetype)initWithFetchResult:(PHFetchResult *)result albumName:(NSString *)albumName {
    if (self = [super init]) {
        _fetchResult = result;
        _albumName = albumName;
        _assetsCount = result.count;
    }
    return self;
}
@end
