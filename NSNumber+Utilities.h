//
//  author:       fabrice truillot de chambrier
//
//  © 2009-2015, men in silicium sàrl
//

#import <Foundation/Foundation.h>


@interface NSNumber (Utilities)

- (BOOL) isBoolean;
- (NSUInteger) numberSize;

- (NSString*) stringJSON;

- (NSDate*) dateJSON;

@end
