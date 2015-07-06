//
//  ThemeManager.h
//  AppSkin
//
//  Created by 蔡杰 on 15/7/2.
//  Copyright (c) 2015年 蔡杰. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#define Bundle_Of_ThemeResource                                @"AppKin.bundle/images"

//the path in the bundle
#define Bundle_Path_Of_ThemeResource(path)                                        \
[[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:path]

/*!
 *
 *  @brief  主题类型
 */
typedef NS_ENUM(NSInteger, AppThemeType){
    /*!
     *  默认引用资源
     */
    AppThemeTypeDefault =0,
    /*!
     *  新的皮肤  从Bundle里面获取
     */
    AppThemeTypeNew = 1
};
/*!
 *
 *  @brief  bundle   path  本地获取需要设置  皮肤的路径
 *
 *  @param  type   AppThemeType
 *
 *  @return path
 */
static inline NSString *getThemeResourcePath(AppThemeType type){
    
    switch (type) {
        case AppThemeTypeDefault:{
            
            break;
        }
        case AppThemeTypeNew:{
            
            return Bundle_Path_Of_ThemeResource(Bundle_Of_ThemeResource);
            break;
        }
            break;
            
        default:
            break;
    }
    return @"";
}


@interface ThemeManager : NSObject

@property (nonatomic,copy) NSString                 *themeName;
@property (nonatomic,copy) NSString                 *themePath;

/*!
 *  @brief  default AppThemeTypeDefault
 */
@property(nonatomic,assign)AppThemeType themeType;

+(ThemeManager*)sharedThemeManager;

- (UIImage*)themedImageWithName:(NSString*)imgName;


@end

/*!
 *
 *  @brief  皮肤更改通知
 */
extern NSString * const kAppThemeTypeChanged;


#pragma mark  --Theme Category
typedef NS_ENUM(NSInteger, AppThemeStyleType){
   
    AppThemeStyleTypeCommon =0, //公共资源
    AppThemeStyleTypeCustomer = 1
};



@interface  UIImage(ImageResourceFind)

+(UIImage *)imageResourceNamed:(NSString *)name  StyleType:(AppThemeStyleType)styleType;

+(UIImage *)imageCommonResourceNamed:(NSString *)name;

+(UIImage *)imageCustomerResourceNamed:(NSString *)name;

@end

@implementation UIImage(ImageResourceFind)

+(UIImage *)imageCommonResourceNamed:(NSString *)name{
    
    return [UIImage imageResourceNamed:name StyleType:AppThemeStyleTypeCommon];
}

+(UIImage *)imageCustomerResourceNamed:(NSString *)name{
    
    return [UIImage imageResourceNamed:name StyleType:AppThemeStyleTypeCustomer];
}

+(UIImage *)imageResourceNamed:(NSString *)name  StyleType:(AppThemeStyleType)styleType{
    
    switch (styleType) {
            
        case AppThemeStyleTypeCommon:{
            
            return [UIImage imageNamed:name];
             break;
        }
           
        case AppThemeStyleTypeCustomer:{
        
            UIImage *image = [[ThemeManager sharedThemeManager] themedImageWithName:name];
            
            if (image) {
                return image;
            }else{
                 return [UIImage imageNamed:name];
                
            }
           
            break;
        }
            
        default:
            break;
    }
    
    return [UIImage imageNamed:name];
    
}
@end

