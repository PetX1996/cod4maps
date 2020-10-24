//I========================================================================I
//I                    ___  _____  _____                                   I
//I                   /   !!  __ \!  ___!                                  I
//I                  / /! !! !  \/! !_          ___  ____                  I
//I                 / /_! !! ! __ !  _!        / __!!_  /                  I
//I                 \___  !! !_\ \! !      _  ! (__  / /                   I
//I                     !_/ \____/\_!     (_)  \___!/___!                  I
//I                                                                        I
//I========================================================================I
// Call of Duty 4: Modern Warfare
//I========================================================================I
// Mod      : Core
// Website  : http://www.4gf.cz/
//I========================================================================I
// Script by: PetX
//I========================================================================I

#include core\include\_usings;

 IsEqual(firstArray, secondArray)
{
	if (!IsDefined(firstArray) && !IsDefined(secondArray))
		return true;
	else if (IsDefined(firstArray) && !IsDefined(secondArray))
		return false;
	else if (!IsDefined(firstArray) && IsDefined(secondArray))
		return false;
	else if (firstArray.size != secondArray.size)
		return false;
	else
	{
		for (i = 0; i < firstArray.size; i++)
		{
			if (firstArray[i] != secondArray[i])
				return false;
		}
	}
	
	return true;
}

/// <summary>
/// Creates a copy of the array.
/// </summary>
/// <returns>T[]</returns>
/// <param name="array">T[]</param>
 ToArray(array)
{
	return array;
}

/// <summary>
/// Gets index of first occurence in the zero-based array.
/// </summary>
/// <returns>Int</returns>
/// <param name="array">T[] - Can be empty</param>
/// <param name="element">T</param>
/// <param name="startIndex">Int - Default is zero</param>
/// <param name="length">Int - Default is length of the array</param>
 IndexOf(array, element, startIndex, length)
{
	core\include\_exception::Undefined(array, "array");
	core\include\_exception::Undefined(element, "element");
	
	if (array.size == 0)
		return -1;
	
	if (!IsDefined(startIndex))	startIndex = 0;
	if (!IsDefined(length))	length = array.size - startIndex;

	endIndex = startIndex + length - 1;
	core\include\_exception::OutOfRange(array.size, startIndex, "startIndex");
	core\include\_exception::OutOfRange(array.size, endIndex, "length");
	
	for (i = startIndex; i <= endIndex; i++)
		if (array[i] == element)
			return i;

	return -1;
}

/// <summary>
/// Gets index of last occurence in the zero-based array.
/// </summary>
/// <returns>Int</returns>
/// <param name="array">T[] - Can be empty</param>
/// <param name="element">T</param>
/// <param name="startIndex">Int - Default is size of the array - 1</param>
/// <param name="length">Int - Default is length of the array</param>
 LastIndexOf(array, element, startIndex, length)
{
	core\include\_exception::Undefined(array, "array");
	core\include\_exception::Undefined(element, "element");

	if (array.size == 0)
		return -1;
	
	if (!IsDefined(startIndex))	startIndex = array.size - 1;
	if (!IsDefined(length))	length = startIndex + 1;

	endIndex = startIndex - length + 1;
	core\include\_exception::OutOfRange(array.size, startIndex, "startIndex");
	core\include\_exception::OutOfRange(array.size, endIndex, "length");
	
	for (i = startIndex; i >= endIndex; i--)
		if (array[i] == element)
			return i;

	return -1;
}

/// <summary>
/// Reverses elements in the array.
/// </summary>
/// <returns>T[]</returns>
/// <param name="array">T[] - Can be empty</param>
/// <param name="startIndex">Int - Default is zero</param>
/// <param name="length">Int - Default is length of the array</param>
 Reverse(array, startIndex, length)
{
	core\include\_exception::Undefined(array, "array");
	
	if (array.size == 0)
		return array;
	
	if (!IsDefined(startIndex))	startIndex = 0;
	if (!IsDefined(length))	length = array.size - startIndex;
	
	core\include\_exception::OutOfRange(array.size, startIndex, "startIndex");
	core\include\_exception::OutOfRange(array.size, startIndex + length - 1, "length");	
	
	count = Int(length * 0.5);
	for (i = 0; i < count; i++)
	{
		firstIndex = startIndex + i;
		secondIndex = startIndex + (length - i - 1);

		firstValue = array[firstIndex];
		array[firstIndex] = array[secondIndex];
		array[secondIndex] = firstValue;
	}
	
	return array;
}

/// <summary>
/// Adds an element to the end of an array.
/// </summary>
/// <returns>T[]</returns>
/// <param name="array">T[]</param>
/// <param name="element">T</param>
 Add(array, element)
{
	core\include\_exception::Undefined(array, "array");
	core\include\_exception::Undefined(element, "element");

	array[array.size] = element;
	return array;
}

