//
//  ZYWBanner.m
//  ScrollerWithTurnAnimal
//
//  Created by zhengyuanwen on 2021/7/7.
//

#import "ZYWBanner.h"
#import "FrontView.h"
#import "BackView.h"
#define SC_WIDTH  self.frame.size.width
#define SC_HEIGHT self.frame.size.height
#define HexUIColorFromRGB(rgbValue, a) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:(a)]


@interface ZYWBanner ()<CAAnimationDelegate>


@property (nonatomic, strong) UITapGestureRecognizer *startTap;
//@property (nonatomic, strong) FrontView *frontView;
//@property (nonatomic, strong) BackView *backView;
@property (nonatomic, assign, getter=isCurrentBack) BOOL currentBack; ///< 当前是否是背面，默认NO
@end
@implementation ZYWBanner

- (id)initWithFrame:(CGRect)frame :(NSArray*)array;
{
    self = [super initWithFrame:frame];
    if (self) {
        self.timerInterval= 2;
        self.bannerArray = array ;
        self.pageCount = array.count;
        [self creatScrollView];
    }
    return self;
}

// 旋转方法
- (void)startRevolveImageView:(FrontView *)frontView andBack:(NSInteger )tapid{
    if (frontView.currentBack) {
        frontView.currentBack = NO;
    } else {
        frontView.currentBack = YES;
    }
    CAKeyframeAnimation *keyAnimation = [CAKeyframeAnimation animation];
    // 旋转角度，其中的value表示图像旋转的最终位置
    keyAnimation.values = [NSArray arrayWithObjects:
                           [NSValue valueWithCATransform3D:CATransform3DMakeRotation(0, 0,1,0)],
                           [NSValue valueWithCATransform3D:CATransform3DMakeRotation((M_PI/2), 0,1,0)],
                           [NSValue valueWithCATransform3D:CATransform3DMakeRotation(0, 0,1,0)],
                           nil];
    keyAnimation.cumulative = NO;
    keyAnimation.duration = 1.0f;
    keyAnimation.repeatCount = 1;
    keyAnimation.removedOnCompletion = NO;
    keyAnimation.delegate = self;
    [frontView.layer addAnimation:keyAnimation forKey:@"transform"];
    if (frontView.currentBack) {
//        [self performSelector:@selector(addBehindView) withObject:nil afterDelay:0.5f];
        BackView *backView = [[BackView alloc]initWithFrame:CGRectMake(0, 0, SC_WIDTH-50, SC_HEIGHT)];
        backView.backlabel .text= [NSString stringWithFormat:@"我是背面%ld",(long)tapid];
        backView.tag = tapid+1000;
        backView.layer.cornerRadius = 25;
        [frontView addSubview:backView];
    } else {
        
        for (UIView *view in frontView.subviews) {
            if (view.tag ==  tapid+1000) {
                view.hidden = YES;
            }
        }
        
//        [self performSelector:@selector(addForentView) withObject:nil afterDelay:0.5f];
    }
}
//// 恢复展示前面view
- (void)addForentView {
//    self.backView.hidden = YES;
}
//// 添加旋转后背面view
- (void)addBehindView {
//    self.backView.hidden = NO;
//    [self.frontView addSubview:self.backView];
}
// 点击图片
- (void)clickImage:(id )sender {
    UITapGestureRecognizer *singleTap = (UITapGestureRecognizer *)sender;

    NSLog(@"======%ldfrontviewtag====",(long)[singleTap view].tag);
    
    
    for (FrontView *view in self.bannerScroll.subviews) {
        if (view.tag ==  [singleTap view].tag) {
            [self startRevolveImageView:view andBack:[singleTap view].tag];
        }
    }
    
//    FrontView *frontView =  self.bannerScroll.subviews[[singleTap view].tag];

}
//- (FrontView *)frontView {
//    if (!_frontView) {
//        _frontView = [[FrontView alloc]initWithFrame:CGRectMake(20, 30, kScreenWidth-40, 450)];
//        _frontView.layer.cornerRadius = 25;
//        _frontView.clipsToBounds = YES;
////        _frontView.center = self.view.center;
//        UITapGestureRecognizer *startTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickImage)];
//        [_frontView addGestureRecognizer:startTap];
//    }
//    return _frontView;
//}
//- (BackView *)backView {
//    if (!_backView) {
//        _backView = [[BackView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth-40, 450)];
//        _backView.layer.cornerRadius = 25;
//    }
//    return _backView;
//}

