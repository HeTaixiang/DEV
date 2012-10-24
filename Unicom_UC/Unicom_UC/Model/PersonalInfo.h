//
//  PersonalInfo.h
//  Unicom_UC
//
//  Created by Andy.NH on 10/17/12.
//  Copyright (c) 2012 Andy.NH. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface PersonalInfo : NSManagedObject

@property (nonatomic, strong) NSString * accountName;
@property (nonatomic, strong) NSData   * icon;
@property (nonatomic, strong) NSNumber * isAlert;
@property (nonatomic, strong) NSNumber * isAutoLogin;
@property (nonatomic, strong) NSNumber * isEmailPush;
@property (nonatomic, strong) NSNumber * isMsgPush;
@property (nonatomic, strong) NSNumber * isMute;
@property (nonatomic, strong) NSNumber * isNotification;
@property (nonatomic, strong) NSNumber * isSavePwd;
@property (nonatomic, strong) NSString * nickName;
@property (nonatomic, strong) NSString * password;
@property (nonatomic, strong) NSString * signature;
@property (nonatomic, strong) NSNumber * skinIndex;

@end
