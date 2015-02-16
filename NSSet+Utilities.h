//
//  author:       fabrice truillot de chambrier
//
//  © 2009-2015, men in silicium sàrl
//

#import <Foundation/Foundation.h>


@interface NSSet (Utilities)

+ (NSSet*) newWithArray: (NSArray*) array;

- (BOOL) isMutable;
- (BOOL) isMutableSet;

- (NSOrderedSet*) sortedSet;
- (NSOrderedSet*) sortedSetUsingComparator: (NSComparator) comparator;

@end
