//
//  LoginViewController.m
//  Unicom_UC
//
//  Created by Andy.NH on 10/16/12.
//  Copyright (c) 2012 Andy.NH. All rights reserved.
//

#import "LoginViewController.h"
#import "Common.h"

@interface LoginViewController () <UITextFieldDelegate>
{
    UITextField __weak *tf_account;
    
    UITextField __weak *tf_pwd;
    
    Boolean isSavePwd ;
    
    Boolean isAutoLogin;
    
    Boolean isMute;
}

/**
 * 更新账号或密码文本框的值 
 * @type 0:账号文本框；1:密码文本框
 */
- (void) updateTextFieldWithType:(int)type withValue:(NSString *)value;

- (void)keyboardWillChangeFrame:(NSNotification *)notification;

- (void)changeStateWithTarget:(UIButton *)target withSelected:(Boolean) checked;

- (void)setDefaultWithSavePwd:(Boolean)savePwd withAutoLogin:(Boolean)autoLogin withMute:(Boolean)mute withPwd:(NSString *)pwd;

@end




@implementation LoginViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    NSString *latestAccount = [self.loginViewDelegate lastetAccount];
    if (latestAccount) {
        [self updateTextFieldWithType:0 withValue:latestAccount];
        
        NSDictionary *lastestValue = [self.loginViewDelegate latestHistoryWithAccount:latestAccount];        
        if (lastestValue) {
            NSString *passord = [lastestValue objectForKey:KEY_FOR_PASSWORD];
            Boolean savePwd = [[lastestValue objectForKey:KEY_FOR_IS_SAVE_PWD] boolValue];
            Boolean autoLogin = [[lastestValue objectForKey:KEY_FOR_IS_AUTO_LOGIN] boolValue];
            Boolean mute = [[lastestValue objectForKey:KEY_FOR_IS_MUTE] boolValue];
            [self setDefaultWithSavePwd:savePwd withAutoLogin:autoLogin withMute:mute withPwd:passord];
            
            //如果自动登陆，且密码不为空
            if (autoLogin && passord && ![passord isEqualToString:@""]) {
                [self.loginViewDelegate loginWithAccount:latestAccount withPwd:passord withProperties:lastestValue];
            }
        }
        
    }
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    [self setTableView:nil];
    [self setSavePwdButton:nil];
    [self setAutoLoginButton:nil];
    [self setMuteButton:nil];
    [super viewDidUnload];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillChangeFrameNotification object:nil];
}


#pragma mark - UITableViewDataSource
- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    int row = indexPath.row;
    if (row == 0) {
        UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"accountCell"];
        tf_account = (UITextField *)[cell viewWithTag:ACCOUNT_TAG];
        [tf_account setDelegate:self];
        if (account) {
            tf_account.text = account;
        }
        return cell;
    }
    else {
        UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"pwdCell"];
        tf_pwd = (UITextField *)[cell viewWithTag:PWD_TAG];
        [tf_pwd setDelegate:self];
        if (pwd) {
            tf_pwd.text = pwd;
        }
        return cell;
    }
}



#pragma mark - UITextFieldDelegate Method

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    if ([textField isEqual:tf_pwd]) {
        return;
    }
    NSDictionary *setting = [self.loginViewDelegate latestHistoryWithAccount:textField.text];
    if (setting) {
        Boolean savePwd = [[setting objectForKey:KEY_FOR_IS_SAVE_PWD] boolValue];
        Boolean autoLogin = [[setting objectForKey:KEY_FOR_IS_AUTO_LOGIN] boolValue];
        Boolean mute = [[setting objectForKey:KEY_FOR_IS_MUTE] boolValue];
        NSString *password = [setting objectForKey:KEY_FOR_PASSWORD];
        [self setDefaultWithSavePwd:savePwd withAutoLogin:autoLogin withMute:mute withPwd:password];
    }else{
        [self setDefaultWithSavePwd:NO withAutoLogin:NO withMute:NO withPwd:@""];
    }

}

