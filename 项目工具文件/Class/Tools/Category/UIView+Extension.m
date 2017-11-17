//
//  UIView+Extension.m
//  项目工具文件
//
//  Created by 凯哥 on 2017/11/13.
//  Copyright © 2017年 凯哥. All rights reserved.
//

#import "UIView+Extension.h"
#import <objc/runtime.h>
#import "Common.h"

@implementation UIView (Extension)

static char kDTActionHandlerTapBlockKey;
static char kDTActionHandlerTapGestureKey;
static char kDTActionHandlerLongPressBlockKey;
static char kDTActionHandlerLongPressGestureKey;

- (CGFloat)left{
    return self.frame.origin.x;
}

- (void)setLeft:(CGFloat)x{
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}

- (CGFloat)top{
    return self.frame.origin.y;
}

- (void)setTop:(CGFloat)y{
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}

- (CGFloat)right{
    return self.frame.origin.x + self.frame.size.width;
}

- (void)setRight:(CGFloat)right{
    CGRect frame = self.frame;
    frame.origin.x = right - frame.size.width;
    self.frame = frame;
}

- (CGFloat)bottom{
    return self.frame.origin.y + self.frame.size.height;
}

- (void)setBottom:(CGFloat)bottom{
    CGRect frame = self.frame;
    frame.origin.y = bottom - frame.size.height;
    self.frame = frame;
}

- (CGFloat)centerX{
    return self.center.x;
}

- (void)setCenterX:(CGFloat)centerX{
    self.center = CGPointMake(centerX, self.center.y);
}

- (CGFloat)centerY{
    return self.center.y;
}

- (void)setCenterY:(CGFloat)centerY{
    self.center = CGPointMake(self.center.x, centerY);
}

- (CGFloat)width{
    return self.frame.size.width;
}

- (void)setWidth:(CGFloat)width{
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}

- (CGFloat)height{
    return self.frame.size.height;
}

- (void)setHeight:(CGFloat)height{
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}


- (CGPoint)origin{
    return self.frame.origin;
}

- (void)setOrigin:(CGPoint)origin{
    CGRect frame = self.frame;
    frame.origin = origin;
    self.frame = frame;
}

- (CGSize)size{
    return self.frame.size;
}

- (void)setSize:(CGSize)size{
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}
- (void) setCornerRadius:(CGFloat)cornerRadius{
    self.layer.cornerRadius = cornerRadius;
}

- (CGFloat) cornerRadius{
    return self.layer.cornerRadius;
}

- (void) setBorderWidth:(CGFloat)borderWidth{
    self.layer.borderWidth = borderWidth;
}

- (CGFloat) borderWidth{
    return self.layer.borderWidth;
}

- (void) setBorderColor:(UIColor *)borderColor{
    self.layer.borderColor = borderColor.CGColor;
}

- (UIColor *) borderColor{
    return [UIColor colorWithCGColor:self.layer.borderColor];
}

- (void)layerShadow:(UIColor *)color
            opacity:(float)opacity
             radius:(CGFloat)radius
             offset:(CGSize)offset{
    self.layer.shadowColor   = color.CGColor;
    self.layer.shadowOffset  = offset;
    self.layer.shadowOpacity = opacity;
    self.layer.shadowRadius  = radius;
}

- (void)dashedBorder:(UIColor *)borderColor
              radius:(CGFloat)radius{
    CAShapeLayer *borderLayer = [CAShapeLayer layer];
    [self layoutIfNeeded];
    borderLayer.bounds          = self.bounds;
    borderLayer.position        = CGPointMake(CGRectGetMidX(self.bounds), CGRectGetMidY(self.bounds));
    borderLayer.path            = [UIBezierPath bezierPathWithRoundedRect:borderLayer.bounds cornerRadius:radius].CGPath;
    borderLayer.lineWidth       = 1. / [[UIScreen mainScreen] scale];
    borderLayer.lineDashPattern = @[@8, @8];
    borderLayer.fillColor       = [UIColor clearColor].CGColor;
    borderLayer.strokeColor     = borderColor.CGColor;
    [self.layer addSublayer:borderLayer];
}

- (void)solidBorder:(UIColor *)borderColor
                top:(CGFloat)top
               left:(CGFloat)left
              right:(CGFloat)right
             bottom:(CGFloat)bottom{
    [self layoutIfNeeded];
    
    CALayer *layer = self.layer;
    
    if ((top == right == bottom == left) && top > 0) {
        CALayer *border = [CALayer layer];
        border.borderWidth = top;
        [border setBorderColor:borderColor.CGColor];
        [layer addSublayer:border];
        return;
    }
    
    if (top > 0) {
        CALayer *topBorder = [CALayer layer];
        topBorder.borderWidth = top;
        topBorder.frame = CGRectMake(0, 0, layer.frame.size.width, top);
        [topBorder setBorderColor:borderColor.CGColor];
        [layer addSublayer:topBorder];
    }
    
    if (right > 0) {
        CALayer *rightBorder = [CALayer layer];
        rightBorder.borderWidth = right;
        rightBorder.frame = CGRectMake(layer.frame.size.width-right, 0, right, layer.frame.size.height);
        [rightBorder setBorderColor:borderColor.CGColor];
        [layer addSublayer:rightBorder];
    }
    
    if (bottom > 0) {
        CALayer *bottomBorder = [CALayer layer];
        bottomBorder.borderWidth = bottom;
        bottomBorder.frame = CGRectMake(0, layer.frame.size.height-bottom, layer.frame.size.width, bottom);
        [bottomBorder setBorderColor:borderColor.CGColor];
        [layer addSublayer:bottomBorder];
    }
    
    if (left > 0) {
        CALayer *leftBorder = [CALayer layer];
        leftBorder.borderWidth = left;
        leftBorder.frame = CGRectMake(0, 0, left, layer.frame.size.height);
        [leftBorder setBorderColor:borderColor.CGColor];
        [layer addSublayer:leftBorder];
    }
}

