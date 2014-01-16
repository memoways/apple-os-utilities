//
//	author:		fabrice truillot de chambrier
//
//	copyright:	© 2009-2014, men in silicium sàrl
//

#import "OS/NSColor+Utilities.h"
#import "OS/nil.h"


namespace {

const NSInteger kRRGGBBAA = 8;
const NSInteger kRRGGBB = 6;
const NSInteger kRGBA = 4;
const NSInteger kRGB = 3;

}


@implementation NSColor (Utilities)

+ (NSColor*) colorWithHexRGB: (NSString*) color
{
	if ( is_empty( color ) ) return nil;

	NSCharacterSet* hex = [NSCharacterSet characterSetWithCharactersInString: @"0123456789aAbBcCdDeEfF"];
	color = [color stringByTrimmingCharactersInSet: [hex invertedSet]];

	NSInteger format = 0;
	switch ( color.length )
	{
		case 8: format = kRRGGBBAA; break;
		case 6: format = kRRGGBB; break;
		case 4: format = kRGBA; break;
		case 3: format = kRGB; break;
	}
	if ( format == 0 ) return nil;

	NSScanner* scanner = nil;

	// red
	unsigned int red = 0;
	if ( (format == kRRGGBBAA) or (format == kRRGGBB) ) scanner = [[NSScanner alloc] initWithString: [color substringWithRange: NSMakeRange( 0, 2 )]];
	if ( (format == kRGBA) or (format == kRGB) ) scanner = [[NSScanner alloc] initWithString: [color substringWithRange: NSMakeRange( 0, 1 )]];
	[scanner scanHexInt: &red];
	scanner = nil;

	// green
	unsigned int green = 0;
	if ( (format == kRRGGBBAA) or (format == kRRGGBB) ) scanner = [[NSScanner alloc] initWithString: [color substringWithRange: NSMakeRange( 2, 2 )]];
	if ( (format == kRGBA) or (format == kRGB) ) scanner = [[NSScanner alloc] initWithString: [color substringWithRange: NSMakeRange( 1, 1 )]];
	[scanner scanHexInt: &green];
	scanner = nil;

	// blue
	unsigned int blue = 0;
	if ( (format == kRRGGBBAA) or (format == kRRGGBB) ) scanner = [[NSScanner alloc] initWithString: [color substringWithRange: NSMakeRange( 4, 2 )]];
	if ( (format == kRGBA) or (format == kRGB) ) scanner = [[NSScanner alloc] initWithString: [color substringWithRange: NSMakeRange( 2, 1 )]];
	[scanner scanHexInt: &blue];
	scanner = nil;

	// alpha
	unsigned int alpha = 255;
	if ( format == kRRGGBBAA ) scanner = [[NSScanner alloc] initWithString: [color substringWithRange: NSMakeRange( 6, 2 )]];
	if ( format == kRGBA ) scanner = [[NSScanner alloc] initWithString: [color substringWithRange: NSMakeRange( 3, 1 )]];
	[scanner scanHexInt: &alpha];
	scanner = nil;

	return [NSColor colorWithCalibratedRed: red / 255.0 green: green / 255.0 blue: blue / 255.0 alpha: alpha / 255.0];
}

- (NSString*) hexRGB
{
	NSColor* color = [self colorUsingColorSpaceName: NSCalibratedRGBColorSpace];

	unsigned int red = color.redComponent * 255;
	unsigned int green = color.greenComponent * 255;
	unsigned int blue = color.blueComponent * 255;

	return [[NSString alloc] initWithFormat: @"#%02x%02x%02x", red, green, blue];
}

- (NSString*) hexRGBA
{
	NSColor* color = [self colorUsingColorSpaceName: NSCalibratedRGBColorSpace];

	unsigned int red = color.redComponent * 255;
	unsigned int green = color.greenComponent * 255;
	unsigned int blue = color.blueComponent * 255;

	if ( color.alphaComponent == 1.0 ) return [[NSString alloc] initWithFormat: @"#%02x%02x%02x", red, green, blue];

	unsigned int alpha = color.alphaComponent * 255;

	return [[NSString alloc] initWithFormat: @"#%02x%02x%02x%02x", red, green, blue, alpha];
}

@end
