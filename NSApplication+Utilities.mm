//
//	author:		fabrice truillot de chambrier
//
//	copyright:	© 2010-2014, men in silicium sàrl
//

#import "OS/NSApplication+Utilities.h"


namespace
{
	dispatch_once_t _systemVersionOnce = 0;
	NSArray* _systemVersion = nil;
}


@implementation NSApplication (Utilities)

- (void) systemVersion: (NSInteger*) major minor: (NSInteger*) minor fix: (NSInteger*) fix
{
	dispatch_once( &_systemVersionOnce, ^ ()
	{
		NSString* version = [[NSDictionary alloc] initWithContentsOfFile: @"/System/Library/CoreServices/SystemVersion.plist"][@"ProductVersion"];
		_systemVersion = [version componentsSeparatedByString: @"."];
	});

	NSUInteger count = _systemVersion.count;
	if ( (count >= 1) and (major != nullptr) ) *major = [_systemVersion[0] integerValue];
	if ( (count >= 2) and (minor != nullptr) ) *minor = [_systemVersion[1] integerValue];
	if ( (count >= 3) and (fix != nullptr) ) *fix = [_systemVersion[2] integerValue];
}

- (BOOL) isMavericks
{
	NSInteger major = 10;
	NSInteger minor = 9;

	[self systemVersion: &major minor: &minor fix: nullptr];

	return (major == 10) and (minor == 9);
}

- (BOOL) isMavericksOrHigher
{
	NSInteger major = 10;
	NSInteger minor = 9;

	[self systemVersion: &major minor: &minor fix: nullptr];

	return (major == 10) and (minor >= 9);
}

- (BOOL) isMountainLion
{
	NSInteger major = 10;
	NSInteger minor = 8;

	[self systemVersion: &major minor: &minor fix: nullptr];

	return (major == 10) and (minor == 8);
}

- (BOOL) isMountainLionOrHigher
{
	NSInteger major = 10;
	NSInteger minor = 8;

	[self systemVersion: &major minor: &minor fix: nullptr];

	return (major == 10) and (minor >= 8);
}

@end
