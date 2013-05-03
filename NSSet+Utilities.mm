//
//	author:		fabrice truillot de chambrier
//
//	copyright:	© 2009-2012, men in silicium sàrl
//

#import "OS/NSSet+Utilities.h"


@implementation NSSet (Utilities)

+ (NSSet*) newWithArray: (NSArray*) array
{
	return [[NSSet alloc] initWithArray: array];
}

- (NSOrderedSet*) sortedSet
{
	return [self sortedSetUsingComparator: ^ ( id lhs, id rhs ) { return [lhs compare: rhs]; }];
}

- (NSOrderedSet*) sortedSetUsingComparator: (NSComparator) comparator
{
	NSMutableOrderedSet* set = [[NSMutableOrderedSet alloc] initWithSet: self];
	[set sortUsingComparator: comparator];

	return [set copy];
}

@end
