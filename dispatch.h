//
//	author:		fabrice truillot de chambrier
//
//	copyright:	© 2009-2013, men in silicium sàrl
//

#import <dispatch/dispatch.h>


DISPATCH_EXPORT DISPATCH_NONNULL_ALL
void dispatch_async_on_main_queue( dispatch_block_t block );

DISPATCH_INLINE DISPATCH_NONNULL_ALL DISPATCH_NOTHROW
void dispatch_async_on_global_queue( dispatch_block_t block )
{
	dispatch_async( dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_DEFAULT, 0 ), block );
}

DISPATCH_EXPORT DISPATCH_NONNULL_ALL
void dispatch_sync_on_main_queue( dispatch_block_t block );
