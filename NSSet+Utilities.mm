//
//  author:       fabrice truillot de chambrier
//
//  © 2009-2015, men in silicium sàrl
//

#import "OS/NSSet+Utilities.h"


@implementation NSSet (Utilities)

+ (NSSet*) newWithArray: (NSArray*) array
{
	return [[NSSet alloc] initWithArray: array];
}

- (BOOL) isMutable
{
	return [self isMutableSet];
}

- (BOOL) isMutableSet
{
	return [self respondsToSelector: @selector(addObject:)];
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
