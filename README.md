# LBTabBarController
1)低耦合集成TabBarController 
2)只需要 两个数组即可完成主流App框架搭建


### 第一步：把configs目录拷贝到您的工程下


###  第二步：设置LBTabBarController的两个数组：控制器数组和TabBar属性数组

```Objective-C
- (void)setupViewControllers {
FirstViewController *firstViewController = [[FirstViewController alloc] init];
UIViewController *firstNavigationController = [[UINavigationController alloc]
initWithRootViewController:firstViewController];

SecondViewController *secondViewController = [[SecondViewController alloc] init];
UIViewController *secondNavigationController = [[UINavigationController alloc]
initWithRootViewController:secondViewController];


LBTabBarController *tabBarController = [[LBTabBarController alloc] init];
[self customizeTabBarForController:tabBarController];

[tabBarController setViewControllers:@[
firstNavigationController,
secondNavigationController,
]];
self.tabBarController = tabBarController;
}

/*
*
在`-setViewControllers:`之前设置TabBar的属性，
*
*/
- (void)customizeTabBarForController:(LBTabBarController *)tabBarController {

NSDictionary *dict1 = @{
LBTabBarItemTitle : @"首页",
LBTabBarItemImage : @"home_normal",
LBTabBarItemSelectedImage : @"home_highlight",
};
NSDictionary *dict2 = @{
LBTabBarItemTitle : @"城市",
LBTabBarItemImage : @"mycity_normal",
LBTabBarItemSelectedImage : @"mycity_highlight",
};

NSArray *tabBarItemsAttributes = @[ dict1, dict2 ];
tabBarController.tabBarItemsAttributes = tabBarItemsAttributes;
}
```


### 第三步：将LBTabBarController设置为window的RootViewController

```Objective-C
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
/* *省略部分：   * */
[self.window setRootViewController:self.tabBarController];
/* *省略部分：   * */
return YES;
}
```

### 第四步（可选）：创建自定义的形状不规则加号按钮


创建一个继承于 CYLPlusButton 的类，要求和步骤：


1. 实现  `LBPlusButtonSubclassingDelegate`  协议 

2. 子类将自身类型进行注册，一般可在 `application` 的 `applicationDelegate` 方法里面调用 `[YourClass registerSubClass]` 或者在子类的 `+load` 方法中调用：

```Objective-C
+(void)load {
[super registerSubclass];
}
```

协议提供了两个可选方法：

```Objective-C
+ (NSUInteger)indexOfPlusButtonInTabBar;
+ (CGFloat)multiplerInCenterY;
```

作用分别是：

```Objective-C
+ (NSUInteger)indexOfPlusButtonInTabBar;
```
用来自定义加号按钮的位置，如果不实现默认居中，但是如果 `tabbar` 的个数是奇数则必须实现该方法，否则 `LBTabBarController` 会抛出 `exception` 来进行提示。


```Objective-C
+ (CGFloat)multiplerInCenterY;
```

该方法是为了调整自定义按钮中心点Y轴方向的位置，建议在按钮超出了 `tabbar` 的边界时实现该方法。返回值是自定义按钮中心点Y轴方向的坐标除以 `tabbar` 的高度，如果不实现，会自动进行比对，预设一个较为合适的位置，如果实现了该方法，预设的逻辑将失效。

