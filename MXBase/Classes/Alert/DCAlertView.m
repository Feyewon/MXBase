//
//  DCAlertView.m
//  梦想旅行
//
//  Created by fzw on 15/10/21.
//  Copyright © 2015年 北京梦想智联科技有限公司. All rights reserved.
//

#import "DCAlertView.h"
#import "Masonry.h"
#import "UIColor+Addition.h"
#import "MXMacro.h"

@implementation DCAlertView
-(id)initWithTitle:(NSString *)title message:(NSString *)message cancelButtonTitle:(NSString *)cancelButtonTitle submitButtonTitle:(NSString *)submitButtonTitle{
    self=[super initWithTitle:title message:message delegate:self cancelButtonTitle:cancelButtonTitle otherButtonTitles:submitButtonTitle, nil];
    return self;
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if(buttonIndex==0){
        RUN(self.cancelBlock,nil);
    }else if(buttonIndex==1){
        RUN(self.submitBlock,nil);
    }
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
