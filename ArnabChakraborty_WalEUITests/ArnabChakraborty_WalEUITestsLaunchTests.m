//
//  ArnabChakraborty_WalEUITestsLaunchTests.m
//  ArnabChakraborty_WalEUITests
//
//  Created by Arnab on 30/11/21.
//

#import <XCTest/XCTest.h>

@interface ArnabChakraborty_WalEUITestsLaunchTests : XCTestCase

@end

@implementation ArnabChakraborty_WalEUITestsLaunchTests

+ (BOOL)runsForEachTargetApplicationUIConfiguration {
    return YES;
}

- (void)setUp {
    self.continueAfterFailure = NO;
}

- (void)testLaunch {
    XCUIApplication *app = [[XCUIApplication alloc] init];
    [app launch];

    // Insert steps here to perform after app launch but before taking a screenshot,
    // such as logging into a test account or navigating somewhere in the app

    XCTAttachment *attachment = [XCTAttachment attachmentWithScreenshot:XCUIScreen.mainScreen.screenshot];
    attachment.name = @"Launch Screen";
    attachment.lifetime = XCTAttachmentLifetimeKeepAlways;
    [self addAttachment:attachment];
}

@end
