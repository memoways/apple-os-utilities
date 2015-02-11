//
//  author:       fabrice truillot de chambrier
//
//  © 2011-2015, men in silicium sàrl
//

#import "OS/NSNull+Utilities.h"


@implementation NSNull (Utilities)

- (void) doesNotRecognizeSelector: (SEL) selector
{
	// calls on nil are harmless. calls on NSNull.null should be as well.

	NSLog( @"[NSNull.null %@] called, catched it, ignored it, the world is still spinning.", NSStringFromSelector( selector ) );
}

@end
