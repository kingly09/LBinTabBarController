//
//  LBTabBarController.h
//  LBTabBarController
//
//  Created by kingly on 15/12/11.
//  Copyright © 2015年 kingly. All rights reserved.
//
@import Foundation;

static NSString *const LBTabBarItemTitle= @"tabBarItemTitle";
static NSString *const LBTabBarItemImage= @"tabBarItemImage";
static NSString *const LBTabBarItemSelectedImage= @"tabBarItemSelectedImage";

extern NSUInteger LBTabbarItemsCount;


#import <UIKit/UIKit.h>

@interface LBTabBarController : UITabBarController


/**
 *  tab bar 界面显示的根视图控制器的数组.
 */
@property (nonatomic, readwrite, copy) IBOutletCollection(UIViewController) NSArray *viewControllers;
/**
 *  tab bar 属性
 */
@property (nonatomic, readwrite, copy) IBOutletCollection(NSDictionary) NSArray *tabBarItemsAttributes;

@end

@interface UIViewController (LBTabBarController)

/**
 * 在视图控制器层次结构中的最近是一个主标签栏控制器. (read-only)
 */
@property(nonatomic, readonly) LBTabBarController *main_tabBarController;

@end
