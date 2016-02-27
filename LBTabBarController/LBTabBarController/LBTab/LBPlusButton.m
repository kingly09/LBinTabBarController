//
//  LBPlusButton.m
//  LBTabBarController
//
//  Created by kingly https://github.com/kingly09/LBinTabBarController  on 15/12/11.
//  Copyright © 2015年 kingly. All rights reserved.
//

#import "LBPlusButton.h"
#import "LBTabBarController.h"

UIButton<LBPlusButtonSubclassingDelegate> *LBExternPushlishButton = nil;

@interface LBPlusButton ()<UIActionSheetDelegate>

@end


@implementation LBPlusButton

#pragma mark - Private Methods

+ (void)registerSubclass {
    if ([self conformsToProtocol:@protocol(LBPlusButtonSubclassingDelegate)]) {
        Class<LBPlusButtonSubclassingDelegate> class = self;
        LBExternPushlishButton = [class plusButton];
    }
}

@end
