// Made by: Tom Crowley (www.tom-bmx.com)
varying vec3 normal,lightDir,halfVector;

void main()
{
	vec3 n = normalize(normal);	
	vec3 halfV,viewV,ldir;
	float NdotL, NdotHV;
	
	vec4 diffuse = vec4(0.4);
	vec4 color = vec4(0.4,0.4,0.4,1);
	

	NdotL = max(dot(n,lightDir),0.0);
	if (NdotL > 0.0) {
		halfV = normalize(halfVector);
		NdotHV = max(dot(n,halfV),0.0);
		color += vec4(0.3,0.3,0.3,1) * pow(NdotHV,0.7);
		color += diffuse * NdotL;
	}

	gl_FragColor = color;
}
