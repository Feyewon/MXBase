//
//  DCMediaPhotoLibraryManager.h
//  梦想旅行
//
//  Created by FEI on 2018/11/2.
//  Copyright © 2018年 北京梦想智联科技有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Photos/Photos.h>
#import "DCMediaAssetModel.h"

typedef struct DCVideoDurationRange {
    int min;
    int max;
} DCVideoDurationRange; // {0,0}为不限时长

@interface DCMediaPhotoLibraryManager : NSObject
@property (nonatomic, strong) PHCachingImageManager *cachingImageManager;
@property (nonatomic, assign) NSInteger minPhotoWidthSelectable;
@property (nonatomic, assign) NSInteger minPhotoHeightSelectable;
@property (nonatomic, assign) BOOL hideWhenCanNotSelect;

/**
 对照片排序
 YES 默认
 NO  最新的照片会显示在最前面
 */
@property (nonatomic, assign) BOOL sortAscendingByModificationDate;

+ (instancetype)sharedManager;

/**
 相册授权
 
 @return Return YES if Authorized
 */
+ (BOOL)authorizationStatusAuthorized;

- (void)requestAuthorization:(void (^)(BOOL authorization))completion;

/**
 Get Album 获得相册/相册数组
 */
- (void)getAllAlbums:(BOOL)allowPickingVideo
   allowPickingImage:(BOOL)allowPickingImage
       durationRange:(DCVideoDurationRange)range
          completion:(void (^)(NSArray<DCMediaAlbumModel *> *models))completion;

/// Get Assets 获得Asset数组
- (void)getAssetsFromFetchResult:(PHFetchResult *)fetchResult
               allowPickingVideo:(BOOL)allowPickingVideo
               allowPickingImage:(BOOL)allowPickingImage
                      completion:(void (^)(NSArray<DCMediaAssetModel *> *models))completion;

- (void)getAssetFromFetchResult:(PHFetchResult *)result
                        atIndex:(NSInteger)index
              allowPickingVideo:(BOOL)allowPickingVideo
              allowPickingImage:(BOOL)allowPickingImage
                     completion:(void (^)(DCMediaAssetModel *model))completion;

- (void)getPhotoWithAsset:(PHAsset *)asset
           thumbnailImage:(BOOL)isThumbnail
               photoWidth:(CGFloat)photoWidth
               completion:(void (^)(UIImage *, NSDictionary *))completion;

/*
**
将asset转为image图片

@param asset asset
@param completion 完成的回调
*/
- (void)getPhotoWithAsset:(PHAsset *)asset thumbnailWidth:(CGFloat)width completion:(void (^)(UIImage *image, UIImage *thumbnailImage, NSDictionary *info))completion;

- (PHImageRequestID)getPhotoWithAsset:(id)asset
                           photoWidth:(CGFloat)photoWidth
                           completion:(void (^)(UIImage *photo,NSDictionary *info,BOOL isDegraded))completion
                      progressHandler:(void (^)(double progress, NSError *error, BOOL *stop, NSDictionary *info))progressHandler
                 networkAccessAllowed:(BOOL)networkAccessAllowed;

- (PHImageRequestID)getPhotoDataWithAsset:(id)asset
                              synchronous:(BOOL)synchronous
                               completion:(void (^)(NSData *, NSDictionary *, BOOL))completion
                          progressHandler:(void (^)(double, NSError *, BOOL *, NSDictionary *))progressHandler;

+ (PHAsset *)getPhAssetWithAssetID:(NSString *)assetID;

- (void)cancelImageRequest:(PHImageRequestID)requestID;
/**
 获取相册封面
 */
- (void)getPostImageWithAlbumModel:(DCMediaAlbumModel *)model completion:(void (^)(UIImage *postImage))completion;

/**
 获取相机胶卷中的资源
 */
- (void)getCameraRollAssetWithallowPickingVideo:(BOOL)allowPickingVideo
                              allowPickingImage:(BOOL)allowPickingImage
                                  durationRange:(DCVideoDurationRange)range
                                     completion:(void (^)(NSArray<DCMediaAssetModel *> *models, NSInteger videoCount))completion;

/**
 获取视频实例
 */
- (PHImageRequestID)getVideoWithAsset:(PHAsset *)asset completion:(void (^)(AVAsset * avAsset, NSDictionary * info))completion;

- (PHImageRequestID)getLocalVideoWithAsset:(PHAsset *)asset completion:(void (^)(AVAsset * avAsset, NSDictionary * info))completion;

- (PHImageRequestID)getVideoWithAsset:(PHAsset *)asset
                      progressHandler:(void (^)(double progress, NSError *error, BOOL *stop, NSDictionary *info))progressHandler
                           completion:(void (^)(AVAsset * avAsset, NSDictionary * info))completion;

/**
 保存视频到相册
 */
- (void)saveVideoAtUrl:(NSURL *)videoURL
           toAlbumName:(NSString *)albumName
            completion:(void (^)(NSError *error))completion;

- (void)savePhotoWithImage:(UIImage *)image completion:(void (^)(NSURL *assetURL, NSError *error))completion;

#pragma mark - new api
- (void)saveGifWithAsset:(PHAsset *)asset maxSize:(CGSize)maxSize outputPath:(NSString *)path completion:(void (^)(NSError *error))completion;

- (void)savePhotoWithAsset:(PHAsset *)asset maxSize:(CGSize)maxSize outputPath:(NSString *)path completion:(void (^)(NSError *error))completion;

@end

