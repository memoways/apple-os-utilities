//
//  author:       fabrice truillot de chambrier
//
//  © 2009-2015, men in silicium sàrl
//

#import <Foundation/Foundation.h>


@interface NSDictionary (Utilities)

- (BOOL) isMutable;
- (BOOL) isMutableDictionary;

- (BOOL) containsKey: (id) key;
- (BOOL) containsObject: (id) object;

- (id) objectForKeyCaseInsensitive: (id) key;

- (NSDictionary*) exchangeObjectsAndKeys: (BOOL*) lossy;

- (BOOL) hasValueForKey: (NSString*) key;
- (BOOL) hasValueForKeyPath: (NSString*) path;

- (id) valueForKey: (NSString*) key1 forKey: (NSString*) key2;

- (NSDictionary*) entriesPassingTest: (BOOL (^)( id key, id obj, BOOL* stop )) predicate;

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
