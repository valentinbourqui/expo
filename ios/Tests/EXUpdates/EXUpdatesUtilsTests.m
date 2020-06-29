//
//  EXUpdatesUtilsTests.m
//  Tests
//
//  Created by Eric Samelson on 6/29/20.
//  Copyright © 2020 650 Industries. All rights reserved.
//

#import <XCTest/XCTest.h>

#import <EXUpdates/EXUpdatesConfig.h>
#import <EXUpdates/EXUpdatesUtils.h>

@interface EXUpdatesUtilsTests : XCTestCase

@end

@implementation EXUpdatesUtilsTests

- (void)setUp {
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
}

- (void)testGetRuntimeVersionWithConfig
{
  EXUpdatesConfig *sdkOnlyConfig = [[EXUpdatesConfig alloc] init];
  [sdkOnlyConfig loadConfigFromDictionary:@{ @"EXUpdatesSDKVersion": @"38.0.0" }];
  XCTAssert([@"38.0.0" isEqualToString:[EXUpdatesUtils getRuntimeVersionWithConfig:sdkOnlyConfig]], @"should return SDK version if no runtime version is specified");

  EXUpdatesConfig *runtimeOnlyConfig = [[EXUpdatesConfig alloc] init];
  [runtimeOnlyConfig loadConfigFromDictionary:@{ @"EXUpdatesRuntimeVersion": @"1.0" }];
  XCTAssert([@"1.0" isEqualToString:[EXUpdatesUtils getRuntimeVersionWithConfig:runtimeOnlyConfig]], @"should return runtime version if no SDK version is specified");

  EXUpdatesConfig *bothConfig = [[EXUpdatesConfig alloc] init];
  [bothConfig loadConfigFromDictionary:@{ @"EXUpdatesSDKVersion": @"38.0.0", @"EXUpdatesRuntimeVersion": @"1.0" }];
  XCTAssert([@"1.0" isEqualToString:[EXUpdatesUtils getRuntimeVersionWithConfig:bothConfig]], @"should return runtime version if both are specified");
}

@end
