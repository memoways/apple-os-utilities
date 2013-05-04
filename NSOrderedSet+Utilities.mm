//
//	author:		fabrice truillot de chambrier
//
//	copyright:	© 2009-2013, men in silicium sàrl
//

#import "OS/NSOrderedSet+Utilities.h"


@implementation NSOrderedSet (Utilities)

+ (NSOrderedSet*) newWithArray: (NSArray*) array
{
	return [NSOrderedSet orderedSetWithArray: array];
}

- (NSArray*) allObjects
{
	return [[self array] copy];
}

@end
