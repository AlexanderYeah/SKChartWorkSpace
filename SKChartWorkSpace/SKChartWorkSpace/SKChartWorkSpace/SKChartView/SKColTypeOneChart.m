//
//  SKColTypeOneChart.m
//  TaxCube
//
//  Created by AY on 2018/1/22.
//  Copyright © 2018年 AY. All rights reserved.
//

#import "SKColTypeOneChart.h"

@interface SKColTypeOneChart()

@property (nonatomic, strong) NSArray *xTittles;

@property (nonatomic ,assign) NSInteger yMaxTittleNum;

@end

@implementation SKColTypeOneChart


//  具体设置 x 轴标题方法
-(void)setValues:(NSArray *)values
{
	// 此处要根据传递进来的每一个item的value 值，计算出要显示X轴对应的刻度值
	NSLog(@"%@",values);
	_values = values;
	if (values == nil) {
        values = @[@0];
    }
	
	
	NSInteger maxNum = [values.firstObject integerValue];
	// 获取最大的值
	for (NSNumber *number in values) {
        if (maxNum < number.integerValue) {
            maxNum = number.integerValue;
        }
    }
	
	// X 轴标题的数量 为 6
	NSInteger marginXTittleNum = 0;
	for (int i = 1; maxNum/6/i >= 1 ; i *=10){
		if (maxNum % (i *6) == 0) {
            marginXTittleNum = (maxNum / 6/i)*i;
        }else {
            marginXTittleNum = (maxNum / 6/i)*i + i;
        }
	
	}
	
	NSMutableArray *xTittles = [NSMutableArray array];
    for (NSInteger i = 6; i > 0; i--) {
        if (marginXTittleNum < 1000) {
            NSString *yTittle = [NSString stringWithFormat:@"%tu",marginXTittleNum * i];
            [xTittles addObject:yTittle];
        }else {
            NSString *yTittle = [NSString stringWithFormat:@"%tuk",marginXTittleNum * i / 1000];
            [xTittles addObject:yTittle];
        }
    }
	
	NSLog(@"%@",xTittles);
	// 计算出的刻度值 复制给对应的
	self.xTittles = (NSMutableArray *)[[xTittles reverseObjectEnumerator] allObjects];
	
	self.yMaxTittleNum = marginXTittleNum * 6;
	
}


- (void)drawRect:(CGRect)rect {
    // 画表格
	CGFloat width = self.bounds.size.width;
    CGFloat height = self.bounds.size.height;
	
	// 画X轴线
	CGFloat xAxisX = 0.2*width;
    CGFloat xAxisY = 0.92*height;
	CGFloat xAxisWidth = 0.7*width;
	UIBezierPath *xAxis = [UIBezierPath bezierPath];
	[xAxis moveToPoint:CGPointMake(xAxisX , xAxisY)];
	[xAxis addLineToPoint:CGPointMake(xAxisX + xAxisWidth, xAxisY)];
	xAxis.lineWidth = 0.7;
	[[UIColor grayColor] set];
	[xAxis stroke];
	
	// 画Y轴线
	CGFloat yAxisX = 0.2*width;
    CGFloat yAxisY = 0.1*height;
    CGFloat yAxisY2 = xAxisY;
    UIBezierPath *yAxis = [UIBezierPath bezierPath];
    [yAxis moveToPoint:CGPointMake(yAxisX, yAxisY)];
    [yAxis addLineToPoint:CGPointMake(yAxisX, yAxisY2)];
    yAxis.lineWidth = 0.7;
	[[UIColor grayColor] set];
    [yAxis stroke];
	
	// x 竖线 根据X轴的标题数量
	
	CGFloat xTittleMargin = xAxisWidth/(6 + 0);
	
	for (int i = 0 ; i < self.xTittles.count; i++) {
		// 线的颜色
		[[UIColor grayColor] set];
		CGFloat x = yAxisX + xTittleMargin * (i + 1);
		CGFloat y = yAxisY;
		UIBezierPath *path = [UIBezierPath bezierPath];
		[path moveToPoint:CGPointMake(x, y)];
		[path addLineToPoint:CGPointMake(x, yAxisY2)];
		path.lineWidth = 0.7;
		[path stroke];
		
		// x 轴的标题
		NSString *str = self.xTittles[i];
		CGSize strSize = [str sizeWithAttributes:@{NSFontAttributeName : [UIFont systemFontOfSize:10]}];
        [str drawInRect:CGRectMake(x - strSize.width/2 , yAxisY2 + strSize.height/2, strSize.width, strSize.height)
         withAttributes:@{NSForegroundColorAttributeName :[UIColor blackColor],
			NSFontAttributeName: [UIFont systemFontOfSize:10]}];
	
	}
	
	// Y 轴的标题
	CGFloat yTittleMargin = (yAxisY2 - yAxisY)/self.values.count;
	CGFloat margin = 0.5 * xTittleMargin;
	
	for (int i = 0 ; i < self.yTitleArr.count; i++) {
		
		CGSize strSize = [self.yTitleArr[i] sizeWithAttributes:@{NSFontAttributeName : [UIFont systemFontOfSize:10]}];
		
		CGFloat  y = yAxisY2 -  ( i + 1) * yTittleMargin;
		
		[self.yTitleArr[i] drawInRect:CGRectMake(yAxisX - strSize.width - 5 , y +  strSize.height/2, strSize.width, strSize.height)
         withAttributes:@{NSForegroundColorAttributeName :[UIColor blackColor],
			NSFontAttributeName: [UIFont systemFontOfSize:10]}];
		
		
		NSNumber *number = self.values[i];
		// 计算出X的值
		CGFloat x = xAxisX + (number.floatValue / self.yMaxTittleNum * xTittleMargin * 6);
		
		// NSLog(@"%f",x);
		
		//绘制line
		UIBezierPath *linePath = [UIBezierPath bezierPath];
		[linePath moveToPoint:CGPointMake(yAxisX + 0.5, y+  strSize.height)];
		[linePath addLineToPoint:CGPointMake(x , y + strSize.height)];
		linePath.lineWidth = 0.4 * xTittleMargin;
		[[UIColor cyanColor] set];//线的颜色
		[linePath stroke];
		
		// 书写对应的Value 值
		
		// NSLog(@"%@",[self.values[i] description]);
		
		NSString *value = [self.values[i] description];
		
		CGSize valueStrSize = [value sizeWithAttributes:@{NSFontAttributeName : [UIFont systemFontOfSize:10.0f]}];
		
		[value drawInRect:CGRectMake(x + valueStrSize.width , y +  strSize.height/2 , valueStrSize.width, valueStrSize.height)
         withAttributes:@{NSForegroundColorAttributeName :[UIColor blackColor],
			NSFontAttributeName: [UIFont systemFontOfSize:10]}];
		
		
		
	}
	
	
	
	
	
	
	
	

	
	
	
	
	
}




@end
