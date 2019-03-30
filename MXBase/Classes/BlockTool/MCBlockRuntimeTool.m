//
//  MCBlockRuntimeTool.m
//  MagicCamera
//
//  Created by fzw on 2018/12/27.
//  Copyright © 2018 Mxtrip. All rights reserved.
//

#import "MCBlockRuntimeTool.h"
#import <objc/runtime.h>
// Block internals.
typedef NS_OPTIONS(int, MCBlockFlags) {
    MCBlockFlagsHasCopyDisposeHelpers = (1 << 25),
    MCBlockFlagsHasSignature          = (1 << 30)
};

typedef struct _MCBlock {
    __unused Class isa;
    MCBlockFlags flags;
    __unused int reserved;
    void (__unused *invoke)(struct _MCBlock *block, ...);
    struct {
        unsigned long int reserved;
        unsigned long int size;
        // requires MCBlockFlagsHasCopyDisposeHelpers
        void (*copy)(void *dst, const void *src);
        void (*dispose)(const void *);
        // requires MCBlockFlagsHasSignature
        const char *signature;
        const char *layout;
    } *descriptor;
    // imported variables
} *MCBlockRef;

@interface MCBlockRuntimeTool ()
@property (nonatomic,strong) NSInvocation *invocation;
@end

@implementation MCBlockRuntimeTool
+ (NSMethodSignature *)getBlockMethodSignature:(id)block error:(NSError * __nullable __autoreleasing * __nullable)error {
    MCBlockRef layout = (__bridge void *)block;
    if (!(layout->flags & MCBlockFlagsHasSignature)) {
        return nil;
    }
    void *desc = layout->descriptor;
    desc += 2 * sizeof(unsigned long int);
    if (layout->flags & MCBlockFlagsHasCopyDisposeHelpers) {
        desc += 2 * sizeof(void *);
    }
    if (!desc) {
        return nil;
    }
    const char *signature = (*(const char **)desc);
    return [NSMethodSignature signatureWithObjCTypes:signature];
}


/**
 用block初始化tool
 
 @param block 泛型block
 @param error 用于保存错误
 */
+ (id)toolWithBlock:(id)block error:(NSError * __nullable __autoreleasing * __nullable)error {
    return [[self alloc] initWithBlock:block error:error];
}

- (id)initWithBlock:(id)block error:(NSError * __nullable __autoreleasing * __nullable)error {
    NSError *pError;
    if (!block) {
        return nil;
    }
    NSMethodSignature *signature = [[self class] getBlockMethodSignature:block error:&pError];
    if (pError) {
        if (error) *error = pError;
        return nil;
    }
    if (self = [self init]) {
        _invocation = [NSInvocation invocationWithMethodSignature:signature];
        _invocation.target = block;
        [_invocation retainArguments];
    }
    return self;
}

/**
 保存参数，从1开始
 
 @param argumentLocation 用于传递参数
 @param idx 保存在第几位 必须从1开始
 */
- (void)setArgument:(void *)argumentLocation atIndex:(NSInteger)idx {
    [self.invocation setArgument:argumentLocation atIndex:idx];
}

/**
 获取返回值
 
 @param retLoc 用于保存结果
 */
- (void)getReturnValue:(void *)retLoc {
    [self.invocation getReturnValue:retLoc];
}

// 有时间了在这加一个参数校验
- (void)run {
    [self.invocation invoke];
}

- (NSUInteger)argumentPtrSizeAtIndex:(NSInteger)idx {
    const char *type = [self.invocation.methodSignature getArgumentTypeAtIndex:idx];
    NSUInteger argSize;
    NSGetSizeAndAlignment(type, &argSize, NULL);
    return argSize;
}

@end
