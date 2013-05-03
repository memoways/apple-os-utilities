//
//	author:		fabrice truillot de chambrier
//
//	copyright:	© 2009-2012, men in silicium sàrl
//

#import "OS/NSNumber+Utilities.h"


@implementation NSNumber (Utilities)

- (BOOL) isBoolean
{
	return (self == @NO) or (self == @YES) or (self == (__bridge NSNumber*) kCFBooleanFalse) or (self == (__bridge NSNumber*) kCFBooleanTrue);
}

- (NSUInteger) numberSize
{
	if ( self.isBoolean )
	{
		return 1;
	}

	CFNumberType type = CFNumberGetType( (__bridge CFNumberRef) self );

	switch ( type )
	{
		case kCFNumberSInt8Type:
		case kCFNumberCharType:
		{
			return 8;
		}
		case kCFNumberSInt16Type:
		case kCFNumberShortType:
		{
			return 16;
		}
		case kCFNumberSInt32Type:
		case kCFNumberFloat32Type:
		case kCFNumberIntType:
		case kCFNumberLongType:
		case kCFNumberFloatType:
		case kCFNumberCFIndexType:
		case kCFNumberNSIntegerType:
		case kCFNumberCGFloatType:
		{
			return 32;
		}
		case kCFNumberSInt64Type:
		case kCFNumberFloat64Type:
		case kCFNumberLongLongType:
		case kCFNumberDoubleType:
		{
			return 64;
		}
		default:
		{
			return 0;
		}
	}
}

- (NSString*) stringJSON
{
	NSNumberFormatter* formatter = [NSNumberFormatter new];
	formatter.numberStyle = NSNumberFormatterDecimalStyle;
	formatter.locale = [[NSLocale alloc] initWithLocaleIdentifier: @"en_US_POSIX"];

	return [formatter stringFromNumber: self];
}

@end
