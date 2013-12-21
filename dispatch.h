//
//	author:		fabrice truillot de chambrier
//
//	copyright:	© 2009-2013, men in silicium sàrl
//

#import <dispatch/dispatch.h>


DISPATCH_EXPORT DISPATCH_NONNULL_ALL
void dispatch_async_on_main_queue( dispatch_block_t block );

DISPATCH_EXPORT DISPATCH_NONNULL_ALL
void dispatch_sync_on_main_queue( dispatch_block_t block );
