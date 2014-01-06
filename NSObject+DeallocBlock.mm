//
//	author:		fabrice truillot de chambrier
//
//	copyright:	© 2011-2013, men in silicium sàrl
//

#import "OS/NSObject+DeallocBlock.h"
#import "OS/NSObject+AssociatedObject.h"

#import <objc/runtime.h>


@interface MDeallocBlock : NSObject

@property ( readwrite, nonatomic, copy ) dispatch_block_t block;

@end


namespace
{
	const void* const kMDeallocBlocksRawKey = "MDeallocBlocks";
}


@implementation NSObject (DeallocBlock)

- (void) pushDeallocBlock: (dispatch_block_t) block
{
	NSMutableArray* deallocBlocks = (NSMutableArray*) [self associatedObjectForRawKey: kMDeallocBlocksRawKey];
	if ( deallocBlocks == nil )
	{
		deallocBlocks = [NSMutableArray new];
		[self setAssociatedObject: deallocBlocks forRawKey: kMDeallocBlocksRawKey];
	}

	MDeallocBlock* deallocBlock = [MDeallocBlock new];
	deallocBlock.block = block;
	[deallocBlocks addObject: deallocBlock];
}

- (dispatch_block_t) popDeallocBlock
{
	NSMutableArray* deallocBlocks = (NSMutableArray*) [self associatedObjectForRawKey: kMDeallocBlocksRawKey];
	if ( deallocBlocks == nil ) return nil;
	if ( deallocBlocks.count == 0 ) return nil;

	dispatch_block_t block = deallocBlocks.lastObject;
	[deallocBlocks removeObject: block];

	return block;
}

- (NSArray*) deallocBlocks
{
	NSArray* deallocBlocks = (NSArray*) [self associatedObjectForRawKey: kMDeallocBlocksRawKey];

	NSMutableArray* blocks = [NSMutableArray new];
	for ( MDeallocBlock* deallocBlock in deallocBlocks )
	{
		[blocks addObject: deallocBlock.block];
	}

	return [blocks copy];
}

@end


@implementation MDeallocBlock

- (void) dealloc
{
	if ( self.block != nil )
	{
		self.block();
	}
}

@end
