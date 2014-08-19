//
//	author:		fabrice truillot de chambrier
//	created:	25.07.2014
//
//	copyright:	© 2014-2014, men in silicium sàrl
//

import Swift


// Documentation: http://www.unicode.org/charts/
// Documentation: http://www.unicode.org/charts/PDF/U2200.pdf

// MARK: not ¬

func not( value: Bool ) -> Bool
{
	return !value
}

func not< T: BooleanType >( value: T ) -> Bool
{
	return !value
}

prefix operator ¬ {}

prefix func ¬( value: Bool ) -> Bool
{
	return !value
}

prefix func ¬< T: BooleanType >( value: T ) -> Bool
{
	return !value
}

// MARK: bit not ¬•

func bitnot( value: Bool ) -> Bool
{
	return ~value
}

func bitnot( value: Int ) -> Int
{
	return ~value
}

func bitnot( value: UInt ) -> UInt
{
	return ~value
}

prefix operator ¬• {}

prefix func ¬•( value: Bool ) -> Bool
{
	return ~value
}

prefix func ¬•( value: Int ) -> Int
{
	return ~value
}

prefix func ¬•( value: UInt ) -> UInt
{
	return ~value
}

// MARK: complement ∁

prefix operator ∁ {}

prefix func ∁( value: Bool ) -> Bool
{
	return ~value
}

prefix func ∁( value: Int ) -> Int
{
	return ~value
}

prefix func ∁( value: UInt ) -> UInt
{
	return ~value
}

// MARK: - and ⋀

func and( lhs: Bool, rhs: @autoclosure () -> Bool ) -> Bool
{
	return lhs && rhs
}

func and< L: BooleanType >( lhs: L, rhs: @autoclosure () -> Bool ) -> Bool
{
	return lhs && rhs
}

func and< L: BooleanType, R: BooleanType >( lhs: L, rhs: @autoclosure () -> R ) -> Bool
{
	return lhs && rhs
}

infix operator ⋀ {
	associativity left
	precedence 120
}

func ⋀( lhs: Bool, rhs: @autoclosure () -> Bool ) -> Bool
{
	return lhs && rhs
}

func ⋀< L: BooleanType >( lhs: L, rhs: @autoclosure () -> Bool ) -> Bool
{
	return lhs && rhs
}

func ⋀< L: BooleanType, R: BooleanType >( lhs: L, rhs: @autoclosure () -> R ) -> Bool
{
	return lhs && rhs
}

// MARK: nand ⊼

func nand( lhs: Bool, rhs: @autoclosure () -> Bool ) -> Bool
{
	return !(lhs && rhs)
}

func nand< L: BooleanType >( lhs: L, rhs: @autoclosure () -> Bool ) -> Bool
{
	return !(lhs && rhs)
}

func nand< L: BooleanType, R: BooleanType >( lhs: L, rhs: @autoclosure () -> R ) -> Bool
{
	return !(lhs && rhs)
}

infix operator ⊼ {
	associativity left
	precedence 120
}

func ⊼( lhs: Bool, rhs: @autoclosure () -> Bool ) -> Bool
{
	return !(lhs && rhs)
}

func ⊼< L: BooleanType, R: BooleanType >( lhs: L, rhs: @autoclosure () -> R ) -> Bool
{
	return !(lhs && rhs)
}

// MARK: - bit and ⋀•

infix operator ⋀• {
	associativity left
	precedence 120
}

func ⋀•( lhs: Bool, rhs: Bool ) -> Bool
{
	return lhs & rhs
}

func ⋀•( lhs: Int, rhs: Int ) -> Int
{
	return lhs & rhs
}

func ⋀•( lhs: UInt, rhs: UInt ) -> UInt
{
	return lhs & rhs
}

// MARK: - or ⋁

func or( lhs: Bool, rhs: @autoclosure () -> Bool ) -> Bool
{
	return lhs || rhs
}

func or< L: BooleanType, R: BooleanType >( lhs: L, rhs: @autoclosure () -> R ) -> Bool
{
	return lhs || rhs
}

infix operator ⋁ {
	associativity left
	precedence 110
}

func ⋁( lhs: Bool, rhs: @autoclosure () -> Bool ) -> Bool
{
	return lhs || rhs
}

func ⋁< L: BooleanType, R: BooleanType >( lhs: L, rhs: @autoclosure () -> R ) -> Bool
{
	return lhs || rhs
}

// MARK: nor ⊽

func nor( lhs: Bool, rhs: @autoclosure () -> Bool ) -> Bool
{
	return !(lhs || rhs)
}

func nor< L: BooleanType, R: BooleanType >( lhs: L, rhs: @autoclosure () -> R ) -> Bool
{
	return !(lhs || rhs)
}

