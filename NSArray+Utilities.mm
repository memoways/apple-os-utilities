//
//  author:       fabrice truillot de chambrier
//
//  © 2009-2014, men in silicium sàrl
//

#import "OS/NSArray+Utilities.h"


@implementation NSArray (Utilities)

- (BOOL) isMutable
{
	return [self isMutableArray];
}

- (BOOL) isMutableArray
{
	return [self respondsToSelector: @selector(addObject:)];
}

- (NSIndexSet*) indexesOfObjects: (NSArray*) objects
{
	return [self indexesOfObjectsPassingTest: ^ BOOL ( id object, NSUInteger index, BOOL* stop )
	{
		return [objects containsObject: object];
	}];
}

@end


@implementation NSMutableArray (Utilities)

- (void) intersectArray: (NSArray*) otherArray
{
	NSIndexSet* indexes = [self indexesOfObjectsPassingTest: ^ BOOL ( id object, NSUInteger index, BOOL* stop )
	{
		return not [otherArray containsObject: object];
	}];

	[self removeObjectsAtIndexes: indexes];
}

- (void) unionArray: (NSArray*) otherArray
{
	for ( id object in otherArray ) {
		if ( not [self containsObject: object] ) [self addObject: object];
	}
}

@end
