//
//	author:		fabrice truillot de chambrier
//	created:	26.07.2014
//
//	copyright:	© 2014-2014, men in silicium sàrl
//

import Swift


// MARK: unwrap

func unwrap<T>( value: T? ) -> T?
{
	if value != nil {
		return value!
	}

	return nil
}

func unwrap< T1, T2 >( value1: T1?, value2: T2? ) -> (T1, T2)?
{
	if (value1 != nil) && (value2 != nil) {
		return (value1!, value2!)
	}

	return nil
}

func unwrap< T1, T2, T3 >( value1: T1?, value2: T2?, value3: T3? ) -> (T1, T2, T3)?
{
	if (value1 != nil) && (value2 != nil) && (value3 != nil) {
		return (value1!, value2!, value3!)
	}

	return nil
}

func unwrap< T1, T2, T3, T4 >( value1: T1?, value2: T2?, value3: T3?, value4: T4? ) -> (T1, T2, T3, T4)?
{
	if (value1 != nil) && (value2 != nil) && (value3 != nil) && (value4 != nil) {
		return (value1!, value2!, value3!, value4!)
	}

	return nil
}

func unwrap< T1, T2, T3, T4, T5 >( value1: T1?, value2: T2?, value3: T3?, value4: T4?, value5: T5? ) -> (T1, T2, T3, T4, T5)?
{
	if (value1 != nil) && (value2 != nil) && (value3 != nil) && (value4 != nil) && (value5 != nil) {
		return (value1!, value2!, value3!, value4!, value5!)
	}

	return nil
}

// MARK: - isEmpty

func isEmpty<T>( value: T? ) -> Bool
{
	return value == nil
}

func isEmpty( value: String ) -> Bool
{
	return value.isEmpty
}

func isEmpty<V>( value: [V] ) -> Bool
{
	return value.isEmpty
}

func isEmpty< K: Hashable, V >( value: [K:V] ) -> Bool
{
	return value.isEmpty
}

