//
//  TAAAppearanceProxyTests.m
//  TAAAppearanceProxyTests
//
//  Created by Elliot Neal on 26/10/2016.
//  Copyright © 2016 Ticket Arena LTD. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <OCMock/OCMock.h>
#import <TAAAppearanceProxy/TAAAppearanceProxy.h>


@interface TAAAppearanceProxyTests : XCTestCase


@property (assign, nonatomic) BOOL testAppearanceBool UI_APPEARANCE_SELECTOR;

@end


@implementation TAAAppearanceProxyTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testProxyCache {
    
    // it should return the same proxy for the same class
    id firstResult = [TAAAppearanceProxy proxyForClass:[self class]];
    id secondResult = [TAAAppearanceProxy proxyForClass:[self class]];
    
    XCTAssertEqual(firstResult, secondResult);
    
    // it should return a different proxy for different classes
    id thirdResult = [TAAAppearanceProxy proxyForClass:[UILabel class]];
    
    XCTAssertNotEqual(firstResult, thirdResult);
}

- (void)testForwardingInvocations {
    
    id proxy = [TAAAppearanceProxy proxyForClass:[self class]];
    [proxy setTestAppearanceBool:YES];
    [proxy setTestAppearanceBool:NO];
    
    id mock = OCMClassMock([self class]);
    [mock setExpectationOrderMatters:YES];
    
    OCMExpect([mock setTestAppearanceBool:YES]);
    OCMExpect([mock setTestAppearanceBool:NO]);
    
    [proxy applyInvocationsToTarget:mock];
    OCMVerifyAll(mock);
}

@end