/// <summary>
/// Adds an array of an elements to end of the array.
/// </summary>
/// <returns>T[]</returns>
/// <param name="array">T[]</param>
/// <param name="elementsArray">T[]</param>
 AddRange(array, elementsArray)
{
	core\include\_exception::Undefined(array, "array");
	core\include\_exception::Undefined(elementsArray, "elementsArray");

	for (i = 0; i < elementsArray.size; i++)
		array[array.size] = elementsArray[i];
		
	return array;
}

/// <summary>
/// Determines whether an element is in the array.
/// </summary>
/// <returns>Bool</returns>
/// <param name="array">T[]</param>
/// <param name="element">T</param>
/// <param name="startIndex">Int - Default is zero</param>
/// <param name="length">Int - Default is length of the array</param>
 Contains(array, element, startIndex, length)
{
	core\include\_exception::Undefined(array, "array");
	core\include\_exception::Undefined(element, "element");
	
	return IndexOf(array, element, startIndex, length) != -1;
}

/// <summary>
/// Gets a range of elements in the array.
/// </summary>
/// <returns>T[]</returns>
/// <param name="array">T[]</param>
/// <param name="startIndex">Int</param>
/// <param name="length">Int</param>
 GetRange(array, startIndex, length)
{
	core\include\_exception::Undefined(array, "array");
	core\include\_exception::Undefined(startIndex, "startIndex");	

	if (array.size == 0)
		return array;
	
	if (!IsDefined(length))	length = array.size - startIndex;

	endIndex = startIndex + length - 1;
	core\include\_exception::OutOfRange(array.size, startIndex, "startIndex");
	core\include\_exception::OutOfRange(array.size, endIndex, "length");
	
	newArray = [];
	for (i = startIndex; i <= endIndex; i++)
		newArray[newArray.size] = array[i];
		
	return newArray;
}

/// <summary>
/// Inserts an element to the specified index in the array.
/// </summary>
/// <returns>T[]</returns>
/// <param name="array">T[]</param>
/// <param name="index">Int</param>
/// <param name="element">T</param>
 Insert(array, index, element)
{
	core\include\_exception::Undefined(array, "array");
	core\include\_exception::EmptyArray(array.size, "array");
	core\include\_exception::Undefined(index, "index");
	core\include\_exception::OutOfRange(array.size, index, "index");
	core\include\_exception::Undefined(element, "element");
	
	for (i = array.size - 1; i >= index; i--)
		array[i + 1] = array[i];
	
	array[index] = element;
	return array;
}

/// <summary>
/// Inserts a range of elements to the specified index in the array.
/// </summary>
/// <returns>T[]</returns>
/// <param name="array">T[]</param>
/// <param name="index">Int</param>
/// <param name="elementsRange">T[]</param>
 InsertRange(array, index, elementsRange)
{
	core\include\_exception::Undefined(array, "array");
	core\include\_exception::EmptyArray(array.size, "array");
	core\include\_exception::Undefined(index, "index");
	core\include\_exception::OutOfRange(array.size, index, "index");
	core\include\_exception::Undefined(elementsRange, "elementsRange");
	core\include\_exception::EmptyArray(elementsRange.size, "elementsRange");
	
	for (i = array.size - 1; i >= index; i--)
		array[i + elementsRange.size] = array[i];
		
	for (i = 0; i < elementsRange.size; i++)
		array[index + i] = elementsRange[i];
		
	return array;
}

/// <summary>
/// Removes an element from the array.
/// </summary>
/// <returns>T[]</returns>
/// <param name="array">T[]</param>
/// <param name="element">T</param>
 Remove(array, element, bEmptyThrow, bDontContainsThrow)
{
	core\include\_exception::Undefined(array, "array");
	//IEXCEPTION::Undefined(element, "element");

	if (!IsDefined(bDontContainsThrow)) bDontContainsThrow = false;
	if (!IsDefined(bEmptyThrow)) bEmptyThrow = false;
	
	if (bEmptyThrow)
		core\include\_exception::EmptyArray(array.size, "array");
	else if (array.size == 0)
		return array;
	
	iIndex = -1;
	if (IsDefined(element))
		iIndex = IndexOf(array, element);
	else
		iIndex = IndexOfUndefined(array);
	
	if (bDontContainsThrow && iIndex == -1)
		core\include\_exception::ArgumentMsg("element");
	else if (iIndex == -1)
		return array;
	
	return RemoveAt(array, iIndex);
}

 IndexOfUndefined(array, iStartIndex, iLength, iUndefinedCount)
{
	if (!IsDefined(iUndefinedCount)) 	iUndefinedCount = 1;
	if (!IsDefined(iStartIndex)) 		iStartIndex = 0;
	if (!IsDefined(iLength)) 			iLength = (array.size + iUndefinedCount) - iStartIndex;
	
	iEndIndex = iStartIndex + iLength;
	
	core\include\_exception::OutOfRange((array.size + iUndefinedCount), iStartIndex, "iStartIndex");
	core\include\_exception::OutOfRange((array.size + iUndefinedCount), (iEndIndex - 1), "iEndIndex");
	
	for (i = iStartIndex; i < iEndIndex; i++)
	{
		if (!IsDefined(array[i]))
			return i;
	}
	
	return -1;
}

