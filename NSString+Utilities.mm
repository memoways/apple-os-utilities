//
//	author:		fabrice truillot de chambrier
//
//	copyright:	© 2009-2012, men in silicium sàrl
//

#import "OS/NSString+Utilities.h"
#import "OS/ARC.h"

#import <CommonCrypto/CommonCrypto.h>
#import <Security/Security.h>
#import <Security/SecEncodeTransform.h>


namespace
{
	NSArray* rfc1123DateFormatters = nil;
	NSArray* jsonDateFormatters = nil;
}


@implementation NSString (Utilities)

+ (instancetype) newWithInt: (int) value
{
	return [NSString stringWithInt: value];
}

+ (instancetype) newWithUnsignedInt: (unsigned int) value
{
	return [NSString stringWithUnsignedInt: value];
}

+ (instancetype) newWithBCDInt: (unsigned long long) value
{
	return [NSString stringWithBCDInt: value];
}

+ (instancetype) newHexadecimalWithNumber: (NSNumber*) number
{
	return [NSString stringHexadecimalWithNumber: number];
}

+ (instancetype) newHexadecimalWithData: (NSData*) data
{
	return [NSString stringHexadecimalWithData: data];
}

+ (instancetype) newBase64WithData: (NSData*) data
{
	return [NSString stringBase64WithData: data];
}

+ (instancetype) newWithFormat: (NSString*) format, ...
{
	va_list	arguments;
	va_start( arguments, format );
	NSString* string = [NSString stringWithFormat: format arguments: arguments];
	va_end( arguments );

	return string;
}

+ (instancetype) newWithFormat: (NSString*) format arguments: (va_list) arguments
{
	return [NSString stringWithFormat: format arguments: arguments];
}

+ (instancetype) stringWithInt: (int) value
{
	return [NSString stringWithString: @(value).stringValue];
}

+ (instancetype) stringWithUnsignedInt: (unsigned int) value
{
	return [NSString stringWithString: @(value).stringValue];
}

+ (instancetype) stringWithBCDInt: (unsigned long long) value
{
	NSMutableString* string = nil;
	for ( int32_t index = sizeof (value) - 1 ; index >= 0 ; --index )
	{
		UInt8 byte = (UInt8) ((value >> (index * 8)) & 0xff);
		if ( (string == nil) and (byte == 0) ) continue;

		UInt8 bcdHigh = (byte >> 4) & 0x0f;
		UInt8 bcdLow = byte & 0x0f;

		if ( (string == nil) and (bcdHigh != 0) ) string = [NSMutableString new];

		if ( string != nil )
		{
			switch ( bcdHigh )
			{
				case 0:
					[string appendString: @"0"];
					break;
				case 1:
					[string appendString: @"1"];
					break;
				case 2:
					[string appendString: @"2"];
					break;
				case 3:
					[string appendString: @"3"];
					break;
				case 4:
					[string appendString: @"4"];
					break;
				case 5:
					[string appendString: @"5"];
					break;
				case 6:
					[string appendString: @"6"];
					break;
				case 7:
					[string appendString: @"7"];
					break;
				case 8:
					[string appendString: @"8"];
					break;
				case 9:
					[string appendString: @"9"];
					break;
			}
		}

		if ( (string == nil) and (bcdLow != 0) ) string = [NSMutableString new];

		if ( string != nil )
		{
			switch ( bcdLow )
			{
				case 0:
					[string appendString: @"0"];
					break;
				case 1:
					[string appendString: @"1"];
					break;
				case 2:
					[string appendString: @"2"];
					break;
				case 3:
					[string appendString: @"3"];
					break;
				case 4:
					[string appendString: @"4"];
					break;
				case 5:
					[string appendString: @"5"];
					break;
				case 6:
					[string appendString: @"6"];
					break;
				case 7:
					[string appendString: @"7"];
					break;
				case 8:
					[string appendString: @"8"];
					break;
				case 9:
					[string appendString: @"9"];
					break;
			}
		}
	} // for

	if ( string != nil )
	{
		return [NSString stringWithString: string];
	}
	else
	{
		return @"0";
	}
}

+ (instancetype) stringHexadecimalWithNumber: (NSNumber*) number
{
	unsigned long long value = number.unsignedLongLongValue;
	NSData* data = [NSData dataWithBytes: &value length: sizeof( value )];

	return [self stringHexadecimalWithData: data];
}

+ (instancetype) stringHexadecimalWithData: (NSData*) data
{
	NSMutableString* string = [NSMutableString stringWithCapacity: data.length * 2];
	for ( NSUInteger index = 0 ; index < data.length ; ++index )
	{
		uint8_t byte = 0;
		[data getBytes: &byte range: NSMakeRange( index, 1 )];

		[string appendFormat: @"%hhx", byte];
	}

	return [self stringWithString: string];
}

