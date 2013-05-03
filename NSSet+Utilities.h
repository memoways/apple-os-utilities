//
//	author:		fabrice truillot de chambrier
//
//	copyright:	© 2009-2012, men in silicium sàrl
//

#import <Foundation/Foundation.h>


@interface NSSet (Utilities)

+ (NSSet*) newWithArray: (NSArray*) array;

- (NSOrderedSet*) sortedSet;
- (NSOrderedSet*) sortedSetUsingComparator: (NSComparator) comparator;

@end
