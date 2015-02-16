//
//  author:       fabrice truillot de chambrier
//
//  © 2010-2015, men in silicium sàrl
//

#import "OS/NSObject+Utilities.h"
#import "OS/OS.h"


@implementation NSObject (Utilities)

+ (instancetype) cast: (id) object
{
	if ( [object isKindOfClass: self] ) return object;

	return nil;
}

- (instancetype) castTo: (Class) type
{
	if ( [self isKindOfClass: type] ) return self;

	return nil;
}

+ (id) convert: (id) object
{
	if ( object == nil ) return nil;
	if ( [object isKindOfClass: self] ) return object;

	if ( [object isKindOfClass: NSString.class] )
	{
		if ( self == NSString.class ) return object;
		if ( self == NSNumber.class ) return [[NSDecimalNumber alloc] initWithString: object];
		if ( self == NSDecimalNumber.class ) return [[NSDecimalNumber alloc] initWithString: object];
		if ( self == NSDate.class )
		{
			NSDate* date = [object dateJSON];
			if ( date == nil ) date = [object dateRFC1123];

			return date;
		}
	}

	if ( [object isKindOfClass: NSNumber.class] )
	{
		if ( self == NSString.class ) return [object stringValue];
		if ( self == NSNumber.class ) return object;
		if ( self == NSDecimalNumber.class ) return [[NSDecimalNumber alloc] initWithString: [object stringValue]];
		if ( self == NSDate.class ) return [[NSDate alloc] initWithTimeIntervalSinceReferenceDate: [object doubleValue]];
	}

	if ( [object isKindOfClass: NSDate.class] )
	{
		if ( self == NSNumber.class ) return [[NSNumber alloc] initWithDouble: [object timeIntervalSinceReferenceDate]];
		if ( self == NSDecimalNumber.class ) return [[NSDecimalNumber alloc] initWithDouble: [object timeIntervalSinceReferenceDate]];
		if ( self == NSDate.class ) return object;
	}

	if ( [object isKindOfClass: NSNull.class] )
	{
		if ( self == NSString.class ) return @"nil";
		if ( self == NSNumber.class ) return @0;
		if ( self == NSDecimalNumber.class ) return NSDecimalNumber.zero;
		if ( self == NSDate.class ) return [[NSDate alloc] initWithTimeIntervalSinceReferenceDate: 0];
		if ( self == NSNull.class ) return object;
		if ( [self isSubclassOfClass: NSArray.class] ) return @[];
		if ( [self isSubclassOfClass: NSDictionary.class] ) return @{};
		if ( [self isSubclassOfClass: NSSet.class] ) return [NSSet new];

		return object;
	}

	if ( [object isKindOfClass: NSArray.class] )
	{
		if ( self == NSString.class ) return [((NSArray*) object) componentsJoinedByString: @"\n"];
		if ( [self isSubclassOfClass: NSArray.class] ) return object;
		if ( [self isSubclassOfClass: NSSet.class] ) return [[NSSet alloc] initWithArray: ((NSArray*) object)];
	}

	if ( [object isKindOfClass: NSSet.class] )
	{
		if ( self == NSString.class ) return [((NSSet*) object).allObjects componentsJoinedByString: @"\n"];
		if ( [self isSubclassOfClass: NSArray.class] ) return ((NSSet*) object).allObjects;
		if ( [self isSubclassOfClass: NSSet.class] ) return object;
	}

	if ( [object isKindOfClass: NSDictionary.class] )
	{
		if ( [self isSubclassOfClass: NSDictionary.class] ) return object;
	}

	return nil;
}

- (id) convertTo: (Class) type
{
	if ( type == nil ) return self;
	if ( [self isKindOfClass: type] ) return self;

	id idself = self;

	if ( [self isKindOfClass: NSString.class] )
	{
		if ( type == NSString.class ) return self;
		if ( type == NSNumber.class ) return [[NSDecimalNumber alloc] initWithString: idself];
		if ( type == NSDecimalNumber.class ) return [[NSDecimalNumber alloc] initWithString: idself];
		if ( type == NSDate.class )
		{
			NSDate* date = [idself dateJSON];
			if ( date == nil ) date = [idself dateRFC1123];

			return date;
		}
	}

	if ( [self isKindOfClass: NSNumber.class] )
	{
		if ( type == NSString.class ) return [idself stringValue];
		if ( type == NSNumber.class ) return self;
		if ( type == NSDecimalNumber.class ) return [[NSDecimalNumber alloc] initWithString: [idself stringValue]];
		if ( type == NSDate.class ) return [[NSDate alloc] initWithTimeIntervalSinceReferenceDate: [idself doubleValue]];
	}

	if ( [self isKindOfClass: NSDate.class] )
	{
		if ( type == NSNumber.class ) return [[NSNumber alloc] initWithDouble: [idself timeIntervalSinceReferenceDate]];
		if ( type == NSDecimalNumber.class ) return [[NSDecimalNumber alloc] initWithDouble: [idself timeIntervalSinceReferenceDate]];
		if ( type == NSDate.class ) return self;
	}

	if ( [self isKindOfClass: NSNull.class] )
	{
		if ( type == NSString.class ) return @"nil";
		if ( type == NSNumber.class ) return @0;
		if ( type == NSDecimalNumber.class ) return NSDecimalNumber.zero;
		if ( type == NSDate.class ) return [[NSDate alloc] initWithTimeIntervalSinceReferenceDate: 0];
		if ( type == NSNull.class ) return self;
		if ( [type isSubclassOfClass: NSArray.class] ) return @[];
		if ( [type isSubclassOfClass: NSDictionary.class] ) return @{};
		if ( [type isSubclassOfClass: NSSet.class] ) return [NSSet new];

		return self;
	}

	if ( [self isKindOfClass: NSArray.class] )
	{
		if ( type == NSString.class ) return [((NSArray*) self) componentsJoinedByString: @"\n"];
		if ( [type isSubclassOfClass: NSArray.class] ) return self;
		if ( [type isSubclassOfClass: NSSet.class] ) return [[NSSet alloc] initWithArray: ((NSArray*) self)];
	}

	if ( [self isKindOfClass: NSSet.class] )
	{
		if ( type == NSString.class ) return [((NSSet*) self).allObjects componentsJoinedByString: @"\n"];
		if ( [type isSubclassOfClass: NSArray.class] ) return ((NSSet*) self).allObjects;
		if ( [type isSubclassOfClass: NSSet.class] ) return self;
	}

	if ( [self isKindOfClass: NSDictionary.class] )
	{
		if ( [type isSubclassOfClass: NSDictionary.class] ) return self;
	}

	return nil;
}


@end
