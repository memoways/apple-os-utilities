//
//	author:		fabrice truillot de chambrier
//
//	copyright:	© 2011-2013, men in silicium sàrl
//

#import "OS/NSObject+AssociatedObject.h"

#import "OS/ARC.h"

#import <objc/runtime.h>


namespace
{
	dispatch_once_t _keysOnce = 0;
	NSMutableDictionary* _keys = nil;
}


@implementation NSObject (AssociatedObject)

+ (void) associatedObjectSetupKeysRegistry
{
	dispatch_once( &_keysOnce, ^ ()
	{
		if ( _keys == nil ) _keys = [NSMutableDictionary new];
	});
}

+ (const void*) associatedObjectRawKeyForKey: (id) key
{
	if ( key == nil ) return nullptr;

	NSValue* value = (NSValue*) _keys[key];
	if ( value == nil )
	{
		value = [NSValue valueWithPointer: (__arc_yield const void*) key];
		_keys[key] = value;
	}

	return value.pointerValue;
}

+ (id) associatedObjectKeyForRawKey: (const void*) key
{
	if ( key == nullptr ) return nil;

	NSValue* value = [NSValue valueWithPointer: key];
	NSArray* keys = [_keys allKeysForObject: value];
	if ( keys.count == 0 ) return nil;

	return keys[0];
}

- (id) associatedObjectForKey: (id) key
{
	if ( key == nil ) return nil;

	const void* rawKey = [NSObject associatedObjectRawKeyForKey: key];

	return [self associatedObjectForRawKey: rawKey];
}

- (id) associatedObjectForRawKey: (const void*) key
{
	if ( key == nullptr ) return nil;

	return objc_getAssociatedObject( self, key );
}

- (void) setAssociatedObject: (id) object forKey: (id) key
{
	if ( key == nil ) return;
	if ( _keys == nil ) [NSObject associatedObjectSetupKeysRegistry];

	const void* rawKey = [NSObject associatedObjectRawKeyForKey: key];

	[self setAssociatedObject: object forRawKey: rawKey];
}

- (void) setAssociatedObject: (id) object forRawKey: (const void*) key
{
	if ( key == nullptr ) return;

	[self setAssociatedObject: object forRawKey: key policy: OBJC_ASSOCIATION_RETAIN_NONATOMIC];
}

- (void) setAssociatedObject: (id) object forKey: (id) key policy: (NSUInteger) policy
{
	if ( key == nil ) return;

	const void* rawKey = [NSObject associatedObjectRawKeyForKey: key];

	[self setAssociatedObject: object forRawKey: rawKey policy: policy];
}

- (void) setAssociatedObject: (id) object forRawKey: (const void*) key policy: (NSUInteger) policy
{
	if ( key == nullptr ) return;

	if ( object != nil )
	{
		// set
		objc_setAssociatedObject( self, key, object, policy );
	}
	else
	{
		// remove
		objc_setAssociatedObject( self, key, nil, OBJC_ASSOCIATION_ASSIGN );
	}
}

- (void) removeAssociatedObjectForKey: (id) key
{
	if ( key == nil ) return;

	const void* rawKey = [NSObject associatedObjectRawKeyForKey: key];

	[self removeAssociatedObjectForRawKey: rawKey];
}

- (void) removeAssociatedObjectForRawKey: (const void*) key
{
	if ( key == nullptr ) return;

	objc_setAssociatedObject( self, key, nil, OBJC_ASSOCIATION_ASSIGN );
}

- (void) removeAssociatedObjects
{
	objc_removeAssociatedObjects( self );
}

@end
