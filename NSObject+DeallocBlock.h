//
//	author:		fabrice truillot de chambrier
//
//	copyright:	© 2011-2014, men in silicium sàrl
//


@interface NSObject (DeallocBlock)

- (void) addDeallocBlock: (dispatch_block_t) block;
- (void) addDeallocBlockOnQueue: (dispatch_queue_t) queue block: (dispatch_block_t) block;

- (dispatch_block_t) removeLastDeallocBlock;

- (NSArray*) deallocBlocks;

@end
