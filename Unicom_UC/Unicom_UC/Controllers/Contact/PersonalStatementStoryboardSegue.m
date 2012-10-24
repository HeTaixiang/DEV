//
//  PersonalStatementStoryboardSegue.m
//  Unicom_UC
//
//  Created by Andy.NH on 10/17/12.
//  Copyright (c) 2012 Andy.NH. All rights reserved.
//

#import "PersonalStatementStoryboardSegue.h"

@implementation PersonalStatementStoryboardSegue

- (void)perform
{
    UIViewController __weak *statementViewController = [self.sourceViewController valueForKey:@"personalStatementViewController"];
    if (!statementViewController) {
        [self.sourceViewController setValue:self.destinationViewController forKey:@"personalStatementViewController"];
        [[[self.sourceViewController view] window] addSubview:[self.destinationViewController view]];
    }
}

@end