-(void)creatScrollView{
    self.bannerScroll = [[UIScrollView alloc]init];
    self.bannerScroll.frame = CGRectMake(0, 0,SC_WIDTH,SC_HEIGHT);
    [self addSubview:self.bannerScroll];
    
    self.bannerScroll.contentSize = CGSizeMake((self.bannerArray.count)*SC_WIDTH, 0);
    self.bannerScroll.pagingEnabled = YES;
    self.bannerScroll.showsHorizontalScrollIndicator = NO ;
    self.bannerScroll.delegate = self ;
    
    for (int i = 0; i < self.bannerArray.count; i++) {
        FrontView *frontView = [[FrontView alloc] initWithFrame:CGRectMake(25+i*SC_WIDTH, 0, SC_WIDTH-50, SC_HEIGHT)];
        frontView.layer.cornerRadius = 25;
        frontView.label.text = [NSString stringWithFormat:@"小狼的ai智能设备%d",i];
        frontView.clipsToBounds = YES;
        frontView.tag = i + 500 ;
        UITapGestureRecognizer *startTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickImage:)];
        [frontView addGestureRecognizer:startTap];
        
        if (i == self.bannerArray.count) {
            
//            imageView.image = [UIImage imageNamed:self.bannerArray[0]];
            
        }else{
//            imageView.image = [UIImage imageNamed:self.bannerArray[i]];
        }
        [self.bannerScroll addSubview:frontView];
    }
    self.bannerPageControl = [[UIPageControl alloc] init];
    self.bannerPageControl.frame = CGRectMake(0, SC_HEIGHT-25, SC_WIDTH, 25);
    self.bannerPageControl.numberOfPages = self.pageCount;
    self.bannerPageControl.currentPage = 0;
    self.bannerPageControl.pageIndicatorTintColor = [UIColor redColor];
    self.bannerPageControl.currentPageIndicatorTintColor = [UIColor blueColor];
    [self addSubview:self.bannerPageControl];
    
    //创建定时器
//    [self creatTimer];

}

- (void)creatTimer {
    self.bannerTimer = [NSTimer scheduledTimerWithTimeInterval:self.timerInterval
                                              target:self
                                            selector:@selector(changeScrollOffset)
                                            userInfo:nil
                                             repeats:YES];
    // 调整timer 的优先级
    NSRunLoop *mainLoop = [NSRunLoop mainRunLoop];
    
    [mainLoop addTimer:self.bannerTimer forMode:NSRunLoopCommonModes];
}

- (void)changeScrollOffset {
    [self.bannerScroll setContentOffset:CGPointMake((self.bannerPageControl.currentPage+1) * SC_WIDTH, 0) animated:YES];
}

- (void)stopTimer
{
    [self.bannerTimer invalidate];
    self.bannerTimer = nil;
}

#pragma  mark **************UIScrollViewDelegate*******************
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGPoint point = scrollView.contentOffset;
    BOOL isRight = self.oldScrollOffset < point.x;
    self.oldScrollOffset = point.x;
    // 调整pageControl的当前 位置
    if (point.x > SC_WIDTH*(self.pageCount-1)+SC_WIDTH*0.5 && !self.bannerTimer) {
        self.bannerPageControl.currentPage = 0;
    }else
        if (point.x > SC_WIDTH*(self.pageCount-1) && self.bannerTimer && isRight){
        self.bannerPageControl.currentPage = 0;
    }else{
        self.bannerPageControl.currentPage = (point.x+SC_WIDTH*0.5)/ SC_WIDTH;
    }
    
    //处理两种情况，1、当偏移量超出scrollView contentSize最大值时 2、当偏移量小于零时
//    if (point.x >= SC_WIDTH*self.pageCount) {
//
//        [scrollView setContentOffset:CGPointMake(0, 0) animated:NO];
//
//    }else if (point.x < 0) {
//
//        [scrollView setContentOffset:CGPointMake(point.x+SC_WIDTH*(self.pageCount), 0) animated:NO];
//    }
}
/**
 手指开始拖动的时候, 就让计时器停止
 */
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    
    [self stopTimer];
    
    self.bannerTimer = nil ;
}
/**
 手指离开屏幕的时候, 就让计时器开始工作
 */
- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset {
    
//    [self creatTimer];
}
@end
