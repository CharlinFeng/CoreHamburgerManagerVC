//
//  CoreHamburgerNavVC.m
//  CoreHamburgerNavVC
//
//  Created by Charlin on 15-2-18.
//  Copyright (c) 2015年 Charlin. All rights reserved.
//
#import <UIKit/UIKit.h>

CGFloat const animationDuratioin=.4f;

CGFloat const maskViewAlpha=.95f;                                                       //maskView的透明度

CGFloat const leftViewMargin=-60.0f;                                                   //左侧View的移动位移

CGFloat const leftViewScale=.9f;                                                        //左侧View的缩放比例

#import "CoreHamburgerManagerVC.h"

@interface CoreHamburgerManagerVC ()

/*
 *  属性列表1
 */

@property (nonatomic,strong) UIViewController *leftVC;                                  //左边控制器

@property (nonatomic,strong) UIView *bgView;                                            //背景视图

@property (nonatomic,assign) BOOL hamburgerMeauEnable;                                  //是否启用汉堡菜单

@property (nonatomic,assign) CGFloat scale;                                             //缩放比例

@property (nonatomic,assign) CGFloat leftMargin;                                        //左移距离

@property (nonatomic,assign) BOOL isPullForShutDown;                                    //左滑为了关闭菜单。



/*
 *  属性列表2
 */

@property (nonatomic,strong) UIButton *maskBtn;                                         //遮罩按钮

@property (nonatomic,strong) UIView *maskView;                                          //遮罩视图

@property (nonatomic,assign) CGAffineTransform mainTransform,leftTransform;             //transform

@property (nonatomic,strong) NSMutableArray *panViews;                                  //支持手势的视图

@end

@implementation CoreHamburgerManagerVC


/*
 *快速包装一个汉堡包菜单控制器体系
 */
+(instancetype)hamburgerManagerVCWithMainVC:(UIViewController *)mainVC bgView:(UIView *)bgView leftVC:(UIViewController *)leftVC scale:(CGFloat)scale leftMargin:(CGFloat)leftMargin{
    
    CoreHamburgerManagerVC *hamburgerManagerVC=[[CoreHamburgerManagerVC alloc] init];
    
    [hamburgerManagerVC removeFromParentViewController];
    
    //记录主体控制器
    hamburgerManagerVC.mainVC=mainVC;
    //成为父子关系
    [hamburgerManagerVC addChildViewController:mainVC];
    
    //记录左侧控制器
    hamburgerManagerVC.leftVC=leftVC;
    //成为父子关系
    [hamburgerManagerVC addChildViewController:leftVC];
    
    //背影视图
    hamburgerManagerVC.bgView=bgView;
    
    //缩放比例
    hamburgerManagerVC.scale=scale;
    
    //左移间距
    hamburgerManagerVC.leftMargin=leftMargin;
    
    return hamburgerManagerVC;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    //子view处理
    [self subViewsHandle];
    
}


-(void)panForView:(UIView *)view{
    
    //新建一个滑动手势
    UIPanGestureRecognizer *pan=[[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panGR:)];
    
    //在mainView上添加手势
    [view addGestureRecognizer:pan];
}

-(void)addPanView:(UIView *)panView{
    
    [self.panViews addObject:panView];
    [self panForView:panView];
}


-(void)panGR:(UIPanGestureRecognizer *)pan{
    
    UIView *panView=pan.view;
    
    CGPoint point = [pan translationInView:panView];
    CGFloat distance=point.x * self.scale;
    //r手势状态
    UIGestureRecognizerState gState = pan.state;
    
    if(UIGestureRecognizerStateBegan == gState){//手势开始
        
    }else if (UIGestureRecognizerStateChanged==gState){//手势移动中
        
        CGFloat leftDistance=self.leftMargin - ABS(distance);
        
        CGFloat d=self.leftVCShowing?leftDistance:distance;
        
        if(self.leftVCShowing && distance>0) return;
        
        [self gestureMovingForShowWithDistance:d];

    }else{//其他状态：正常结束、手势异常中断（系统来电）
        
        if((!self.leftVCShowing && distance<_leftMargin * .42f) || (self.leftVCShowing && ABS(distance)>_leftMargin * .42f) ){
            [self hideHamburgerMeauVC];
        }else{
            [self showHamburgerMeauVCWithAnim:NO];
        }
    }
}






