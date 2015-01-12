//
//  author:       fabrice truillot de chambrier
//
//  © 2011-2014, men in silicium sàrl
//

#import "OS/NSObject+DeallocBlock.h"
#import "OS/NSObject+AssociatedObject.h"

#import <objc/runtime.h>


@interface MDeallocBlock : NSObject


@property ( readwrite, nonatomic, strong ) dispatch_queue_t queue;
@property ( readwrite, nonatomic, copy ) dispatch_block_t block;


@end


@implementation NSObject (DeallocBlock)

- (void) addDeallocBlock: (dispatch_block_t) block
{
	[self addDeallocBlockOnQueue: nil block: block];
}

- (void) addDeallocBlockOnQueue: (dispatch_queue_t) queue block: (dispatch_block_t) block
{
	@synchronized( self )
	{
		NSMutableArray* deallocBlocks = (NSMutableArray*) [self associatedObjectForRawKey: @selector(deallocBlocks)];
		if ( deallocBlocks == nil )
		{
			deallocBlocks = [NSMutableArray new];
			[self setAssociatedObject: deallocBlocks forRawKey: @selector(deallocBlocks) policy: OBJC_ASSOCIATION_RETAIN];
		}

		MDeallocBlock* deallocBlock = [MDeallocBlock new];
		deallocBlock.queue = queue;
		deallocBlock.block = block;
		[deallocBlocks addObject: deallocBlock];
	}
}

- (dispatch_block_t) removeLastDeallocBlock
{
	@synchronized( self )
	{
		NSMutableArray* deallocBlocks = (NSMutableArray*) [self associatedObjectForRawKey: @selector(deallocBlocks)];
		if ( deallocBlocks == nil ) return nil;
		if ( deallocBlocks.count == 0 ) return nil;

		dispatch_block_t block = deallocBlocks.lastObject;
		[deallocBlocks removeObject: block];

		return block;
	}
}

- (NSArray*) deallocBlocks
{
	@synchronized( self )
	{
		NSArray* deallocBlocks = (NSArray*) [self associatedObjectForRawKey: @selector(deallocBlocks)];

		NSMutableArray* blocks = [NSMutableArray new];
		for ( MDeallocBlock* deallocBlock in deallocBlocks ) {
			[blocks addObject: deallocBlock.block];
		}

		return [blocks copy];
	}
}

@end


@implementation MDeallocBlock

- (void) dealloc
{
	if ( self.block == nil ) return;

	if ( self.queue == nil ) {
		self.block();
	}
	else {
		dispatch_async( self.queue, self.block );
	}
}

@end
