//
//  NSData+MD5Digest.m
//  NSData+MD5Digest
//
//  Created by Francis Chong on 12年6月5日.
//

#import "NSData+MD5Digest.h"
#import <CommonCrypto/CommonDigest.h>

@implementation NSData (MD5)

+ (NSData *)MD5Digest:(NSData *)input {
    CC_MD5_CTX md5;
    CC_MD5_Init(&md5);
    CC_MD5_Update(&md5, [input bytes], (CC_LONG)[input length]);
    unsigned char digist[CC_MD5_DIGEST_LENGTH]; //CC_MD5_DIGEST_LENGTH = 16
    CC_MD5_Final(digist, &md5);
    return [[NSData alloc] initWithBytes:digist length:CC_MD5_DIGEST_LENGTH];
}

- (NSData *)MD5Digest {
    return [NSData MD5Digest:self];
}

+ (NSString *)MD5HexDigest:(NSData *)input {
    NSData *md5Data = [self MD5Digest:input];
    NSMutableString *outPutStr = [[NSMutableString alloc] initWithCapacity:[md5Data length]];
    [md5Data enumerateByteRangesUsingBlock:^(const void *bytes, NSRange byteRange, BOOL *stop) {
        unsigned char *dataBytes = (unsigned char*)bytes;
        for (NSInteger i = 0; i < byteRange.length; i++) {
            NSString *hexStr = [NSString stringWithFormat:@"%x", (dataBytes[i]) & 0xff];
            [outPutStr appendString:hexStr];
        }
    }];
    return [outPutStr lowercaseString];
}

- (NSString *)MD5HexDigest {
    return [NSData MD5HexDigest:self];
}
@end
