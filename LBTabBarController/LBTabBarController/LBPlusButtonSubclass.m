//
//  LBPlusButtonSubclass.m
//  LBTabBarController
//
//  Created by kingly https://github.com/kingly09/LBinTabBarController  on 15/12/11.
//  Copyright © 2015年 kingly. All rights reserved.
//

#import "LBPlusButtonSubclass.h"
#import "LBAddViewController.h"
#import "TestViewController.h"

@interface LBPlusButtonSubclass () {
    CGFloat _buttonImageHeight;
}
@end

@implementation LBPlusButtonSubclass

#pragma mark -
#pragma mark - Life Cycle

+(void)load {
    [super registerSubclass];
}

-(instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.adjustsImageWhenHighlighted = NO;
    }
    
    return self;
}

//上下结构的 button
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    // 控件大小,间距大小
    CGFloat const imageViewEdge   = self.bounds.size.width * 0.6;
    CGFloat const centerOfView    = self.bounds.size.width * 0.5;
    CGFloat const labelLineHeight = self.titleLabel.font.lineHeight;
    CGFloat const verticalMarginT = self.bounds.size.height - labelLineHeight - imageViewEdge;
    CGFloat const verticalMargin  = verticalMarginT / 2;
    
    // imageView 和 titleLabel 中心的 Y 值
    CGFloat const centerOfImageView  = verticalMargin + imageViewEdge * 0.5;
    CGFloat const centerOfTitleLabel = imageViewEdge  + verticalMargin * 2 + labelLineHeight * 0.5 + 5;
    
    //imageView position 位置
    self.imageView.bounds = CGRectMake(0, 0, imageViewEdge, imageViewEdge);
    self.imageView.center = CGPointMake(centerOfView, centerOfImageView);
    
    //title position 位置
    self.titleLabel.bounds = CGRectMake(0, 0, self.bounds.size.width, labelLineHeight);
    self.titleLabel.center = CGPointMake(centerOfView, centerOfTitleLabel);
}

#pragma mark -
#pragma mark - Public Methods
/*
 *
 Create a custom UIButton with title and add it to the center of our tab bar
 *
 */
//+ (instancetype)plusButton{
//    
//    LBPlusButtonSubclass *button = [[LBPlusButtonSubclass alloc] init];
//    
//    [button setImage:[UIImage imageNamed:@"post_normal"] forState:UIControlStateNormal];
//    [button setTitle:@"发布" forState:UIControlStateNormal];
//    
//    [button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
//    button.titleLabel.font = [UIFont systemFontOfSize:9.5];
//    [button sizeToFit];
//    
//    [button addTarget:button action:@selector(clickPublish) forControlEvents:UIControlEventTouchUpInside];
//    
//    return button;
//}

/*
 *
 Create a custom UIButton without title and add it to the center of our tab bar
 *
 */
+ (instancetype)plusButton
{

    UIImage *buttonImage = [UIImage imageNamed:@"hood.png"];
    UIImage *highlightImage = [UIImage imageNamed:@"hood-selected.png"];

    LBPlusButtonSubclass* button = [LBPlusButtonSubclass buttonWithType:UIButtonTypeCustom];

    button.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleTopMargin;
    button.frame = CGRectMake(0.0, 0.0, buttonImage.size.width, buttonImage.size.height);
    [button setBackgroundImage:buttonImage forState:UIControlStateNormal];
    [button setBackgroundImage:highlightImage forState:UIControlStateHighlighted];
    [button addTarget:button action:@selector(clickPublish) forControlEvents:UIControlEventTouchUpInside];

    return button;
}

#pragma mark -
#pragma mark - Event Response

- (void)clickPublish {
    UITabBarController *tabBarController = (UITabBarController *)self.window.rootViewController;
    UIViewController *viewController = tabBarController.selectedViewController;
    
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:nil
                                                             delegate:nil
                                                    cancelButtonTitle:@"取消"
                                               destructiveButtonTitle:nil
                                                    otherButtonTitles:@"拍照", @"从相册选取", @"淘宝一键转卖", nil];
    [actionSheet showInView:viewController.view];

    
//    
//    LBAddViewController *addView = [[LBAddViewController alloc]init];
//     UITabBarController *tabBarController = (UITabBarController *)self.window.rootViewController;
//    
//    UIViewController *viewController = tabBarController.selectedViewController;
//
//    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:addView];
//    
//    
//    [viewController presentViewController:navigationController animated:YES completion:^{}];
    
    
//
    
//    TestViewController *addView = [[TestViewController alloc]init];
//    UITabBarController *tabBarController = (UITabBarController *)self.window.rootViewController;
//    
//    UIViewController *viewController = tabBarController.selectedViewController;
    //
    //    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:addView];
    
//    [viewController presentViewController:addView animated:YES completion:^{}];

}

#pragma mark - UIActionSheetDelegate

- (void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex {
    NSLog(@"buttonIndex = %@", @(buttonIndex));
}

#pragma mark - CYLPlusButtonSubclassing

//+ (NSUInteger)indexOfPlusButtonInTabBar {
//    return 3;
//}

+ (CGFloat)multiplerInCenterY {
    return  0.3;
}




@end
