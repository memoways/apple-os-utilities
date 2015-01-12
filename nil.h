//
//  author:       fabrice truillot de chambrier
//
//  © 2009-2014, men in silicium sàrl
//

#import <Foundation/Foundation.h>
#ifdef __cplusplus
#include <cstddef>
#endif

#import "OS/ARC.h"


// is_nil & is_not_nil

NS_INLINE BOOL is_nil( id object )
{
	return ( object == nil ) || ( object == NSNull.null );
}

#if __cplusplus

NS_INLINE BOOL is_nil( std::nullptr_t pointer )
{
	return pointer == nullptr;
}

NS_INLINE BOOL is_nil( void* pointer )
{
	return pointer == nullptr;
}

#endif

NS_INLINE BOOL is_not_nil( id object )
{
	return ! is_nil( object );
}

#if __cplusplus

NS_INLINE BOOL is_not_nil( std::nullptr_t pointer )
{
	return not is_nil( pointer );
}

NS_INLINE BOOL is_not_nil( void* pointer )
{
	return pointer != nullptr;
}

#endif

// is_nullptr & is_not_nullptr

#if __cplusplus

NS_INLINE BOOL is_nullptr( std::nullptr_t pointer )
{
	return pointer == nullptr;
}

NS_INLINE BOOL is_nullptr( void* pointer )
{
	return pointer == nullptr;
}

NS_INLINE BOOL is_not_nullptr( std::nullptr_t pointer )
{
	return pointer != nullptr;
}

NS_INLINE BOOL is_not_nullptr( void* pointer )
{
	return pointer != nullptr;
}

#endif

// is_empty & is_not_empty

NS_INLINE BOOL is_empty( id object )
{
	if ( is_nil( object ) ) return YES;

	// NSString
	if ( [object isKindOfClass: NSString.class] ) {
		return ((NSString*) object).length == 0;
	}

	// NSArray, NSDictionary, NSSet & NSOrderedSet
	if ( [object isKindOfClass: NSArray.class] || [object isKindOfClass: NSDictionary.class] ||
		[object isKindOfClass: NSSet.class] || [object isKindOfClass: NSOrderedSet.class] ) {
		return [object count] == 0;
	}

	// NSData
	if ( [object isKindOfClass: NSData.class] ) {
		return ((NSData*) object).length == 0;
	}

	// NSURL
	if ( [object isKindOfClass: NSURL.class] ) {
		return [((NSURL*) object) absoluteString].length == 0;
	}

	return NO;
}

#if __cplusplus

NS_INLINE BOOL is_empty( std::nullptr_t pointer )
{
	return YES;
}

NS_INLINE BOOL is_empty( void* pointer )
{
	return is_nil( pointer );
}

#endif

NS_INLINE BOOL is_not_empty( id object )
{
	return ! is_empty( object );
}

#if __cplusplus

NS_INLINE BOOL is_not_empty( std::nullptr_t pointer )
{
	return NO;
}

NS_INLINE BOOL is_not_empty( void* pointer )
{
	return is_not_nil( pointer );
}

#endif

// idfy & unidfy

NS_INLINE id idfy( id object )
{
	if ( is_nil( object ) ) return NSNull.null;

	return object;
}

#if __cplusplus

NS_INLINE id idfy( std::nullptr_t pointer )
{
	return NSNull.null;
}

NS_INLINE id idfy( void* pointer )
{
	if ( is_nil( pointer ) ) return NSNull.null;

	return (__arc_claim id) pointer;
}

#endif

NS_INLINE id unidfy( id object )
{
	if ( is_nil( object ) ) return nil;
	
	return object;
}

#if __cplusplus

NS_INLINE id unidfy( std::nullptr_t pointer )
{
	return nil;
}

NS_INLINE id unidfy( void* pointer )
{
	if ( is_nil( pointer ) ) return nil;

	return (__arc_claim id) pointer;
}

#endif