#pragma mark 给定一个手势移动的距离，mainView、leftView做出正确的移动：展示菜单
-(void)gestureMovingForShowWithDistance:(CGFloat)distance{
    
    //mainView处理
    [self transformView:_mainVC.view distance:distance originalMargin:self.leftMargin originalScale:self.scale];
    
    [self transformView:_leftVC.view distance:distance originalMargin:leftViewMargin originalScale:leftViewScale];

    //leftView处理
    //maskView的alpha变化
    CGFloat alpha=maskViewAlpha-distance / self.leftMargin ;
    if(alpha <= 0) alpha=0.f;
    if(alpha >=1) alpha=1.f;
    self.maskView.alpha=alpha;
}


#pragma mark 传入动态距离以及原始值，返回一个当前对应的transform给你
-(void)transformView:(UIView *)transformView distance:(CGFloat)distance originalMargin:(CGFloat)originalMargin originalScale:(CGFloat)originalScale{
    
    if(distance<0) return;
    
    if(transformView==_mainVC.view){
        if(distance>=originalMargin) distance=originalMargin;
        if(distance<=0) distance = 0;
        
    }
    
    
    CGFloat p=distance / self.leftMargin;
    
    //计算scale
    CGFloat scale=1 - (1-originalScale) * p;
    if(transformView==_leftVC.view){
        distance=originalMargin *(1-p);
        if(distance>=0) distance=0;
        scale=originalScale + (1-originalScale)*p;
    }
    if(scale<=.0f) scale=.0f;
    if(scale >=1.f) scale=1.f;
    
    distance=distance - transformView.bounds.size.width  * (1-scale)*.5f ;

    CGAffineTransform transform=CGAffineTransformMakeTranslation(distance, 0);
    
    transform=CGAffineTransformScale(transform, scale, scale);
    
    transformView.transform=transform;
}





#pragma mark 子view处理
-(void)subViewsHandle{
    
    self.panViews=[NSMutableArray array];
    
    CGRect frame=self.view.bounds;
    
    //添加背景视图
    _bgView.frame=frame;
    [self.view addSubview:_bgView];
    
    //添加左侧视图
    _leftVC.view.frame=frame;
    //添加一个遮罩
    self.maskView=[[UIView alloc] initWithFrame:frame];
    //遮罩颜色为黑色
    self.maskView.backgroundColor=[UIColor blackColor];
    [self.view addSubview:_leftVC.view];
    [self.view addSubview:self.maskView];

    //初始化一下
    self.leftVCShowing=NO;
    
    //添加主视图
    _mainVC.view.frame=self.view.bounds;
    //添加阴影
    _mainVC.view.layer.shadowPath=CGPathCreateWithRect(_mainVC.view.bounds, NULL);
    _mainVC.view.layer.shadowColor=[UIColor blackColor].CGColor;
    _mainVC.view.layer.shadowOpacity=.2f;
    _mainVC.view.layer.shadowOffset=CGSizeMake(-6.f, 0.f);
    [self.view addSubview:_mainVC.view];
    
    [self panForView:self.maskBtn];
}


/*
 *  展示左侧的汉堡包菜单
 */
-(void)showHamburgerMeauVC{
    
    [self showHamburgerMeauVCWithAnim:YES];
    
}