/// <summary>
/// Removes an element at the given position from the array.
/// </summary>
/// <returns>T[]</returns>
/// <param name="array">T[]</param>
/// <param name="index">Int</param>
 RemoveAt(array, index)
{
	core\include\_exception::Undefined(array, "array");
	core\include\_exception::EmptyArray(array.size, "array");
	core\include\_exception::Undefined(index, "index");
	core\include\_exception::OutOfRange(array.size, index, "index");
	
	for (i = index; i < array.size; i++)
		array[i] = array[i + 1]; // last index will be array.size - 1 -> value will be undefined(out of range)
		
	return array;
}

/// <summary>
/// Removes a range of elements at the given position from the array.
/// </summary>
/// <returns>T[]</returns>
/// <param name="array">T[]</param>
/// <param name="index">Int</param>
/// <param name="length">Int</param>
 RemoveRange(array, index, length)
{
	core\include\_exception::Undefined(array, "array");
	core\include\_exception::EmptyArray(array.size, "array");
	core\include\_exception::Undefined(index, "index");
	core\include\_exception::OutOfRange(array.size, index, "index");
	
	if (!IsDefined(length)) length = array.size - index;
	
	core\include\_exception::OutOfRange(array.size, index + length - 1, "length");
	
	arraySize = array.size;
	for (i = index; i < arraySize; i++)
		array[i] = array[i + length];
		
	return array;
}

/// <summary>
/// Removes same elements in the array.
/// </summary>
/// <returns>T[]</returns>
/// <param name="array">T[]</param>
 Distinct(array)
{
	core\include\_exception::Undefined(array, "array");
	
	for (i = 0; i < array.size; i++)
	{
		for (j = i + 1; j < array.size; j++)
		{
			if (array[j] == array[i])
			{
				array = RemoveAt(array, j);
				j--; // elements in the array will move
			}
		}
	}
	return array;
}

/// <summary>
/// Returns the intersect from two arrays.
/// </summary>
/// <returns>T[]</returns>
/// <param name="array">T[]</param>
/// <param name="secondArray">T[]</param>
 Intersect(array, secondArray)
{
	core\include\_exception::Undefined(array, "array");
	core\include\_exception::Undefined(secondArray, "secondArray");

	newArray = [];

	for (i = 0; i < array.size; i++)
		if (Contains(secondArray, array[i]))
			newArray[newArray.size] = array[i];
			
	return newArray;
}

/// <summary>
/// Returns the union from two arrays.
/// </summary>
/// <returns>T[]</returns>
/// <param name="array">T[]</param>
/// <param name="secondArray">T[]</param>
 Union(array, secondArray)
{
	core\include\_exception::Undefined(array, "array");
	core\include\_exception::Undefined(secondArray, "secondArray");

	startLength = array.size;
	for (i = 0; i < secondArray.size; i++)
		if (!Contains(array, secondArray[i], 0, startLength))
			array[array.size] = secondArray[i];
			
	return array;
}

/// <summary>
/// Sets same value for each element in the array.
/// </summary>
/// <returns>T[]</returns>
/// <param name="array">T[]</param>
/// <param name="value">T</param>
/// <param name="startIndex">Int</param>
/// <param name="length">Int</param>
 SetForAll(array, value, startIndex, length)
{
	core\include\_exception::Undefined(array, "array");
	core\include\_exception::Undefined(value, "value");
	
	if (array.size == 0)
		return array;
	
	if (!IsDefined(startIndex)) startIndex = 0;
	if (!IsDefined(length)) length = array.size - startIndex;
	
	lastIndex = length - startIndex - 1;
	core\include\_exception::OutOfRange(array.size, startIndex, "startIndex");
	core\include\_exception::OutOfRange(array.size, lastIndex, "length");
	
	for (i = startIndex; i <= lastIndex; i++)
		array[i] = value;
		
	return array;
}

 Sort(array, startIndex, length, compareFunc)
{
	core\include\_exception::NotImplemented();
}

 Cast(array, castFunc)
{
	core\include\_exception::NotImplemented();
}

 Sum(array)
{
	core\include\_exception::NotImplemented();
}

 Average(array)
{
	core\include\_exception::NotImplemented();
}

 MaxValue(array)
{
	core\include\_exception::NotImplemented();
}

 MinValue(array)
{
	core\include\_exception::NotImplemented();
}

 Except(array, exceptArray)
{
	core\include\_exception::NotImplemented();
}

