//
//	author:		fabrice truillot de chambrier
//
//	copyright:	© 2009-2014, men in silicium sàrl
//

#import "OS/dispatch.h"


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

dispatch_queue_t dispatch_queue_create_with_target( const char* label, dispatch_queue_attr_t attr, dispatch_queue_t target_queue )
{
	dispatch_queue_t queue = dispatch_queue_create( label, attr );
	dispatch_set_target_queue( queue, target_queue );

	return queue;
}
