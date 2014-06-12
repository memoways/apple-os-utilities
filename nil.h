//
//	author:		fabrice truillot de chambrier
//
//	copyright:	© 2009-2014, men in silicium sàrl
//


// is_nil & is_not_nil

NS_INLINE BOOL is_nil( id object )
{
	if ( object == nil ) return YES;
	if ( object == NSNull.null ) return YES;

	return NO;
}

#if __cplusplus

NS_INLINE BOOL is_nil( std::nullptr_t pointer )
{
	return YES;
}

NS_INLINE BOOL is_nil( void* pointer )
{
	return pointer == nullptr;
}

#endif

NS_INLINE BOOL is_not_nil( id object )
{
	return not is_nil( object );
}

#if __cplusplus

NS_INLINE BOOL is_not_nil( std::nullptr_t pointer )
{
	return NO;
}

NS_INLINE BOOL is_not_nil( void* pointer )
{
	return pointer != nullptr;
}

#endif

// is_nullptr & is_not_nullptr

#if __cplusplus

NS_INLINE bool is_nullptr( std::nullptr_t pointer )
{
	return true;
}

NS_INLINE bool is_nullptr( void* pointer )
{
	return pointer == nullptr;
}

NS_INLINE bool is_not_nullptr( std::nullptr_t pointer )
{
	return false;
}

NS_INLINE bool is_not_nullptr( void* pointer )
{
	return pointer != nullptr;
}

#endif

// is_empty & is_not_empty

NS_INLINE BOOL is_empty( id object )
{
	if ( is_nil( object ) ) return YES;

	// NSString
	if ( [object isKindOfClass: NSString.class] and (((NSString*) object).length == 0) ) return YES;

	// NSArray, NSDictionary, NSSet & NSOrderedSet
	if ( ([object isKindOfClass: NSArray.class] or [object isKindOfClass: NSDictionary.class] or
		[object isKindOfClass: NSSet.class] or [object isKindOfClass: NSOrderedSet.class]) and
		([object count] == 0) ) {
		return YES;
	}

	// NSData
	if ( [object isKindOfClass: NSData.class] and (((NSData*) object).length == 0) ) return YES;

	// NSURL
	if ( [object isKindOfClass: NSURL.class] and ([((NSURL*) object) absoluteString].length == 0) ) return YES;

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
	return not is_empty( object );
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
