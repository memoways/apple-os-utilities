//
//  author:       fabrice truillot de chambrier
//
//  © 2009-2014, men in silicium sàrl
//

#import "OS/NSOrderedSet+Utilities.h"


@implementation NSOrderedSet (Utilities)


- (BOOL) isMutable
{
	return [self isMutableOrderedSet];
}

- (BOOL) isMutableOrderedSet
{
	return [self respondsToSelector: @selector(addObject:)];
}

+ (NSOrderedSet*) newWithArray: (NSArray*) array
{
	return [NSOrderedSet orderedSetWithArray: array];
}

- (NSArray*) allObjects
{
	return [[self array] copy];
}

@end