+ (instancetype) stringBase64WithData: (NSData*) data
{
	CFErrorRef error = nullptr;
	SecTransformRef encoder = SecEncodeTransformCreate( kSecBase64Encoding, &error );
	if ( error ) { CFShow( error ); exit( -1 ); }

	SecTransformSetAttribute( encoder, kSecTransformInputAttributeName, (__bridge CFDataRef) data, &error );

	NSData* encodedData = (__arc_claim NSData*) SecTransformExecute( encoder, &error );

	NSString* encodedString = [[NSString alloc] initWithData: encodedData encoding: NSUTF8StringEncoding];

	CFReleaseSafe( encoder );
	encoder = nullptr;

	return encodedString;
}

+ (instancetype) stringWithFormat: (NSString*) format arguments: (va_list) arguments
{
	return [[NSString alloc] initWithFormat: format arguments: arguments];
}

- (void) setupRFC1123DateFormatters
{
	if ( rfc1123DateFormatters == nil )
	{
		NSMutableArray* dateFormatters = [NSMutableArray new];
		NSDateFormatter* dateFormatter = nil;
		NSLocale* locale = [[NSLocale alloc] initWithLocaleIdentifier: @"en_US"];
		NSTimeZone* timeZone = [[NSTimeZone alloc] initWithName: @"UTC"];

		// @"EEE',' dd MMM yyyy HH':'mm':'ss z"

		dateFormatter = [NSDateFormatter new];
		dateFormatter.locale = locale;
		dateFormatter.timeZone = timeZone;

		dateFormatter.dateFormat = @"EEE',' dd MMM yyyy HH':'mm':'ss z";

		[dateFormatters addObject: dateFormatter];

		// @"EEEE',' dd'-'MMM'-'yy HH':'mm':'ss z"

		dateFormatter = [NSDateFormatter new];
		dateFormatter.locale = locale;
		dateFormatter.timeZone = timeZone;

		dateFormatter.dateFormat = @"EEEE',' dd'-'MMM'-'yy HH':'mm':'ss z";

		[dateFormatters addObject: dateFormatter];

		// @"EEE MMM d HH':'mm':'ss yyyy"

		dateFormatter = [NSDateFormatter new];
		dateFormatter.locale = locale;
		dateFormatter.timeZone = timeZone;

		dateFormatter.dateFormat = @"EEE MMM d HH':'mm':'ss yyyy";

		[dateFormatters addObject: dateFormatter];

		rfc1123DateFormatters = [dateFormatters copy];
	}
}

- (void) setupJSONDateFormatters
{
	if ( jsonDateFormatters == nil )
	{
		NSMutableArray* dateFormatters = [NSMutableArray new];
		NSDateFormatter* dateFormatter = nil;
		//NSLocale* localeUS = [[NSLocale alloc] initWithLocaleIdentifier: @"en_US"];
		NSLocale* locale = [[NSLocale alloc] initWithLocaleIdentifier: @"en_US_POSIX"];
		NSTimeZone* timeZone = [[NSTimeZone alloc] initWithName: @"UTC"];

		dateFormatter = [NSDateFormatter new];
		dateFormatter.locale = locale;
		dateFormatter.timeZone = timeZone;
		dateFormatter.dateFormat = @"yyyy-MM-dd'T'HH:mm:ss'Z'";
		[dateFormatters addObject: dateFormatter];

		dateFormatter = [NSDateFormatter new];
		dateFormatter.locale = locale;
		dateFormatter.timeZone = timeZone;
		dateFormatter.dateFormat = @"yyyy-MM-dd'T'HH:mm:ss.SSSS'Z'";
		[dateFormatters addObject: dateFormatter];

		dateFormatter = [NSDateFormatter new];
		dateFormatter.locale = locale;
		dateFormatter.timeZone = timeZone;
		dateFormatter.dateFormat = @"yyyy-MM-dd'T'HH:mm:ss.SSS'Z'";
		[dateFormatters addObject: dateFormatter];

		dateFormatter = [NSDateFormatter new];
		dateFormatter.locale = locale;
		dateFormatter.timeZone = timeZone;
		dateFormatter.dateFormat = @"yyyy-MM-dd HH:mm:ss Z";
		[dateFormatters addObject: dateFormatter];

		dateFormatter = [NSDateFormatter new];
		dateFormatter.locale = locale;
		dateFormatter.timeZone = timeZone;
		dateFormatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
		[dateFormatters addObject: dateFormatter];

		jsonDateFormatters = [dateFormatters copy];
	}
}

- (NSUInteger) unsignedIntegerValue
{
	return [NSDecimalNumber decimalNumberWithString: self].unsignedIntegerValue;
}

