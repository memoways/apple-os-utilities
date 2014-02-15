//
//	author:		fabrice truillot de chambrier
//
//	copyright:	© 2014-2014, men in silicium sàrl
//

#import "OS/OS.h"

#import <objc/runtime.h>
#import <dispatch/dispatch.h>


@interface MKVOBlock: NSObject


@property ( readwrite, nonatomic, copy ) NSString* uuid;

@property ( readwrite, nonatomic, weak ) id object;
@property ( readwrite, nonatomic, copy ) NSString* keypath;

@property ( readwrite, nonatomic, strong ) dispatch_queue_t queue;
@property ( readwrite, nonatomic, copy ) KVOBlock block;


+ (instancetype) newWithObservee: (id) object keypath: (NSString*) keypath queue: (dispatch_queue_t) queue block: (KVOBlock) block;


@end


namespace
{
	dispatch_queue_t kvo_blocks_queue;
	dispatch_once_t kvo_blocks_queue_once = 0;
}


@implementation NSObject (KVOBlock)

- (id) addObserverForKeyPath: (NSString*) keyPath block: (KVOBlock) block
{
	return [self addObserverForKeyPath: keyPath options: 0 queue: nil block: block];
}

- (id) addObserverForKeyPath: (NSString*) keyPath options: (NSKeyValueObservingOptions) options block: (KVOBlock) block
{
	return [self addObserverForKeyPath: keyPath options: options queue: nil block: block];
}

- (id) addObserverForKeyPath: (NSString*) keyPath options: (NSKeyValueObservingOptions) options queue: (dispatch_queue_t) queue block: (KVOBlock) block
{
	dispatch_once( &kvo_blocks_queue_once, ^ ()
	{
		kvo_blocks_queue = dispatch_queue_create( "com.meninsilicium.KVOBlocks", 0 );
	});

	MKVOBlock* observer = [MKVOBlock newWithObservee: self keypath: keyPath queue: queue block: block];

	dispatch_sync( kvo_blocks_queue, ^ ()
	{
		NSMutableDictionary* observers = [self associatedObjectForRawKey: @selector(addObserverForKeyPath:block:)];
		if ( observers == nil )
		{
			observers = [NSMutableDictionary new];
			[self setAssociatedObject: observers forRawKey: @selector(addObserverForKeyPath:block:)];
		}

		observers[observer.uuid] = observer;

		[self addObserver: observer forKeyPath: keyPath options: options context: @selector(addObserverForKeyPath:block:)];
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
		NSMutableDictionary* observers = [self associatedObjectForRawKey: @selector(addObserverForKeyPath:block:)];
		if ( observers == nil ) return;

		MKVOBlock* observer = observers[uuid];
		if ( observer == nil ) return;

		[observers removeObjectForKey: uuid];
		if ( is_empty( observers ) ) [self removeAssociatedObjectForRawKey: @selector(addObserverForKeyPath:block:)];

		[self removeObserver: observer forKeyPath: observer.keypath context: @selector(addObserverForKeyPath:block:)];
	});
}

- (void) removeBlockObservers
{
	dispatch_once( &kvo_blocks_queue_once, ^ ()
	{
		kvo_blocks_queue = dispatch_queue_create( "com.meninsilicium.KVOBlocks", 0 );
	});

	dispatch_sync( kvo_blocks_queue, ^ ()
	{
		NSMutableDictionary* observers = [self associatedObjectForRawKey: @selector(addObserverForKeyPath:block:)];
		if ( observers == nil ) return;

		[[observers copy] enumerateKeysAndObjectsUsingBlock: ^ ( NSString* uuid, MKVOBlock* observer, BOOL* stop )
		{
			[observers removeObjectForKey: uuid];
			if ( is_empty( observers ) ) [self removeAssociatedObjectForRawKey: @selector(addObserverForKeyPath:block:)];

			[self removeObserver: observer forKeyPath: observer.keypath context: @selector(addObserverForKeyPath:block:)];
		}];
	});
}

@end


@implementation MKVOBlock

+ (instancetype) newWithObservee: (id) object keypath: (NSString*) keypath queue: (dispatch_queue_t) queue block: (KVOBlock) block
{
	return [[self alloc] initWithObservee: object keypath: keypath queue: queue block: block];
}

- (instancetype) init
{
	return nil;
}

- (instancetype) initWithObservee: (id) object keypath: (NSString*) keypath queue: (dispatch_queue_t) queue block: (KVOBlock) block
{
	self = [super init];
	if ( self == nil ) return nil;
	if ( block == nil ) return nil;

	self.uuid = [[NSUUID new].UUIDString lowercaseString];
	self.object = object;
	self.keypath = keypath;
	self.queue = queue;
	self.block = block;

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
		[self.object removeObserver: self forKeyPath: self.keypath context: @selector(addObserverForKeyPath:block:)];
	});
}

- (void) observeValueForKeyPath: (NSString*) keyPath ofObject: (id) object change: (NSDictionary*) change context: (void*) context
{
	if ( self.block == nil ) return;
	NSAssert( [keyPath isEqualToString: self.keypath], @"expecting [keyPath isEqualToString: self.keypath ]" );
	NSAssert( object == self.object, @"expecting object == self.object" );
	NSAssert( context == @selector(addObserverForKeyPath:block:), @"expecting context == @selector(addObserverForKeyPath:block:)" );

	if ( self.queue == nil )
	{
		self.block( self.uuid, self.object, self.keypath, change );
	}
	else
	{
		dispatch_async( self.queue, ^ ()
		{
			self.block( self.uuid, self.object, self.keypath, change );
		});
	}
}

@end