infix operator ⊽ {
	associativity left
	precedence 110
}

func ⊽( lhs: Bool, rhs: @autoclosure () -> Bool ) -> Bool
{
	return !(lhs || rhs)
}

func ⊽< L: BooleanType >( lhs: L, rhs: @autoclosure () -> Bool ) -> Bool
{
	return !(lhs || rhs)
}

func ⊽< L: BooleanType, R: BooleanType >( lhs: L, rhs: @autoclosure () -> R ) -> Bool
{
	return !(lhs || rhs)
}

// MARK: - bit or ⋁•

infix operator ⋁• {
	associativity left
	precedence 110
}

func ⋁•( lhs: Bool, rhs: Bool ) -> Bool
{
	return lhs | rhs
}

func ⋁•( lhs: Int, rhs: Int ) -> Int
{
	return lhs | rhs
}

func ⋁•( lhs: UInt, rhs: UInt ) -> UInt
{
	return lhs | rhs
}

// MARK: - xor ^^ ⊻

func xor( lhs: Bool, rhs: Bool ) -> Bool
{
	return (lhs || rhs) && !(lhs && rhs)
	//return (lhs && !rhs) || (!lhs && rhs)
}

func xor< L: BooleanType, R: BooleanType >( lhs: L, rhs: @autoclosure () -> R ) -> Bool
{
	return (lhs || rhs) && !(lhs && rhs)
}

infix operator ^^ {
	associativity left
	precedence 110
}

func ^^( lhs: Bool, rhs: Bool ) -> Bool
{
	return (lhs || rhs) && !(lhs && rhs)
}

func ^^< L: BooleanType, R: BooleanType >( lhs: L, rhs: @autoclosure () -> R ) -> Bool
{
	return (lhs || rhs) && !(lhs && rhs)
}

infix operator ⊻ {
	associativity left
	precedence 110
}

func ⊻( lhs: Bool, rhs: Bool ) -> Bool
{
	return (lhs || rhs) && !(lhs && rhs)
}

func ⊻< L: BooleanType, R: BooleanType >( lhs: L, rhs: @autoclosure () -> R ) -> Bool
{
	return (lhs || rhs) && !(lhs && rhs)
}

// MARK: - elementOf ∈

func elementOf< S : SequenceType where S.Generator.Element : Equatable >( value: S.Generator.Element, sequence: S ) -> Bool
{
	return contains( sequence, value )
}

infix operator ∈ {
	associativity none
	precedence 130
}

func ∈< S : SequenceType where S.Generator.Element : Equatable >( value: S.Generator.Element, sequence: S ) -> Bool
{
	//return elementOf( value, sequence )
	return contains( sequence, value )
}

// MARK: - exists ∃

func exists< T >( value: T? ) -> Bool
{
	return (value != nil) && !(value is NSNull)
}

func isNil< T >( value: T? ) -> Bool
{
	return (value == nil) || (value is NSNull)
}

func isNull< T >( value: T? ) -> Bool
{
	return (value == nil) || (value is NSNull)
}

prefix operator ∃ {}

prefix func ∃< T >( value: T? ) -> Bool
{
	return value != nil
}

prefix operator ∄ {}

prefix func ∄< T >( value: T? ) -> Bool
{
	return value == nil
}

// MARK: - bind <*>

func bind< T, R >( lhs: (T) -> R, rhs: T? ) -> R?
{
	if let letRhs = rhs {
		return lhs( letRhs )
	}
	else {
		return nil
	}
}

func bind< T, R >( lhs: (T) -> R, rhs: T ) -> R
{
	return lhs( rhs )
}

infix operator  <*> {
	associativity left
	precedence 150
}

func <*>< T, R >( lhs: (T) -> R, rhs: T? ) -> R?
{
	if let letRhs = rhs {
		return lhs( letRhs )
	}
	else {
		return nil
	}
}

func <*>< T, R >( lhs: (T) -> R, rhs: T ) -> R
{
	return lhs( rhs )
}

// MARK: - apply >>* (>>= in Haskell, but already defined in Swift)

func apply< T, R >( lhs: T?, rhs: (T) -> R? ) -> R?
{
	if let letLhs = lhs {
		return rhs( letLhs )
	}
	else {
		return nil
	}
}

func apply< T, R >( lhs: T, rhs: (T) -> R ) -> R
{
	return rhs( lhs )
}

infix operator  >>* {
	associativity left
	precedence 150
}

func >>*< T, R >( lhs: T?, rhs: (T) -> R? ) -> R?
{
	if let letLhs = lhs {
		return rhs( letLhs )
	}
	else {
		return nil
	}
}

func >>*< T, R >( lhs: T, rhs: (T) -> R ) -> R
{
	return rhs( lhs )
}
