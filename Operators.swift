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

prefix operator ¬ {}

func not( value: Bool ) -> Bool
{
	return !value
}

func not< T: BooleanType >( value: T ) -> Bool
{
	return !value
}

prefix func ¬( value: Bool ) -> Bool
{
	return !value
}

prefix func ¬< T: BooleanType >( value: T ) -> Bool
{
	return !value
}

// MARK: bit not ¬∘

prefix operator ¬∘ {}

prefix func ¬∘( value: Bool ) -> Bool
{
	return ~value
}

prefix func ¬∘( value: Int ) -> Int
{
	return ~value
}

prefix func ¬∘( value: UInt ) -> UInt
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

infix operator ⋀ {
	associativity left
	precedence 120
}

func and( lhs: Bool, rhs: @autoclosure () -> Bool ) -> Bool
{
	return lhs && rhs()
}

func and( lhs: BooleanType, rhs: @autoclosure () -> BooleanType ) -> Bool
{
	return lhs && rhs()
}

func ⋀( lhs: Bool, rhs: @autoclosure () -> Bool ) -> Bool
{
	return lhs && rhs()
}

func ⋀( lhs: BooleanType, rhs: @autoclosure () -> BooleanType ) -> Bool
{
	return lhs && rhs()
}

// MARK: nand ⊼

infix operator ⊼ {
	associativity left
	precedence 120
}

func nand( lhs: Bool, rhs: @autoclosure () -> Bool ) -> Bool
{
	return !(lhs && rhs())
}

func nand( lhs: BooleanType, rhs: @autoclosure () -> BooleanType ) -> Bool
{
	return !(lhs && rhs())
}

func ⊼( lhs: Bool, rhs: @autoclosure () -> Bool ) -> Bool
{
	return !(lhs && rhs())
}

func ⊼( lhs: BooleanType, rhs: @autoclosure () -> BooleanType ) -> Bool
{
	return !(lhs && rhs())
}

// MARK: - bit and ⋀∘

infix operator ⋀∘ {
	associativity left
	precedence 120
}

func ⋀∘( lhs: Bool, rhs: @autoclosure () -> Bool ) -> Bool
{
	return lhs & rhs()
}

func ⋀∘( lhs: Int, rhs: @autoclosure () -> Int ) -> Int
{
	return lhs & rhs()
}

func ⋀∘( lhs: UInt, rhs: @autoclosure () -> UInt ) -> UInt
{
	return lhs & rhs()
}

// MARK: - or ⋁

infix operator ⋁ {
	associativity left
	precedence 110
}

func or( lhs: Bool, rhs: @autoclosure () -> Bool ) -> Bool
{
	return lhs || rhs()
}

func or( lhs: BooleanType, rhs: @autoclosure () -> BooleanType ) -> Bool
{
	return lhs || rhs()
}

func ⋁( lhs: Bool, rhs: @autoclosure () -> Bool ) -> Bool
{
	return lhs || rhs()
}

func ⋁( lhs: BooleanType, rhs: @autoclosure () -> BooleanType ) -> Bool
{
	return lhs || rhs()
}

// MARK: nor ⊽

infix operator ⊽ {
	associativity left
	precedence 110
}

func nor( lhs: Bool, rhs: @autoclosure () -> Bool ) -> Bool
{
	return !(lhs || rhs())
}

func nor( lhs: BooleanType, rhs: @autoclosure () -> BooleanType ) -> Bool
{
	return !(lhs || rhs())
}

func ⊽( lhs: Bool, rhs: @autoclosure () -> Bool ) -> Bool
{
	return !(lhs || rhs())
}

func ⊽( lhs: BooleanType, rhs: @autoclosure () -> BooleanType ) -> Bool
{
	return !(lhs || rhs())
}

// MARK: - bit or ⋁∘

infix operator ⋁∘ {
	associativity left
	precedence 110
}

func ⋁∘( lhs: Bool, rhs: @autoclosure () -> Bool ) -> Bool
{
	return lhs | rhs()
}

func ⋁∘( lhs: Int, rhs: @autoclosure () -> Int ) -> Int
{
	return lhs | rhs()
}

func ⋁∘( lhs: UInt, rhs: @autoclosure () -> UInt ) -> UInt
{
	return lhs | rhs()
}

// MARK: - xor ⊻

infix operator ⊻ {
	associativity left
	precedence 110
}

func xor( lhs: Bool, rhs: Bool ) -> Bool
{
	return (lhs || rhs) && !(lhs && rhs)
}

func xor( lhs: BooleanType, rhs: BooleanType ) -> Bool
{
	return (lhs || rhs) && !(lhs && rhs)
}

func ⊻( lhs: Bool, rhs: Bool ) -> Bool
{
	return (lhs || rhs) && !(lhs && rhs)
	//return (lhs && !rhs) || (!lhs && rhs)
}

func ⊻( lhs: BooleanType, rhs: BooleanType ) -> Bool
{
	return (lhs || rhs) && !(lhs && rhs)
}

// MARK: - elementOf ∈

infix operator ∈ {
	associativity none
	precedence 130
}

func elementOf< S : SequenceType where S.Generator.Element : Equatable >( value: S.Generator.Element, sequence: S ) -> Bool
{
	return contains( sequence, value )
}

func ∈< S : SequenceType where S.Generator.Element : Equatable >( value: S.Generator.Element, sequence: S ) -> Bool
{
	//return elementOf( value, sequence )
	return contains( sequence, value )
}

// MARK: - exists ∃

prefix operator ∃ {}

func isNil<T>( value: T? ) -> Bool
{
	return (value == nil) || (value is NSNull)
}

func exists<T>( value: T? ) -> Bool
{
	return (value != nil) && !(value is NSNull)
}

prefix func ∃<T>( value: T? ) -> Bool
{
	return value != nil
}

prefix operator ∄ {}

prefix func ∄<T>( value: T? ) -> Bool
{
	return value == nil
}
