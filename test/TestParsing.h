//
//  TestParsing.h
//  YAMLKit
//
//  Created by Patrick Thomson on 12/29/08.
//

#import <SenTestingKit/SenTestingKit.h>


@interface TestParsing : SenTestCase {

}

- (void)testVerySimpleLoadingFromFile;
- (void)testVerySimpleStringParsing;
- (void)testModerateLoadingFromFile;
- (void)testAutomaticIntegerCasting;
- (void)testWithNonexistentFile;
- (void)testWithMalformedStringInput;
- (void)testSuccessfulLoadingUsingErrors;
- (void)testUnsuccessfulLoadingUsingErrors;
- (void)testUnsuccessfulLoadingUsingExceptions;
- (void)testWhatHappensWhenParseIsCalledTwice;
- (void)testDifferentEncodings;
- (void)testWithCustomInputHandler;

@end
