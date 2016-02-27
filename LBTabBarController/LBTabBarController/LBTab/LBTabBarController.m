//
//  LBTabBarController.m
//  LBTabBarController
//
//  Created by kingly on 15/12/11.
//  Copyright © 2015年 kingly. All rights reserved.
//

#import "LBTabBarController.h"

#import "LBTabBar.h"
#import <objc/runtime.h>


NSUInteger LBTabbarItemsCount = 0;

#pragma mark - UIViewController+LBTabBarControllerItem
@interface UIViewController (LBTabBarControllerItemInternal)

- (void)main_setTabBarController:(LBTabBarController *)tabBarController;

@end


@implementation UIViewController (LBTabBarControllerItemInternal)

- (void)main_setTabBarController:(LBTabBarController *)tabBarController {
    objc_setAssociatedObject(self, @selector(main_tabBarController), tabBarController, OBJC_ASSOCIATION_ASSIGN);
}

@end


@interface LBTabBarController ()

@end

@implementation LBTabBarController
@synthesize viewControllers = _viewControllers;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    // 处理tabBar，使用自定义 tabBar 添加 发布按钮
    [self setUpTabBar];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Private Methods

/**
 *  利用 KVC 把 系统的 tabBar 类型改为自定义类型。
 */
- (void)setUpTabBar {
    [self setValue:[[LBTabBar alloc] init] forKey:@"tabBar"];
}


- (void)setViewControllers:(NSArray *)viewControllers {
    if (_viewControllers && _viewControllers.count) {
        for (UIViewController *viewController in _viewControllers) {
            [viewController willMoveToParentViewController:nil];
            [viewController.view removeFromSuperview];
            [viewController removeFromParentViewController];
        }
    }
    
    if (viewControllers && [viewControllers isKindOfClass:[NSArray class]]) {
        _viewControllers = [viewControllers copy];
        if (_tabBarItemsAttributes) {
            if (_tabBarItemsAttributes.count != _viewControllers.count) {
                [NSException raise:@"LBTabBarController" format:@"设置_tabBarItemsAttributes属性时，请确保元素个数与控制器的个数相同，并在方法`-setViewControllers:`之前设置"];
            }
        }
        LBTabbarItemsCount = [viewControllers count];
        NSUInteger idx = 0;
        for (UIViewController *viewController in viewControllers) {
            [self addOneChildViewController:viewController
                                  WithTitle:_tabBarItemsAttributes[idx][LBTabBarItemTitle]
                            normalImageName:_tabBarItemsAttributes[idx][LBTabBarItemImage]
                          selectedImageName:_tabBarItemsAttributes[idx][LBTabBarItemSelectedImage]];
            [viewController main_setTabBarController:self];
            idx++;
        }
    } else {
        for (UIViewController *viewController in _viewControllers) {
            [viewController main_setTabBarController:nil];
        }
        _viewControllers = nil;
    }
}

/**
 *  添加一个子控制器
 *
 *  @param viewController    控制器
 *  @param title             标题
 *  @param normalImageName   图片
 *  @param selectedImageName 选中图片
 */
- (void)addOneChildViewController:(UIViewController *)viewController
                        WithTitle:(NSString *)title
                  normalImageName:(NSString *)normalImageName
                selectedImageName:(NSString *)selectedImageName {
    
    viewController.tabBarItem.title         = title;
    UIImage *normalImage = [UIImage imageNamed:normalImageName];
    normalImage = [normalImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    viewController.tabBarItem.image         = normalImage;
    UIImage *selectedImage = [UIImage imageNamed:selectedImageName];
    selectedImage = [selectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    viewController.tabBarItem.selectedImage = selectedImage;
    
    [self addChildViewController:viewController];
    
}

@end


#pragma mark - UIViewController+LBTabBarController
@implementation UIViewController (LBTabBarController)

- (LBTabBarController *)main_tabBarController {
    LBTabBarController *tabBarController = objc_getAssociatedObject(self, @selector(main_tabBarController));
    
    if (!tabBarController && self.parentViewController) {
        tabBarController = [self.parentViewController main_tabBarController];
    }
    
    return tabBarController;
}

@end
