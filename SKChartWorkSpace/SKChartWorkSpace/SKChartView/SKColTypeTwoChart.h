//
//  SKColTypeTwoChart.h
//  SKChartWorkSpace
//
//  Created by AY on 2018/1/24.
//  Copyright © 2018年 alexander. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SKColTypeTwoChart : UIView
/** 第一个数组 */
@property (nonatomic, strong) NSArray *firstValArr;
/** 第二个数组 */
@property (nonatomic,strong) NSArray *secondValArr;

/** x 轴标题数组 */
@property (nonatomic,strong)NSArray *titleArray;


@end
