//
//	author:		fabrice truillot de chambrier
//
//	copyright:	© 2008-2014, men in silicium sàrl
//


@interface NSURL (Utilities)

- (NSURL*) constantURL;
- (NSString*) variablesString;

- (NSArray*) parameterComponents; // @[ @[ @"parameter", @"value" ], … ]
- (NSDictionary*) queryComponents;

@end
