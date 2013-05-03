//
//	author:		fabrice truillot de chambrier
//
//	copyright:	© 2011-2012, men in silicium sàrl
//

#import <Foundation/Foundation.h>


@interface NSObject (DeallocBlock)

- (void) pushDeallocBlock: (dispatch_block_t) block;
- (dispatch_block_t) popDeallocBlock;

- (NSArray*) deallocBlocks;

@end
