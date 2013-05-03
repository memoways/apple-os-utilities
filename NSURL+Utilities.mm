//
//	author:		fabrice truillot de chambrier
//
//	copyright:	© 2008-2012, men in silicium sàrl
//

#import "OS/NSURL+Utilities.h"
#import "OS/NSArray+Utilities.h"


@implementation NSURL (Utilities)

- (NSURL*) constantURL
{
	NSArray* components = [self.absoluteString componentsSeparatedByString: @";"];
	if ( components.count == 0 ) return nil;

	NSString* constantString = components.firstObject;

	return [[NSURL alloc] initWithString: constantString];
}

- (NSString*) variablesString
{
	NSArray* components = [self.absoluteString componentsSeparatedByString: @";"];
	if ( components.count <= 1 ) return nil;

	NSString* constantString = components.firstObject;
	NSString* variablesString = [self.absoluteString substringFromIndex: constantString.length];

	return variablesString;
}

- (NSArray*) parameterComponents
{
	NSArray* parameters = [self.parameterString componentsSeparatedByCharactersInSet: [NSCharacterSet characterSetWithCharactersInString: @";&"]];

	NSMutableArray* components = [NSMutableArray new];
	for ( NSString* parameter in parameters )
	{
		NSArray* component = [parameter componentsSeparatedByString: @"="];
		if ( component.count == 1 ) [components addObject: @[ component[0], NSNull.null ]];
		else if ( component.count == 2 ) [components addObject: @[ component[0], component[1] ]];
	}

	return components;
}

- (NSDictionary*) queryComponents
{
	NSArray* parameters = [self.query componentsSeparatedByCharactersInSet: [NSCharacterSet characterSetWithCharactersInString: @";&"]];

	NSMutableDictionary* components = [NSMutableDictionary new];
	for ( NSString* parameter in parameters )
	{
		NSArray* component = [parameter componentsSeparatedByString: @"="];
		if ( component.count == 1 ) components[component[0]] = NSNull.null;
		else if ( component.count == 2 ) components[component[0]] = component[1];
	}

	return components;
}

@end
