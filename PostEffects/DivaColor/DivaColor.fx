#define TEXFORMAT "A8R8G8B8"

float3 AcsPos : CONTROLOBJECT < string name = "(self)"; >;
float3 AcsRot : CONTROLOBJECT < string name = "(self)"; string item = "Rx"; >;
float AcsTr   : CONTROLOBJECT < string name = "(self)"; string item = "Tr"; >;


float Script : STANDARDSGLOBAL <
	string ScriptOutput = "color";
	string ScriptClass = "scene";
	string ScriptOrder = "postprocess";
> = 0.8;
float time_elapsed : TIME;
#define FILTER_MODE	MinFilter = POINT; MagFilter = POINT; MipFilter = NONE;
#define ADDRESSING_MODE	AddressU = BORDER; AddressV = BORDER; BorderColor = float4(0,0,0,0);

float4 ClearColor = {0.0, 0.0, 0.0, 0};
float ClearDepth  = 1.0;

float2 ViewportSize : VIEWPORTPIXELSIZE;
static float2 ViewportOffset = (float2(0.5, 0.5) / ViewportSize.xy);

texture2D ScnMap : RENDERCOLORTARGET <
	bool AntiAlias = true;
	float2 ViewportRatio = {4.0, 4.0};
	int MipLevels = 1;
	string Format = TEXFORMAT;

>;

sampler2D ScnSamp = sampler_state {
	texture = <ScnMap>;
	// FILTER_MODE
	// ADDRESSING_MODE
 	ADDRESSU = Clamp; ADDRESSV = Clamp;    
	MinFilter = Anisotropic;
    MagFilter = Anisotropic;
    MipFilter = Anisotropic;
};
sampler2D ScnSamp2 = sampler_state {
	texture = <ScnMap>;
	// FILTER_MODE
	// ADDRESSING_MODE
 	ADDRESSU = Clamp; ADDRESSV = Clamp;    
	MinFilter = Anisotropic;
    MagFilter = Anisotropic;
    MipFilter = Anisotropic;
	SRGBTexture = true;
};

texture2D DepthBuffer : RENDERDEPTHSTENCILTARGET <
	float2 ViewportRatio = {1, 1};
	string Format = "D24S8";
>;

struct VS_INPUT {
	float4 Pos : POSITION;
	float4 uv  : TEXCOORD0;
};

struct VS_OUTPUT {
	float4 Pos      : POSITION;
	float2 TexCoord : TEXCOORD0;
	float4 WPos	: TEXCOORD1;	
};



VS_OUTPUT VS_Color(VS_INPUT i)
{
	VS_OUTPUT Out;
	Out.Pos = i.Pos;
	Out.TexCoord = i.uv.xy + ViewportOffset.xy;
	Out.WPos = i.Pos;
	return Out;
}
float4 _builtin_divsq(float4 a, float b) // from rpcs3
{
	float4 tmp = a / sqrt(b);
	float4 choice = abs(a);
	return lerp(a, tmp, choice > 0);
}


float brightness = 0;

float4 PS_Color(VS_OUTPUT i) : COLOR
{
    // Sample textures
    float4 tex0 = pow(tex2D(ScnSamp2, i.TexCoord.xy), 2.2);
    float4 tex1 = tex2D(ScnSamp, i.TexCoord.xy);
    
    // Apply brightness blend
    float4 result;
    result.x = saturate(tex0.x * brightness + tex1.x);
    result.y = saturate(tex0.y * brightness + tex1.y);
    result.z = saturate(tex0.z * brightness + tex1.z);
    
    // Normalize using division by square root
    result.x = saturate(_builtin_divsq(abs(result.x), result.x));
    result.y = saturate(_builtin_divsq(abs(result.y), result.y));
    result.z = saturate(_builtin_divsq(abs(result.z), result.z));
    
    // Apply color scaling
    result.xyz = saturate(result.xyz * 0.8501);
    
    // Calculate luminance
    // float luminance = dot(result.xyz, float3(0.30005, 0.58984, 0.10999));
    
    // Output with alpha set to luminance
    return float4(result.xyz, tex1.w);
}

technique ColorTech <
	string Script = 
		"RenderColorTarget0=ScnMap;"
		"RenderDepthStencilTarget=DepthBuffer;"
		"ClearSetColor=ClearColor;"
		"ClearSetDepth=ClearDepth;"
		"Clear=Color;"
		"Clear=Depth;"
		"ScriptExternal=Color;"
		"RenderColorTarget0=;"
		"RenderDepthStencilTarget=;"
		"Pass=FinalPass;";
> {
	pass FinalPass < string Script= "Draw=Buffer;"; > {
		AlphaBlendEnable = FALSE;
		AlphaTestEnable = FALSE;
		VertexShader = compile vs_3_0 VS_Color();
		PixelShader  = compile ps_3_0 PS_Color();
	}
}
