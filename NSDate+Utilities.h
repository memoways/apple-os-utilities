//
//	author:		fabrice truillot de chambrier
//
//	copyright:	© 2009-2014, men in silicium sàrl
//

#import <Foundation/Foundation.h>


FOUNDATION_EXPORT const NSTimeInterval NSTimeIntervalSince2012;
FOUNDATION_EXPORT const NSTimeInterval NSTimeIntervalUntil2012;


@interface NSDate (Utilities)

+ (NSDate*) referenceDate;

+ (NSTimeInterval) localTimeIntervalSinceReferenceDate;
+ (NSTimeInterval) systemTimeIntervalSinceReferenceDate;
+ (NSNumber*) numberSinceReferenceDate;
+ (NSTimeInterval) timeIntervalSince2012;

- (NSTimeInterval) localTimeIntervalSinceReferenceDate;
- (NSTimeInterval) systemTimeIntervalSinceReferenceDate;
- (NSNumber*) numberSinceReferenceDate;
- (NSTimeInterval) timeIntervalSince2012;

+ (instancetype) newWithNumberSinceReferenceDate: (NSNumber*) secs;
+ (instancetype) newWithTimeIntervalSince2012: (NSTimeInterval) secs;
+ (instancetype) dateWithTimeIntervalSince2012: (NSTimeInterval) secs;
- (instancetype) initWithNumberSinceReferenceDate: (NSNumber*) secs;
- (instancetype) initWithTimeIntervalSince2012: (NSTimeInterval) secs;

- (NSString*) stringRFC1123;
- (NSString*) stringJSON;
- (NSString*) stringJSONLong;

@end