- (uint64_t) unsignedLongLongValue
{
	return [NSDecimalNumber decimalNumberWithString: self].unsignedLongLongValue;
}

- (NSString*) stringValue
{
	return self;
}

- (NSNumber*) numberJSON
{
	NSNumberFormatter* formatter = [NSNumberFormatter new];
	formatter.numberStyle = NSNumberFormatterDecimalStyle;
	formatter.locale = [[NSLocale alloc] initWithLocaleIdentifier: @"en_US_POSIX"];

	return [formatter numberFromString: self];
}
- (NSDate*) dateRFC1123
{
	if ( self.length == 0 ) return nil;

	if ( rfc1123DateFormatters == nil ) [self setupRFC1123DateFormatters];

	NSDate* date = nil;

	for ( NSDateFormatter* dateFormatter in jsonDateFormatters )
	{
		date = [dateFormatter dateFromString: self];
		if ( date != nil ) break;
	}

	return date;
}

- (NSDate*) dateJSON
{
	if ( self.length == 0 ) return nil;

	NSDate* date = nil;

	// NSScanner @"yyyy-mm-ddThh:mm:ss.ssssssZ"

	CFGregorianDate gregorianDate = {};
	NSScanner* scanner = [[NSScanner alloc] initWithString: self];
	scanner.locale = [[NSLocale alloc] initWithLocaleIdentifier: @"en_US_POSIX"];
	BOOL ok = YES;
	int scannedInt = 0;
	double scannedDouble = 0;
	if ( ok ) ok = ok and [scanner scanInt: &scannedInt];
	if ( ok ) gregorianDate.year = (SInt32) scannedInt;
	if ( ok ) ok = ok and [scanner scanString: @"-" intoString: nullptr];
	if ( ok ) ok = ok and [scanner scanInt: &scannedInt];
	if ( ok ) gregorianDate.month = (SInt8) scannedInt;
	if ( ok ) ok = ok and [scanner scanString: @"-" intoString: nullptr];
	if ( ok ) ok = ok and [scanner scanInt: &scannedInt];
	if ( ok ) gregorianDate.day = (SInt8) scannedInt;
	if ( ok ) ok = ok and [scanner scanString: @"T" intoString: nullptr];
	if ( ok ) ok = ok and [scanner scanInt: &scannedInt];
	if ( ok ) gregorianDate.hour = (SInt8) scannedInt;
	if ( ok ) ok = ok and [scanner scanString: @":" intoString: nullptr];
	if ( ok ) ok = ok and [scanner scanInt: &scannedInt];
	if ( ok ) gregorianDate.minute = (SInt8) scannedInt;
	if ( ok ) ok = ok and [scanner scanString: @":" intoString: nullptr];
	if ( ok ) ok = ok and [scanner scanDouble: &scannedDouble];
	if ( ok ) gregorianDate.second = scannedDouble;
	if ( ok ) ok = ok and [scanner scanString: @"Z" intoString: nullptr];

	if ( ok )
	{
		NSTimeZone* timeZone = [[NSTimeZone alloc] initWithName: @"UTC"];
		CFAbsoluteTime absoluteTime = CFGregorianDateGetAbsoluteTime( gregorianDate, (__bridge CFTimeZoneRef) timeZone );
		date = [[NSDate alloc] initWithTimeIntervalSinceReferenceDate: absoluteTime];
	}

	if ( date != nil ) return date;

	// NSDateFormatter

	if ( jsonDateFormatters == nil ) [self setupJSONDateFormatters];

	for ( NSDateFormatter* dateFormatter in jsonDateFormatters )
	{
		date = [dateFormatter dateFromString: self];
		if ( date != nil ) break;
	}

	return date;
}

