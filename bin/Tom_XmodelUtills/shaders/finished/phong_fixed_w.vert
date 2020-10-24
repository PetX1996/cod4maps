// Made by: Tom Crowley (www.tom-bmx.com)
varying vec3 normal,lightDir,halfVector;

void main()
{
	normal = normalize(gl_NormalMatrix * gl_Normal);

	lightDir = normalize(vec3(gl_LightSource[0].position));
	halfVector = normalize(gl_LightSource[0].halfVector.xyz);


	gl_Position = ftransform();
}