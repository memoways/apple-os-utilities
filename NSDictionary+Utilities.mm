//
//	author:		fabrice truillot de chambrier
//
//	copyright:	© 2009-2014, men in silicium sàrl
//

#import "OS/NSDictionary+Utilities.h"
#import "OS/NSString+Utilities.h"
#import "OS/nil.h"


@implementation NSDictionary (Utilities)

- (BOOL) isMutable
{
	return [self isMutableDictionary];
}

- (BOOL) isMutableDictionary
{
	return [self respondsToSelector: @selector(setObject:forKey:)];
}

- (BOOL) containsKey: (id) key
{
	return [self objectForKey: key] != nil;
}

- (BOOL) containsObject: (id) object
{
	NSArray* keys = [self allKeysForObject: object];

	return keys.count > 0;
}

- (id) objectForKeyCaseInsensitive: (id) key
{
	if ( key == nil ) return nil;
	if ( not [key isKindOfClass: NSString.class] ) return nil;

	for ( id mykey in self.allKeys )
	{
		if ( not [mykey isKindOfClass: NSString.class] ) continue;

		if ( [mykey isEqualToStringCaseInsensitive: key] )
		{
			return [self objectForKey: mykey];
		}
	}

	return nil;
}

- (NSDictionary*) exchangeObjectsAndKeys: (BOOL*) lossy
{
	NSMutableDictionary* dictionary = [[NSMutableDictionary alloc] initWithCapacity: self.count];
	BOOL isLossy = NO;

	for ( id key in self.allKeys )
	{
		id object = [self objectForKey: key];
		if ( [dictionary objectForKey: object] == nil )
		{
			dictionary[object] = key;
		}
		else
		{
			isLossy = YES;
		}
	}

	if ( lossy != nil ) *lossy = isLossy;

	return [dictionary copy];
}

- (BOOL) hasValueForKey: (NSString*) key
{
	return [self valueForKey: key] != nil;
}

- (BOOL) hasValueForKeyPath: (NSString*) path
{
	if ( path == nil ) return YES;

	NSRange dot = [path rangeOfString: @"." options: NSBackwardsSearch];
	if ( dot.location != NSNotFound )
	{
		NSString* subpath = [path substringToIndex: dot.location];
		NSString* key = [path substringFromIndex: dot.location + 1];
		id leaf = [self valueForKeyPath: subpath];
		if ( is_nil( leaf ) ) return NO;
		if ( [leaf isKindOfClass: NSDictionary.class] )
		{
			return [leaf hasValueForKey: key];
		}
		else
		{
			return NO;
		}
	}
	else
	{
		return [self hasValueForKey: path];
	}
}

- (id) valueForKey: (NSString*) key1 forKey: (NSString*) key2
{
	id value = [self valueForKey: key1];
	if ( not [value respondsToSelector: @selector(valueForKey:)] ) return nil;

	return [value valueForKey: key2];
}

- (NSDictionary*) entriesPassingTest: (BOOL (^)( id key, id obj, BOOL* stop )) predicate
{
	NSMutableDictionary* entries = [NSMutableDictionary new];
	for ( id key in self.allKeys )
	{
		id object = self[key];
		BOOL stop = NO;
		if ( predicate( key, object, &stop ) )
		{
			entries[key] = object;
		}

		if ( stop ) break;
	}

	return entries;
}

@end


@implementation NSMutableDictionary (Creation)

+ (instancetype) newWithCapacity: (NSUInteger) capacity
{
	return [NSMutableDictionary dictionaryWithCapacity: capacity];
}

@end


@implementation NSMutableDictionary (Utilities)

- (void) intersectKeysWithDictionary: (NSDictionary*) dictionary
{
	[self intersectKeysWithArray: dictionary.allKeys];
}

- (void) intersectKeysWithArray: (NSArray*) keys
{
	for ( id key in self )
	{
		if ( not [keys containsObject: key] )
		{
			[self removeObjectForKey: key];
		}
	}
}

- (void) setValue: (id) value forKey: (NSString*) key1 forKey: (NSString*) key2
{
	id value1 = [self valueForKey: key1];

	if ( value1 == nil )
	{
		value1 = [NSMutableDictionary new];
		[self setValue: value1 forKey: key1];
	}

	if ( [value1 isKindOfClass: NSDictionary.class] )
	{
		value1 = [value1 mutableCopy];
		[value1 setValue: value forKey: key2];
		[self setValue: value1 forKey: key1];
	}
	else
	{
		[NSException raise: NSDestinationInvalidException format: @"NSMutableDictionary setValue:forKey:forKey: couldn't set the value %@ at %@.%@", value, key1, key2];
	}
}

- (void) setValue: (id) value forKeyPath: (NSString*) keyPath create: (BOOL) create
{
	if ( not create )
	{
		[self setValue: value forKeyPath: keyPath];

		return;
	}

	if ( [keyPath containsString: @"."] )
	{
		NSString* key = [keyPath substringToString: @"."];
		id keyValue = [self valueForKey: key];

		if ( is_not_nil( keyValue ) )
		{
			if ( [keyValue isKindOfClass: NSDictionary.class] )
			{
				keyValue = [keyValue mutableCopy];
				[self setValue: keyValue forKey: key];
			}
			else
			{
				[NSException raise: NSDestinationInvalidException format: @"NSMutableDictionary setValue:forKeyPath:create: couldn't set the value %@ at %@", value, keyPath];
			}
		}
		else
		{
			keyValue = [NSMutableDictionary new];
			[self setValue: keyValue forKey: key];
		}

		if ( keyValue != nil )
		{
			NSString* path = [keyPath substringFromString: @"." included: NO];

			// Recursion down the path
			[keyValue setValue: value forKeyPath: path create: create];
		}
	}
	else
	{
		[self setValue: value forKey: keyPath];
	}
}

@end
