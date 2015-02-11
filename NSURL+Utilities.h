//
//  author:       fabrice truillot de chambrier
//
//  © 2008-2015, men in silicium sàrl
//

#import <Foundation/Foundation.h>


@interface NSURL (Utilities)

- (NSURL*) constantURL;
- (NSString*) variablesString;

- (NSArray*) parameterComponents; // @[ @[ @"parameter", @"value" ], … ]
- (NSDictionary*) queryComponents;

@end
