//
//  SKPieTypeOneView.h
//  SKChartWorkSpace
//
//  Created by AY on 2018/2/27.
//  Copyright © 2018年 alexander. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SKPieTypeOneView : UIView

/** 设置数据源 */
- (void)setSourceData:(NSArray *)dataArr withColors:(NSArray *)colorArr;

/** 动画 */
- (void)stroke;

@end
