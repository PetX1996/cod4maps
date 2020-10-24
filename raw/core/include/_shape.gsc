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





// ===================================================================================== //


 Circle_Create(vOrigin, fRadius)
{
	circle = SpawnStruct();
	
	circle.vOrigin = vOrigin;
	circle.fRadius = fRadius;
	
	return circle;
}

 Circle_Draw(vColor, fDuration, iEdges)
{
	if (!IsDefined(iEdges))	iEdges = Max(5, self.fRadius / 10);
	
	fAnglInc = 360 / iEdges;
	for (i = 0; i < iEdges; i++)
	{
		j = (i + 1) % iEdges;
		
		vI = self.vOrigin + AnglesToForward((0,fAnglInc * i,0)) * self.fRadius;
		vJ = self.vOrigin + AnglesToForward((0,fAnglInc * j,0)) * self.fRadius;
		
		DrawLine(vI, vJ, vColor, fDuration);
	}
	
	DrawPivot(self.vOrigin, undefined, undefined, vColor, fDuration);
}

 Circle_GetRandomPoint()
{
	return self.vOrigin + AnglesToForward((0, RandomFloat(360), 0)) * RandomFloat(self.fRadius);
}

 Circle_ContainsPoint(vPoint)
{
	return DistanceSquared(self.vOrigin, vPoint) < (self.fRadius * self.fRadius);
}


// ===================================================================================== //

 RectangleDraw(origin, measurement)
{
core\include\_exception::NotImplemented();
}

 RectangleRandomPoint(origin, measurement)
{
core\include\_exception::NotImplemented();
}

 RectangleContains(origin, measurement, point)
{
core\include\_exception::NotImplemented();
}


 SphereDraw(origin, radius)
{
core\include\_exception::NotImplemented();
}

 SphereRandomPoint(origin, radius)
{
core\include\_exception::NotImplemented();
}

 SphereColliding(origin, radius, ignoreEnt)
{
core\include\_exception::NotImplemented();
}

 SpherePlayerColliding(origin, radius, ignoreEnt)
{
core\include\_exception::NotImplemented();
}

 SphereContains(origin, radius, point)
{
core\include\_exception::NotImplemented();
}


 Cylinder_Create(vOrigin, fRadius, fHeight)
{
	cylinder = SpawnStruct();
	
	cylinder.vOrigin = vOrigin;
	cylinder.fRadius = fRadius;
	cylinder.fHeight = fHeight;
	
	return cylinder;
}

 Cylinder_Draw(vColor, bDrawPivot, fDuration, iEdges)
{
	if (!IsDefined(iEdges))	iEdges = Max(5, self.fRadius / 10);
	
	iEdges = Int(iEdges);
	fAnglInc = 360 / iEdges;
	for (i = 0; i < iEdges; i++)
	{
		j = (i + 1) % iEdges;
		
		vI = self.vOrigin + AnglesToForward((0,fAnglInc * i,0)) * self.fRadius;
		vJ = self.vOrigin + AnglesToForward((0,fAnglInc * j,0)) * self.fRadius;
		
		DrawLine(vI, vJ, vColor, fDuration);
		DrawLine(vI + (0, 0, self.fHeight), vJ + (0, 0, self.fHeight), vColor, fDuration);
		DrawLine(vI, vI + (0, 0, self.fHeight), vColor, fDuration);
	}
	
	if (IsDefined(bDrawPivot) && bDrawPivot)
		DrawPivot(self.vOrigin, undefined, undefined, vColor, fDuration);
}

 CylinderRandomPoint(origin, radius, height)
{
core\include\_exception::NotImplemented();
}

 CylinderColliding(origin, radius, height, ignoreEnt)
{
core\include\_exception::NotImplemented();
}

 CylinderPlayerColliding(origin, radius, height, ignoreEnt)
{
core\include\_exception::NotImplemented();
}

 CylinderContains(origin, radius, height, point)
{
core\include\_exception::NotImplemented();
}

