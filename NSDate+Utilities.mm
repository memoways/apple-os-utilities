//
//	author:		fabrice truillot de chambrier
//
//	copyright:	© 2009-2012, men in silicium sàrl
//

#import "OS/NSDate+Utilities.h"


const NSTimeInterval NSTimeIntervalSince2012 = -347068800.0; // seconds between 2012-01-01 and 2001-01-01
const NSTimeInterval NSTimeIntervalUntil2012 = +347068800.0; // seconds between 2001-01-01 and 2012-01-01


namespace
{
	NSDate* referenceDate = nil;
	NSDateFormatter* rfc1123DateFormatter = nil;
	NSDateFormatter* jsonDateFormatter = nil;
	NSDateFormatter* jsonLongDateFormatter = nil;
}


@implementation NSDate (Utilities)

+ (NSDate*) referenceDate
{
	if ( referenceDate != nil ) return referenceDate;

	referenceDate = [[NSDate alloc] initWithTimeIntervalSinceReferenceDate: 0];

	return referenceDate;
}

+ (NSTimeInterval) localTimeIntervalSinceReferenceDate
{
	NSTimeInterval time = self.timeIntervalSinceReferenceDate;
	NSInteger seconds = [NSTimeZone.localTimeZone secondsFromGMT];

	return time + seconds;
}

+ (NSTimeInterval) systemTimeIntervalSinceReferenceDate
{
	NSTimeInterval time = self.timeIntervalSinceReferenceDate;
	NSInteger seconds = [NSTimeZone.systemTimeZone secondsFromGMT];

	return time + seconds;
}

+ (NSNumber*) numberSinceReferenceDate
{
	return @(self.timeIntervalSinceReferenceDate);
}

+ (NSTimeInterval) timeIntervalSince2012
{
	NSTimeInterval time = self.timeIntervalSinceReferenceDate;

	return time - NSTimeIntervalUntil2012;
}

- (NSTimeInterval) localTimeIntervalSinceReferenceDate
{
	NSTimeInterval time = self.timeIntervalSinceReferenceDate;
	NSInteger seconds = [NSTimeZone.localTimeZone secondsFromGMTForDate: self];

	return time + seconds;
}

- (NSTimeInterval) systemTimeIntervalSinceReferenceDate
{
	NSTimeInterval time = self.timeIntervalSinceReferenceDate;
	NSInteger seconds = [NSTimeZone.systemTimeZone secondsFromGMTForDate: self];

	return time + seconds;
}

- (NSNumber*) numberSinceReferenceDate
{
	return @(self.timeIntervalSinceReferenceDate);
}

- (NSTimeInterval) timeIntervalSince2012
{
	NSTimeInterval time = self.timeIntervalSinceReferenceDate;

	return time - NSTimeIntervalUntil2012;
}

+ (instancetype) newWithNumberSinceReferenceDate: (NSNumber*) secs
{
	return [[NSDate alloc] initWithNumberSinceReferenceDate: secs];
}

+ (instancetype) newWithTimeIntervalSince2012: (NSTimeInterval) secs
{
	return [[NSDate alloc] initWithTimeIntervalSinceReferenceDate: NSTimeIntervalUntil2012 + secs];
}

+ (instancetype) dateWithTimeIntervalSince2012: (NSTimeInterval) secs
{
	return [[NSDate alloc] initWithTimeIntervalSinceReferenceDate: NSTimeIntervalUntil2012 + secs];
}

- (instancetype) initWithNumberSinceReferenceDate: (NSNumber*) secs
{
	return [self initWithTimeIntervalSinceReferenceDate: secs.doubleValue];
}

- (instancetype) initWithTimeIntervalSince2012: (NSTimeInterval) secs
{
	return [self initWithTimeIntervalSinceReferenceDate: NSTimeIntervalUntil2012 + secs];
}

- (NSString*) stringRFC1123
{
	if ( rfc1123DateFormatter == nil )
	{
		rfc1123DateFormatter = [NSDateFormatter new];
		rfc1123DateFormatter.locale = [[NSLocale alloc] initWithLocaleIdentifier: @"en_US_POSIX"];
		rfc1123DateFormatter.timeZone = [NSTimeZone timeZoneWithAbbreviation: @"UTC"];

		rfc1123DateFormatter.dateFormat = @"EEE',' dd MMM yyyy HH':'mm':'ss 'GMT'";
	}

	NSString* date = [rfc1123DateFormatter stringFromDate: self];

	return date;
}

- (NSString*) stringJSON
{
	if ( jsonDateFormatter == nil )
	{
		jsonDateFormatter = [NSDateFormatter new];
		jsonDateFormatter.locale = [[NSLocale alloc] initWithLocaleIdentifier: @"en_US_POSIX"];
		jsonDateFormatter.timeZone = [[NSTimeZone alloc] initWithName: @"UTC"];

		jsonDateFormatter.dateFormat = @"yyyy-MM-dd'T'HH:mm:ss'Z'";
	}

	NSString* date = [jsonDateFormatter stringFromDate: self];

	return date;
}

- (NSString*) stringJSONLong
{
	NSString* date = nil;

	// raw

	NSTimeZone* timeZone = [[NSTimeZone alloc] initWithName: @"UTC"];
	CFGregorianDate gregorianDate = CFAbsoluteTimeGetGregorianDate( self.timeIntervalSinceReferenceDate, (__bridge CFTimeZoneRef) timeZone );

	date = [[NSString alloc] initWithFormat: @"%04d-%02d-%02dT%02d:%02d:%02.6fZ", (int) gregorianDate.year, (int) gregorianDate.month, (int) gregorianDate.day, (int) gregorianDate.hour, (int) gregorianDate.minute, (double) gregorianDate.second ];

	if ( date != nil ) return date;

	// NSDateFormatter

	if ( jsonLongDateFormatter == nil )
	{
		jsonLongDateFormatter = [NSDateFormatter new];
		jsonLongDateFormatter.locale = [[NSLocale alloc] initWithLocaleIdentifier: @"en_US_POSIX"];
		jsonLongDateFormatter.timeZone = [[NSTimeZone alloc] initWithName: @"UTC"];

		jsonLongDateFormatter.dateFormat = @"yyyy-MM-dd'T'HH:mm:ss.SSSS'Z'";
	}

	date = [jsonLongDateFormatter stringFromDate: self];

	return date;
}

@end
