//
//  ShowLoginViewStoryboardSegue.m
//  Unicom_UC
//
//  Created by Andy.NH on 10/16/12.
//  Copyright (c) 2012 Andy.NH. All rights reserved.
//

#import "ShowLoginViewStoryboardSegue.h"

@implementation ShowLoginViewStoryboardSegue

- (void)perform
{
    [self.sourceViewController addChildViewController:self.destinationViewController];
    [self.sourceViewController setValue:self.destinationViewController forKey:@"loginViewController"];
    UIViewController *contentViewController = [self.sourceViewController valueForKey:@"contentViewController"];
    if (contentViewController) {
        [self.sourceViewController transitionFromViewController:contentViewController toViewController:self.destinationViewController duration:0.5f options:UIViewAnimationOptionCurveEaseInOut|UIViewAnimationOptionTransitionFlipFromLeft animations:NULL completion:^(BOOL finished){
            [contentViewController removeFromParentViewController];
        }];
    }else{
        [[self.sourceViewController view] addSubview:[self.destinationViewController view]];
    }
}

@end
