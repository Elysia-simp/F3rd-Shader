#define AlphaDiscard //disable if not needed
#define DiffuseMul float3(1.168, 1.168, 1.156)
#define DiffuseAdd float3(0,0,0)
#define RampMul float3(1.00, 1.00, 1.00)
#define RampAdd float3(1.00, 1.00, 1.00)
#define RampFactor 0.15f


#define SpecularMul float3(2.f, 2.f, 2.f)
#define RimMaskMul float3(0.5f, 0.5f, 0.5f)

#include <CommonSettings.config>
#include <Shaders/DivaF_Shader.fxsub>//