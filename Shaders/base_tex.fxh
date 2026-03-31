#define merge_strings(a,b) a##b 


texture diffuseTexture : MATERIALTEXTURE <>;
sampler diffuseSampler = sampler_state {texture = < diffuseTexture >; ADDRESSU = WRAP; ADDRESSV = WRAP;};

texture SpecularTexture : MATERIALSPHEREMAP<>;
sampler SpecularSampler = sampler_state 
{texture = < SpecularTexture >; ADDRESSU = WRAP; ADDRESSV = WRAP;};

texture RampTexture : MATERIALTOONTEXTURE<>;
sampler RampSampler = sampler_state 
{texture = < RampTexture >; ADDRESSU = CLAMP; ADDRESSV = CLAMP;};