//
//	author:		fabrice truillot de chambrier
//
//	copyright:	© 2010-2014, men in silicium sàrl
//


@interface NSObject (Utilities)

+ (instancetype) cast: (id) object;
- (instancetype) castTo: (Class) type;

+ (id) convert: (id) object;
- (id) convertTo: (Class) type;

@end


#if __cplusplus

template<typename type> inline type*
objc_cast( id object )
{
	if ( [object isKindOfClass: [type class]] ) {
		return static_cast<type*>( object );
	}

	return nil;
}

#endif
