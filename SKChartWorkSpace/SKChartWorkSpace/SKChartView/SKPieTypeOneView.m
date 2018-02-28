//
//  SKPieTypeOneView.m
//  SKChartWorkSpace
//
//  Created by AY on 2018/2/27.
//  Copyright © 2018年 alexander. All rights reserved.
//

#import "SKPieTypeOneView.h"
#define KOffsetRadius 10 //偏移距离
#define KMargin 20 //边缘间距
#define kPieRandColor [UIColor colorWithRed:arc4random() % 255 / 255.0f green:arc4random() % 255 / 255.0f blue:arc4random() % 255 / 255.0f alpha:1.0f]

#define Hollow_Circle_Radius 0 //中间空心圆半径，默认为0实心
@interface SKPieLayer : CAShapeLayer

@property (nonatomic,assign)CGFloat startAngle;
@property (nonatomic,assign)CGFloat endAngle;
@property (nonatomic,assign)BOOL    isSelected;

@end


@implementation SKPieLayer


@end

@interface SKPieTypeOneView()
{
    
    CAShapeLayer *_maskLayer;
    CGFloat _radius;
    CGPoint _center;
    
}

@end

@implementation SKPieTypeOneView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/


- (instancetype)initWithFrame:(CGRect)frame
{

	
	if (self = [super initWithFrame:frame]) {
		
		_radius = (frame.size.width - KMargin*2)/4.f;
        _center = CGPointMake(_radius*2 + KMargin, _radius*2 + KMargin);
		
		_maskLayer = [CAShapeLayer layer];
		UIBezierPath *maskPath = [UIBezierPath bezierPathWithArcCenter:_center radius:self.bounds.size.width/4.f startAngle:-M_PI_2 endAngle:M_PI_2*3 clockwise:YES];
		_maskLayer.strokeColor = [UIColor greenColor].CGColor;
        _maskLayer.lineWidth = self.bounds.size.width/2.f;
        //设置填充颜色为透明，可以通过设置半径来设置中心透明范围
        _maskLayer.fillColor = [UIColor clearColor].CGColor;
        _maskLayer.path = maskPath.CGPath;
        _maskLayer.strokeEnd = 0;
		self.layer.mask = _maskLayer;
	}
	return self;
}


- (void)setSourceData:(NSArray *)dataArr withColors:(NSArray *)colorArr
{

		CGFloat start = - M_PI_2;
     	CGFloat end = start;
	
	
		NSArray *newDatas = [self getNewDataArrWithDataArr:dataArr];
	
	
	
	    while (newDatas.count > self.layer.sublayers.count) {
        
        	SKPieLayer *pieLayer = [SKPieLayer layer];
        	pieLayer.strokeColor = NULL;
        	[self.layer addSublayer:pieLayer];
   		 }
	
		for (int i = 0; i < self.layer.sublayers.count; i ++) {
        
        SKPieLayer *pieLayer = (SKPieLayer *)self.layer.sublayers[i];
        if (i < newDatas.count) {
            pieLayer.hidden = NO;
            end =  start + M_PI*2*[newDatas[i] floatValue];
            
            UIBezierPath *piePath = [UIBezierPath bezierPath];
            [piePath moveToPoint:_center];
            [piePath addArcWithCenter:_center radius:_radius*2 startAngle:start endAngle:end clockwise:YES];
            
            pieLayer.fillColor = [colorArr.count > i?colorArr[i]:kPieRandColor CGColor];
            pieLayer.startAngle = start;
            pieLayer.endAngle = end;
            pieLayer.path = piePath.CGPath;
            
            start = end;
        }else{
            pieLayer.hidden = YES;
        }
    }
	
}

/** 一个动画形式的展示 */

- (void)stroke{
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    animation.duration = 1.f;
    animation.fromValue = [NSNumber numberWithFloat:0.f];
    animation.toValue = [NSNumber numberWithFloat:1.f];
    //禁止还原
    animation.autoreverses = NO;
    //禁止完成即移除
    animation.removedOnCompletion = NO;
    //让动画保持在最后状态
    animation.fillMode = kCAFillModeForwards;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    [_maskLayer addAnimation:animation forKey:@"strokeEnd"];
}

/** 排序数组 */
- (NSArray *)getNewDataArrWithDataArr:(NSArray *)targetArr
{

	
	NSArray *newDataArr = [targetArr sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
		if ([obj1 floatValue] < [obj2 floatValue]) {
			return NSOrderedDescending;
		}else if ([obj1 floatValue] > [obj2 floatValue]){
			return NSOrderedAscending;
		}else{
			return NSOrderedSame;
		}
	}];
	
	NSLog(@"newDataArr--%@",newDataArr);
	NSMutableArray *resArr = [NSMutableArray array];
	NSNumber *sum = [newDataArr valueForKeyPath:@"@sum.floatValue"];
	for (NSNumber *number in newDataArr) {
		[resArr addObject:@(number.floatValue / sum.floatValue)];
	}
	
	NSLog(@"resArr--%@",resArr);
	return resArr;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    CGPoint point = [touches.anyObject locationInView:self];
    
    [self upDateLayersWithPoint:point];
    
    NSLog(@"%@",NSStringFromCGPoint(point));
}

- (void)upDateLayersWithPoint:(CGPoint)point{
    
    //如需做点击效果，则应采用第二种方法较好
    for (SKPieLayer *layer in self.layer.sublayers) {
        
        if (CGPathContainsPoint(layer.path, &CGAffineTransformIdentity, point, 0) && !layer.isSelected) {
            layer.isSelected = YES;

            //原始中心点为（0，0），扇形所在圆心、原始中心点、偏移点三者是在一条直线，通过三角函数即可得到偏移点的对应x，y。
            CGPoint currPos = layer.position;
            double middleAngle = (layer.startAngle + layer.endAngle)/2.0;
            CGPoint newPos = CGPointMake(currPos.x + KOffsetRadius*cos(middleAngle), currPos.y + KOffsetRadius*sin(middleAngle));
            layer.position = newPos;
            
        }else{

            layer.position = CGPointMake(0, 0);
            layer.isSelected = NO;
        }
    }
}


@end
