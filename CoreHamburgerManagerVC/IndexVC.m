//
//  IndexVC.m
//  CoreHamburgerNavVC
//
//  Created by Charlin on 15-2-18.
//  Copyright (c) 2015年 Charlin. All rights reserved.
//

#import "IndexVC.h"
#import "CoreHamburgerManagerVC.h"

@interface IndexVC ()

@end

@implementation IndexVC

- (void)viewDidLoad {
    [super viewDidLoad];
    

    
    //禁用
    self.tabBarItem.title=@"首页";
    
    CoreHamburgerManagerVC *hvc=[CoreHamburgerManagerVC findHamburgerManagerVCFromVC:self];
    
    [hvc addPanView:self.view];

    
}





@end
