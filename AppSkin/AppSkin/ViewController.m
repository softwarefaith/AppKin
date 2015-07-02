//
//  ViewController.m
//  AppSkin
///Users/caijie/Desktop/Swift Programming Language中文版-老码团队发布[20150510].pdf
//  Created by 蔡杰 on 15/7/1.
//  Copyright (c) 2015年 蔡杰. All rights reserved.
//

#import "ThemeManager.h"

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *tesImageView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(appkinChange) name:kAppThemeTypeChanged object:nil];
    
    //_tesImageView.image = [UIImage imageNamed:@"home_icon_data_usage.png"];
    
    _tesImageView.image = [UIImage imageResourceNamed:@"home_icon_data_usage"];;

   
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)newType:(id)sender {
    
    ThemeManager *theme = [ThemeManager sharedThemeManager];
    theme.themeType = AppThemeTypeNew;
}

- (IBAction)defaultType:(id)sender {
    
    ThemeManager *theme = [ThemeManager sharedThemeManager];
    theme.themeType = AppThemeTypeDefault;
}

-(void)appkinChange{
    
    _tesImageView.image = [UIImage imageResourceNamed:@"home_icon_data_usage"];

}
@end
