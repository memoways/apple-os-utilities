//
//	author:		fabrice truillot de chambrier
//	created:	05.08.2014
//
//	copyright:	© 2014-2014, men in silicium sàrl
//

import Swift


// MARK: public protocol Resultable

public protocol Resultable
{
	var succeeded: Bool { get }
	var failed: Bool { get }

	var error: NSError? { get }
}

// MARK: public enum Result

public enum Result : Resultable
{
	// MARK: cases

	case Success
	case Failure( NSError )

	// MARK: initialization

	public init() {
		self = .Success
	}

	public init( error: NSError ) {
		self = .Failure( error )
	}

	// MARK: convenience

	public var succeeded: Bool
	{
		switch self {
			case .Success:
				return true

			case .Failure:
				return false
		}
	}

	public var value: Any? {
		return nil
	}

	public var failed: Bool
	{
		switch self {
			case .Success:
				return false

			case .Failure:
				return true
		}
	}

	public var error: NSError?
	{
		switch self {
			case .Success:
				return nil

			case .Failure( let error ):
				return error
		}
	}

	public func asa() -> NSError? {
		return self.error
	}

}

// MARK: public enum ResultOf< T >

public enum ResultOf< T > : Resultable
{
	// MARK: cases

	case Success( BoxedValue< T > )
	case Failure( NSError )

	// MARK: initialization

	public init( value: T ) {
		self = .Success( BoxedValue( value ) )
	}

	public init( error: NSError ) {
		self = .Failure( error )
	}

	// MARK: convenience

	public var succeeded: Bool
	{
		switch self {
			case .Success:
				return true

			case .Failure:
				return false
		}
	}

	var value: T?
	{
		switch self {
			case .Success( let box ):
				return box.value

			case .Failure:
				return nil
		}
	}

	public func asa() -> T? {
		return self.value
	}

	public var failed: Bool
	{
		switch self {
			case .Success:
				return false

			case .Failure:
				return true
		}
	}

	public var error: NSError?
	{
		switch self {
			case .Success:
				return nil

			case .Failure( let error ):
				return error
		}
	}

	public func asa() -> NSError? {
		return self.error
	}

}

// FIXME: workaround for a compiler crashing bug
public class BoxedValue<T>
{
	public let value: T

	public init( _ value: T ) {
		self.value = value
	}
}
