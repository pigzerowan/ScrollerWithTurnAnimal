//
//  ZYWBanner.h
//  ScrollerWithTurnAnimal
//
//  Created by zhengyuanwen on 2021/7/7.
//

#import <UIKit/UIKit.h>



@interface ZYWBanner : UIView<UIScrollViewDelegate>

@property(strong ,nonatomic) UIScrollView  *  bannerScroll; //滚动视图
@property(strong ,nonatomic) UIPageControl *  bannerPageControl; //分页指示控件
@property(strong ,nonatomic) NSArray       *  bannerArray;   //轮播图name数组
@property(strong ,nonatomic) NSTimer       *  bannerTimer;  //轮播定时器
@property(assign ,nonatomic) NSUInteger       pageCount ;   //记录总页面数
@property(assign ,nonatomic) NSUInteger       CurrentPageCount ; //记录当前的页面
@property(assign ,nonatomic) float            oldScrollOffset;   //记录之前Scroll偏移量
@property(assign ,nonatomic) float            timerInterval; //设置定时器的间隔时间

- (id)initWithFrame:(CGRect)frame :(NSArray*)array;

@end




