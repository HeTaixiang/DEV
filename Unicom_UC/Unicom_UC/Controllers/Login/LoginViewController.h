//
//  LoginViewController.h
//  Unicom_UC
//
//  Created by Andy.NH on 10/16/12.
//  Copyright (c) 2012 Andy.NH. All rights reserved.
//

#import <UIKit/UIKit.h>

#define ACCOUNT_TAG 100
#define PWD_TAG     200

@protocol LoginViewDelegate <NSObject>

/**
 * 认证，保存认证信息
 *
 * @return TRUE 认证成功；FALSE 认证失败
 */
- (Boolean) loginWithAccount:(NSString *)account withPwd:(NSString *)pwd withProperties:(NSDictionary *)properties;

/**
 * 根据用户输入的账户信息获取历史设置信息
 *
 * @return 历史设置信息
 */
- (NSDictionary *) latestHistoryWithAccount:(NSString *)account;

/**
 * 获取最近登陆的账号
 */
- (NSString *) lastetAccount;


@end


@interface LoginViewController : UIViewController
{
    NSString *account;
    NSString *pwd;
}

@property (weak, nonatomic) id<LoginViewDelegate> loginViewDelegate;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIButton *savePwdButton;
@property (weak, nonatomic) IBOutlet UIButton *autoLoginButton;
@property (weak, nonatomic) IBOutlet UIButton *muteButton;
- (IBAction)login:(id)sender;
- (IBAction)savePwd:(id)sender;
- (IBAction)autoLogin:(id)sender;
- (IBAction)mute:(id)sender;

@end
