//
//  CoreHamburgerNavVC.h
//  CoreHamburgerNavVC
//
//  Created by Charlin on 15-2-18.
//  Copyright (c) 2015年 Charlin. All rights reserved.
//  基于导航条的汉堡包菜单控制器

#import <UIKit/UIKit.h>
#import "HMSingleton.h"

@class CoreHamburgerManagerVC;

typedef void(^LeftVCListItemClickBlock)(CoreHamburgerManagerVC *hmc, NSInteger index);

@interface CoreHamburgerManagerVC : UIViewController
HMSingletonH(CoreHamburgerManagerVC)

@property (nonatomic,assign,readonly) BOOL leftVCShowing;                                //是否展示左侧菜单控制器

@property (nonatomic,copy) LeftVCListItemClickBlock leftVCListItemClickBlock;


/*
 *快速包装一个汉堡包菜单控制器体系
 */
+(instancetype)hamburgerManagerVCWithMainVC:(UIViewController *)mainVC bgView:(UIView *)bgView leftVC:(UIViewController *)leftVC scale:(CGFloat)scale leftMargin:(CGFloat)leftMargin;



/*
 *  展示左侧的汉堡包菜单
 */
-(void)showHamburgerMeauVC;


/*
 *  隐藏左侧的汉堡包菜单
 */
-(void)hideHamburgerMeauVC;


-(void)addPanView:(UIView *)panView;



@end
