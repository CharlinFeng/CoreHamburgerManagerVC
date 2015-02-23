//
//  NewsVC.m
//  CoreHamburgerNavVC
//
//  Created by Charlin on 15-2-19.
//  Copyright (c) 2015年 Charlin. All rights reserved.
//

#import "NewsVC.h"
#import "CoreHamburgerManagerVC.h"

@interface NewsVC ()

@end

@implementation NewsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.tabBarItem.title=@"新闻";
    CoreHamburgerManagerVC *hvc=[CoreHamburgerManagerVC sharedCoreHamburgerManagerVC];
    
    [hvc addPanView:self.view];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
