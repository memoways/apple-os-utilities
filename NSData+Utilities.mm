//
//	author:		fabrice truillot de chambrier
//
//	copyright:	© 2009-2013, men in silicium sàrl
//

#import "OS/NSData+Utilities.h"

#import "OS/ARC.h"

#import <CommonCrypto/CommonCrypto.h>
#import <Security/Security.h>
#import <Security/SecEncodeTransform.h>


@implementation NSData (Utilities)

- (BOOL) isMutable
{
	return [self isMutableData];
}

- (BOOL) isMutableData
{
	return [self respondsToSelector: @selector(appendData:)];
}

- (NSString*) stringUsingEncoding: (NSStringEncoding) encoding
{
	return [[NSString alloc] initWithData: self encoding: encoding];
}

- (NSString*) stringUsingUTF8StringEncoding
{
	return [self stringUsingEncoding: NSUTF8StringEncoding];
}

- (NSString*) stringBase64
{
	CFErrorRef error = nullptr;
	SecTransformRef encoder = SecEncodeTransformCreate( kSecBase64Encoding, &error );
	if ( (encoder == nullptr) or (error != nullptr) )
	{
		CFReleaseSafe( encoder );
		encoder = nullptr;

		return nil;
	}

	SecTransformSetAttribute( encoder, kSecTransformInputAttributeName, (__bridge CFDataRef) self, &error );
	SecTransformSetAttribute( encoder, kSecEncodeLineLengthAttribute, kSecLineLength76, &error );

	NSData* encodedData = (__arc_claim NSData*) SecTransformExecute( encoder, &error );

	CFReleaseSafe( encoder );
	encoder = nullptr;

	return [encodedData stringUsingUTF8StringEncoding];
}

- (NSData*) digestMD5
{
	return [self _digestWithType: kSecDigestMD5 length: 128];
}

- (NSData*) digestSHA2
{
	return [self _digestWithType: kSecDigestSHA2 length: 256];
}
- (NSData*) digestHMACSHA2
{
	return [self _digestWithType: /* kSecDigestHMACSHA2 is broken */ CFSTR( "HMAC-SHA2 Digest Family" ) length: 256];
}

- (NSData*) _digestWithType: (CFTypeRef) digestType length: (CFIndex) length
{
	CFErrorRef error = nullptr;
	SecTransformRef encoder = SecDigestTransformCreate( digestType, length, &error );
	if ( encoder == nullptr ) return nil;
	if ( error != nullptr )
	{
		CFReleaseSafe( encoder );
		encoder = nullptr;

		return nil;
	}

	SecTransformSetAttribute( encoder, kSecTransformInputAttributeName, (__bridge CFDataRef) self, &error );
	if ( error != nullptr )
	{
		CFReleaseSafe( encoder );
		encoder = nullptr;

		return nil;
	}

	NSData* encodedData = (__arc_claim NSData*) SecTransformExecute( encoder, &error );

	CFReleaseSafe( encoder );
	encoder = nullptr;

	if ( (encodedData == nil) or (error != nullptr) )
	{
		return nil;
	}


	return encodedData;
}

@end
