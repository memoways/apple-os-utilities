//
//	author:		fabrice truillot de chambrier
//
//	copyright:	© 2011-2013, men in silicium sàrl
//


#if __has_feature( objc_arc )


#define __arc_yield __bridge_retained
#define __arc_claim __bridge_transfer

#define __bridge_claim __bridge_retained
#define __bridge_yield __bridge_transfer


NS_INLINE CF_RETURNS_RETAINED CFTypeRef NStoCF( id ns )
{
	return (__arc_yield CFTypeRef) ns;
}

NS_INLINE CF_RETURNS_RETAINED void* NStoPTR( id ns )
{
	return (__arc_yield void*) ns;
}

NS_INLINE id CFtoNS( CF_CONSUMED CFTypeRef cf )
{
	return (__arc_claim id) cf;
}

NS_INLINE id PTRtoNS( CF_CONSUMED void* ptr )
{
	return (__arc_claim id) ptr;
}

NS_INLINE void CFRetainSafe( CFTypeRef cf )
{
#ifdef __cplusplus
	if ( cf == nullptr ) return;
#else
	if ( cf == NULL ) return;
#endif

	CFRetain( cf );
}

NS_INLINE void CFReleaseSafe( CFTypeRef cf )
{
#ifdef __cplusplus
	if ( cf == nullptr ) return;
#else
	if ( cf == NULL ) return;
#endif

	CFRelease( cf );
}

#endif
