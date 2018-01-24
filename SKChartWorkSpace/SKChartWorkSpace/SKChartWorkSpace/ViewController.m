//
//  ViewController.m
//  SKChartWorkSpace
//
//  Created by Alexander on 2018/1/22.
//  Copyright © 2018年 alexander. All rights reserved.
//

#import "ViewController.h"
#import "ExampleViewController.h"
#import "SKColTypeOneChart.h"
#import "SKColTypeTwoChart.h"
#define SCREEN_WIDTH   [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

#define SKRandomColor [UIColor colorWithRed:arc4random_uniform(256)/255.0 green:arc4random_uniform(256)/255.0 blue:arc4random_uniform(256)/255.0 alpha:1.0]
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
	[super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
	
		NSArray *menuArr = @[@"水平柱状",@"Bounces",@"Tada",@"Pulse",@"Shake",@"Swing",@"Snap",@"Bounce2",@"Expand",@"Hinge",@"Drop"];
	CGFloat btn_padding = 30;
	CGFloat btn_w = (SCREEN_WIDTH - 5 * btn_padding)/4;
	CGFloat btn_h = 35;
	int max_cols = 4;
	for (int i = 0; i < menuArr.count; i ++) {
		UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
		btn.backgroundColor = SKRandomColor;
		[btn setTitle:menuArr[i] forState:UIControlStateNormal];
		btn.titleLabel.font = [UIFont systemFontOfSize:12.0f];
		btn.tag = 666 + i;
		[btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];

		int row = 0;
		int col = i;
		if (i >= max_cols) {
			row = i / max_cols;
			col = i % max_cols;
		}
		
		btn.frame = CGRectMake(btn_padding + col *( btn_w + btn_padding) , btn_padding + row * (btn_h + btn_padding) + 80, btn_w, btn_h);
		
		[self.view addSubview:btn];
		
	}
	
	
}

#pragma mark -  按钮点击
- (void)btnClick:(UIButton *)btn
{
	
	NSInteger idx = btn.tag - 666;
	ExampleViewController *exVC = [[ExampleViewController alloc]init];
	exVC.view.backgroundColor = [UIColor whiteColor];
	[self presentViewController:exVC animated:YES completion:nil];
	switch (idx) {
  case 0:
    {
		// Sample1

		SKColTypeOneChart *one = [[SKColTypeOneChart alloc]init];
		one.backgroundColor =[UIColor whiteColor];
		one.values = @[@134,@41,@65,@0,@98,@134,@41,@65,@12,@98];
		one.yTitleArr = @[@"李东",@"王五",@"张三",@"李四",@"黄三",@"李东",@"王五",@"张三",@"李四",@"黄三"];
		one.frame = CGRectMake(0, 200, SCREEN_WIDTH, 300);
		[exVC.view addSubview:one];
		
	}
    break;
    case 1:{
		// Sample2
		SKColTypeTwoChart *two = [[SKColTypeTwoChart alloc]init];
		two.frame = CGRectMake(0, 200, SCREEN_WIDTH, 300);
		two.backgroundColor = [UIColor whiteColor];
		two.titleArray = @[@"李东",@"王五",@"张三",@"李四",@"黄三",@"李东",@"王五"];
		two.firstValArr = @[@15,@9,@15,@25,@19,@34,@52,@16,@9,@25,@125,@9,@84,@42];
		[exVC.view addSubview:two];
		
	}
	break;
	case 2:{
		
	
	}
	break;
	case 3:{
		
	
	}
	break;
	case 4:{
		
	
	}
	break;
	case 5:{
		
	
	}
	break;
	case 6:{
		
	
	}
	break;
	case 7:{
		
	
	}
	break;
	case 8:{
		
	
	}
	break;
	case 9:{
		
	
	}
	break;
	case 10:{
		;
	
	}
	break;

  default:
    break;
}

}


- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}


@end
