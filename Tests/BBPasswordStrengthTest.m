#import <GHUnit/GHUnit.h>

#import "BBPasswordStrength.h"

@interface BBPasswordStrengthTest : GHTestCase
@end

@implementation BBPasswordStrengthTest

- (void)testScore {
  BBPasswordStrength *strength = [[BBPasswordStrength alloc] initWithPassword:@""];
  GHAssertEquals((NSUInteger)0, [strength score], nil);
  GHAssertEqualStrings(@"Very Weak", [strength scoreLabel], nil);
}

@end
