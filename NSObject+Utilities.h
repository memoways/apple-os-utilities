//
//  author:       fabrice truillot de chambrier
//
//  © 2010-2015, men in silicium sàrl
//

#import <Foundation/Foundation.h>


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
