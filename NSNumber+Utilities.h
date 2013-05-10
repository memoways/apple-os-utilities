//
//	author:		fabrice truillot de chambrier
//
//	copyright:	© 2009-2013, men in silicium sàrl
//

#import <Foundation/Foundation.h>


@interface NSNumber (Utilities)

- (BOOL) isBoolean;
- (NSUInteger) numberSize;

- (NSString*) stringJSON;

- (NSDate*) dateJSON;

@end