-(void)showHamburgerMeauVCWithAnim:(BOOL)withAnim{
    //添加遮罩按钮
    [_mainVC.view addSubview:self.maskBtn];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        self.maskBtn.userInteractionEnabled=NO;
    });
    
    //执行一个动画
    [UIView animateWithDuration:animationDuratioin animations:^{
        
        //动画曲线
        [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
        
        //赋值
        _mainVC.view.transform=self.mainTransform;
        
        //左侧菜单动画:出现
        self.leftVCShowing=YES;
    } completion:^(BOOL finished) {
        
        if(!withAnim){
            dispatch_async(dispatch_get_main_queue(), ^{
                self.maskBtn.userInteractionEnabled=YES;
            });
             return;
        }
        
        //执行一个图层帧动画
        CAKeyframeAnimation *kfa=[CAKeyframeAnimation animationWithKeyPath:@"transform.scale"];
        
        CGFloat scale=self.scale;
        
        CGFloat timeDuratiom=.5f;
        
        kfa.timingFunction=[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
        
        kfa.values=@[@(scale),@(scale-.03f),@(scale-.01f),@(scale),@(scale+.006f),@(scale)];
        
        kfa.duration=5.5f;
        
        [_mainVC.view.layer addAnimation:kfa forKey:@"fka"];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(timeDuratiom * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            self.maskBtn.userInteractionEnabled=YES;
        });
    }];
}


/*
 *  隐藏左侧的汉堡包菜单
 */
-(void)hideHamburgerMeauVC{
    
    [self maskBtnAction];
}

#pragma mark 点击了遮罩按钮
-(void)maskBtnAction{
    
    //清空transform
    [UIView animateWithDuration:animationDuratioin animations:^{
        
        //动画曲线
        [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
        
        self.mainVC.view.transform=CGAffineTransformIdentity;
        
        //左侧菜单动画：隐藏
        self.leftVCShowing=NO;
        
    } completion:^(BOOL finished) {
        
        //移除遮罩按钮
        [self.maskBtn removeFromSuperview];
    }];
}



-(UIButton *)maskBtn{
    
    if(!_maskBtn){
        
        _maskBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        
        _maskBtn.frame=_mainVC.view.bounds;
        
        //添加事件
        [_maskBtn addTarget:self action:@selector(maskBtnAction) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _maskBtn;
}



#pragma mark mainTransform
-(CGAffineTransform)mainTransform{
    
    //注此处不能使用普通的Get方法，否则在横屏下的_mainVC.view.bounds.size.width是错误的。
    
    CGFloat leftMarginFix=_leftMargin - (_mainVC.view.bounds.size.width *(1- _scale) * .5f);
    
    //平移
    _mainTransform=CGAffineTransformMakeTranslation(leftMarginFix, 0.f);
    
    //缩放
    _mainTransform=CGAffineTransformScale(_mainTransform, _scale, _scale);
    
    return _mainTransform;
}

#pragma mark leftTransform
-(CGAffineTransform)leftTransform{
    
    CGFloat leftViewHideDistance=leftViewMargin;
    
    CGFloat leftScale=leftViewScale;
    
    if(_leftTransform.a!=leftScale && _leftTransform.tx !=leftViewHideDistance){
        
        _leftTransform=CGAffineTransformMakeTranslation(leftViewHideDistance, 0);
        
        _leftTransform=CGAffineTransformScale(_leftTransform, leftScale, leftScale);
    }
 
    return _leftTransform;
}



#pragma mark -左侧菜单
-(void)setLeftVCShowing:(BOOL)leftVCShowing{
    
    _leftVCShowing=leftVCShowing;
    
    _maskView.alpha=leftVCShowing?.0f:maskViewAlpha;
    
    CGAffineTransform leftTransform=leftVCShowing?CGAffineTransformIdentity:self.leftTransform;
    
    self.leftVC.view.transform=leftTransform;
}


-(void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration{
    [self hideHamburgerMeauVC];
}



-(void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation{
    
    //解决iPhone6 Plus横屏下阴影错乱的问题
    _mainVC.view.layer.shadowPath=CGPathCreateWithRect(_mainVC.view.bounds, NULL);
}

/**
 *  找到汉堡控制器：三代查找
 *
 *  @param vc 需要找到汉堡控制器的子控制器
 *
 *  @return 汉堡控制器
 */
+(instancetype)findHamburgerManagerVCFromVC:(UIViewController *)vc{
    
    UIViewController *parentVC=vc.parentViewController;
    
    if(parentVC==nil) return nil;
    
    if([parentVC isKindOfClass:self]){
        
        CoreHamburgerManagerVC *hamVC=(CoreHamburgerManagerVC *)parentVC;
        
        return hamVC;
    }else{
        return [self findHamburgerManagerVCFromVC:parentVC];
    } 
}

@end