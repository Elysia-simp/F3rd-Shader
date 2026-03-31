#define merge_strings(a,b) a##b 


texture diffuseTexture : MATERIALTEXTURE <>;
sampler diffuseSampler = sampler_state {texture = < diffuseTexture >; ADDRESSU = WRAP; ADDRESSV = WRAP;};

texture CubeTexture : TEXTURE<
string ResourceName = merge_strings("Textures/Cubemap/", CubeMap);
string ResourceType = "Cube";
>;
samplerCUBE CubeSampler = sampler_state 
{
	TEXTURE = <CubeTexture>;
	MinFilter = LINEAR;
    MagFilter = LINEAR;
    MipFilter = LINEAR;
    AddressU = Clamp;
    AddressV = Clamp;
    AddressW = Clamp;
};
