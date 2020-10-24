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

// supports undefined 

 IsEqual(secondList)
{
	if (!IsDefined(secondList))
		return false;
	else if (self.iCount != secondList.iCount)
		return false;
	else
	{
		for (i = 0; i < secondList.iCount; i++)
		{
			if (!core\include\_type::IsEqual(self Get(i), secondList Get(i)))
				return false;
		}
	}
	
	return true;
}

 Create(iCount)
{
	if (!IsDefined(iCount)) iCount = 0;
	
	list = SpawnStruct();
	list.iCount = iCount;
	list.Elems = [];
	
	return list;
}

 CreateCopy()
{
	list = Create(self.iCount);
	list.iCount = self.iCount;
	list.Elems = self.Elems;
	
	return list;
}

 Get(iIndex)
{
	core\include\_exception::OutOfRange(self.iCount, iIndex);

	return self.Elems[iIndex];
}

 Set(iIndex, elem)
{
	core\include\_exception::OutOfRange(self.iCount, iIndex);

	self.Elems[iIndex] = elem;
}

 Add(elem)
{
	self.Elems[self.iCount] = elem;
	self.iCount++;
}

 AddRange(array, iCount)
{
	if (!IsDefined(iCount)) iCount = array.size;
	for (i = 0; i < iCount; i++)
		self.Elems[self.iCount + i] = array[i];
		
	self.iCount += iCount;
}

 AddList(list)
{
	for (i = 0; i < list.iCount; i++)
		self.Elems[self.iCount + i] = list.Elems[i];
		
	self.iCount += list.iCount;
}

 ToArray()
{
	a = [];
	for (i = 0; i < self.iCount; i++)
		a[a.size] = self.Elems[i];
		
	return a;
}

 IndexOf(elem, iStartIndex, iLength)
{
	core\include\_exception::Undefined(elem, "elem");
	
	if (self.iCount == 0)
		return -1;
	
	if (!IsDefined(iStartIndex))	iStartIndex = 0;
	if (!IsDefined(iLength))		iLength = self.iCount - iStartIndex;

	endIndex = iStartIndex + iLength - 1;
	core\include\_exception::OutOfRange(self.iCount, iStartIndex, "iStartIndex");
	core\include\_exception::OutOfRange(self.iCount, endIndex, "iLength");
	
	for (i = iStartIndex; i <= endIndex; i++)
		if (IsDefined(self.Elems[i]) && self.Elems[i] == elem)
			return i;

	return -1;
}

 LastIndexOf(elem, iStartIndex, iLength)
{
	core\include\_exception::Undefined(elem, "elem");

	if (self.iCount == 0)
		return -1;
	
	if (!IsDefined(iStartIndex))	iStartIndex = self.iCount - 1;
	if (!IsDefined(iLength))		iLength = iStartIndex + 1;

	endIndex = iStartIndex - iLength + 1;
	core\include\_exception::OutOfRange(self.iCount, iStartIndex, "iStartIndex");
	core\include\_exception::OutOfRange(self.iCount, endIndex, "iLength");
	
	for (i = iStartIndex; i >= endIndex; i--)
		if (IsDefined(self.Elems[i]) && self.Elems[i] == elem)
			return i;

	return -1;
}

 Contains(elem, iStartIndex, iLength)
{
	core\include\_exception::Undefined(elem, "elem");
	
	return self IndexOf(elem, iStartIndex, iLength) != -1;
}

 GetRange(iStartIndex, iLength)
{
	core\include\_exception::Undefined(iStartIndex, "iStartIndex");	

	if (!IsDefined(iLength) && self.iCount == 0)
		return [];
	
	if (!IsDefined(iLength))	iLength = self.iCount - iStartIndex;

	endIndex = iStartIndex + iLength - 1;
	core\include\_exception::OutOfRange(self.iCount, iStartIndex, "iStartIndex");
	core\include\_exception::OutOfRange(self.iCount, endIndex, "iLength");
	
	newArray = [];
	for (i = iStartIndex; i <= endIndex; i++)
		newArray[newArray.size] = self.Elems[i];
		
	return newArray;
}

 GetList(iStartIndex, iLength)
{
	core\include\_exception::Undefined(iStartIndex, "iStartIndex");	

	newList = Create();
	
	if (!IsDefined(iLength) && self.iCount == 0)
		return newList;
	
	if (!IsDefined(iLength))	iLength = self.iCount - iStartIndex;

	endIndex = iStartIndex + iLength - 1;
	core\include\_exception::OutOfRange(self.iCount, iStartIndex, "iStartIndex");
	core\include\_exception::OutOfRange(self.iCount, endIndex, "iLength");
	
	for (i = iStartIndex; i <= endIndex; i++)
		newList Add(self.Elems[i]);
		
	return newList;
}

 Insert(iIndex, elem)
{
	core\include\_exception::Undefined(iIndex, "iIndex");
	if (iIndex < 0 || (self.iCount > 0 && iIndex >= self.iCount))
		core\include\_exception::OutOfRangeMsg("iIndex");
	
	for (i = self.iCount; i > iIndex; i--)
		self.Elems[i] = self.Elems[i - 1];
	
	self.Elems[iIndex] = elem;
	self.iCount++;
}

 InsertRange(iIndex, array)
{
	core\include\_exception::Undefined(iIndex, "iIndex");
	if (iIndex < 0 || (self.iCount > 0 && iIndex >= self.iCount))
		core\include\_exception::OutOfRangeMsg("iIndex");
		
	core\include\_exception::Undefined(array, "array");
	
	for (i = self.iCount + array.size - 1; i >= (iIndex + array.size); i--)
		self.Elems[i] = self.Elems[i - array.size];
		
	for (i = 0; i < array.size; i++)
		self.Elems[iIndex + i] = array[i];
		
	self.iCount += array.size;
}

 InsertList(iIndex, list)
{
	core\include\_exception::Undefined(iIndex, "iIndex");
	if (iIndex < 0 || (self.iCount > 0 && iIndex >= self.iCount))
		core\include\_exception::OutOfRangeMsg("iIndex");
		
	core\include\_exception::Undefined(list, "list");
	
	for (i = self.iCount + list.iCount - 1; i >= (iIndex + list.iCount); i--)
		self.Elems[i] = self.Elems[i - list.iCount];
		
	for (i = 0; i < list.iCount; i++)
		self.Elems[iIndex + i] = list.Elems[i];
		
	self.iCount += list.iCount;
}

 Remove(elem)
{
	core\include\_exception::Undefined(elem, "elem");

	iIndex = IndexOf(elem);
	if (iIndex == -1)
		return;
	
	return self RemoveAt(iIndex);
}

 RemoveAt(iIndex)
{
	core\include\_exception::Undefined(iIndex, "iIndex");
	core\include\_exception::OutOfRange(self.iCount, iIndex, "iIndex");
	
	for (i = iIndex; i < self.iCount; i++)
		self.Elems[i] = self.Elems[i + 1]; // last index will be array.size - 1 -> value will be undefined(out of range)
		
	self.iCount--;
}

 RemoveRange(iIndex, iLength)
{
	core\include\_exception::Undefined(iIndex, "iIndex");
	core\include\_exception::OutOfRange(self.iCount, iIndex, "iIndex");
	
	if (!IsDefined(iLength)) iLength = self.iCount - iIndex;
	
	core\include\_exception::OutOfRange(self.iCount, iIndex + iLength - 1, "iLength");
	
	for (i = iIndex; i < self.iCount; i++)
		self.Elems[i] = self.Elems[i + iLength];
		
	self.iCount -= iLength;
}

 Distinct()
{
	for (i = 0; i < self.iCount; i++)
	{
		for (j = i + 1; j < self.iCount; j++)
		{
			if ((!IsDefined(self.Elems[j]) && !IsDefined(self.Elems[i])) 
				|| (IsDefined(self.Elems[j]) && IsDefined(self.Elems[i]) && self.Elems[j] == self.Elems[i]))
			{
				self RemoveAt(j);
				j--; // elements in the self has moved
			}
		}
	}
}

 Intersect(array)
{
	core\include\_exception::Undefined(array, "array");
	
	newArray = [];
	for (i = 0; i < array.size; i++)
		if (self Contains(array[i]))
			newArray[newArray.size] = array[i];
			
	return newArray;
}

 Union(array)
{
	core\include\_exception::Undefined(array, "array");

	newArray = self ToArray();
	startCount = self.iCount;
	for (i = 0; i < array.size; i++)
		if (!self Contains(array[i], 0, startCount))
			newArray[newArray.size] = array[i];
			
	return newArray;
}

 SetForAll(value, iStartIndex, iLength)
{
	if (self.iCount == 0)
		return;
	
	if (!IsDefined(iStartIndex)) iStartIndex = 0;
	if (!IsDefined(iLength)) iLength = self.iCount - iStartIndex;
	
	lastIndex = iLength - iStartIndex - 1;
	core\include\_exception::OutOfRange(self.iCount, iStartIndex, "iStartIndex");
	core\include\_exception::OutOfRange(self.iCount, lastIndex, "iLength");
	
	for (i = iStartIndex; i <= lastIndex; i++)
		self.Elems[i] = value;
}