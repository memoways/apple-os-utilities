//
//	author:		fabrice truillot de chambrier
//
//	copyright:	© 2009-2013, men in silicium sàrl
//

#import "OS/NSArray+Utilities.h"


@implementation NSArray (Utilities)

{

}

- (NSIndexSet*) indexesOfObjects: (NSArray*) objects
{
	return [self indexesOfObjectsPassingTest: ^ BOOL ( id object, NSUInteger index, BOOL* stop )
	{
		return [objects containsObject: object];
	}];
}

@end
