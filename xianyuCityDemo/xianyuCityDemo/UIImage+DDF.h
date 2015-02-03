//
//  UIImage+DDF.h
//  DaiDaiFa
//
//  Created by coder.j on 14-10-17.
//  Copyright (c) 2014年 com.daidaifa. All rights reserved.
//
#import <UIKit/UIKit.h>

@interface UIImage (DDF)
+ (instancetype)circleImageWithName:(NSString *)name borderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor;

+ (UIImage *)resizableImageWithName:(NSString *)name;

+ (UIImage *)strenchImageWithName:(NSString *)name;
+ (UIImage *)blurryImage:(UIImage *)image withBlurLevel:(CGFloat)blur;
@end