- (BOOL)textFieldShouldClear:(UITextField *)textField
{
    [self setDefaultWithSavePwd:NO withAutoLogin:NO withMute:NO withPwd:@""];
    return TRUE;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if ([textField isEqual:tf_account]) {
        [tf_pwd becomeFirstResponder];
    }else{
        [textField resignFirstResponder];
        [self.loginViewDelegate loginWithAccount:tf_account.text withPwd:tf_pwd.text withProperties:@{KEY_FOR_IS_SAVE_PWD : [NSNumber numberWithBool:isSavePwd], KEY_FOR_IS_AUTO_LOGIN: [NSNumber numberWithBool:isAutoLogin], KEY_FOR_IS_MUTE:[NSNumber numberWithBool:isMute]}];
    }    
    return TRUE;
}







#pragma mark - Private Method

- (void)updateTextFieldWithType:(int)type withValue:(NSString *)value
{
    if (type == 0) {
        account = value;
    }else{
        pwd = value;
    }        
    NSIndexPath *indexPath = [NSIndexPath indexPathForItem:type inSection:0];
    [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
}

- (void)keyboardWillChangeFrame:(NSNotification *)notification{
    
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_3_2
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
#endif
#if __IPHONE_OS_VERSION_MIN_REQUIRED >= __IPHONE_3_2
        NSValue *keyboardBoundsValue = [[notification userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey];
#else
        NSValue *keyboardBoundsValue = [[notification userInfo] objectForKey:UIKeyboardBoundsUserInfoKey];
#endif
        CGRect keyboardBounds;
        [keyboardBoundsValue getValue:&keyboardBounds];
        
        float visibleHeight = self.muteButton.frame.origin.y + self.muteButton.frame.size.height +20;
        float offset = (visibleHeight - keyboardBounds.origin.y > 0) ? keyboardBounds.origin.y - visibleHeight : 0;        
        
        CGRect listFrame = CGRectMake(0, offset, self.view.frame.size.width, self.view.frame.size.height);
        
        [UIView beginAnimations:@"anim" context:NULL];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
        [UIView setAnimationBeginsFromCurrentState:YES];
        [UIView setAnimationDuration:0.3];
        //处理移动事件，将各视图设置最终要达到的状态
        [self.view setFrame:listFrame];
        
        [UIView commitAnimations];
        
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_3_2
    }
#endif
    
}

- (void)changeStateWithTarget:(UIButton *)target withSelected:(Boolean) checked
{
    if (!checked) {
        [target setImage:NULL forState:UIControlStateNormal];
    }else{
        [target setImage:[UIImage imageNamed:@"uc_login_check_box_checked.png"] forState:UIControlStateNormal];
    }
}

- (void)setDefaultWithSavePwd:(Boolean)savePwd withAutoLogin:(Boolean)autoLogin withMute:(Boolean)mute withPwd:(NSString *)password
{
    
    [self updateTextFieldWithType:1 withValue:password];
    isSavePwd = savePwd;
    isAutoLogin = autoLogin;
    isMute = mute;
    [self changeStateWithTarget:_savePwdButton withSelected:savePwd];
    [self changeStateWithTarget:_autoLoginButton withSelected:autoLogin];
    [self changeStateWithTarget:_muteButton withSelected:mute];
}


- (IBAction)login:(id)sender {
    [tf_pwd resignFirstResponder];
    [tf_account resignFirstResponder];
    [self.loginViewDelegate loginWithAccount:tf_account.text withPwd:tf_pwd.text withProperties:@{KEY_FOR_IS_SAVE_PWD : [NSNumber numberWithBool:isSavePwd], KEY_FOR_IS_AUTO_LOGIN: [NSNumber numberWithBool:isAutoLogin], KEY_FOR_IS_MUTE:[NSNumber numberWithBool:isMute]}];
}

- (IBAction)savePwd:(id)sender {
    isSavePwd = !isSavePwd;
    [self changeStateWithTarget:sender withSelected:isSavePwd];
}

- (IBAction)autoLogin:(id)sender {
    isAutoLogin = !isAutoLogin;
    [self changeStateWithTarget:sender withSelected:isAutoLogin];
}

- (IBAction)mute:(id)sender {
    isMute = !isMute;
    [self changeStateWithTarget:sender withSelected:isMute];
}
@end
