//
//	author:		fabrice truillot de chambrier
//
//	copyright:	© 2009-2013, men in silicium sàrl
//


@interface NSOrderedSet (Utilities)

- (BOOL) isMutable;
- (BOOL) isMutableOrderedSet;

+ (NSOrderedSet*) newWithArray: (NSArray*) array;

- (NSArray*) allObjects;

@end
