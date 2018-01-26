//
//  ExampleViewController.m
//  SKChartWorkSpace
//
//  Created by Alexander on 2018/1/22.
//  Copyright © 2018年 alexander. All rights reserved.
//

#import "ExampleViewController.h"

@interface ExampleViewController ()

@end

@implementation ExampleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
	
	UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
	[backBtn setTitle:@"Back" forState:UIControlStateNormal];
	backBtn.frame = CGRectMake(100, 30, 200, 50);
	[self.view addSubview:backBtn];
	[backBtn addTarget:self action:@selector(backBtnClick) forControlEvents:UIControlEventTouchUpInside];
	backBtn.backgroundColor =[UIColor cyanColor];
	
}

- (void)backBtnClick{

	// 返回
	[self dismissViewControllerAnimated:YES completion:nil];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
