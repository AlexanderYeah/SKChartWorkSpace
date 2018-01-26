//
//  SKColTypeTwoChart.m
//  SKChartWorkSpace
//
//  Created by AY on 2018/1/24.
//  Copyright © 2018年 alexander. All rights reserved.
//

#import "SKColTypeTwoChart.h"

#define kTitleCount 5

@interface SKColTypeTwoChart()

@property (nonatomic ,assign) NSInteger yMaxTittleNum;



@end


@implementation SKColTypeTwoChart


// 赋值之后 就要计算出数组中最大值
-(void)setFirstValArr:(NSArray *)firstValArr
{

	if (firstValArr == nil) {
        firstValArr = @[@0];
    }
	_firstValArr = firstValArr;
	NSInteger maxNum = [firstValArr.firstObject integerValue];
	for (NSNumber *number in firstValArr) {
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
	
	for (NSInteger i = 5; i > 0; i--) {
        if (marginYTittleNum < 1000) {
            NSString *yTittle = [NSString stringWithFormat:@"%tu",marginYTittleNum * i];
            [yTittles addObject:yTittle];
        }else {
            NSString *yTittle = [NSString stringWithFormat:@"%tuk",marginYTittleNum * i / 1000];
            [yTittles addObject:yTittle];
        }
    }
	
	self.yMaxTittleNum = marginYTittleNum * kTitleCount;
	
	NSLog(@"%ld",(long)self.yMaxTittleNum);
	
}

-(void)setSecondValArr:(NSArray *)secondValArr
{
	_secondValArr = secondValArr;
	

}



- (void)drawRect:(CGRect)rect {
    // Drawing code
	
	CGFloat width = self.bounds.size.width;
    CGFloat height = self.bounds.size.height;
	
	CGFloat xAxisX = 0.05*width;
    CGFloat xAxisY = 0.8*height;
    CGFloat xAxisWidth = 0.9*width;
	
	[[[UIColor grayColor]colorWithAlphaComponent:0.8] set];
	
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
	
	// y2 轴
	CGFloat y2AxisX = xAxisX + xAxisWidth;
    CGFloat y2AxisY = yAxisY;
    CGFloat y2AxisY2 = xAxisY;
    UIBezierPath *y2Axis = [UIBezierPath bezierPath];
    [y2Axis moveToPoint:CGPointMake(y2AxisX, y2AxisY)];
    [y2Axis addLineToPoint:CGPointMake(y2AxisX, y2AxisY2)];
    y2Axis.lineWidth = 1;
    [y2Axis stroke];
	
	// 5 个 x 栅格线
	for (int i = 0; i < 5; i ++) {
		
		CGFloat padding = 0.75 * height / 5;
		CGFloat x = xAxisX;
		CGFloat y = xAxisY - (i+1) * padding;
		CGFloat y2 = xAxisX + xAxisWidth;
		UIBezierPath *path = [UIBezierPath bezierPath];
		[path moveToPoint:CGPointMake(x, y)];
		[path addLineToPoint:CGPointMake(y2, y)];
		path.lineWidth = 1;
    	[path stroke];
		
	}
	
	
	// x 轴标题 本例中x轴的标题是7个
	for (int i = 0; i < self.titleArray.count; i ++) {
		CGFloat x = xAxisX + xAxisWidth / 7 / 2  + i * xAxisWidth / 7;
		CGSize strSize = [self.titleArray[i] sizeWithAttributes:@{NSFontAttributeName : [UIFont systemFontOfSize:10]}];
		[self.titleArray[i] drawInRect:CGRectMake(x - strSize.width /2, xAxisY + 3, strSize.width, 20)
                     withAttributes:@{NSForegroundColorAttributeName  : [UIColor blackColor],
                                      NSFontAttributeName             : [UIFont systemFontOfSize:10]}];
									  
	}
	
	
	// 画柱状图
	CGFloat bar_area_total_width = xAxisWidth / 7;
	CGFloat bar_left_padding = bar_area_total_width * 0.1;
	CGFloat bar_width = bar_area_total_width * 0.35;
	CGFloat bar_item_padding = bar_area_total_width * 0.05;
	// 计算出对应的Value 的值
	CGFloat yTittleMargin = 0.75 * height / self.firstValArr.count / 2 ;
	for (int i = 0; i < self.firstValArr.count / 2; i ++) {
				
		NSNumber *number1 = self.firstValArr[i];
		
		// 计算出X 与 Y 的值
		CGFloat y1 = xAxisY - number1.floatValue / self.yMaxTittleNum * 0.75 * height;
		
		CGFloat x1 = xAxisX + i * bar_area_total_width + bar_left_padding + bar_width / 2;
		
		UIBezierPath *linePath = [UIBezierPath bezierPath];
		[linePath moveToPoint:CGPointMake(x1, xAxisY - 0.5)];
		[linePath addLineToPoint:CGPointMake(x1 , y1)];
		linePath.lineWidth = bar_width;
		[[UIColor colorWithRed:39/255.0f green:255/255.0f blue:87/255.0f alpha:1] set];//线的颜色
		[linePath stroke];
		
		// 写出对应的value值
		
				
		NSString *value2 = [self.firstValArr[i] description];
		
		CGSize valueStrSize = [value2 sizeWithAttributes:@{NSFontAttributeName : [UIFont systemFontOfSize:9.0f]}];
		
		[value2 drawInRect:CGRectMake(x1 - valueStrSize.width/2   , y1 - valueStrSize.height , valueStrSize.width, valueStrSize.height)
         withAttributes:@{NSForegroundColorAttributeName :[UIColor blackColor],
			NSFontAttributeName: [UIFont systemFontOfSize:9]}];
		
		
	}
	
	// 第二个值
	for (int i = 0; i < self.firstValArr.count / 2; i ++) {
	
		NSInteger idx = self.firstValArr.count / 2 + i;
		
		NSNumber *number2 = self.firstValArr[idx];
		
		CGFloat y2 = xAxisY - number2.floatValue / self.yMaxTittleNum * 0.75 * height;
		
		CGFloat x2 = xAxisX + i * bar_area_total_width + bar_left_padding + bar_width / 2 + bar_width + bar_item_padding;
		
		UIBezierPath *linePath2 = [UIBezierPath bezierPath];
		[linePath2 moveToPoint:CGPointMake(x2, xAxisY - 0.5)];
		[linePath2 addLineToPoint:CGPointMake(x2 , y2)];
		linePath2.lineWidth = bar_width;
		[[UIColor colorWithRed:248/255.0f green:205/255.0f blue:22/255.0f alpha:1] set];//线的颜色
		[linePath2 stroke];
		
		// 写出对应的value值
		
		NSString *value2 = [self.firstValArr[idx] description];
		
		CGSize valueStrSize = [value2 sizeWithAttributes:@{NSFontAttributeName : [UIFont systemFontOfSize:9.0f]}];
		
		[value2 drawInRect:CGRectMake(x2 - valueStrSize.width/2   , y2 - valueStrSize.height , valueStrSize.width, valueStrSize.height)
         withAttributes:@{NSForegroundColorAttributeName :[UIColor blackColor],
			NSFontAttributeName: [UIFont systemFontOfSize:9]}];

		
		
	}
	
	
	
	
	
	
	
}

















@end
