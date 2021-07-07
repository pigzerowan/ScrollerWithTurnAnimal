//
//  ViewController.m
//  ScrollerWithTurnAnimal
//
//  Created by zhengyuanwen on 2021/7/7.
//

#import "ViewController.h"
#import "ZYWBanner.h"
@interface ViewController ()

@end

@implementation ViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor redColor];
    [self createBannerView];
}

- (void)createBannerView {
    NSArray * array = @[@"1",@"2",@"3"];
    ZYWBanner * view = [[ZYWBanner alloc]initWithFrame:CGRectMake(0, 100,self.view.frame.size.width , 450) :array];
    [self.view addSubview:view];
}


@end