// ===================================================================================== //


 Cuboid_Create(vOrigin, vSize, vAngles, vPivot)
{
	if (!IsDefined(vPivot))
		vPivot = vOrigin;

	cuboid = SpawnStruct();
	
	cuboid.vOrigin = vOrigin;
	cuboid.vSize = vSize;
	cuboid.vAngles = vAngles;
	cuboid.vPivot = vPivot;
	
	cuboid.vBaseOriginDiff = cuboid.vOrigin - cuboid.vPivot;
	cuboid.vertices = cuboid Cuboid_GetVertices();
	
	return cuboid;
}

 Cuboid_GetVertices()
{
	vertices = [];
	vHalfSize = self.vSize * 0.5;
	
	//vFirstOrigin = self.vPivot + ((1, 0, 0) * Distance(self.vOrigin, self.vPivot));
	//vFirstOrigin = RotatePoint(self.vOrigin, self.vAngles * -1, self.vPivot);
	vBaseOrigin = self.vPivot + self.vBaseOriginDiff;
	self.vOrigin = RotatePoint(vBaseOrigin, self.vAngles, self.vPivot);
	
	vBottom = vBaseOrigin - (0, 0, vHalfSize[2]);
	vertices[vertices.size] = vBottom + (-1 * vHalfSize[0], -1 * vHalfSize[1], 0);
	vertices[vertices.size] = vBottom + (vHalfSize[0], -1 * vHalfSize[1], 0);
	vertices[vertices.size] = vBottom + (vHalfSize[0], vHalfSize[1], 0);
	vertices[vertices.size] = vBottom + (-1 * vHalfSize[0], vHalfSize[1], 0);
	
	vTop = vBaseOrigin + (0, 0, vHalfSize[2]);
	vertices[vertices.size] = vTop + (-1 * vHalfSize[0], -1 * vHalfSize[1], 0);
	vertices[vertices.size] = vTop + (vHalfSize[0], -1 * vHalfSize[1], 0);
	vertices[vertices.size] = vTop + (vHalfSize[0], vHalfSize[1], 0);
	vertices[vertices.size] = vTop + (-1 * vHalfSize[0], vHalfSize[1], 0);	
	
	for (i = 0; i < vertices.size; i++)
		vertices[i] = RotatePoint(vertices[i], self.vAngles, self.vPivot);
	
	return vertices;
}

 Cuboid_SetAngles(vAngles)
{
	self.vAngles = vAngles;
	
	self.vertices = self Cuboid_GetVertices();
}

 Cuboid_SetPivot(vPivot)
{
	self.vPivot = vPivot;
	
	self.vBaseOriginDiff = self.vOrigin - self.vPivot;
	//self.vertices = self Cuboid_GetVertices();
}

 Cuboid_SetOrigin(vOrigin)
{
	vDiff = vOrigin - self.vOrigin;
	self.vOrigin = vOrigin;
	self.vPivot += vDiff;
	
	self.vertices = self Cuboid_GetVertices();
}

 Cuboid_SetSize(vSize)
{
	self.vSize = vSize;
	
	self.vertices = self Cuboid_GetVertices();
}

 Cuboid_UpdateVertices()
{
	self.vertices = self Cuboid_GetVertices();
}

 Cuboid_Draw(vColor, bDrawPivot, fDuration)
{
	//vertices = self Cuboid_GetVertices();
	for (i = 0; i < 8; i++)
	{
		if (i < 4)
		{
			j = (i + 1) % 4;
			
			DrawLine(self.vertices[i], self.vertices[i + 4], vColor);
		}
		else
			j = (((i - 4) + 1) % 4) + 4;
			
		DrawLine(self.vertices[i], self.vertices[j], vColor);
	}
	
	if (IsDefined(bDrawPivot) && bDrawPivot)
		DrawPivot(self.vPivot, undefined, self.vAngles, vColor, fDuration);
}

/// <summary>
/// Returns a random point in a cuboid.
/// </summary>
/// <returns>Vector</returns>
 Cuboid_GetRandomPoint()
{
	//vertices = self Cuboid_GetVertices();
	vRight = VectorNormalize(self.vertices[1] - self.vertices[0]);
	vForward = VectorNormalize(self.vertices[3] - self.vertices[0]);
	vUp = VectorNormalize(self.vertices[4] - self.vertices[0]);
	
	vRnd = self.vertices[0] + (vRight * RandomFloat(self.vSize[0]) + vForward * RandomFloat(self.vSize[1]) + vUp * RandomFloat(self.vSize[2]));
	return vRnd;
}

