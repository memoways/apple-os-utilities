//
//	author:		fabrice truillot de chambrier
//
//	copyright:	© 2009-2014, men in silicium sàrl
//

#import "OS/NSNumber+Utilities.h"


@implementation NSNumber (Utilities)

- (BOOL) isBoolean
{
	if ( self == (__bridge NSNumber*) kCFBooleanTrue ) return YES;
	if ( self == (__bridge NSNumber*) kCFBooleanFalse ) return YES;

	if ( strncmp( self.objCType, @encode(bool), 8 ) == 0 ) return YES;
	if ( self.objCType[0] == 'B' ) return YES;

	return NO;
}

- (NSUInteger) numberSize
{
	if ( self.isBoolean ) return 1;

	CFIndex size = CFNumberGetByteSize( (__bridge CFNumberRef) self );
	if ( size > 0 ) return size;

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

- (NSDate*) dateJSON
{
	return [[NSDate alloc] initWithTimeIntervalSince1970: [self doubleValue]];
}

@end
