//
//  Connectivity.m
//  ArnabChakraborty_WalE
//
//  Created by Arnab on 03/12/21.
//

#import "Connectivity.h"

@implementation Connectivity

- (BOOL)connected
{
    Reachability *reachability = [Reachability reachabilityForInternetConnection];
    NetworkStatus networkStatus = [reachability currentReachabilityStatus];
    return networkStatus != NotReachable;
}

@end
