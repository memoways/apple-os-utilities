//
//  author:       fabrice truillot de chambrier
//
//  © 2009-2014, men in silicium sàrl
//

#import <Cocoa/Cocoa.h>


@interface NSColor (Utilities)

+ (NSColor*) colorWithHexRGB: (NSString*) color;
+ (NSColor*) colorWithHexRGB: (NSString*) color alpha: (NSString*) colorA;
+ (NSColor*) colorWithHexRGB: (NSString*) color opacity: (CGFloat) opacity;

- (NSString*) hexRGB;
- (NSString*) hexRGBA;
- (NSString*) hexA;

@end
