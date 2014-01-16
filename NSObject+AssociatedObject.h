//
//	author:		fabrice truillot de chambrier
//
//	copyright:	© 2011-2014, men in silicium sàrl
//


@interface NSObject (AssociatedObject)

- (id) associatedObjectForKey: (id) key;
- (id) associatedObjectForRawKey: (const void*) key;

- (void) setAssociatedObject: (id) object forKey: (id) key;
- (void) setAssociatedObject: (id) object forRawKey: (const void*) key;
- (void) setAssociatedObject: (id) object forKey: (id) key policy: (NSUInteger) policy;
- (void) setAssociatedObject: (id) object forRawKey: (const void*) key policy: (NSUInteger) policy;

- (void) removeAssociatedObjectForKey: (id) key;
- (void) removeAssociatedObjectForRawKey: (const void*) key;

- (void) removeAssociatedObjects;

@end
