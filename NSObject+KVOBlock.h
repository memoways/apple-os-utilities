//
//	author:		fabrice truillot de chambrier
//
//	copyright:	© 2011-2014, men in silicium sàrl
//


@interface NSObject (KVOBlock)

typedef void (^ KVOBlock)( id object, NSString* keypath, NSDictionary* change );

- (id) addObserverForKeyPath: (NSString*) keyPath block: (KVOBlock) block;
- (void) removeBlockObserver: (id) uuid;

@end
