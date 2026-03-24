#define AlphaDiscard
#define DiffuseMul float3(1.192, 1.172, 1.148)
#define Light_Values float4(0.35, 6.66667, 0.50, 1.00)
#define DiffuseColor float4(0, 0, 0, 1.00)
#define DiffuseRampConst 0.5f
#define DiffuseAdd float3(0.f, 0.f, 0.f)


#define SpecularMul 2.00f
#define RimMaskMul 0.5f

#include <CommonSettings.config>
#include <shaders/base_shader.fxsub>////