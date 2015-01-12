//
//  author:       fabrice truillot de chambrier
//
//  © 2009-2014, men in silicium sàrl
//

#import "OS/NSPredicate+Utilities.h"


@implementation NSPredicate (Utilities)

+ (instancetype) newWithString: (NSString*) predicateString
{
	return [NSPredicate predicateWithFormat: predicateString];
}

+ (instancetype) newWithFormat: (NSString*) predicateFormat, ...
{
	va_list	arguments;
	va_start( arguments, predicateFormat );
	NSPredicate* predicate = [NSPredicate predicateWithFormat: predicateFormat arguments: arguments];
	va_end( arguments );

	return predicate;
}

+ (instancetype) newWithFormat: (NSString*) predicateFormat arguments: (NSArray*) arguments
{
	return [NSPredicate predicateWithFormat: predicateFormat argumentArray: arguments];
}

@end
