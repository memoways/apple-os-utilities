//
//  author:       fabrice truillot de chambrier
//
//  © 2009-2014, men in silicium sàrl
//

#import <Foundation/Foundation.h>


@interface NSPredicate (Utilities)

+ (instancetype) newWithString: (NSString*) predicateString;
+ (instancetype) newWithFormat: (NSString*) predicateFormat, ...;
+ (instancetype) newWithFormat: (NSString*) predicateFormat arguments: (NSArray*) arguments;

@end
