//
//	author:		fabrice truillot de chambrier
//
//	copyright:	© 2009-2013, men in silicium sàrl
//


@interface NSPredicate (Utilities)

+ (instancetype) newWithString: (NSString*) predicateString;
+ (instancetype) newWithFormat: (NSString*) predicateFormat, ...;
+ (instancetype) newWithFormat: (NSString*) predicateFormat arguments: (NSArray*) arguments;

@end
