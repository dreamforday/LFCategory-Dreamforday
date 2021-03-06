//
//  UIView+MBProgressHUD.m
//  LFMBProgressHUDDemo
//
//  Created by WangZhiWei on 16/5/26.
//  Copyright © 2016年 youku. All rights reserved.
//

#import "LFUIView+MBProgressHUD.h"
#import "LFUIView+Add.h"
#import "LFNSString+Add.h"
#import "MBProgressHUD.h"

@implementation UIView (LFMBProgressHUDAdditions)

/*!
 @method
 @abstract
 @discussion	显示转菊花
 @param 	animated
 @result
 */
- (void)lf_showHUDAnimated:(BOOL)animated;
{
    [self lf_showHUDAnimated:animated yOffset:0 height:self.frame.size.height];

}

- (void)lf_showHUDAnimated:(BOOL)animated yOffset:(CGFloat)yOffset height:(CGFloat)height
{
    [self lf_removeAllHUDAnimated:animated];
    
    CGRect hudFrame = self.bounds;
    hudFrame.origin.y += yOffset;
    hudFrame.size.height = height;
    MBProgressHUD *hud = [[MBProgressHUD alloc] initWithFrame:hudFrame];
    [self addSubview:hud];
    hud.mode = MBProgressHUDModeIndeterminate;
    hud.removeFromSuperViewOnHide = YES;
    //hud.graceTime = 0.5; /// 延迟一小段时间再显示，能有更好的用户体验  //这里window不展示 homeTabBar也不展示
    [hud show:animated];
}




/*!
 @method
 @abstract
 @discussion	显示消息
 @param 	animated
 @param 	message 	消息内容
 @result
 */
- (void)lf_showHUDAnimated:(BOOL)animated message:(NSString *)message;
{
    [self showTimedHUD:animated message:message hideAfter:1.2];

}

- (void)showTimedHUD:(BOOL)animated message:(NSString *)message hideAfter:(NSTimeInterval)time {
    [self lf_removeAllHUDAnimated:animated];
    if (message.length == 0) return;
    
    //支持多行
    UILabel *label = [UILabel new];
    label.backgroundColor = [UIColor clearColor];
    label.font = [UIFont boldSystemFontOfSize:15.0f];
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor whiteColor];
    label.lineBreakMode = NSLineBreakByCharWrapping;
    label.text = message;
    label.numberOfLines = 20;
    CGSize size = [message lf_sizeForFont:label.font size:CGSizeMake(self.width - 40, self.height - 40) mode:label.lineBreakMode];
    label.size = CGSizeMake(size.width + 1, size.height + 1);
    
    MBProgressHUD *hud = [[MBProgressHUD alloc] initWithView:self];
    [self addSubview:hud];
    hud.mode = MBProgressHUDModeCustomView;
    hud.customView = label;
    hud.margin = 10.f;
    //    hud.yOffset = self.height > 480 ? 0 : -80;
    hud.removeFromSuperViewOnHide = YES;
    [hud show:animated];
    [hud hide:animated afterDelay:time];
}

/*!
 @method
 @abstract
 @discussion
 @param 	animated
 @param 	message 	消息内容
 @param 	time 	延迟时间
 @result
 */
- (MBProgressHUD *)lf_showHUDAnimated:(BOOL)animated message:(NSString *)message andHiddenAfter:(NSTimeInterval)time
{
    [self lf_removeAllHUDAnimated:animated];
    if (message.length == 0) return nil;
    
    //支持多行
    UILabel *label = [UILabel new];
    label.backgroundColor = [UIColor clearColor];
    label.font = [UIFont boldSystemFontOfSize:14];
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor whiteColor];
    label.lineBreakMode = NSLineBreakByCharWrapping;
    label.text = message;
    label.numberOfLines = 18;
    CGSize size = [message lf_sizeForFont:label.font size:CGSizeMake(CGRectGetWidth(self.bounds) - 60, CGRectGetHeight(self.bounds) - 40) mode:label.lineBreakMode];
    label.size = CGSizeMake(size.width + 1, size.height + 1);
    UIView *v = [UIView new];
    v.size = label.size;
    v.width += 15;
    v.height += 15;
    [v addSubview:label];
    label.center = CGPointMake(v.width / 2, v.height / 2);
    
    MBProgressHUD *hud = [[MBProgressHUD alloc] initWithView:self];
    [self addSubview:hud];
    hud.mode = MBProgressHUDModeCustomView;
    hud.customView = v;
    hud.margin = 10.f;
    hud.yOffset = CGRectGetHeight(self.bounds) > 480 ? 0 : -80;
    hud.removeFromSuperViewOnHide = YES;
    [hud show:animated];
    [hud hide:animated afterDelay:time];
    return hud;
}

/*!
 @method
 @abstract
 @discussion	删除
 @param 	animated
 @result
 */
- (void)lf_removeAllHUDAnimated:(BOOL)animated
{
    [MBProgressHUD hideAllHUDsForView:self animated:animated];
}

@end
