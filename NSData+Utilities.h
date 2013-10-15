//
//	author:		fabrice truillot de chambrier
//
//	copyright:	© 2009-2013, men in silicium sàrl
//


@interface NSData (Utilities)

- (BOOL) isMutable;
- (BOOL) isMutableData;

- (NSString*) stringUsingEncoding: (NSStringEncoding) encoding;
- (NSString*) stringUsingUTF8StringEncoding;

- (NSString*) stringBase64;

- (NSData*) digestMD5;
- (NSData*) digestSHA2;
- (NSData*) digestHMACSHA2;

@end
