//
//	author:		fabrice truillot de chambrier
//
//	copyright:	© 2009-2013, men in silicium sàrl
//


@interface NSDictionary (Utilities)

- (BOOL) containsKey: (id) key;
- (BOOL) containsObject: (id) object;

- (id) objectForKeyCaseInsensitive: (id) key;

- (NSDictionary*) exchangeObjectsAndKeys: (BOOL*) lossy;

- (BOOL) hasValueForKey: (NSString*) key;
- (BOOL) hasValueForKeyPath: (NSString*) path;

- (id) valueForKey: (NSString*) key1 forKey: (NSString*) key2;

@end


@interface NSMutableDictionary (Creation)

+ (instancetype) newWithCapacity: (NSUInteger) capacity;

@end


@interface NSMutableDictionary (Utilities)

- (void) intersectKeysWithDictionary: (NSDictionary*) dictionary;
- (void) intersectKeysWithArray: (NSArray*) keys;

- (void) setValue: (id) value forKey: (NSString*) key1 forKey: (NSString*) key2;
- (void) setValue: (id) value forKeyPath: (NSString*) keyPath create: (BOOL) create;

@end
