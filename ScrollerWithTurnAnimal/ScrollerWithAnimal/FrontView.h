//
//  FrontView.h
//  ScrollerWithTurnAnimal
//
//  Created by zhengyuanwen on 2021/7/7.
//
#import <UIKit/UIKit.h>



@interface FrontView : UIView
@property (nonatomic, assign, getter=isCurrentBack) BOOL currentBack;
@property (nonatomic, strong) UILabel *label;
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UILabel *nickName;
@property (nonatomic, strong) UIImageView *iconImage;
@end


