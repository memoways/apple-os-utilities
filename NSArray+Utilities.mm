//
//	author:		fabrice truillot de chambrier
//
//	copyright:	© 2009-2012, men in silicium sàrl
//

#import "OS/NSArray+Utilities.h"


@implementation NSArray (Utilities)

- (id) firstObject
{
	if ( self.count == 0 ) return nil;

	return self[0];
}

- (NSIndexSet*) indexesOfObjects: (NSArray*) objects
{
	return [self indexesOfObjectsPassingTest: ^ BOOL ( id object, NSUInteger index, BOOL* stop )
	{
		return [objects containsObject: object];
	}];
}

@end
