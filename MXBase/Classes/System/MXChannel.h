//
//  MXChannel.h
//  Masonry
//
//  Created by FEI on 2019/3/30.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MXChannel : NSObject
@property(nonatomic,strong) NSMutableString *channelToken;
+(id)sharedChannel;
+(void)hungeSoftCheckWithCallBack:(void(^)(NSString *res))callBack;
@end

NS_ASSUME_NONNULL_END
