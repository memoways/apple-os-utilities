//
//	author:		fabrice truillot de chambrier
//
//	copyright:	© 2009-2012, men in silicium sàrl
//

#import <Foundation/Foundation.h>


@interface NSString (Utilities)

+ (instancetype) newWithInt: (int) value;
+ (instancetype) newWithUnsignedInt: (unsigned int) value;
+ (instancetype) newWithBCDInt: (unsigned long long) value;
+ (instancetype) newHexadecimalWithNumber: (NSNumber*) number;
+ (instancetype) newHexadecimalWithData: (NSData*) data;
+ (instancetype) newBase64WithData: (NSData*) data;
+ (instancetype) newWithFormat: (NSString*) format, ... NS_FORMAT_FUNCTION(1,2);
+ (instancetype) newWithFormat: (NSString*) format arguments: (va_list) arguments NS_FORMAT_FUNCTION(1,0);

+ (instancetype) stringWithInt: (int) value;
+ (instancetype) stringWithUnsignedInt: (unsigned int) value;
+ (instancetype) stringWithBCDInt: (unsigned long long) value;
+ (instancetype) stringHexadecimalWithNumber: (NSNumber*) number;
+ (instancetype) stringHexadecimalWithData: (NSData*) data;
+ (instancetype) stringBase64WithData: (NSData*) data;
+ (instancetype) stringWithFormat: (NSString*) format arguments: (va_list) arguments NS_FORMAT_FUNCTION(1,0);

- (NSUInteger) unsignedIntegerValue;
- (uint64_t) unsignedLongLongValue;
- (NSString*) stringValue;

- (NSNumber*) numberJSON;

- (NSDate*) dateRFC1123;
- (NSDate*) dateJSON;
- (NSDate*) dateJSON2;

- (bool) containsString: (NSString*) string;
- (bool) containsStringCaseInsensitive: (NSString*) string;

- (bool) isEqualToStringCaseInsensitive: (NSString*) string;
- (bool) hasPrefixCaseInsensitive: (NSString*) prefix;

- (NSString*) substringFromIndex: (NSUInteger) from included: (BOOL) included;
- (NSString*) substringToString: (NSString*) string;
- (NSString*) substringFromString: (NSString*) string;
- (NSString*) substringFromString: (NSString*) string included: (BOOL) included;

- (NSData*) dataUsingUTF8StringEncoding;

- (NSString*) digestMD5;
- (NSString*) digestSHA2;

- (NSData*) dataDigestHMACSHA2;

@end
