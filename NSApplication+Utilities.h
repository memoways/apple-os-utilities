//
//	author:		fabrice truillot de chambrier
//
//	copyright:	© 2010-2014, men in silicium sàrl
//

#import <Cocoa/Cocoa.h>


@interface NSApplication (Utilities)

- (void) systemVersion: (NSInteger*) major minor: (NSInteger*) minor fix: (NSInteger*) fix;

- (BOOL) isMavericks;
- (BOOL) isMavericksOrHigher;

- (BOOL) isMountainLion;
- (BOOL) isMountainLionOrHigher;

@end
