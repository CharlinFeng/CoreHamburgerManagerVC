//
//  LeftVC.m
//  CoreHamburgerNavVC
//
//  Created by Charlin on 15-2-18.
//  Copyright (c) 2015年 Charlin. All rights reserved.
//

#import "LeftVC.h"
#import "CoreHamburgerManagerVC.h"

@interface LeftVC ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) NSArray *dataList;

@end

@implementation LeftVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.dataList=@[@"首页",@"新闻",@"关于"];
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"rid"];
    
    if(cell==nil){
        cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"rid"];
    }
    
    cell.textLabel.text=self.dataList[indexPath.row];
    
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    CoreHamburgerManagerVC *hvc=[CoreHamburgerManagerVC sharedCoreHamburgerManagerVC];
    
    if(hvc.leftVCListItemClickBlock!=nil) hvc.leftVCListItemClickBlock(hvc,indexPath.row);
    
}


@end