- (void)removeAllSubviews{
    while (self.subviews.count) {
        UIView* child = self.subviews.lastObject;
        [child removeFromSuperview];
    }
}

- (UIViewController *)viewController{
    for (UIView *view = self; view; view = view.superview) {
        UIResponder *nextResponder = [view nextResponder];
        
        if ([nextResponder isKindOfClass:[UIViewController class]])
            return (UIViewController *)nextResponder;
    }
    
    return nil;
}

- (void)tapped:(nonnull void(^)(UITapGestureRecognizer *gesture))clicked
      delegate:(nullable id <UIGestureRecognizerDelegate>)delegate{
    UITapGestureRecognizer *gesture = objc_getAssociatedObject(self, &kDTActionHandlerTapGestureKey);
    
    if (!gesture) {
        gesture = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                          action:@selector(__handleActionForTapGesture:)];
        if (delegate)
            gesture.delegate = delegate;
        [self addGestureRecognizer:gesture];
        
        objc_setAssociatedObject(self, &kDTActionHandlerTapGestureKey, gesture, OBJC_ASSOCIATION_RETAIN);
    }
    
    objc_setAssociatedObject(self, &kDTActionHandlerTapBlockKey, clicked, OBJC_ASSOCIATION_COPY);
}

- (void)__handleActionForTapGesture:(UITapGestureRecognizer *)gesture{
    if (gesture.state == UIGestureRecognizerStateRecognized) {
        void(^action)(UITapGestureRecognizer *) = objc_getAssociatedObject(self, &kDTActionHandlerTapBlockKey);
        
        if (action)
            action(gesture);
    }
}

- (void)longPressed:(nonnull void(^)(UILongPressGestureRecognizer *))longPressed
           delegate:(nullable id <UIGestureRecognizerDelegate>)delegate{
    UILongPressGestureRecognizer *gesture = objc_getAssociatedObject(self, &kDTActionHandlerLongPressGestureKey);
    
    if (!gesture) {
        gesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self
                                                                action:@selector(__handleActionForLongPressGesture:)];
        if (delegate)
            gesture.delegate = delegate;
        [self addGestureRecognizer:gesture];
        
        objc_setAssociatedObject(self, &kDTActionHandlerLongPressGestureKey, gesture, OBJC_ASSOCIATION_RETAIN);
    }
    
    objc_setAssociatedObject(self, &kDTActionHandlerLongPressBlockKey, longPressed, OBJC_ASSOCIATION_COPY);
}

- (void)__handleActionForLongPressGesture:(UILongPressGestureRecognizer *)gesture{
    if (gesture.state == UIGestureRecognizerStateBegan) {
        void(^action)(UILongPressGestureRecognizer *) = objc_getAssociatedObject(self, &kDTActionHandlerLongPressBlockKey);
        
        if (action)
            action(gesture);
    }
}

- (UIImage *)screenShot{
    UIGraphicsBeginImageContextWithOptions(self.frame.size, NO, [[UIScreen mainScreen] scale]);
    [self.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    NSData *imageData = UIImagePNGRepresentation(image);
    image = [UIImage imageWithData:imageData];
    return image;
}

-(UIImage *)quickScreenShot{
    //    UIGraphicsBeginImageContextWithOptions(self.frame.size, YES, 0);
    //    [[self layer] renderInContext:UIGraphicsGetCurrentContext()];
    //
    //    UIImage *viewImage = UIGraphicsGetImageFromCurrentImageContext();
    //
    //    UIGraphicsEndImageContext();
    //
    //    CGImageRef imageRef = viewImage.CGImage;
    //    CGRect rect = CGRectMake(0, 0, self.width, self.height);//这里可以设置想要截图的区域
    //    CGImageRef imageRefRect =CGImageCreateWithImageInRect(imageRef, rect);
    //    UIImage *sendImage = [[UIImage alloc] initWithCGImage:imageRefRect];
    //    return sendImage;
    
    UIGraphicsBeginImageContextWithOptions(self.frame.size, NO, 0);
    [self.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    NSData *imageData = UIImagePNGRepresentation(image);
    image = [UIImage imageWithData:imageData];
    return image;
}
@end
