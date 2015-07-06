//
//  ThemeManager.m
//  AppSkin
//
//  Created by 蔡杰 on 15/7/2.
//  Copyright (c) 2015年 蔡杰. All rights reserved.
//

#import "ThemeManager.h"

NSString * const kAppThemeTypeChanged = @"AppThemeTypeChanged";

static NSString *const kAppThemeType  = @"AppThemeType";

@implementation ThemeManager

+(ThemeManager *)sharedThemeManager{
    
    static ThemeManager * theme = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
         theme = [[ThemeManager alloc]init];
        
        
    });
    return theme;
}

-(AppThemeType)themeType{
    
    NSInteger type = [[NSUserDefaults standardUserDefaults]integerForKey:kAppThemeType];
    if (type > 0 ) {
        
        return (AppThemeType)type;
    }
    return AppThemeTypeDefault;
}

-(void)setThemeType:(AppThemeType)aThemeType{
    
    if ([self themeType] == aThemeType) {
        return;
    }
    
    [[NSUserDefaults standardUserDefaults]setInteger:aThemeType forKey:kAppThemeType];
    [[NSUserDefaults standardUserDefaults] synchronize];

    [[NSNotificationCenter defaultCenter]postNotificationName:kAppThemeTypeChanged object:nil userInfo:nil];
}

-(NSString *)themePath{
    NSInteger type = [[NSUserDefaults standardUserDefaults]integerForKey:kAppThemeType];
    return  getThemeResourcePath(type);
}
- (UIImage*)themedImageWithName:(NSString*)imgName{
    
    
    if(self.themeType ==  AppThemeTypeDefault)  return nil;
    
    if (!imgName || [imgName isEqualToString:@""]) return nil;
    //先判断bundle
    
    if (!([self.themePath length] > 0)) {
        return nil;
    }
    
    NSString *imgPath=[self.themePath stringByAppendingPathComponent:imgName];
    NSLog(@"imapath = %@",imgPath);
    return [UIImage imageWithContentsOfFile:imgPath];
    //
}
@end
