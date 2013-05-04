//
//	author:		fabrice truillot de chambrier
//
//	copyright:	© 2009-2013, men in silicium sàrl
//

#import <Foundation/Foundation.h>


@interface NSData (Utilities)

- (NSString*) stringUsingEncoding: (NSStringEncoding) encoding;
- (NSString*) stringUsingUTF8StringEncoding;

- (NSString*) stringBase64;

- (NSData*) digestMD5;
- (NSData*) digestSHA2;
- (NSData*) digestHMACSHA2;

@end