/// <summary>
/// Determine whether a cuboid colliding with the world.
/// </summary>
/// <returns>Bool</returns>
/// <param name="bHitCharacters"></param>
/// <param name="ignoreEnts"></param>
/// <param name="fTestSpaces">Float - distance between test traces</param>
 Cuboid_IsWordCollide(bHitCharacters, ignoreEnts, fTestSpaces)
{
	if (!IsDefined(fTestSpaces))	fTestSpaces = 15;
	
	//vertices = self Cuboid_GetVertices();
	vRight = VectorNormalize(self.vertices[1] - self.vertices[0]);
	vForward = VectorNormalize(self.vertices[3] - self.vertices[0]);
	vUp = VectorNormalize(self.vertices[4] - self.vertices[0]);
	
	// ---------
	// found the shortest edges
	iCur = 0;
	jCur = 1;
	kCur = 2;
	
	vRightCur = vRight;
	vForwardCur = vForward;
	vUpCur = vUp;
	
	vSizeIJ = self.vSize[0] + self.vSize[1];
	vSizeIK = self.vSize[0] + self.vSize[2];
	vSizeJK = self.vSize[1] + self.vSize[2];
	
	if (vSizeIK < vSizeIJ && vSizeIK < vSizeJK)
	{
		iCur = 0;
		jCur = 2;
		kCur = 1;
		
		vRightCur = vRight;
		vForwardCur = vUp;
		vUpCur = vForward;
	}
	else if (vSizeJK < vSizeIJ)
	{
		iCur = 1;
		jCur = 2;
		kCur = 0;
		
		vRightCur = vForward;
		vForwardCur = vUp;
		vUpCur = vRight;
	}
	// -----------
	
	iIMax = Int(self.vSize[iCur] / fTestSpaces) + 1;
	iJMax = Int(self.vSize[jCur] / fTestSpaces) + 1;
	
	fISize = self.vSize[iCur] / iIMax;
	fJSize = self.vSize[jCur] / iJMax;
	
	fICur = undefined;
	fJCur = undefined;
	
	for (i = 0; i < iIMax + 1; i++)
	{
		fICur = fISize * i;
		if (i == iIMax)
			fICur = self.vSize[iCur];
			
		for (j = 0; j < iJMax + 1; j++)
		{
			fJCur = fJSize * j;
			if (j == iJMax)
				fJCur = self.vSize[jCur];
			
			vBottom = self.vertices[0] + (vRightCur * fICur + vForwardCur * fJCur);
			vTop = vBottom + (vUpCur * self.vSize[kCur]);
			
			trace = core\include\_physic::BulletTraceMultipleEnts(vBottom, vTop, bHitCharacters, ignoreEnts);
			if (IsDefined(trace) && trace["fraction"] != 1)
			{
				//ISHAPE::DrawLine(vBottom, vTop, (1,0,0));
				return true;
			}
		}
	}
	
	return false;
}

/// <summary>
/// Determines whether a point is in a cuboid.
/// </summary>
/// <returns>Bool</returns>
/// <param name="vPoint">A Point</param>
 Cuboid_ContainsPoint(vPoint)
{
	// ray-crossing algorithm
	intersects = self Cuboid_GetLineIntersects(vPoint, vPoint + (1, 0, 0) * 999999);
	return intersects.size % 2 == 1;
}

 Cuboid_IsLineIntersect(vStart, vEnd)
{
	//vertices = self Cuboid_GetVertices();
	faceVertices = undefined;
	for (i = 0; i < 6; i++)
	{
		if (i < 4)
			{ faceVertices[0] = self.vertices[i]; faceVertices[1] = self.vertices[(i + 1) % 4]; faceVertices[2] = self.vertices[((i + 1) % 4) + 4]; faceVertices[3] = self.vertices[i + 4]; } // sides
		else if (i == 4)
			{ faceVertices[0] = self.vertices[0]; faceVertices[1] = self.vertices[1]; faceVertices[2] = self.vertices[2]; faceVertices[3] = self.vertices[3]; } // bottom
		else if (i == 5)
			{ faceVertices[0] = self.vertices[4]; faceVertices[1] = self.vertices[5]; faceVertices[2] = self.vertices[6]; faceVertices[3] = self.vertices[7]; } // top
			
		vIntersect = self Cuboid_GetLineFaceIntersect(vStart, vEnd, faceVertices);
		if (IsDefined(vIntersect))
			return true;
	}
	
	return false;
}

