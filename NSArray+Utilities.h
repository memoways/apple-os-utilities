//
//	author:		fabrice truillot de chambrier
//
//	copyright:	© 2009-2014, men in silicium sàrl
//


@interface NSArray (Utilities)

- (BOOL) isMutable;
- (BOOL) isMutableArray;

- (NSIndexSet*) indexesOfObjects: (NSArray*) objects;

@end


@interface NSMutableArray (Utilities)

- (void) intersectArray: (NSArray*) otherArray;
- (void) unionArray: (NSArray*) otherArray;

@end
