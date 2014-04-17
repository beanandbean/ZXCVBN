#import <GHUnit/GHUnit.h>

#import "BBPasswordStrength.h"

@interface BBPasswordStrengthTest : GHTestCase
@end

@implementation BBPasswordStrengthTest

- (void)testScore {
  BBPasswordStrength *strength = [[BBPasswordStrength alloc] initWithPassword:@""];
  GHAssertEquals((NSUInteger)0, [strength score], nil);
  GHAssertEqualsWithAccuracy(0.0, 0.0, [strength entropy], nil);
  GHAssertEqualStrings(@"Very Weak", [strength scoreLabel], nil);
  GHAssertEqualStrings(@"no time", [strength crackTimeDisplay], nil);
  
  BBPasswordStrength *strength0 = [[BBPasswordStrength alloc] initWithPassword:@"zxcvbn"];
  GHAssertEquals((NSUInteger)0, [strength0 score], nil);
  GHAssertEqualsWithAccuracy(6.845, [strength0 entropy], 1.0, nil);
  GHAssertEqualStrings(@"Very Weak", [strength0 scoreLabel], nil);
  GHAssertEqualStrings(@"no time", [strength0 crackTimeDisplay], nil);
  
  BBPasswordStrength *strength1 = [[BBPasswordStrength alloc] initWithPassword:@"qwER43@!"];
  GHAssertEquals((NSUInteger)1, [strength1 score], nil);
  GHAssertEqualsWithAccuracy(26.44, [strength1 entropy], 1.0, nil);
  GHAssertEqualStrings(@"Weak", [strength1 scoreLabel], nil);
  GHAssertEqualStrings(@"39 minutes", [strength1 crackTimeDisplay], nil);
  
  BBPasswordStrength *strength2 = [[BBPasswordStrength alloc] initWithPassword:@"Tr0ub4dour&3"];
  GHAssertEquals((NSUInteger)2, [strength2 score], nil);
  GHAssertEqualsWithAccuracy(30.435, [strength2 entropy], 1.0, nil);
  GHAssertEqualStrings(@"So-so", [strength2 scoreLabel], nil);
  GHAssertEqualStrings(@"11 hours", [strength2 crackTimeDisplay], nil);
  
  BBPasswordStrength *strength4 = [[BBPasswordStrength alloc] initWithPassword:@"correcthorsebatterystaple"];
  GHAssertEquals((NSUInteger)4, [strength4 score], nil);
  GHAssertEqualsWithAccuracy(45.212, [strength4 entropy], 1.0, nil);
  GHAssertEqualStrings(@"Great!", [strength4 scoreLabel], nil);
  GHAssertEqualStrings(@"64 years", [strength4 crackTimeDisplay], nil);
}

@end