- (NSDate*) dateJSON2
{
	if ( self.length == 0 ) return nil;

	NSDate* date = nil;

	// NSScanner @"yyyy-mm-dd hh:mm:ss.ssssss"

	CFGregorianDate gregorianDate = {};
	NSScanner* scanner = [[NSScanner alloc] initWithString: self];
	scanner.locale = [[NSLocale alloc] initWithLocaleIdentifier: @"en_US_POSIX"];
	BOOL ok = YES;
	int scannedInt = 0;
	double scannedDouble = 0;
	if ( ok ) ok = ok and [scanner scanInt: &scannedInt];
	if ( ok ) gregorianDate.year = (SInt32) scannedInt;
	if ( ok ) ok = ok and [scanner scanString: @"-" intoString: nullptr];
	if ( ok ) ok = ok and [scanner scanInt: &scannedInt];
	if ( ok ) gregorianDate.month = (SInt8) scannedInt;
	if ( ok ) ok = ok and [scanner scanString: @"-" intoString: nullptr];
	if ( ok ) ok = ok and [scanner scanInt: &scannedInt];
	if ( ok ) gregorianDate.day = (SInt8) scannedInt;
	//if ( ok ) ok = ok and [scanner scanString: @" " intoString: nullptr];
	if ( ok ) ok = ok and [scanner scanInt: &scannedInt];
	if ( ok ) gregorianDate.hour = (SInt8) scannedInt;
	if ( ok ) ok = ok and [scanner scanString: @":" intoString: nullptr];
	if ( ok ) ok = ok and [scanner scanInt: &scannedInt];
	if ( ok ) gregorianDate.minute = (SInt8) scannedInt;
	if ( ok ) ok = ok and [scanner scanString: @":" intoString: nullptr];
	if ( ok ) ok = ok and [scanner scanDouble: &scannedDouble];
	if ( ok ) gregorianDate.second = scannedDouble;

	if ( ok )
	{
		NSTimeZone* timeZone = [[NSTimeZone alloc] initWithName: @"UTC"];
		CFAbsoluteTime absoluteTime = CFGregorianDateGetAbsoluteTime( gregorianDate, (__bridge CFTimeZoneRef) timeZone );
		date = [[NSDate alloc] initWithTimeIntervalSinceReferenceDate: absoluteTime];
	}

	return date;
}

- (void) locationISO6709
{
	// Documentation: http://en.wikipedia.org/wiki/ISO_6709
	__unused NSString* coordinate = @"+44.1617+004.6209+057.000/";
}

- (bool) containsString: (NSString*) string
{
	return [self rangeOfString: string].length != 0;
}

- (bool) containsStringCaseInsensitive: (NSString*) string
{
	return [self rangeOfString: string options: NSCaseInsensitiveSearch].length != 0;
}

- (bool) isEqualToStringCaseInsensitive: (NSString*) string
{
	return [self caseInsensitiveCompare: string] == NSOrderedSame;
}

- (bool) hasPrefixCaseInsensitive: (NSString*) prefix
{
	if ( [self length] > [prefix length] )
	{
		return [[self substringToIndex: [prefix length]] caseInsensitiveCompare: prefix] == NSOrderedSame;
	}

	if ( [self length] == [prefix length] )
	{
		return [self caseInsensitiveCompare: prefix] == NSOrderedSame;
	}

	return false;
}

- (NSString*) substringFromIndex: (NSUInteger) from included: (BOOL) included
{
	if ( included ) return [self substringFromIndex: from];
	else return [self substringFromIndex: from + 1];
}

- (NSString*) substringToString: (NSString*) string
{
	NSRange range = [self rangeOfString: string];
	NSUInteger index = range.location;

	return [self substringToIndex: index];
}

- (NSString*) substringFromString: (NSString*) string
{
	NSRange range = [self rangeOfString: string];
	NSUInteger index = range.location;

	return [self substringFromIndex: index];
}

- (NSString*) substringFromString: (NSString*) string included: (BOOL) included
{
	NSRange range = [self rangeOfString: string];

	if ( included ) return [self substringFromIndex: range.location];
	else return [self substringFromIndex: range.location + range.length];
}

- (NSData*) dataUsingUTF8StringEncoding
{
	return [self dataUsingEncoding: NSUTF8StringEncoding];
}

- (NSData*) dataDigestMD5
{
	return [self _dataDigestWithType: kSecDigestMD5 length: 128];
}

- (NSString*) digestMD5
{
	return [NSString stringHexadecimalWithData: [self dataDigestMD5]];
}

- (NSData*) dataDigestSHA2
{
	return [self _dataDigestWithType: kSecDigestSHA2 length: 256];
}

- (NSString*) digestSHA2
{
	return [NSString stringHexadecimalWithData: [self dataDigestSHA2]];
}

- (NSData*) dataDigestHMACSHA2
{
	return [self _dataDigestWithType: /* kSecDigestHMACSHA2 is broken */ CFSTR( "HMAC-SHA2 Digest Family" ) length: 256];
}

- (NSData*) _dataDigestWithType: (CFTypeRef) digestType length: (CFIndex) length
{
	NSData* data = [self dataUsingEncoding: NSUTF8StringEncoding];
	if ( data == nil ) return nil;

	CFErrorRef error = nullptr;
	SecTransformRef encoder = SecDigestTransformCreate( digestType, length, &error );
	if ( encoder == nullptr ) return nil;
	if ( error != nullptr )
	{
		CFReleaseSafe( encoder );
		encoder = nullptr;

		return nil;
	}

	SecTransformSetAttribute( encoder, kSecTransformInputAttributeName, (__bridge CFDataRef) data, &error );
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
