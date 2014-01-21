//
//	author:		fabrice truillot de chambrier
//
//	copyright:	© 2011-2014, men in silicium sàrl
//

#import "OS/NSObject+KVOBlock.h"
#import "OS/NSObject+AssociatedObject.h"

#import <objc/runtime.h>
#import <dispatch/dispatch.h>


@interface MKVOBlock: NSObject


@property ( readwrite, nonatomic, copy ) NSString* uuid;

@property ( readwrite, nonatomic, weak ) id object;
@property ( readwrite, nonatomic, copy ) NSString* keypath;

@property ( readwrite, nonatomic, strong ) dispatch_queue_t queue;
@property ( readwrite, nonatomic, copy ) KVOBlock block;


@end


namespace
{
	const char* const kKVOBlocksRawKey = "com.meninsilicium.KVOBlocks";
	dispatch_queue_t kvo_blocks_queue;
	dispatch_once_t kvo_blocks_queue_once = 0;
}


@implementation NSObject (KVOBlock)

- (id) addObserverForKeyPath: (NSString*) keyPath block: (KVOBlock) block
{
	return [self addObserverForKeyPath: keyPath options: 0 queue: nil block: block];
}

- (id) addObserverForKeyPath: (NSString*) keyPath options: (NSKeyValueObservingOptions) options queue: (dispatch_queue_t) queue block: (KVOBlock) block
{
	dispatch_once( &kvo_blocks_queue_once, ^ ()
	{
		kvo_blocks_queue = dispatch_queue_create( "com.meninsilicium.KVOBlocks", 0 );
	});

	MKVOBlock* observer = [MKVOBlock new];
	observer.object = self;
	observer.keypath = keyPath;
	observer.queue = queue;
	observer.block = block;

	dispatch_sync( kvo_blocks_queue, ^ ()
	{
		NSMutableDictionary* observers = [self associatedObjectForRawKey: kKVOBlocksRawKey];
		if ( observers == nil )
		{
			observers = [NSMutableDictionary new];
			[self setAssociatedObject: observers forRawKey: kKVOBlocksRawKey];
		}

		observers[observer.uuid] = observer;

		[self addObserver: observer forKeyPath: keyPath options: options context: (void*) kKVOBlocksRawKey];
	});

	return observer.uuid;
}

- (void) removeBlockObserver: (id) uuid
{
	dispatch_once( &kvo_blocks_queue_once, ^ ()
	{
		kvo_blocks_queue = dispatch_queue_create( "com.meninsilicium.KVOBlocks", 0 );
	});

	dispatch_sync( kvo_blocks_queue, ^ ()
	{
		NSMutableDictionary* observers = [self associatedObjectForRawKey: kKVOBlocksRawKey];
		if ( observers == nil ) return;

		MKVOBlock* observer = observers[uuid];
		if ( observer == nil ) return;

		[observers removeObjectForKey: uuid];

		[self removeObserver: observer forKeyPath: observer.keypath context: (void*) kKVOBlocksRawKey];
	});
}

@end


@implementation MKVOBlock

- (instancetype) init
{
	self = [super init];
	if ( self == nil ) return nil;

	self.uuid = [[NSUUID new].UUIDString lowercaseString];

	return self;
}

- (void) dealloc
{
	dispatch_once( &kvo_blocks_queue_once, ^ ()
	{
		kvo_blocks_queue = dispatch_queue_create( "com.meninsilicium.KVOBlocks", 0 );
	});

	dispatch_sync( kvo_blocks_queue, ^ ()
	{
		[self.object removeObserver: self forKeyPath: self.keypath context: (void*) kKVOBlocksRawKey];
	});
}

- (void) observeValueForKeyPath: (NSString*) keyPath ofObject: (id) object change: (NSDictionary*) change context: (void*) context
{
	if ( self.block == nil ) return;

	if ( self.queue == nil )
	{
		self.block( self.object, self.keypath, change );
	}
	else
	{
		dispatch_async( self.queue, ^ ()
		{
			self.block( self.object, self.keypath, change );
		});
	}
}

@end
