//
//  Common.h
//  Unicom_UC
//
//  Created by fedora xiang on 12-5-29.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//


#import <Foundation/Foundation.h>

#ifndef IOS_VERSION
#define IOS_VERSION [[[UIDevice currentDevice] systemVersion] floatValue]
#endif


#ifndef FOUR_SCREEN
#define FOUR_SCREEN ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)
#endif

//release 时去掉nslog的方法 
#ifndef __OPTIMIZE__
#    define NSLog(...) NSLog(__VA_ARGS__)
#else
#    define NSLog(...) {}
#endif


#define COOKBOOK_PURPLE_COLOR	[UIColor colorWithRed:0.20392f green:0.19607f blue:0.61176f alpha:1.0f]

#define BARBUTTON(TITLE, SELECTOR) 	[[UIBarButtonItem alloc] initWithTitle:TITLE style:UIBarButtonItemStylePlain target:self action:SELECTOR]

#define IMGBUTTON(FILENAME, SELECTOR) [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:FILENAME] style:UIBarButtonItemStyleBordered target:self action:SELECTOR]

#define ALPHA	@"ABCDEFGHIJKLMNOPQRSTUVWXYZ#"

#define hasCamera [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]

#define VIDEOCHAT_SERVER_IP_LOCAL   @"192.168.100.88"//@"10.20.11.188" //
#define VIDEOCHAT_SERVER_IP_PORT_LOCAL  @"8080"
#define VIDEOCHAT_SERVER_IP       @"120.197.89.60"//211.136.253.210 
#define VIDEOCHAT_SERVER_IP_PORT  @"80"


//定义创建临时用户的密码
#define TEMP_PASSWORD  @"123456"
#define TEMP_NAME  [[UIDevice currentDevice] uniqueIdentifier]

#define CONPAGENO 12
#define CONPAGEROWNO 4
#define CONPAGECOLUMNNO 3
#define CONPAGENOIPAD 16
#define CONPAGEROWNOIPAD 4
#define CONPAGECOLUMNNOIPAD 4



#define ADTIME 10
#define VIDEOCHATTIME 60*60*2 //60*5

#define TEXTFIELDHEIGHT 40


#define ENDEBUG YES

//conference 的状态，类型
typedef enum CONSTATE{
    ConStateReady,  
    ConStateDoing,  
    ConStateEnd,  
}CONSTATE;

typedef enum CONTYPE{
    ConTypeDay,  
    ConTypeWeek,  
    ConTypeMonth, 
    ConTypeTeam,
}CONTYPE;


typedef enum PERSONTYPE{
    PersonNormal,
    PersonManager,
}PERSONTYPE;


//会议成员信息，结构体
/*
 typedef struct PersonInfo
 {
 int persionID;
 PERSONTYPE  personType;
 NSString *personName;
 NSString *personPhone;
 }PersonInfo;
 */

//用户列表变化通知，
#define LISTCHANGENOTIFACTION @"LISTCHANGENOTIFACTION"

//用户发言变化通知，
#define TALKCHANGENOTIFACTION @"TALKCHANGENOTIFACTION"

//更新用户列表通知，
#define LISTUPDATENOTIFACTION @"LISTUPDATENOTIFACTION"

//更新共享文档通知，
#define SHAREDOCNOTIFACTION @"SHAREDOCNOTIFACTION"

//进入后台时调用此函数 (iphone的返回iphone桌面按钮)的通知，
#define TOBACKGROUNDNOTIFACTION @"TOBACKGROUNDNOTIFACTION"
//恢复到前台时调用此函数的通知，
#define TOFOREGROUNDNOTIFACTION @"TOFOREGROUNDNOTIFACTION"

//-------------------设置参数保存-------------------
//自动登录
#define keyForSetAutoLogin @"keyForSetAutoLogin"

//本机号码
#define keyForSetSelfNO @"keyForSetSelfNO"

//保存地址
#define keyForSetSavePosition @"keyForSetSavePosition"

//绑定的账号
#define keyForSetBindAccount @"keyForSetBindAccount"

//用户名
#define keyForSetUserName @"keyForSetUserName"

//用户密码
#define keyForSetUserPassword @"keyForSetUserPassword"

//最近一次的用户昵称，会议id 密码
#define keyForLastConfNickname  @"keyForLastConfNickname"
#define keyForLastConfID        @"keyForLastConfID"
#define keyForLastPassword      @"keyForLastPassword"

//服务器地址：0 内网， 1 外网
#define keyForServerAdrress @"keyForServerAdrress"


//------------------------参数设置-----------------------
#define KEY_FOR_IS_SAVE_PWD   @"isSavePwd"
#define KEY_FOR_IS_AUTO_LOGIN @"isAutoLogin"
#define KEY_FOR_IS_MUTE       @"isMute"
#define KEY_FOR_PASSWORD      @"password"
#define KEY_FOR_ACCOUNT       @"account"

//保存最近登陆的账号
#define KEY_FOR_LATEST_ACCOUNT @"KeyForLatestAccount"


@interface Common : NSObject{
    
    NSDateFormatter *formater ; 
    
    //服务器时间与本地时间差
    NSTimeInterval duration ;
    
    //栈内视图序号
    //会议列表的界面序号，方便返回
    int indexLoginView;
    int indexConListView;
}
@property (nonatomic) NSTimeInterval duration;
//网络连接状态
@property (nonatomic, assign) BOOL isReachability;

@property (nonatomic, assign) int indexLoginView;
@property (nonatomic, assign) int indexConListView;

@property (nonatomic, strong) NSString *severIP;
@property (nonatomic, strong) NSString *severPort;

@property (nonatomic, assign) BOOL isOpenLoc;


+ (Common *)sharedInstance;

- (NSString *) stringFromDate:(NSDate *)date;

- (NSDate *) dateFromString:(NSString *)dateString;


//得到字符串的宽度
- (CGFloat) getStringSize:(NSString *)string fontSize:(float)size;

@end
