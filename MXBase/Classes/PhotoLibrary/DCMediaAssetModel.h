//
//  DCMediaAssetModel.h
//  梦想旅行
//
//  Created by FEI on 2018/11/2.
//  Copyright © 2018年 北京梦想智联科技有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, DCMediaAssetModelMediaType) {
    DCMediaAssetModelMediaTypePhoto = 0,
    DCMediaAssetModelMediaTypeLivePhoto,
    DCMediaAssetModelMediaTypePhotoGif,
    DCMediaAssetModelMediaTypeVideo,
    DCMediaAssetModelMediaTypeAudio,
};

NS_ASSUME_NONNULL_BEGIN

@class PHAsset;
@interface DCMediaAssetModel : NSObject
@property (nonatomic, strong) PHAsset *asset;
@property (nonatomic, strong) NSString *imagePath;
@property (nonatomic, strong) UIImage *image;
@property (nonatomic, retain) NSMutableDictionary *metadata;
@property (nonatomic, assign) DCMediaAssetModelMediaType type;
@property (nonatomic, copy) NSString *timeLength;
@property (nonatomic, assign) CGFloat assetDuration;
@property (nonatomic, strong) UIImage *thumbnailImage;
@property (nonatomic, assign) NSInteger selectedIndex;
@property (nonatomic, assign) BOOL enableSelect;
@property (nonatomic, assign) BOOL selected;
@property (nonatomic, assign) BOOL isiCloudAsset;

+ (instancetype)modelWithAsset:(PHAsset *)asset type:(DCMediaAssetModelMediaType)type;
@end

@class PHFetchResult;
@interface DCMediaAlbumModel : NSObject
@property (nonatomic, strong) NSString *albumName;
@property (nonatomic, assign) NSInteger assetsCount;
@property (nonatomic, strong) PHFetchResult *fetchResult;
@property (nonatomic, strong) NSArray *models;
@property (nonatomic, strong) NSArray *selectedModels;
@property (nonatomic, assign) NSUInteger selectedCount;

- (instancetype)initWithFetchResult:(PHFetchResult *)result albumName:(NSString *)albumName;
@end

NS_ASSUME_NONNULL_END
