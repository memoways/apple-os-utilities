//
//  author:       fabrice truillot de chambrier
//
//  © 2009-2014, men in silicium sàrl
//

#import <Foundation/Foundation.h>


@interface NSOrderedSet (Utilities)

- (BOOL) isMutable;
- (BOOL) isMutableOrderedSet;

+ (NSOrderedSet*) newWithArray: (NSArray*) array;

- (NSArray*) allObjects;

@end