/// <summary>
/// Returns array of intersects.
/// </summary>
/// <returns>Vertices[]</returns>
/// <param name="vStart">Start point of the Line</param>
/// <param name="vEnd">End point of the Line</param>
 Cuboid_GetLineIntersects(vStart, vEnd)
{
	//vertices = self Cuboid_GetVertices();
	faceVertices = undefined;
	intersects = [];
	for (i = 0; i < 6; i++)
	{
		if (i < 4)
			{ faceVertices[0] = self.vertices[i]; faceVertices[1] = self.vertices[(i + 1) % 4]; faceVertices[2] = self.vertices[((i + 1) % 4) + 4]; faceVertices[3] = self.vertices[i + 4]; } // sides
		else if (i == 4)
			{ faceVertices[0] = self.vertices[0]; faceVertices[1] = self.vertices[1]; faceVertices[2] = self.vertices[2]; faceVertices[3] = self.vertices[3]; } // bottom
		else if (i == 5)
			{ faceVertices[0] = self.vertices[4]; faceVertices[1] = self.vertices[5]; faceVertices[2] = self.vertices[6]; faceVertices[3] = self.vertices[7]; } // top
			
		vIntersect = self Cuboid_GetLineFaceIntersect(vStart, vEnd, faceVertices);
		if (IsDefined(vIntersect))
			intersects[intersects.size] = vIntersect;
	}
	
	return intersects;
}

 Cuboid_GetLineFaceIntersect(vStart, vEnd, vertices)
{
	vFaceA = vertices[0];
	vFaceB = vertices[1];
	vFaceC = vertices[2];
	
	vPlaneNormal = core\include\_math::VectorCross(vFaceA - vFaceB, vFaceC - vFaceB);
	
	vIntersect = GetLinePlaneIntersect(vStart, vEnd, vFaceB, VectorNormalize(vPlaneNormal));
	if (IsDefined(vIntersect))
	{
		for (i = 0; i < 4; i++)
		{
			vA = vertices[i];
			vB = vertices[(i + 1) % 4];
			
			// all vertices are on same plane...
			fDot = VectorDot(vB - vA, vIntersect - vA);
			// vIntersect have to be on the right side of each cuboid edge -> vIntersect is on the cuboid face
			if (fDot <= 0)
				return undefined;
		}
	}
	
	return vIntersect;
}


// ===================================================================================== //

/// <summary>
/// Returns a Point where a Line intersects a Plane.
/// </summary>
/// <returns>Undefined if there is no intersection or intersecting everywhere(parallel)</returns>
/// <param name="vStart">Start point of the Line</param>
/// <param name="vEnd">End point of the Line</param>
/// <param name="vPlanePoint">Any point on the Plane</param>
/// <param name="vPlaneNormal">Unit normal vector to the Plane</param>
 GetLinePlaneIntersect(vStart, vEnd, vPlanePoint, vPlaneNormal)
{
	vLineDir = VectorNormalize(vEnd - vStart);
	
	denominator = VectorDot(vLineDir, vPlaneNormal);
	numerator = VectorDot(vPlanePoint - vStart, vPlaneNormal);
	
	// line is parallel to the plane
	// -> no intersection or intersecting everywhere...
	if (denominator == 0) // ehm...it will may be a very small number....
		return undefined;
	
	dist = (numerator / denominator);
	// intersect is too far...
	if (dist < 0 || dist >= Distance(vStart, vEnd))
		return undefined;
		
	return vStart + vLineDir * dist;
}

 RotatePoint(vPoint, vAngles, vPivot)
{
	//a = vAngles[0];
	//b = vAngles[2];
	//c = vAngles[1];
	if (!IsDefined(vPivot)) vPivot = (0, 0, 0);
	vTemp = vPoint - vPivot;

	// clear but non-optimized way
	/*
	xAxisRotation = {	{1, 0, 0}, 
						{0, Cos(b), Sin(b)},
						{0, -1 * Sin(b), Cos(b)} };
	
	yAxisRotation = {	{Cos(a), 0, -1 * Sin(a)}, 
						{0, 1, 0},
						{Sin(a), 0, Cos(a)} };

	zAxisRotation = {	{Cos(c), Sin(c), 0}, 
						{-1 * Sin(c), Cos(c), 0},
						{0, 0, 1} };						
	
	rotation = MultiplyMatrices(MultiplyMatrices(xAxisRotation, yAxisRotation), zAxisRotation);
	
	pos = { {vTemp[0], vTemp[1], vTemp[2]} };

	vNewPos = MultiplyMatrices(pos, rotation);
	vNewPos = (vNewPos[0][0], vNewPos[0][1], vNewPos[0][2]);
	*/
	
	// optimized
	sA = Sin(vAngles[0]);
	sB = Sin(vAngles[2]);
	sC = Sin(vAngles[1]);
	cA = Cos(vAngles[0]);
	cB = Cos(vAngles[2]);
	cC = Cos(vAngles[1]);
	
	cBsC = cB * sC;
	sBsC = sB * sC;
	cBcC = cB * cC;
	
	vNewX = vTemp[0] * (cA * cC) + vTemp[1] * (sB * sA * cC - cBsC) + vTemp[2] * (cBcC * sA + sBsC);
	vNewY = vTemp[0] * (cA * sC) + vTemp[1] * (sBsC * sA + cBcC) + vTemp[2] * (cBsC * sA - sB * cC);
	vNewZ = vTemp[0] * (-1 * sA) + vTemp[1] * (sB * cA) + vTemp[2] * (cB * cA);
	
	vNewPos = (vNewX, vNewY, vNewZ);
	
	return vPivot + vNewPos;
}

