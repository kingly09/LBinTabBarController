//
//  LBTabBar.m
//  LiBTabBarController
//
//  Created by kingly on 15/12/11.
//  Copyright © 2015年 kingly. All rights reserved.
//

#import "LBTabBar.h"

@interface LBTabBar ()

/** 发布按钮 */
@property (nonatomic, strong) UIButton<LBPlusButtonSubclassingDelegate> *plusButton;

@end

@implementation LBTabBar

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self = [self sharedInit];
    }
    return self;
}

- (instancetype)initWithCoder: (NSCoder *)aDecoder {
    self = [super initWithCoder: aDecoder];
    if (self) {
        self = [self sharedInit];
    }
    return self;
}

- (instancetype)sharedInit {
    if (LBExternPushlishButton) {
        self.plusButton = LBExternPushlishButton;
        [self addSubview:(UIButton *)self.plusButton];
    }
    [self setBackgroundImage:[self imageWithColor:[UIColor whiteColor]]];
    return self;
}


-(void)layoutSubviews{
    [super layoutSubviews];
    
    if (!LBExternPushlishButton) {
        return;
    }
    CGFloat barWidth = self.frame.size.width;
    CGFloat barHeight = self.frame.size.height;
    
    CGFloat tabBarButtonW = (CGFloat) barWidth / (LBTabbarItemsCount + 1);
    NSInteger buttonIndex = 0;
    CGFloat multiplerInCenterY;
    if ([[self.plusButton class] respondsToSelector:@selector(multiplerInCenterY)]) {
        multiplerInCenterY = [[self.plusButton class] multiplerInCenterY];
    }
    else {
        CGSize sizeOfPlusButton = self.plusButton.frame.size;
        CGFloat heightDifference = sizeOfPlusButton.height - self.bounds.size.height;
        if (heightDifference < 0) {
            multiplerInCenterY = 0.5;
        } else {
            CGPoint center = CGPointMake(self.bounds.size.height / 2.0f, self.bounds.size.height / 2.0f);
            center.y = center.y - heightDifference / 2.0f;
            multiplerInCenterY = center.y/self.bounds.size.height;
        }
    }
    
    self.plusButton.center = CGPointMake(barWidth * 0.5, barHeight * multiplerInCenterY);
    
    NSUInteger plusButtonIndex;
    if ([[self.plusButton class] respondsToSelector:@selector(indexOfPlusButtonInTabBar)]) {
        if (LBTabbarItemsCount % 2 == 0) {
            [NSException raise:@"LBTabBarController" format:@"If the count of LBTabbarControllers is not odd,there's no need to realizse `+indexOfPlusButtonInTabBar` in your custom plusButton class."];
        }
        plusButtonIndex = [[self.plusButton class] indexOfPlusButtonInTabBar];
        //仅修改self.plusButton的x,ywh值不变
        self.plusButton.frame = CGRectMake(plusButtonIndex*tabBarButtonW,
                                           CGRectGetMinY(self.plusButton.frame),
                                           CGRectGetWidth(self.plusButton.frame),
                                           CGRectGetHeight(self.plusButton.frame)
                                           );
    }
    else {
        if (LBTabbarItemsCount % 2 != 0) { //必须
            [NSException raise:@"LBTabBarController" format:@"If the count of LBTabBarControllers is odd,you must realizse `+indexOfPlusButtonInTabBar` in your custom plusButton class."];
        }
        plusButtonIndex = LBTabbarItemsCount / 2.0;
    }
    
    for (UIView *childView in self.subviews) {
        //调整加号按钮后面的UITabBarItem的位置
        if ([childView isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
            if (buttonIndex == plusButtonIndex) {
                buttonIndex++;
            }
            //仅修改childView的宽度,xyh值不变
            childView.frame = CGRectMake(CGRectGetMinX(childView.frame),
                                         CGRectGetMinY(childView.frame),
                                         tabBarButtonW,
                                         CGRectGetHeight(childView.frame)
                                         );
            //仅修改childView的x,ywh值不变
            childView.frame = CGRectMake(buttonIndex*tabBarButtonW,
                                         CGRectGetMinY(childView.frame),
                                         CGRectGetWidth(childView.frame),
                                         CGRectGetHeight(childView.frame)
                                         );
            buttonIndex++;
        }
    }
    //bring the plus button to top
    [self bringSubviewToFront:self.plusButton];
}

/*
 *
    Capturing touches on a subview outside the frame of its superview
 *
 */
//- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event
//{
//    if (!self.clipsToBounds && !self.hidden && self.alpha > 0) {
//        for (UIView *subview in self.subviews.reverseObjectEnumerator) {
//            CGPoint subPoint = [subview convertPoint:point fromView:self];
//            UIView *result = [subview hitTest:subPoint withEvent:event];
//            if (result != nil) {
//                return result;
//            }
//        }
//    }
//    return nil;
//}


- (UIImage *)imageWithColor:(UIColor *)color
{
    NSParameterAssert(color != nil);
    
    CGRect rect = CGRectMake(0, 0, 1, 1);
    // Create a 1 by 1 pixel context
    UIGraphicsBeginImageContextWithOptions(rect.size, NO, 0);
    [color setFill];
    UIRectFill(rect);   // Fill it with your color
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}


@end
