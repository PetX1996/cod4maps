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

 Pow(num, e)
{
	if(e == 0)
		return 1;

	result = 1;
	while (e != 0)
	{
		if (e > 0)
		{
			result *= num;
			e--;
		}
		else
		{
			result /= num;
			e++;
		}
	}
	return result;
}

 DictanceZ(vecA, vecB)
{
	return Abs(vecA[2] - vecB[2]);
}

 AnglesToPositive(vAngles)
{
	for (i = 0; i < 3; i++)
		AngleToPositive(vAngles[i]);

	return vAngles;
}

 AngleToPositive(iAngle)
{
	if (iAngle < 0)
		iAngle = 360 + iAngle;

	return iAngle;
}

SQRT()
{
	core\include\_exception::NotImplemented();
}

 Round(num, iDecimalPos)
{
	core\include\_exception::NotImplemented("Fuck it!");

	// TODO: try to fix it...
	// Am I idiot or COD cannot work with float numbers?!

	// 47|6|887.14654 (iDecimalPos = -3) 	-> 477000
	// 476|8|87.14654 (iDecimalPos = -2) 	-> 476900
	// 4768|8|7.14654 (iDecimalPos = -1) 	-> 476890
	// 47688|7|.14654 (iDecimalPos = 0) 	-> 476887
	// 476887.|1|4654 (iDecimalPos = 1) 	-> 476887.1
	// 476887.1|4|654 (iDecimalPos = 2) 	-> 476887.15
	// 476887.14|6|54 (iDecimalPos = 3) 	-> 476887.147
	
	// 476887.1|4|654 -> iDec = 100
	// 476887.1|4|654 * iDec -> iRest = Int(4768871|4|.654) -> 4768871|4|
	// 476887.1|4|654 * iDec * 10 -> iMarginal = Int(4768871|4|6.54 - (iRest(4768871|4|) * 10)) -> 6
	// 6 is higher than 5 -> iRest += 1 -> iRest = 4768871|5|
	// iRest / iDec -> iRest = 476887.1|5|
	
	// 476|8|87.14654 -> iDec = 100
	// 476|8|87.14654 / iDec -> iRest = Int(476|8|.8714654) -> 476|8|
	// 476|8|87.14654 / iDec * 10 -> iMarginal = Int(476|8|8.714654 - (iRest(476|8|) * 10)) -> 8
	// 8 is higher than 5 -> iRest += 1 -> iRest = 476|9|
	// iRest * iDec -> iRest = 476|9|00
	
	// 47688|7|.14654 -> iDec = 1
	// 47688|7|.14654 * iDec -> iRest = Int(47688|7|.14654) -> 47688|7|
	// 47688|7|.14654 * iDec * 10 -> iMarginal = Int(47688|7|1.4654 - (iRest(47688|7|) * 10)) -> 1
	// 1 is lower than 5 -> iRest += 0 -> iRest = 47688|7|
	// iRest / iDec -> iRest = 47688|7|
	
	iDec = GetRoundDec(Int(Abs(iDecimalPos)));
	iRest = undefined;
	if (iDecimalPos >= 0)
		iRest = Int(num * iDec);
	else
		iRest = Int(num / iDec);
	
	iprintln("iDec" + iDec);
	iprintln("iRest" + iRest);
	iprintln("num * iDec" + num * iDec);
	iprintln("Int(num * iDec)" + Int(num * iDec));
	
	iMarginal = undefined;
	if (iDecimalPos >= 0)
		iMarginal = num * iDec;
	else
		iMarginal = num / iDec;

	iMarginal = Int((iMarginal * 10) - (iRest * 10));
	if (iMarginal >= 5)
		iRest += 1;
		
	if (iDecimalPos >= 0)
		return iRest / iDec;
	
	return iRest * iDec;
}

 GetRoundDec(iDecimalPos)
{
	switch (iDecimalPos)
	{
		case 0:
			return 1;
		case 1:
			return 10;
		case 2:
			return 100;
		case 3:
			return 1000;
		case 4:
			return 10000;
		case 5:
			return 100000;
		case 6:
			return 1000000;
		case 7:
			return 10000000;
		case 8:
			return 100000000;
		case 9:
			return 1000000000;		
		default:
			return Pow(10, iDecimalPos);
	}	
}

/// <summary>
/// Returns a vector which is perpendicular to vA and vB.
/// </summary>
/// <returns></returns>
/// <param name="vA"></param>
/// <param name="vB"></param>
 VectorCross(vA, vB)
{
	return (vA[1] * vB[2] - vA[2] * vB[1], 
			vA[2] * vB[0] - vA[0] * vB[2],
			vA[0] * vB[1] - vA[1] * vB[0]);
}

 MultiplyMatrices(mA, mB)
{
	core\include\_exception::Argument(mA[0].size == mB.size);

	matrix = [];
	for (iMARow = 0; iMARow < mA.size; iMARow++)
	{
		for (iMBColumn = 0; iMBColumn < mB[0].size; iMBColumn++)
		{
			value = 0;
			for (iCur = 0; iCur < mB.size; iCur++)
			{
				a = mA[iMARow][iCur];
				b = mB[iCur][iMBColumn];
				
				value += a * b;
			}
			
			matrix[iMARow][iMBColumn] = value;
		}
	}
	return matrix;
}

 PrintMatrix(m)
{
	iprintln("matrix " + m.size + "x" + m[0].size);
	for (i = 0; i < m.size; i++)
	{
		line = "{";
		
		for (j = 0; j < m[i].size; j++)
		{
			line += " " + m[i][j];
			if (j == m[i].size - 1)
				line += " ";
			else
				line += ",";
		}
		
		line += "}";
		iprintln(line);
	}
}