/// <summary>
/// Returns first element in the array.
/// Throws an exception if the array is empty.
/// </summary>
/// <returns>T</returns>
/// <param name="array">T[]</param>
 First(array)
{
	core\include\_exception::EmptyArray(array.size, "array");
	
	return array[0];
}

/// <summary>
/// Returns first element in the array.
/// Returns defaultValue if the array is empty.
/// </summary>
/// <returns>T</returns>
/// <param name="array">T[]</param>
/// <param name="defaultValue">T</param>
 FirstOrDefault(array, defaultValue)
{
	if (array.size == 0)
		return defaultValue;
	
	return array[0];
}

 Last(array)
{
	core\include\_exception::NotImplemented();
}

 LastOrDefault(array, defaultValue)
{
	core\include\_exception::NotImplemented();
}

 Single(array)
{
	core\include\_exception::NotImplemented();
}

 SingleOrDefault(array, defaultValue)
{
	core\include\_exception::NotImplemented();
}

/*
ARRAY_Combine( firstArray, secondArray )
{
	for( i = 0; i < secondArray.size; i++ )
		firstArray[firstArray.size] = secondArray[i];
	
	return firstArray;
}

AddToArray( array, value )
{
	array[array.size] = value;
}

DeleteFromArray( array, current )
{
	size = array.size;
	for( i = 0;i < size;i++ )
	{
		if( array[i] == current )
		{
			for( a = i;a < size;a++ )
			{
				if( a == size-1 )
				{
					array[a] = undefined;
					return array;
				}
				
				array[a] = array[a+1];
			}
		}
	}
	return array;
}

IsInArray( array, value )
{
	keys = GetArrayKeys( array );
	for( i = 0;i < keys.size;i++ )
	{
		current = array[keys[i]];
		if( isString( current ) && isString( value ) && current == value )
			return true;
		else if( isPlayer( current ) && isPlayer( value ) && current == value )
			return true;
		else if( !isString( current ) && !isString( value ) && current == value )
			return true;
	}
	return false;
}

GetArrayKeyByValue( array, value )
{
	keys = GetArrayKeys( array );
	for(i = 0;i < keys.size;i++)
	{
		if( array[keys[i]] == value )
			return keys[i];
	}
	return undefined;
}

ARRAY_ReWrite( sourceArray, newArray )
{
	keys = GetArrayKeys( newArray );
	for( k = 0; k < keys.size; k++ )
		sourceArray[keys[k]] = newArray[keys[k]];
		
	return sourceArray;
}

ARRAY_Add( array, item )
{
	array[array.size] = item;
	return array;
}
ARRAY_AddRange( array, items )
{
	for( i = 0; i < items.size; i++ )
		array[array.size] = items[i];
	
	return array;
}
ARRAY_Insert( array, item, index )
{
	oldArray = array;
	array[index] = item;
	for( i = index; i < oldArray.size; i++ )
		array[i+1] = oldArray[i];
		
	return array;
}
ARRAY_InsertRange( array, items, index )
{
	oldArray = array;
	for( i = 0; i < items.size; i++ )
		array[index+i] = items[i];
		
	for( i = index; i < oldArray.size; i++ )
		array[i+items.size] = oldArray[i];
		
	return array;
}
ARRAY_Remove( array, item )
{
	for( i = 0; i < array.size; i++ )
	{
		if( array[i] == item )
		{
			for( j = i; j < array.size - 1; j++ )
				array[j] = array[j+1];
				
			array[j] = undefined;
			break;
		}
	}
	return array;
}
ARRAY_RemoveRange( array, items )
{
	newArray = [];
	for( i = 0; i < array.size; i++ )
	{
		if( ARRAY_Contains( items, array[i] ) )
			continue;
			
		newArray[newArray.size] = array[i];
	}
	return newArray;
}
ARRAY_RemoveAt( array, index )
{
	for( i = index; i < array.size - 1; i++ )
		array[i] = array[i+1];

	array[i] = undefined;
	return array;
}
ARRAY_Contains( array, item )
{
	for( i = 0; i < array.size; i++ )
	{
		if( array[i] == item )
			return true;
	}
	return false;
}
ARRAY_IndexOf( array, item, startIndex )
{
	if( !IsDefined( startIndex ) )
		startIndex = 0;
		
	for( i = startIndex; i < array.size; i++ )
	{
		if( array[i] == item )
			return i;
	}
	return -1;
}		*/	