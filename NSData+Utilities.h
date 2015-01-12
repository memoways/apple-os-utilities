//
//  author:       fabrice truillot de chambrier
//
//  © 2009-2014, men in silicium sàrl
//

#import <Foundation/Foundation.h>


@interface NSData (Utilities)

+ (instancetype) newWithBytes: (const void*) bytes length: (NSUInteger) length;

- (BOOL) isMutable;
- (BOOL) isMutableData;

- (NSString*) stringUsingEncoding: (NSStringEncoding) encoding;
- (NSString*) stringUsingUTF8StringEncoding;

- (NSString*) stringBase64;

- (NSData*) digestMD5;
- (NSData*) digestSHA2;
- (NSData*) digestHMACSHA2;

@end
