//
//  FrontView.m
//  ScrollerWithTurnAnimal
//
//  Created by zhengyuanwen on 2021/7/7.
//

#import "FrontView.h"

@interface FrontView()

@end
@implementation FrontView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        
        [self configViews];
       
    }
    return self;
}


-(void)configViews{
    
    [self addSubview:self.imageView];
    [self.imageView addSubview:self.label];
    
    self.imageView.backgroundColor = [UIColor yellowColor];

    
}


- (UILabel *)label {
    if (!_label) {
        _label = [[UILabel alloc]initWithFrame:CGRectMake(10, 20, self.frame.size.width, 30)];
//        _label.center = CGPointMake(self.center.x, self.center.y-80);
        _label.textAlignment = NSTextAlignmentCenter;
        _label.text = @"小狼的ai智能设备";
        _label.textColor = [UIColor blackColor];
        _label.font = [UIFont systemFontOfSize:30];
    }
    return _label;
}
- (UIImageView *)imageView {
    if (!_imageView) {
        _imageView = [[UIImageView alloc]initWithFrame:self.bounds];
        _imageView.image = [UIImage imageNamed:@"front"];
    }
    return _imageView;
}
@end