// ===================================================================================== //


 DrawLine(vStart, vEnd, vColor, fDuration)
{
	if (!IsDefined(vColor)) vColor = (1, 1, 1);
	if (!IsDefined(fDuration)) 
		fDuration = 0.05;
	else
	{
		thread DrawLineDelayed(vStart, vEnd, vColor, fDuration);
		return;
	}

	//iFrames = Int(fDuration / 0.05);
	//for (i = 0; i < iFrames; i++)
	//{
	//iprintln("vStart: " + vStart + " vEnd: " + vEnd + " f: " + iFrames);
		/#
		Line(vStart, vEnd, vColor, false, 1);
		#/
		//wait 0.05;
	//}
}

 DrawLineDelayed(vStart, vEnd, vColor, fDuration)
{
	iFrames = Int(fDuration / 0.05);
	for (i = 0; i < iFrames; i++)
	{
	//iprintln("vStart: " + vStart + " vEnd: " + vEnd + " f: " + iFrames);
		/#
		Line(vStart, vEnd, vColor, false, 1);
		#/
		wait 0.05;
	}
}



 DrawPivot(vOrigin, fAxesLength, vAngles, vColor, fDuration)
{
	if (!IsDefined(fAxesLength))	fAxesLength = 10;
	if (!IsDefined(vAngles))		vAngles = (0, 0, 0);
	if (!IsDefined(vColor))			vColor = (0, 0, 0);
	
	core\include\_shape::DrawLine(vOrigin, vOrigin + AnglesToForward(vAngles) * (fAxesLength * 2), BlendColors((1, 0, 0), vColor), fDuration);
	core\include\_shape::DrawLine(vOrigin, vOrigin + AnglesToRight(vAngles) * fAxesLength, BlendColors((0, 1, 0), vColor), fDuration);
	core\include\_shape::DrawLine(vOrigin, vOrigin + AnglesToUp(vAngles) * fAxesLength, BlendColors((0, 0, 1), vColor), fDuration);
}

 DrawPoint(vOrigin, vColor, fDuration)
{
	core\include\_shape::DrawLine(vOrigin, vOrigin + (1, 1, 1), vColor, fDuration);
}


 DrawText(vOrigin, sText, vColor, fAlpha, fScale, fDuration)
{
	if (!IsDefined(vColor))		vColor = (1, 1, 1);
	if (!IsDefined(fAlpha))		fAlpha = 1;
	if (!IsDefined(fScale))		fScale = 0.5;
	if (!IsDefined(fDuration))	fDuration = 0.05;
	/#
	iFrames = Int(fDuration / 0.05);
	Print3D(vOrigin, sText, vColor, fAlpha, fScale, iFrames);
	#/
}

 BlendColors(vA, vB)
{
	return VectorNormalize(vA + vB);
}


// ===================================================================================== //