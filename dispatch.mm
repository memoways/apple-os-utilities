//
//	author:		fabrice truillot de chambrier
//
//	copyright:	© 2009-2014, men in silicium sàrl
//

#import "OS/dispatch.h"


void dispatch_async_on_main_queue( dispatch_block_t block )
{
	if ( pthread_main_np() != 0 )
	{
		block();
	}
	else
	{
		dispatch_async( dispatch_get_main_queue(), block );
	}
}

void dispatch_sync_on_main_queue( dispatch_block_t block )
{
	if ( pthread_main_np() != 0 )
	{
		block();
	}
	else
	{
		dispatch_sync( dispatch_get_main_queue(), block );
	}
}
