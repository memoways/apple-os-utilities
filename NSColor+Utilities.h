//
//	author:		fabrice truillot de chambrier
//
//	copyright:	© 2009-2013, men in silicium sàrl
//

#import <Foundation/Foundation.h>


@interface NSColor (Utilities)

+ (NSColor*) colorWithHexRGB: (NSString*) color;

- (NSString*) hexRGB;
- (NSString*) hexRGBA;

@end
