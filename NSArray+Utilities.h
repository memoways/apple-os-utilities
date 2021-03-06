//
//  author:       fabrice truillot de chambrier
//
//  © 2009-2015, men in silicium sàrl
//

#import <Foundation/Foundation.h>


@interface NSArray (Utilities)

- (BOOL) isMutable;
- (BOOL) isMutableArray;

- (NSIndexSet*) indexesOfObjects: (NSArray*) objects;

@end


@interface NSMutableArray (Utilities)

- (void) intersectArray: (NSArray*) otherArray;
- (void) unionArray: (NSArray*) otherArray;

@end
