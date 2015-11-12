//
//  UIBarButtonItem+Exyension.h
//  微博
//
//  Created by Kerwin on 15/9/9.
//  Copyright (c) 2015年 Kerwin. All rights reserved.
//  设置按钮文字，背景图片，点击高亮图片，点击触发事件


#import <UIKit/UIKit.h>

@interface UIBarButtonItem (Extension)
+ (UIBarButtonItem *)itemWithTarget:(id)target action:(SEL)action image:(NSString *)image highImage:(NSString *)highImage;
@end
