//
//  SKLineTypeOneChart.m
//  SKChartWorkSpace
//
//  Created by AY on 2018/1/25.
//  Copyright © 2018年 alexander. All rights reserved.
//

#import "SKLineTypeOneChart.h"
#define kTitleCount 4

@interface SKLineTypeOneChart()
/** Y 轴的标题 */
@property (nonatomic, strong) NSArray *yTittles;

@end

@implementation SKLineTypeOneChart

// 赋值的时候 进行数据处理
- (void)setValues:(NSArray *)values
{
	_values = values;
	
	NSInteger maxNum = [values[0] integerValue];
    for (NSNumber *number in values) {
        if (maxNum < number.integerValue) {
            maxNum = number.integerValue;
        }
    }
	
    NSInteger marginYTittleNum = 0;
    for (int i = 1; maxNum/kTitleCount/i >= 1 ; i *=10) {
        if (maxNum % (i *kTitleCount) == 0) {
            marginYTittleNum = (maxNum / kTitleCount/i)*i;
        }else {
            marginYTittleNum = (maxNum / kTitleCount/i)*i + i;
        }
    }

    NSMutableArray *yTittles = [NSMutableArray array];
    for (NSInteger i = kTitleCount; i > 0; i--) {
        NSString *yTittle = [NSString stringWithFormat:@"%tu",marginYTittleNum * i];
        [yTittles addObject:yTittle];
    }
	
    self.yTittles = yTittles;
}



- (void)drawRect:(CGRect)rect {
		CGFloat width = self.bounds.size.width;
    CGFloat height = self.bounds.size.height;
	
	CGFloat xAxisX = 0.05*width;
    CGFloat xAxisY = 0.8*height;
    CGFloat xAxisWidth = 0.9*width;
	
	[[[UIColor blackColor]colorWithAlphaComponent:0.8] set];
	
	//  x 轴
	UIBezierPath *xAxis = [UIBezierPath bezierPath];
    [xAxis moveToPoint:CGPointMake(xAxisX , xAxisY)];
    [xAxis addLineToPoint:CGPointMake(xAxisX + xAxisWidth, xAxisY)];
    xAxis.lineWidth = 1;
    [xAxis stroke];
	
	// y1 轴
	CGFloat yAxisX = xAxisX;
    CGFloat yAxisY = 0.05*height;
    CGFloat yAxisY2 = xAxisY;
    UIBezierPath *yAxis = [UIBezierPath bezierPath];
    [yAxis moveToPoint:CGPointMake(yAxisX, yAxisY)];
    [yAxis addLineToPoint:CGPointMake(yAxisX, yAxisY2)];
    yAxis.lineWidth = 1;
    [yAxis stroke];
	
	// y 轴 箭头
	CGFloat y_arrow1_x1 = xAxisX - 4;
	CGFloat y_arrow1_x2 = xAxisX + 4;
	CGFloat y_arrow1_y = yAxisY + 8;
	
	UIBezierPath *arrow1_path = [UIBezierPath bezierPath];
	[arrow1_path moveToPoint:CGPointMake(xAxisX, yAxisY)];
	[arrow1_path addLineToPoint:CGPointMake(y_arrow1_x1, y_arrow1_y)];
	arrow1_path.lineWidth = 1;
	[arrow1_path stroke];
	
	UIBezierPath *arrow2_path = [UIBezierPath bezierPath];
	[arrow2_path moveToPoint:CGPointMake(xAxisX, yAxisY)];
	[arrow2_path addLineToPoint:CGPointMake(y_arrow1_x2, y_arrow1_y)];
	arrow2_path.lineWidth = 1;
	[arrow2_path stroke];
	
	
	// x 轴箭头
	CGFloat x_arrow_y1 = xAxisY - 4;
	CGFloat x_arrow_y2 = xAxisY + 4;
	CGFloat x_arrow_x = xAxisX + xAxisWidth;
	
	UIBezierPath *x_arrow1_path = [UIBezierPath bezierPath];
	[x_arrow1_path moveToPoint:CGPointMake(x_arrow_x, yAxisY2)];
	[x_arrow1_path addLineToPoint:CGPointMake(x_arrow_x - 8, x_arrow_y1)];
	x_arrow1_path.lineWidth = 1;
	[x_arrow1_path stroke];
	
	UIBezierPath *x_arrow2_path = [UIBezierPath bezierPath];
	[x_arrow2_path moveToPoint:CGPointMake(x_arrow_x, yAxisY2)];
	[x_arrow2_path addLineToPoint:CGPointMake(x_arrow_x - 8, x_arrow_y2)];
	x_arrow2_path.lineWidth = 1;
	[x_arrow2_path stroke];
	
	
	// y 轴标题的间隔
	CGFloat yTittleMargin = (xAxisY - yAxisY)/(self.yTittles.count + 1);
	
	for (int i = 0 ; i < self.yTittles.count; i ++) {
        [[[UIColor grayColor]colorWithAlphaComponent:0.6] setStroke];//设置背景网格颜色
        CGFloat x = yAxisX;
        CGFloat y = yTittleMargin * (i + 1) + yAxisY;
        UIBezierPath *path = [UIBezierPath bezierPath];
        [path moveToPoint:CGPointMake(x, y)];
        [path addLineToPoint:CGPointMake(xAxisX + xAxisWidth, y)];
        path.lineWidth = 1;
        [path stroke];
		
		NSString *str = self.yTittles[i];
        CGSize strSize = [str sizeWithAttributes:@{NSFontAttributeName : [UIFont systemFontOfSize:10]}];
        [str drawInRect:CGRectMake(yAxisX - strSize.width - 3, y - strSize.height/2, strSize.width, strSize.height)
         withAttributes:@{NSForegroundColorAttributeName :[UIColor blackColor],
                          NSFontAttributeName            : [UIFont systemFontOfSize:10]}];
		
	}
	
	
	// 画点
	UIBezierPath *linePath = [UIBezierPath bezierPath];
	for (int i = 0; i < self.values.count; i ++) {
		//画圆
		NSNumber *number = self.values[i];
		//计算其y值
		CGFloat item_width = (xAxisX + xAxisWidth) / self.values.count;
		CGFloat x = xAxisX + item_width / 2 + i * item_width - 2.5 * i;
		CGFloat y = xAxisY - (number.floatValue / [self.yTittles[0] integerValue] * yTittleMargin * kTitleCount);
		[[UIColor colorWithRed:255/255.0f green:134/255.0f blue:8/255.0f alpha:1] set];
		
		// 画一个点
		UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(x, y, 5, 5)];
		[path fill];
		
		// 连线
	
		if (i == 0) {
			[linePath moveToPoint:CGPointMake(x + 2.5, y + 2.5)];
		}else{
			[linePath addLineToPoint:CGPointMake(x + 2.5, y + 2.5)];
		}
		
		
		[linePath stroke];
		
	}
	
	
	
	
	
	
	
	
	
	
	
}


@end
