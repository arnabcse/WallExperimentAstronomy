//
//  AppDelegate.h
//  ArnabChakraborty_WalE
//
//  Created by Arnab on 30/11/21.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (readonly, strong) NSPersistentContainer *persistentContainer;

- (void)saveContext;


@end

