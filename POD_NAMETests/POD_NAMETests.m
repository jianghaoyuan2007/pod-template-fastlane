//
//  ${POD_NAME}Tests.m
//  ${POD_NAME}Tests
//
//  Created by Stephen Chiang on 14/06/2017.
//
//

#import <XCTest/XCTest.h>
#import <Kiwi/Kiwi.h>

SPEC_BEGIN(MathSpec)

describe(@"Math", ^{
    it(@"is pretty cool", ^{
        NSUInteger a = 16;
        NSUInteger b = 26;
        [[theValue(a + b) should] equal:theValue(42)];
    });
});

SPEC_END
