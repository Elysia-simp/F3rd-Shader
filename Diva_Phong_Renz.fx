#define CubeMap "F_VITA_MIK153_ENVMAP01.dds"
#define FresnelStrength 0.7125f
#define FresnelPower 5.0f
#define FresnelStrengths float2(6.0f, 1.0f)
#define FresnelStrengths2 float2(3.0f, 1.0f) // i'm seriously running out of fucking names
#define PhongColorAdd float3(0.90, 0.90, 0.90)
#define PhongColorMul float3(0.60, 0.60, 0.60)
#define AlphaInfluence 1.0
#define AlphaInfluenceAdd 0.0f
// vc[0] 0.7125, 0.05, 6.00, 1.00 0 float4
// fc[3] 0.90, 0.90, 0.90, 1.00 48 float4
// fc[4] 0.60, 0.60, 0.60, 1.00 64 float4

// fc[6] 0.7125, 0.05, 6.00, 1.00 96 float4

#include <CommonSettings.config>
#include <shaders/Phong_Renz.fxsub>////