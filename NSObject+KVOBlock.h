//
//	author:		fabrice truillot de chambrier
//
//	copyright:	© 2014-2014, men in silicium sàrl
//


@interface NSObject (KVOBlock)

typedef void (^ KVOBlock)( id observer, id object, NSString* keypath, NSDictionary* change );

- (id) addObserverForKeyPath: (NSString*) keyPath block: (KVOBlock) block;
- (id) addObserverForKeyPath: (NSString*) keyPath options: (NSKeyValueObservingOptions) options block: (KVOBlock) block;
- (id) addObserverForKeyPath: (NSString*) keyPath options: (NSKeyValueObservingOptions) options queue: (dispatch_queue_t) queue block: (KVOBlock) block;

- (void) removeBlockObserver: (id) uuid;
- (void) removeBlockObservers;

@end
