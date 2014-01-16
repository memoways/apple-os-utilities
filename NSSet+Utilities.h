//
//	author:		fabrice truillot de chambrier
//
//	copyright:	© 2009-2014, men in silicium sàrl
//


@interface NSSet (Utilities)

+ (NSSet*) newWithArray: (NSArray*) array;

- (BOOL) isMutable;
- (BOOL) isMutableSet;

- (NSOrderedSet*) sortedSet;
- (NSOrderedSet*) sortedSetUsingComparator: (NSComparator) comparator;

@end
