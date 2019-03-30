//
//  NSData+Addition.h
//  梦想旅行
//
//  Created by fzw on 2018/5/30.
//  Copyright © 2018年 北京梦想智联科技有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSData (Addition)
-(NSString*)getMD5;
-(NSData *) aes256_encrypt:(NSString *)key;
-(NSData *) aes256_decrypt:(NSString *)key;
@end
