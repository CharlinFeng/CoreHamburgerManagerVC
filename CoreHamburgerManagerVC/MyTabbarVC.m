//
//  MyTabbarVC.m
//  CoreHamburgerNavVC
//
//  Created by Charlin on 15-2-19.
//  Copyright (c) 2015年 Charlin. All rights reserved.
//

#import "MyTabbarVC.h"
#import "CoreHamburgerManagerVC.h"

@interface MyTabbarVC ()

@end

@implementation MyTabbarVC

- (void)viewDidLoad {
    [super viewDidLoad];

    CoreHamburgerManagerVC *hvc=[CoreHamburgerManagerVC sharedCoreHamburgerManagerVC];
    
    hvc.leftVCListItemClickBlock=^(CoreHamburgerManagerVC *hmc ,NSInteger index){
        
        self.selectedIndex=index;
        [hmc hideHamburgerMeauVC];
    };
    
    self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc] initWithTitle:@"菜单" style:UIBarButtonItemStylePlain target:self action:@selector(showMeau)];

}


-(void)showMeau{
    
    CoreHamburgerManagerVC *hvc=[CoreHamburgerManagerVC sharedCoreHamburgerManagerVC];
    
    [hvc showHamburgerMeauVC];
}
@end
