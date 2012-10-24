//
//  Common.m
//  Unicom_UC
//
//  Created by fedora xiang on 12-5-29.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "Common.h"


static Common *common ;

@implementation Common

@synthesize duration;
@synthesize isReachability;

@synthesize indexLoginView;
@synthesize indexConListView;
@synthesize severIP;
@synthesize severPort;

@synthesize isOpenLoc;

+ (Common *)sharedInstance {
    @synchronized(common){
        if (!common) {
            common = [[Common alloc] init];
        }
    }
    return common;
}

- (id) init{
    self = [super init];
    if (self) {
        formater = [[NSDateFormatter alloc] init];
        [formater setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    }
    return self;
}

- (NSString *)stringFromDate:(NSDate *)date{
    return [formater stringFromDate:date];
}

- (NSDate *)dateFromString:(NSString *)dateString{
    return [formater dateFromString:dateString];
}

//得到字符串的宽度
- (CGFloat) getStringSize:(NSString *)string fontSize:(float)size
{
    CGSize boundingSize = CGSizeMake(320.0f, CGFLOAT_MAX);
    CGSize requiredSize = [string sizeWithFont:[UIFont boldSystemFontOfSize:size] constrainedToSize:boundingSize lineBreakMode:UILineBreakModeWordWrap];
    
    //NSLog(@"%f,%f", requiredSize.width,requiredSize.height);
    return requiredSize.width;
}

@end
