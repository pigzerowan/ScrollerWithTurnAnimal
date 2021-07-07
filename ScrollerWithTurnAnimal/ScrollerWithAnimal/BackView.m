//
//  BackView.m
//  ScrollerWithTurnAnimal
//
//  Created by zhengyuanwen on 2021/7/7.
//

#import "BackView.h"


#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height
@interface BackView()

@end
@implementation BackView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.imageView];
    
        [self addSubview:self.backlabel];
    }
    return self;
}

- (UIImageView *)imageView {
    if (!_imageView) {
        _imageView = [[UIImageView alloc]initWithFrame:self.bounds];
        _imageView.image = [UIImage imageNamed:@"back"];
    }
    return _imageView;
}


- (UILabel *)backlabel {
    if (!_backlabel) {
        _backlabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 200, 20)];
        _backlabel.center = CGPointMake(self.center.x, self.center.y+80);
    }
    return _backlabel;
}
@end
