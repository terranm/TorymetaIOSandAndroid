#include "pch-cpp.hpp"

#ifndef _MSC_VER
# include <alloca.h>
#else
# include <malloc.h>
#endif


#include <limits>
#include <stdint.h>


template <typename T1>
struct VirtualActionInvoker1
{
	typedef void (*Action)(void*, T1, const RuntimeMethod*);

	static inline void Invoke (Il2CppMethodSlot slot, RuntimeObject* obj, T1 p1)
	{
		const VirtualInvokeData& invokeData = il2cpp_codegen_get_virtual_invoke_data(slot, obj);
		((Action)invokeData.methodPtr)(obj, p1, invokeData.method);
	}
};
template <typename R>
struct VirtualFuncInvoker0
{
	typedef R (*Func)(void*, const RuntimeMethod*);

	static inline R Invoke (Il2CppMethodSlot slot, RuntimeObject* obj)
	{
		const VirtualInvokeData& invokeData = il2cpp_codegen_get_virtual_invoke_data(slot, obj);
		return ((Func)invokeData.methodPtr)(obj, invokeData.method);
	}
};
template <typename R>
struct GenericVirtualFuncInvoker0
{
	typedef R (*Func)(void*, const RuntimeMethod*);

	static inline R Invoke (const RuntimeMethod* method, RuntimeObject* obj)
	{
		VirtualInvokeData invokeData;
		il2cpp_codegen_get_generic_virtual_invoke_data(method, obj, &invokeData);
		return ((Func)invokeData.methodPtr)(obj, invokeData.method);
	}
};
struct InterfaceActionInvoker0
{
	typedef void (*Action)(void*, const RuntimeMethod*);

	static inline void Invoke (Il2CppMethodSlot slot, RuntimeClass* declaringInterface, RuntimeObject* obj)
	{
		const VirtualInvokeData& invokeData = il2cpp_codegen_get_interface_invoke_data(slot, obj, declaringInterface);
		((Action)invokeData.methodPtr)(obj, invokeData.method);
	}
};
template <typename T1, typename T2>
struct InterfaceActionInvoker2
{
	typedef void (*Action)(void*, T1, T2, const RuntimeMethod*);

	static inline void Invoke (Il2CppMethodSlot slot, RuntimeClass* declaringInterface, RuntimeObject* obj, T1 p1, T2 p2)
	{
		const VirtualInvokeData& invokeData = il2cpp_codegen_get_interface_invoke_data(slot, obj, declaringInterface);
		((Action)invokeData.methodPtr)(obj, p1, p2, invokeData.method);
	}
};
template <typename R>
struct InterfaceFuncInvoker0
{
	typedef R (*Func)(void*, const RuntimeMethod*);

	static inline R Invoke (Il2CppMethodSlot slot, RuntimeClass* declaringInterface, RuntimeObject* obj)
	{
		const VirtualInvokeData& invokeData = il2cpp_codegen_get_interface_invoke_data(slot, obj, declaringInterface);
		return ((Func)invokeData.methodPtr)(obj, invokeData.method);
	}
};
template <typename R, typename T1>
struct InterfaceFuncInvoker1
{
	typedef R (*Func)(void*, T1, const RuntimeMethod*);

	static inline R Invoke (Il2CppMethodSlot slot, RuntimeClass* declaringInterface, RuntimeObject* obj, T1 p1)
	{
		const VirtualInvokeData& invokeData = il2cpp_codegen_get_interface_invoke_data(slot, obj, declaringInterface);
		return ((Func)invokeData.methodPtr)(obj, p1, invokeData.method);
	}
};
template <typename R>
struct GenericInterfaceFuncInvoker0
{
	typedef R (*Func)(void*, const RuntimeMethod*);

	static inline R Invoke (const RuntimeMethod* method, RuntimeObject* obj)
	{
		VirtualInvokeData invokeData;
		il2cpp_codegen_get_generic_interface_invoke_data(method, obj, &invokeData);
		return ((Func)invokeData.methodPtr)(obj, invokeData.method);
	}
};
template <typename R, typename T1>
struct InvokerFuncInvoker1;
template <typename R, typename T1>
struct InvokerFuncInvoker1<R, T1*>
{
	static inline R Invoke (Il2CppMethodPointer methodPtr, const RuntimeMethod* method, void* obj, T1* p1)
	{
		R ret;
		void* params[1] = { p1 };
		method->invoker_method(methodPtr, method, obj, params, &ret);
		return ret;
	}
};
template <typename R, typename T1, typename T2>
struct InvokerFuncInvoker2;
template <typename R, typename T1, typename T2>
struct InvokerFuncInvoker2<R, T1*, T2*>
{
	static inline R Invoke (Il2CppMethodPointer methodPtr, const RuntimeMethod* method, void* obj, T1* p1, T2* p2)
	{
		R ret;
		void* params[2] = { p1, p2 };
		method->invoker_method(methodPtr, method, obj, params, &ret);
		return ret;
	}
};

// System.Collections.Generic.Dictionary`2<System.Int32,System.Collections.Generic.IDictionary`2<System.Int32,System.Int32[]>>
struct Dictionary_2_t403ABC2FA2D9740F9ADD28DB8815C00EE2DB4249;
// System.Collections.Generic.Dictionary`2<System.Int32,System.Int32[]>
struct Dictionary_2_t029F6A37F043A1B571A7DB746955ECB8DC548AD9;
// System.Collections.Generic.Dictionary`2<System.Int32,System.Globalization.CultureInfo>
struct Dictionary_2_t9FA6D82CAFC18769F7515BB51D1C56DAE09381C3;
// System.Collections.Generic.Dictionary`2<System.Int32,System.Object>
struct Dictionary_2_tA75D1125AC9BE8F005BA9B868B373398E643C907;
// System.Collections.Generic.Dictionary`2<System.String,System.Globalization.CultureInfo>
struct Dictionary_2_tE1603CE612C16451D1E56FF4D4859D4FE4087C28;
// System.Collections.Generic.IDictionary`2<System.Int32,System.Collections.Generic.IDictionary`2<System.Int32,System.Int32[]>>
struct IDictionary_2_t9503DE0744217071D554CC415B2890C454070024;
// System.Collections.Generic.IDictionary`2<System.String,Agora.Rtc.LitJson.JsonData>
struct IDictionary_2_t71799C6CC5257548A5D3BF2E120E449FB1B2DBA9;
// System.Collections.Generic.IDictionary`2<System.Type,System.Collections.Generic.IDictionary`2<System.Type,Agora.Rtc.LitJson.ImporterFunc>>
struct IDictionary_2_t4CBC3A47DE74E6CEE1992EFF7341CFC45D8B4B56;
// System.Collections.Generic.IDictionary`2<System.Type,System.Collections.Generic.IDictionary`2<System.Type,System.Reflection.MethodInfo>>
struct IDictionary_2_tE7FFBD71D86A280E4B101DF2F8E59C9FFFAA4C29;
// System.Collections.Generic.IDictionary`2<System.Type,System.Collections.Generic.IList`1<Agora.Rtc.LitJson.PropertyMetadata>>
struct IDictionary_2_t29BB91F618B4AC5102D59D4F5A61A9CBC91F15A8;
// System.Collections.Generic.IDictionary`2<System.Type,Agora.Rtc.LitJson.ArrayMetadata>
struct IDictionary_2_t685901FCF34C6719CAFEE59FAC7829AB0B99134C;
// System.Collections.Generic.IDictionary`2<System.Type,Agora.Rtc.LitJson.ExporterFunc>
struct IDictionary_2_t6000AC6596E315F8026880CC88C2CC49EC9EACEB;
// System.Collections.Generic.IDictionary`2<System.Type,Agora.Rtc.LitJson.ObjectMetadata>
struct IDictionary_2_tA898CC0B185EF3195BD98FE53E364962C36C0F5C;
// System.Collections.Generic.IEqualityComparer`1<System.Int32>
struct IEqualityComparer_1_tDBFC8496F14612776AF930DBF84AFE7D06D1F0E9;
// System.Collections.Generic.IList`1<System.Collections.Generic.KeyValuePair`2<System.String,Agora.Rtc.LitJson.JsonData>>
struct IList_1_tC2D4AA6390601267AADDB5F04DA5C39FFA53C1C0;
// System.Collections.Generic.IList`1<Agora.Rtc.LitJson.JsonData>
struct IList_1_t00EB641566AC2B4DF080CE0FBD272C09CF73F4A5;
// System.Collections.Generic.Dictionary`2/KeyCollection<System.Int32,System.Collections.Generic.IDictionary`2<System.Int32,System.Int32[]>>
struct KeyCollection_tE8399140098D3D8028A8D5FB2CBF88B0965541B7;
// System.Collections.Generic.Dictionary`2/KeyCollection<System.Int32,System.Int32[]>
struct KeyCollection_tC542A7519E04306FF4830698FC8A485843209C5F;
// Agora.Rtc.Optional`1<Agora.Rtc.AUDIENCE_LATENCY_LEVEL_TYPE>
struct Optional_1_t3D985A7F63673DFB7B5DCD8CE9EE622EABB76D1F;
// Agora.Rtc.Optional`1<System.Boolean>
struct Optional_1_t5ECCECA11C3EA2B3D72FC80C3EEC85F541294665;
// Agora.Rtc.Optional`1<Agora.Rtc.CHANNEL_PROFILE_TYPE>
struct Optional_1_t6777AA03B6B6BCE1D48C4DFAA9F6499242C82F05;
// Agora.Rtc.Optional`1<Agora.Rtc.CLIENT_ROLE_TYPE>
struct Optional_1_t5C8656A1B957381763DED81AE837B5564B6B338C;
// Agora.Rtc.Optional`1<System.Double>
struct Optional_1_tD55CF2B24B2306B7B7CE9AFEE8C63C8C1C6A3C55;
// Agora.Rtc.Optional`1<System.Int16>
struct Optional_1_t3E699351D46D874511D63581794E1D62BC1A2E12;
// Agora.Rtc.Optional`1<System.Int32>
struct Optional_1_t702276DAE9B7132B4ED017493544FE3162F72A13;
// Agora.Rtc.Optional`1<System.Int32Enum>
struct Optional_1_t2954B1B7E8E21A89BCCE60964639F2F7B046A240;
// Agora.Rtc.Optional`1<System.Int64>
struct Optional_1_tBB9FFF9D20636D333BC8766DBB02D617339F5001;
// Agora.Rtc.Optional`1<System.Object>
struct Optional_1_tBE74ACADAF125EAA7731E765B4D8F7F002656BFF;
// Agora.Rtc.Optional`1<System.Single>
struct Optional_1_tF876A70CDF0D3ADF96F01942F0AEAC7EB19FC62A;
// Agora.Rtc.Optional`1<System.String>
struct Optional_1_t3CE97B858328B754CADD94F152EB4D1D51932DB4;
// Agora.Rtc.Optional`1<Agora.Rtc.THREAD_PRIORITY_TYPE>
struct Optional_1_tF6D53E8DA343ADCA47506DF62B9921E5612BCA69;
// Agora.Rtc.Optional`1<System.UInt16>
struct Optional_1_tC0B7C5D987A3B3FBE615A0BA80C8AE46F260A6D5;
// Agora.Rtc.Optional`1<System.UInt32>
struct Optional_1_t9D1D61BD0E1BAFD11E7902319403D52C0DF276FD;
// Agora.Rtc.Optional`1<System.UInt64>
struct Optional_1_tD8A059C84DFD90B30DB7B4CAC4A0C5F232084498;
// Agora.Rtc.Optional`1<Agora.Rtc.VIDEO_STREAM_TYPE>
struct Optional_1_tC5AB3A88C37AF5FA76EC96E7F6256F299BBA4827;
// System.Collections.Generic.Stack`1<System.Int32>
struct Stack_1_t3197E0F5EA36E611B259A88751D31FC2396FE4B6;
// System.Collections.Generic.Stack`1<System.Object>
struct Stack_1_tAD790A47551563636908E21E4F08C54C0C323EB5;
// System.Collections.Generic.Stack`1<Agora.Rtc.LitJson.WriterContext>
struct Stack_1_t7D2C4DA3105E485DD5491FB8B36FC2D66DA84336;
// System.Collections.Generic.Dictionary`2/ValueCollection<System.Int32,System.Collections.Generic.IDictionary`2<System.Int32,System.Int32[]>>
struct ValueCollection_t28FD47FCC4F1763B936C9A4BB2A8B2276E633FEF;
// System.Collections.Generic.Dictionary`2/ValueCollection<System.Int32,System.Int32[]>
struct ValueCollection_t6D44D0A2B65933FB953BE36FD019130BBA243B59;
// System.Collections.Generic.Dictionary`2/Entry<System.Int32,System.Collections.Generic.IDictionary`2<System.Int32,System.Int32[]>>[]
struct EntryU5BU5D_tDFD4E62BB3F1C0F3B7819DAEE99FF5E659B06D91;
// System.Collections.Generic.Dictionary`2/Entry<System.Int32,System.Int32[]>[]
struct EntryU5BU5D_tE39FFA41A51BE829EA4A822560291EDF5752730D;
// System.Byte[]
struct ByteU5BU5D_tA6237BF417AE52AD70CFB4EF24A7A82613DF9031;
// System.Char[]
struct CharU5BU5D_t799905CF001DD5F13F7DBB310181FC4D8B7D0AAB;
// System.Delegate[]
struct DelegateU5BU5D_tC5AB7E8F745616680F337909D3A8E6C722CDF771;
// System.Int32[]
struct Int32U5BU5D_t19C97395396A72ECAF310612F0760F165060314C;
// System.IntPtr[]
struct IntPtrU5BU5D_tFD177F8C806A6921AD7150264CCC62FA00CAD832;
// System.Object[]
struct ObjectU5BU5D_t8061030B0A12A55D5AD8652A20C922FE99450918;
// System.Diagnostics.StackTrace[]
struct StackTraceU5BU5D_t32FBCB20930EAF5BAE3F450FF75228E5450DA0DF;
// System.String[]
struct StringU5BU5D_t7674CD946EC0CE7B3AE0BE70E6EE85F2ECD9F248;
// Agora.Rtc.LitJson.WriterContext[]
struct WriterContextU5BU5D_t5AD69F1BE0D77811ED5EF244CC68C1B422A2EE99;
// Agora.Rtc.LitJson.Lexer/StateHandler[]
struct StateHandlerU5BU5D_t766A22C9C454D383614ED21CB99EAD5F5F15438B;
// Torymeta.Addressable.AddressableWrapper
struct AddressableWrapper_tE5A9032A2E5B8B8CC585239824D2603BFF52FC75;
// System.ArgumentNullException
struct ArgumentNullException_t327031E412FAB2351B0022DD5DAD47E67E597129;
// System.AsyncCallback
struct AsyncCallback_t7FEF460CBDCFB9C5FA2EF776984778B9A4145F4C;
// System.Globalization.Calendar
struct Calendar_t0A117CC7532A54C17188C2EFEA1F79DB20DF3A3B;
// System.Globalization.CompareInfo
struct CompareInfo_t1B1A6AC3486B570C76ABA52149C9BD4CD82F9E57;
// System.Globalization.CultureData
struct CultureData_tEEFDCF4ECA1BBF6C0C8C94EB3541657245598F9D;
// System.Globalization.CultureInfo
struct CultureInfo_t9BA817D41AD55AC8BD07480DD8AC22F8FFA378E0;
// System.Globalization.DateTimeFormatInfo
struct DateTimeFormatInfo_t0457520F9FA7B5C8EAAEB3AD50413B6AEEB7458A;
// System.Delegate
struct Delegate_t;
// System.DelegateData
struct DelegateData_t9B286B493293CD2D23A5B2B5EF0E5B1324C2B77E;
// System.Exception
struct Exception_t;
// Agora.Rtc.LitJson.ExporterFunc
struct ExporterFunc_tB3923D0991F0FAE9055F93A0F7C67E5885568CC4;
// Agora.Rtc.LitJson.FsmContext
struct FsmContext_tC11B461D4D90680FC71416881106E6AF48CAE21F;
// System.IAsyncResult
struct IAsyncResult_t7B9B5A0ECB35DCEC31B8A8122C37D687369253B5;
// System.Collections.ICollection
struct ICollection_t37E7B9DC5B4EF41D190D607F92835BF1171C0E8E;
// System.Collections.IDictionary
struct IDictionary_t6D03155AF1FA9083817AA5B6AD7DEEACC26AB220;
// System.Collections.IDictionaryEnumerator
struct IDictionaryEnumerator_tE129D608FCDB7207E0F0ECE33473CC950A83AD16;
// System.Collections.IEnumerator
struct IEnumerator_t7B609C2FFA6EB5167D9C62A0C32A21DE2F666DAA;
// System.IFormatProvider
struct IFormatProvider_tC202922D43BFF3525109ABF3FB79625F5646AB52;
// Agora.Rtc.LitJson.IJsonWrapper
struct IJsonWrapper_tD46A04D691DDCCF2C3CA4B202A0DF453DC04ACE6;
// Agora.Rtc.LitJson.ImporterFunc
struct ImporterFunc_tC3095AD1938F844CD79CF79C1F2A2199CA03ABCD;
// Agora.Rtc.LitJson.JsonData
struct JsonData_t84ADF600AA1B164B56CAFAAF965FE17B8A3543D5;
// Agora.Rtc.LitJson.JsonException
struct JsonException_t3B214813E48AA5E19793F9026831120B5B2254A1;
// Agora.Rtc.LitJson.JsonMockWrapper
struct JsonMockWrapper_tE04391F97D9A84CC02FF454281A59C54DE05355C;
// Agora.Rtc.LitJson.JsonReader
struct JsonReader_tE72AF24875A229A65356715AAFF4C23E38105A3F;
// Agora.Rtc.LitJson.JsonWriter
struct JsonWriter_tC9B032D35ED4E85319A227892A43EB8627661732;
// Agora.Rtc.LitJson.Lexer
struct Lexer_tDC14CFA7B390E884510F554D9D1E03188A185E27;
// System.Reflection.MethodInfo
struct MethodInfo_t;
// System.Globalization.NumberFormatInfo
struct NumberFormatInfo_t8E26808B202927FEBF9064FCFEEA4D6E076E6472;
// System.Runtime.Serialization.SafeSerializationManager
struct SafeSerializationManager_tCBB85B95DFD1634237140CD892E82D06ECB3F5E6;
// System.String
struct String_t;
// System.Text.StringBuilder
struct StringBuilder_t;
// System.IO.StringReader
struct StringReader_t1A336148FF22A9584E759A9D720CC96C23E35DD8;
// System.IO.StringWriter
struct StringWriter_tF48052BE4F980E5C85403221E835768E4156267D;
// System.Globalization.TextInfo
struct TextInfo_tD3BAFCFD77418851E7D5CB8D2588F47019E414B4;
// System.IO.TextReader
struct TextReader_tB8D43017CB6BE1633E5A86D64E7757366507C1F7;
// System.IO.TextWriter
struct TextWriter_tA9E5461506CF806E17B6BBBF2119359DEDA3F0F3;
// System.Text.UnicodeEncoding
struct UnicodeEncoding_t2C90D9E1E55C16081FACA57B229053C1EF05DAF0;
// System.Void
struct Void_t4861ACF8F4594C3437BB48B6E56783494B843915;
// Agora.Rtc.LitJson.WrapperFactory
struct WrapperFactory_t92E5AF7D73458CC8A0E1D25FE2B2D3A07CCE07B9;
// Agora.Rtc.LitJson.WriterContext
struct WriterContext_tAA13A82DA53BA6A99795422A71F6D19F331F30BA;
// Agora.Rtc.LitJson.JsonMapper/<>c
struct U3CU3Ec_tB2417947DB790EC3B314B9BB1046B04B68400CDA;
// Agora.Rtc.LitJson.Lexer/StateHandler
struct StateHandler_t8EA5CD11BFA1A958F305A2A0134A0BBB631FAFCB;

IL2CPP_EXTERN_C RuntimeClass* AddressableWrapper_tE5A9032A2E5B8B8CC585239824D2603BFF52FC75_il2cpp_TypeInfo_var;
IL2CPP_EXTERN_C RuntimeClass* ArgumentNullException_t327031E412FAB2351B0022DD5DAD47E67E597129_il2cpp_TypeInfo_var;
IL2CPP_EXTERN_C RuntimeClass* Boolean_t09A6377A54BE2F9E6985A8149F19234FD7DDFE22_il2cpp_TypeInfo_var;
IL2CPP_EXTERN_C RuntimeClass* Byte_t94D9231AC217BE4D2E004C4CD32DF6D099EA41A3_il2cpp_TypeInfo_var;
IL2CPP_EXTERN_C RuntimeClass* CharU5BU5D_t799905CF001DD5F13F7DBB310181FC4D8B7D0AAB_il2cpp_TypeInfo_var;
IL2CPP_EXTERN_C RuntimeClass* Char_t521A6F19B456D956AF452D926C32709DC03D6B17_il2cpp_TypeInfo_var;
IL2CPP_EXTERN_C RuntimeClass* Convert_t7097FF336D592F7C06D88A98349A44646F91EFFC_il2cpp_TypeInfo_var;
IL2CPP_EXTERN_C RuntimeClass* CultureInfo_t9BA817D41AD55AC8BD07480DD8AC22F8FFA378E0_il2cpp_TypeInfo_var;
IL2CPP_EXTERN_C RuntimeClass* DateTimeOffset_t4EE701FE2F386D6F932FAC9B11E4B74A5B30F0A4_il2cpp_TypeInfo_var;
IL2CPP_EXTERN_C RuntimeClass* DateTime_t66193957C73913903DDAD89FEDC46139BCA5802D_il2cpp_TypeInfo_var;
IL2CPP_EXTERN_C RuntimeClass* Debug_t8394C7EEAECA3689C2C9B9DE9C7166D73596276F_il2cpp_TypeInfo_var;
IL2CPP_EXTERN_C RuntimeClass* Decimal_tDA6C877282B2D789CF97C0949661CC11D643969F_il2cpp_TypeInfo_var;
IL2CPP_EXTERN_C RuntimeClass* Dictionary_2_t029F6A37F043A1B571A7DB746955ECB8DC548AD9_il2cpp_TypeInfo_var;
IL2CPP_EXTERN_C RuntimeClass* Dictionary_2_t403ABC2FA2D9740F9ADD28DB8815C00EE2DB4249_il2cpp_TypeInfo_var;
IL2CPP_EXTERN_C RuntimeClass* Double_tE150EF3D1D43DEE85D533810AB4C742307EEDE5F_il2cpp_TypeInfo_var;
IL2CPP_EXTERN_C RuntimeClass* FsmContext_tC11B461D4D90680FC71416881106E6AF48CAE21F_il2cpp_TypeInfo_var;
IL2CPP_EXTERN_C RuntimeClass* IDictionary_2_t9503DE0744217071D554CC415B2890C454070024_il2cpp_TypeInfo_var;
IL2CPP_EXTERN_C RuntimeClass* IDictionary_2_tAD4D3CC9C1631510439F3806F67FAA90CE4C4313_il2cpp_TypeInfo_var;
IL2CPP_EXTERN_C RuntimeClass* IDisposable_t030E0496B4E0E4E4F086825007979AF51F7248C5_il2cpp_TypeInfo_var;
IL2CPP_EXTERN_C RuntimeClass* Int16_tB8EF286A9C33492FA6E6D6E67320BE93E794A175_il2cpp_TypeInfo_var;
IL2CPP_EXTERN_C RuntimeClass* Int32U5BU5D_t19C97395396A72ECAF310612F0760F165060314C_il2cpp_TypeInfo_var;
IL2CPP_EXTERN_C RuntimeClass* Int32_t680FF22E76F6EFAD4375103CBBFFA0421349384C_il2cpp_TypeInfo_var;
IL2CPP_EXTERN_C RuntimeClass* Int64_t092CFB123BE63C28ACDAF65C68F21A526050DBA3_il2cpp_TypeInfo_var;
IL2CPP_EXTERN_C RuntimeClass* IntPtr_t_il2cpp_TypeInfo_var;
IL2CPP_EXTERN_C RuntimeClass* JsonData_t84ADF600AA1B164B56CAFAAF965FE17B8A3543D5_il2cpp_TypeInfo_var;
IL2CPP_EXTERN_C RuntimeClass* JsonException_t3B214813E48AA5E19793F9026831120B5B2254A1_il2cpp_TypeInfo_var;
IL2CPP_EXTERN_C RuntimeClass* JsonMapper_t3A3F5A7CFFC63F7DF9A3563D52974D21D47798F2_il2cpp_TypeInfo_var;
IL2CPP_EXTERN_C RuntimeClass* JsonMockWrapper_tE04391F97D9A84CC02FF454281A59C54DE05355C_il2cpp_TypeInfo_var;
IL2CPP_EXTERN_C RuntimeClass* JsonReader_tE72AF24875A229A65356715AAFF4C23E38105A3F_il2cpp_TypeInfo_var;
IL2CPP_EXTERN_C RuntimeClass* JsonWriter_tC9B032D35ED4E85319A227892A43EB8627661732_il2cpp_TypeInfo_var;
IL2CPP_EXTERN_C RuntimeClass* KeyNotFoundException_tCE416EC9BCA9F396A3DFFF86D1B5209BA876079E_il2cpp_TypeInfo_var;
IL2CPP_EXTERN_C RuntimeClass* Lexer_tDC14CFA7B390E884510F554D9D1E03188A185E27_il2cpp_TypeInfo_var;
IL2CPP_EXTERN_C RuntimeClass* Optional_1_t3CE97B858328B754CADD94F152EB4D1D51932DB4_il2cpp_TypeInfo_var;
IL2CPP_EXTERN_C RuntimeClass* Optional_1_t3D985A7F63673DFB7B5DCD8CE9EE622EABB76D1F_il2cpp_TypeInfo_var;
IL2CPP_EXTERN_C RuntimeClass* Optional_1_t3E699351D46D874511D63581794E1D62BC1A2E12_il2cpp_TypeInfo_var;
IL2CPP_EXTERN_C RuntimeClass* Optional_1_t5C8656A1B957381763DED81AE837B5564B6B338C_il2cpp_TypeInfo_var;
IL2CPP_EXTERN_C RuntimeClass* Optional_1_t5ECCECA11C3EA2B3D72FC80C3EEC85F541294665_il2cpp_TypeInfo_var;
IL2CPP_EXTERN_C RuntimeClass* Optional_1_t6777AA03B6B6BCE1D48C4DFAA9F6499242C82F05_il2cpp_TypeInfo_var;
IL2CPP_EXTERN_C RuntimeClass* Optional_1_t702276DAE9B7132B4ED017493544FE3162F72A13_il2cpp_TypeInfo_var;
IL2CPP_EXTERN_C RuntimeClass* Optional_1_t9D1D61BD0E1BAFD11E7902319403D52C0DF276FD_il2cpp_TypeInfo_var;
IL2CPP_EXTERN_C RuntimeClass* Optional_1_tBB9FFF9D20636D333BC8766DBB02D617339F5001_il2cpp_TypeInfo_var;
IL2CPP_EXTERN_C RuntimeClass* Optional_1_tC0B7C5D987A3B3FBE615A0BA80C8AE46F260A6D5_il2cpp_TypeInfo_var;
IL2CPP_EXTERN_C RuntimeClass* Optional_1_tC5AB3A88C37AF5FA76EC96E7F6256F299BBA4827_il2cpp_TypeInfo_var;
IL2CPP_EXTERN_C RuntimeClass* Optional_1_tD55CF2B24B2306B7B7CE9AFEE8C63C8C1C6A3C55_il2cpp_TypeInfo_var;
IL2CPP_EXTERN_C RuntimeClass* Optional_1_tD8A059C84DFD90B30DB7B4CAC4A0C5F232084498_il2cpp_TypeInfo_var;
IL2CPP_EXTERN_C RuntimeClass* Optional_1_tF6D53E8DA343ADCA47506DF62B9921E5612BCA69_il2cpp_TypeInfo_var;
IL2CPP_EXTERN_C RuntimeClass* Optional_1_tF876A70CDF0D3ADF96F01942F0AEAC7EB19FC62A_il2cpp_TypeInfo_var;
IL2CPP_EXTERN_C RuntimeClass* SByte_tFEFFEF5D2FEBF5207950AE6FAC150FC53B668DB5_il2cpp_TypeInfo_var;
IL2CPP_EXTERN_C RuntimeClass* Single_t4530F2FF86FCB0DC29F35385CA1BD21BE294761C_il2cpp_TypeInfo_var;
IL2CPP_EXTERN_C RuntimeClass* Stack_1_t3197E0F5EA36E611B259A88751D31FC2396FE4B6_il2cpp_TypeInfo_var;
IL2CPP_EXTERN_C RuntimeClass* Stack_1_t7D2C4DA3105E485DD5491FB8B36FC2D66DA84336_il2cpp_TypeInfo_var;
IL2CPP_EXTERN_C RuntimeClass* StateHandlerU5BU5D_t766A22C9C454D383614ED21CB99EAD5F5F15438B_il2cpp_TypeInfo_var;
IL2CPP_EXTERN_C RuntimeClass* StateHandler_t8EA5CD11BFA1A958F305A2A0134A0BBB631FAFCB_il2cpp_TypeInfo_var;
IL2CPP_EXTERN_C RuntimeClass* StringBuilder_t_il2cpp_TypeInfo_var;
IL2CPP_EXTERN_C RuntimeClass* StringReader_t1A336148FF22A9584E759A9D720CC96C23E35DD8_il2cpp_TypeInfo_var;
IL2CPP_EXTERN_C RuntimeClass* StringWriter_tF48052BE4F980E5C85403221E835768E4156267D_il2cpp_TypeInfo_var;
IL2CPP_EXTERN_C RuntimeClass* String_t_il2cpp_TypeInfo_var;
IL2CPP_EXTERN_C RuntimeClass* U3CU3Ec_tB2417947DB790EC3B314B9BB1046B04B68400CDA_il2cpp_TypeInfo_var;
IL2CPP_EXTERN_C RuntimeClass* UInt16_tF4C148C876015C212FD72652D0B6ED8CC247A455_il2cpp_TypeInfo_var;
IL2CPP_EXTERN_C RuntimeClass* UInt32_t1833D51FFA667B18A5AA4B8D34DE284F8495D29B_il2cpp_TypeInfo_var;
IL2CPP_EXTERN_C RuntimeClass* UInt64_t8F12534CC8FC4B5860F2A2CD1EE79D322E7A41AF_il2cpp_TypeInfo_var;
IL2CPP_EXTERN_C RuntimeClass* WriterContext_tAA13A82DA53BA6A99795422A71F6D19F331F30BA_il2cpp_TypeInfo_var;
IL2CPP_EXTERN_C RuntimeField* U3CPrivateImplementationDetailsU3E_t0F5473E849A5A5185A9F4C5246F0C32816C49FCA____59B7E757844D3BF9299877BD1C17451611BFBAB493374D6B18D973FDE534151A_0_FieldInfo_var;
IL2CPP_EXTERN_C RuntimeField* U3CPrivateImplementationDetailsU3E_t0F5473E849A5A5185A9F4C5246F0C32816C49FCA____5B979F69B96A61586A09DD4ED26F20534C629B08732AE32FA34B6F8A0049ACDD_1_FieldInfo_var;
IL2CPP_EXTERN_C RuntimeField* U3CPrivateImplementationDetailsU3E_t0F5473E849A5A5185A9F4C5246F0C32816C49FCA____7FCA397EF25DB53B2C58A05F9BBFA4E8E0685FDBC8AAF39536123447056895C0_2_FieldInfo_var;
IL2CPP_EXTERN_C RuntimeField* U3CPrivateImplementationDetailsU3E_t0F5473E849A5A5185A9F4C5246F0C32816C49FCA____B257E85A5D3CAB5E738D5A0FD1A7AE96624BFE92CB7915726CBBE1518C3225CF_3_FieldInfo_var;
IL2CPP_EXTERN_C RuntimeField* U3CPrivateImplementationDetailsU3E_t0F5473E849A5A5185A9F4C5246F0C32816C49FCA____B7A918F6F138CA8137025633559198B529D28CCEC5A51B005376CC69A5B83D85_4_FieldInfo_var;
IL2CPP_EXTERN_C RuntimeField* U3CPrivateImplementationDetailsU3E_t0F5473E849A5A5185A9F4C5246F0C32816C49FCA____C84227140A8A7787B30DFF8BD5693C19AA5A430C4E89FFD0256D7F77B3FEAD82_5_FieldInfo_var;
IL2CPP_EXTERN_C RuntimeField* U3CPrivateImplementationDetailsU3E_t0F5473E849A5A5185A9F4C5246F0C32816C49FCA____FC03ECB1D62767A5B31230F548FA4D4C02F01E3DA8CA1FC66C7C332EA16BF206_6_FieldInfo_var;
IL2CPP_EXTERN_C String_t* _stringLiteral057118C49B28F31FA4955B194753088DDCD94999;
IL2CPP_EXTERN_C String_t* _stringLiteral0C3C6829C3CCF8020C6AC45B87963ADC095CD44A;
IL2CPP_EXTERN_C String_t* _stringLiteral1168E92C164109D6220480DEDA987085B2A21155;
IL2CPP_EXTERN_C String_t* _stringLiteral242259752214E86B8CCBBF56AA4774B954BC34AD;
IL2CPP_EXTERN_C String_t* _stringLiteral4D8D9C94AC5DA5FCED2EC8A64E10E714A2515C30;
IL2CPP_EXTERN_C String_t* _stringLiteral5962E944D7340CE47999BF097B4AFD70C1501FB9;
IL2CPP_EXTERN_C String_t* _stringLiteral5BEFD8CC60A79699B5BB00E37BAC5B62D371E174;
IL2CPP_EXTERN_C String_t* _stringLiteral5D67E25274B2D936623ECD74ACD07BD06587D500;
IL2CPP_EXTERN_C String_t* _stringLiteral638C5441E8427B2B9D2C941DDBF958579B5FE3F0;
IL2CPP_EXTERN_C String_t* _stringLiteral77D38C0623F92B292B925F6E72CF5CF99A20D4EB;
IL2CPP_EXTERN_C String_t* _stringLiteral785F17F45C331C415D0A7458E6AAC36966399C51;
IL2CPP_EXTERN_C String_t* _stringLiteral7B6EE056E549534162451A09C7F0AFAC372DBD06;
IL2CPP_EXTERN_C String_t* _stringLiteral7BB3A8E1171A70E5B0BF6BC8AF767AB60C516DAF;
IL2CPP_EXTERN_C String_t* _stringLiteral7F3238CD8C342B06FB9AB185C610175C84625462;
IL2CPP_EXTERN_C String_t* _stringLiteral84BE6DF7F5E86A94476E7ED44C8A9ACA10E6236A;
IL2CPP_EXTERN_C String_t* _stringLiteral8B93D713065FCD706110EEBDDB368C2646BA9761;
IL2CPP_EXTERN_C String_t* _stringLiteral8E284AA45C643AAA8D3553AA7AB6A1C3BC3E32D1;
IL2CPP_EXTERN_C String_t* _stringLiteralA7C3FCA8C63E127B542B38A5CA5E3FEEDDD1B122;
IL2CPP_EXTERN_C String_t* _stringLiteralB78F235D4291950A7D101307609C259F3E1F033F;
IL2CPP_EXTERN_C String_t* _stringLiteralB7C45DD316C68ABF3429C20058C2981C652192F2;
IL2CPP_EXTERN_C String_t* _stringLiteralC31E66F919D06AD2730738EF7F884271E99BB7DA;
IL2CPP_EXTERN_C String_t* _stringLiteralC63496F78F80F09E4841EF5CD0DA8DAF7028FB4B;
IL2CPP_EXTERN_C String_t* _stringLiteralCDA723AA4DBB226A906416AA9BF1C2D4CEC53C89;
IL2CPP_EXTERN_C String_t* _stringLiteralCEE7535349ADB76DD55B08451D311FC3CF06A19C;
IL2CPP_EXTERN_C String_t* _stringLiteralD9691C4FD8A1F6B09DB1147CA32B442772FB46A1;
IL2CPP_EXTERN_C String_t* _stringLiteralDA39A3EE5E6B4B0D3255BFEF95601890AFD80709;
IL2CPP_EXTERN_C String_t* _stringLiteralDA666908BB15F4E1D2649752EC5DCBD0D5C64699;
IL2CPP_EXTERN_C String_t* _stringLiteralE166C9564FBDE461738077E3B1B506525EB6ACCC;
IL2CPP_EXTERN_C String_t* _stringLiteralECAC83771A00C701043A940F621CC1C765D30D31;
IL2CPP_EXTERN_C const RuntimeMethod* Dictionary_2__ctor_m3F530E7CD9CC3EB97DCC6E1669EAB9FCE984FA9A_RuntimeMethod_var;
IL2CPP_EXTERN_C const RuntimeMethod* Dictionary_2__ctor_mF37C098D396E6388CF354D6F37970685A85B6FC0_RuntimeMethod_var;
IL2CPP_EXTERN_C const RuntimeMethod* JsonReader_Read_mD49C2B0A28DE9C640B1B812B85DE7D5B9B7158D2_RuntimeMethod_var;
IL2CPP_EXTERN_C const RuntimeMethod* JsonReader__ctor_m8532B5B8E63218CC7A3123B9935E1C5E44A07BBC_RuntimeMethod_var;
IL2CPP_EXTERN_C const RuntimeMethod* JsonWriter_DoValidation_mE5807100853E142A9F37794C4C13B30619720445_RuntimeMethod_var;
IL2CPP_EXTERN_C const RuntimeMethod* JsonWriter__ctor_mDFC33F09AE54B24B0930A2B55C43B3B4EABD168D_RuntimeMethod_var;
IL2CPP_EXTERN_C const RuntimeMethod* Lexer_NextToken_mE34A5B2E9932497D86F3BCD0B7732A1454A2760E_RuntimeMethod_var;
IL2CPP_EXTERN_C const RuntimeMethod* Lexer_State10_m09FDA0FCE8DC10439C3F0230FE49C2479EA2CF9F_RuntimeMethod_var;
IL2CPP_EXTERN_C const RuntimeMethod* Lexer_State11_m10B21AA8B5F120F37CA9A6BA3FCE91093028E921_RuntimeMethod_var;
IL2CPP_EXTERN_C const RuntimeMethod* Lexer_State12_mA3309CA31EA7DF35795793EC1625BD7BB8F0DE31_RuntimeMethod_var;
IL2CPP_EXTERN_C const RuntimeMethod* Lexer_State13_mA36CE192CAB3A980421944E2E748C60C36F5C46D_RuntimeMethod_var;
IL2CPP_EXTERN_C const RuntimeMethod* Lexer_State14_mE16EEB2471742849851399A944FEAEFA52627434_RuntimeMethod_var;
IL2CPP_EXTERN_C const RuntimeMethod* Lexer_State15_m31270A40FAFFF8A0360B89A4BCBEE77B9CDA16B6_RuntimeMethod_var;
IL2CPP_EXTERN_C const RuntimeMethod* Lexer_State16_m180FD3FBA0BCDCB7CD31DF8066CFB0D95A8E5899_RuntimeMethod_var;
IL2CPP_EXTERN_C const RuntimeMethod* Lexer_State17_mBCA9C4F0E50F372C89018A235BD28A351CD066BF_RuntimeMethod_var;
IL2CPP_EXTERN_C const RuntimeMethod* Lexer_State18_m08C6ABD65DA0E9E71E22F625E7767F5FDA5E527B_RuntimeMethod_var;
IL2CPP_EXTERN_C const RuntimeMethod* Lexer_State19_m72717A35567FDD6CB2B2D17F405D9A8A62D5A7D7_RuntimeMethod_var;
IL2CPP_EXTERN_C const RuntimeMethod* Lexer_State1_m354DEC7337AB8F388456A52C690558DA2667A78A_RuntimeMethod_var;
IL2CPP_EXTERN_C const RuntimeMethod* Lexer_State20_m7AB439035107082B949A2E84806B0234056451CF_RuntimeMethod_var;
IL2CPP_EXTERN_C const RuntimeMethod* Lexer_State21_mAF43928E6128B3D414351408BEC48D9D8A13FE1F_RuntimeMethod_var;
IL2CPP_EXTERN_C const RuntimeMethod* Lexer_State22_mA8F75DBBADDA9897FF5A4FC0618085644BC527F9_RuntimeMethod_var;
IL2CPP_EXTERN_C const RuntimeMethod* Lexer_State23_m40E6D1E13EEAE247AA7A182A25CDB3251ED54DC4_RuntimeMethod_var;
IL2CPP_EXTERN_C const RuntimeMethod* Lexer_State24_mF032D4CC3EC466A9348FAD9C1054FD29C7214A44_RuntimeMethod_var;
IL2CPP_EXTERN_C const RuntimeMethod* Lexer_State25_mFF34556A9AC7D3134B061F186784E9D14D749CB2_RuntimeMethod_var;
IL2CPP_EXTERN_C const RuntimeMethod* Lexer_State26_mD4B202B505D9D18BB02A00E78A066B94C3FF041A_RuntimeMethod_var;
IL2CPP_EXTERN_C const RuntimeMethod* Lexer_State27_m7A8DB0C14046DC8E864B145D58075823088F7DCC_RuntimeMethod_var;
IL2CPP_EXTERN_C const RuntimeMethod* Lexer_State28_mE35361243292AE3F746EA665EE51E35AD2F71D58_RuntimeMethod_var;
IL2CPP_EXTERN_C const RuntimeMethod* Lexer_State2_m17C42E885DC482058990D1CBB0A22E1A61275E61_RuntimeMethod_var;
IL2CPP_EXTERN_C const RuntimeMethod* Lexer_State3_mD790267EE8D2875ECF01971BB71AB85D34F7F164_RuntimeMethod_var;
IL2CPP_EXTERN_C const RuntimeMethod* Lexer_State4_m5A6397940610B555715FF84A98B939A20F3222DD_RuntimeMethod_var;
IL2CPP_EXTERN_C const RuntimeMethod* Lexer_State5_m66419555D44A07340F468202EB1623F64E07D057_RuntimeMethod_var;
IL2CPP_EXTERN_C const RuntimeMethod* Lexer_State6_m2FA1AC1A3BB7D134A4070EAA04B4B8F7578082F9_RuntimeMethod_var;
IL2CPP_EXTERN_C const RuntimeMethod* Lexer_State7_mD7D75CE8EE1228FA4F834D0A5B9D70366738FA78_RuntimeMethod_var;
IL2CPP_EXTERN_C const RuntimeMethod* Lexer_State8_m6E43322CC449B219D8B91721D69CB1BC06D49D67_RuntimeMethod_var;
IL2CPP_EXTERN_C const RuntimeMethod* Lexer_State9_m7801BC5CF8DBDCFD46091BF2BFAF300D2108FA62_RuntimeMethod_var;
IL2CPP_EXTERN_C const RuntimeMethod* Optional_1_SetValue_m2C9100B836AAA180D846DCC74A0ED4A4118E8863_RuntimeMethod_var;
IL2CPP_EXTERN_C const RuntimeMethod* Optional_1_SetValue_m3DE667644E7C516EB481AB0BEE32FE7EDFB435AF_RuntimeMethod_var;
IL2CPP_EXTERN_C const RuntimeMethod* Optional_1_SetValue_m43C38C7D77F2E17987091551FC38C2867EB8A66F_RuntimeMethod_var;
IL2CPP_EXTERN_C const RuntimeMethod* Optional_1_SetValue_m4536867BC951C653111124BBB2F692D695165773_RuntimeMethod_var;
IL2CPP_EXTERN_C const RuntimeMethod* Optional_1_SetValue_m4DA972A9DB7CD324E7EAB9E82D7A394EAAC7C4CC_RuntimeMethod_var;
IL2CPP_EXTERN_C const RuntimeMethod* Optional_1_SetValue_m63B29B35805A275BE9D1E1FEF8B269FF41763BBD_RuntimeMethod_var;
IL2CPP_EXTERN_C const RuntimeMethod* Optional_1_SetValue_m9451999734A371C8E4986D51E5019BD66C8A16D9_RuntimeMethod_var;
IL2CPP_EXTERN_C const RuntimeMethod* Optional_1_SetValue_m95F307C9D84062644F9AC400634290FF95E311AF_RuntimeMethod_var;
IL2CPP_EXTERN_C const RuntimeMethod* Optional_1_SetValue_m9F830E4C0FE451B2678B622ABD1354E73E885BB3_RuntimeMethod_var;
IL2CPP_EXTERN_C const RuntimeMethod* Optional_1_SetValue_mB47C082042F2A87BF323DF623B36F42D9E9D7F57_RuntimeMethod_var;
IL2CPP_EXTERN_C const RuntimeMethod* Optional_1_SetValue_mD23D4E22ECBEF9E399D3F72DD292DFBFFD63EC38_RuntimeMethod_var;
IL2CPP_EXTERN_C const RuntimeMethod* Optional_1_SetValue_mE51373D626F7E164049DB4371067C33F9229DC80_RuntimeMethod_var;
IL2CPP_EXTERN_C const RuntimeMethod* Optional_1_SetValue_mF3084568B1C3B43E1DF604DF0771558BE954DFFC_RuntimeMethod_var;
IL2CPP_EXTERN_C const RuntimeMethod* Optional_1_SetValue_mFAAAF5769CD67501C36EBB483D13A1A015F82492_RuntimeMethod_var;
IL2CPP_EXTERN_C const RuntimeMethod* Optional_1_SetValue_mFAD6E19EFE099CD86FA9A55C3185DE2351661769_RuntimeMethod_var;
IL2CPP_EXTERN_C const RuntimeMethod* Optional_1__ctor_m2ADDAA3E2FF62251E6B96683AC3D58EC6E8CE0AA_RuntimeMethod_var;
IL2CPP_EXTERN_C const RuntimeMethod* Optional_1__ctor_m4BCDD38353BEADF1738DB8386E39A5FE1AF02022_RuntimeMethod_var;
IL2CPP_EXTERN_C const RuntimeMethod* Optional_1__ctor_m56D215BBB37874E1671635AE7C29FEDA54E188DD_RuntimeMethod_var;
IL2CPP_EXTERN_C const RuntimeMethod* Optional_1__ctor_m5760A6A5D2C28A6694EE100F6AFEC70D7756D2DF_RuntimeMethod_var;
IL2CPP_EXTERN_C const RuntimeMethod* Optional_1__ctor_m5DC885CD5B69591EB08A40E04FA0FC5614236845_RuntimeMethod_var;
IL2CPP_EXTERN_C const RuntimeMethod* Optional_1__ctor_m79B26B02B0FF0383EC85B8E2E045C2C5B97A45D1_RuntimeMethod_var;
IL2CPP_EXTERN_C const RuntimeMethod* Optional_1__ctor_m9DF6F847C789BC17876C2CD77F24BEFB722B396B_RuntimeMethod_var;
IL2CPP_EXTERN_C const RuntimeMethod* Optional_1__ctor_mA5DC848AD987E18C01F59A7A5289BAD0E6BCE9D2_RuntimeMethod_var;
IL2CPP_EXTERN_C const RuntimeMethod* Optional_1__ctor_mA609C23EDD6086480DE074C6062697F841A89DE5_RuntimeMethod_var;
IL2CPP_EXTERN_C const RuntimeMethod* Optional_1__ctor_mB7E1B789CD114B93E341606596E8E6CE6D5EB1D0_RuntimeMethod_var;
IL2CPP_EXTERN_C const RuntimeMethod* Optional_1__ctor_mDCE5346C89F45F6878E2B214DF77B1B37CBD1265_RuntimeMethod_var;
IL2CPP_EXTERN_C const RuntimeMethod* Optional_1__ctor_mE3FEC568347BCA235ECDF84A661CA953A0C3E6EC_RuntimeMethod_var;
IL2CPP_EXTERN_C const RuntimeMethod* Optional_1__ctor_mE49D786DC8CA5DF649858A60CBFBBA062B92BD0C_RuntimeMethod_var;
IL2CPP_EXTERN_C const RuntimeMethod* Optional_1__ctor_mE58BCB3372AE04CCD5F9ED566F9364F5CC849D62_RuntimeMethod_var;
IL2CPP_EXTERN_C const RuntimeMethod* Optional_1__ctor_mEC9461341FDABED29A99326920E7090D70BD3901_RuntimeMethod_var;
IL2CPP_EXTERN_C const RuntimeMethod* Stack_1_Clear_m6A6BD959A75D18D594176D96A28F64A48E06FF42_RuntimeMethod_var;
IL2CPP_EXTERN_C const RuntimeMethod* Stack_1_Clear_mEE1C6E0AF654AE01D41D12DAF62217D4FE3930E0_RuntimeMethod_var;
IL2CPP_EXTERN_C const RuntimeMethod* Stack_1_Peek_m0FEDB97EFD290B417A1782460FB52FDA59229146_RuntimeMethod_var;
IL2CPP_EXTERN_C const RuntimeMethod* Stack_1_Peek_m919AA48BFC239B260BB6A0639B8E027B60CB8B66_RuntimeMethod_var;
IL2CPP_EXTERN_C const RuntimeMethod* Stack_1_Pop_m59DFD2B5EC8D9044532E0AD0BDB20DB33BA76748_RuntimeMethod_var;
IL2CPP_EXTERN_C const RuntimeMethod* Stack_1_Pop_mCA172CFAE834614F947860C76631CFF9A995BBE3_RuntimeMethod_var;
IL2CPP_EXTERN_C const RuntimeMethod* Stack_1_Push_m55AF25BEEA08E56F5C74631BB98562B8461303E9_RuntimeMethod_var;
IL2CPP_EXTERN_C const RuntimeMethod* Stack_1_Push_mF7CC12CF73D9D4B66FFA2E2D264270212CAB3EDA_RuntimeMethod_var;
IL2CPP_EXTERN_C const RuntimeMethod* Stack_1__ctor_m6F4B606D290A80B5EA37E96C0DE8A1C9C9C88769_RuntimeMethod_var;
IL2CPP_EXTERN_C const RuntimeMethod* Stack_1__ctor_mF63AE96E8925749CDACE05B89002A389DDD748D1_RuntimeMethod_var;
IL2CPP_EXTERN_C const RuntimeMethod* Stack_1_get_Count_mDE5E5A58BFA286D4526261A83956911D0C00D06E_RuntimeMethod_var;
struct CultureData_tEEFDCF4ECA1BBF6C0C8C94EB3541657245598F9D_marshaled_com;
struct CultureData_tEEFDCF4ECA1BBF6C0C8C94EB3541657245598F9D_marshaled_pinvoke;
struct CultureInfo_t9BA817D41AD55AC8BD07480DD8AC22F8FFA378E0_marshaled_com;
struct CultureInfo_t9BA817D41AD55AC8BD07480DD8AC22F8FFA378E0_marshaled_pinvoke;
struct Delegate_t_marshaled_com;
struct Delegate_t_marshaled_pinvoke;
struct Exception_t_marshaled_com;
struct Exception_t_marshaled_pinvoke;

struct CharU5BU5D_t799905CF001DD5F13F7DBB310181FC4D8B7D0AAB;
struct DelegateU5BU5D_tC5AB7E8F745616680F337909D3A8E6C722CDF771;
struct Int32U5BU5D_t19C97395396A72ECAF310612F0760F165060314C;
struct StateHandlerU5BU5D_t766A22C9C454D383614ED21CB99EAD5F5F15438B;

IL2CPP_EXTERN_C_BEGIN
IL2CPP_EXTERN_C_END

#ifdef __clang__
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Winvalid-offsetof"
#pragma clang diagnostic ignored "-Wunused-variable"
#endif

// System.Collections.Generic.Dictionary`2<System.Int32,System.Collections.Generic.IDictionary`2<System.Int32,System.Int32[]>>
struct Dictionary_2_t403ABC2FA2D9740F9ADD28DB8815C00EE2DB4249  : public RuntimeObject
{
	// System.Int32[] System.Collections.Generic.Dictionary`2::_buckets
	Int32U5BU5D_t19C97395396A72ECAF310612F0760F165060314C* ____buckets_0;
	// System.Collections.Generic.Dictionary`2/Entry<TKey,TValue>[] System.Collections.Generic.Dictionary`2::_entries
	EntryU5BU5D_tDFD4E62BB3F1C0F3B7819DAEE99FF5E659B06D91* ____entries_1;
	// System.Int32 System.Collections.Generic.Dictionary`2::_count
	int32_t ____count_2;
	// System.Int32 System.Collections.Generic.Dictionary`2::_freeList
	int32_t ____freeList_3;
	// System.Int32 System.Collections.Generic.Dictionary`2::_freeCount
	int32_t ____freeCount_4;
	// System.Int32 System.Collections.Generic.Dictionary`2::_version
	int32_t ____version_5;
	// System.Collections.Generic.IEqualityComparer`1<TKey> System.Collections.Generic.Dictionary`2::_comparer
	RuntimeObject* ____comparer_6;
	// System.Collections.Generic.Dictionary`2/KeyCollection<TKey,TValue> System.Collections.Generic.Dictionary`2::_keys
	KeyCollection_tE8399140098D3D8028A8D5FB2CBF88B0965541B7* ____keys_7;
	// System.Collections.Generic.Dictionary`2/ValueCollection<TKey,TValue> System.Collections.Generic.Dictionary`2::_values
	ValueCollection_t28FD47FCC4F1763B936C9A4BB2A8B2276E633FEF* ____values_8;
	// System.Object System.Collections.Generic.Dictionary`2::_syncRoot
	RuntimeObject* ____syncRoot_9;
};

// System.Collections.Generic.Dictionary`2<System.Int32,System.Int32[]>
struct Dictionary_2_t029F6A37F043A1B571A7DB746955ECB8DC548AD9  : public RuntimeObject
{
	// System.Int32[] System.Collections.Generic.Dictionary`2::_buckets
	Int32U5BU5D_t19C97395396A72ECAF310612F0760F165060314C* ____buckets_0;
	// System.Collections.Generic.Dictionary`2/Entry<TKey,TValue>[] System.Collections.Generic.Dictionary`2::_entries
	EntryU5BU5D_tE39FFA41A51BE829EA4A822560291EDF5752730D* ____entries_1;
	// System.Int32 System.Collections.Generic.Dictionary`2::_count
	int32_t ____count_2;
	// System.Int32 System.Collections.Generic.Dictionary`2::_freeList
	int32_t ____freeList_3;
	// System.Int32 System.Collections.Generic.Dictionary`2::_freeCount
	int32_t ____freeCount_4;
	// System.Int32 System.Collections.Generic.Dictionary`2::_version
	int32_t ____version_5;
	// System.Collections.Generic.IEqualityComparer`1<TKey> System.Collections.Generic.Dictionary`2::_comparer
	RuntimeObject* ____comparer_6;
	// System.Collections.Generic.Dictionary`2/KeyCollection<TKey,TValue> System.Collections.Generic.Dictionary`2::_keys
	KeyCollection_tC542A7519E04306FF4830698FC8A485843209C5F* ____keys_7;
	// System.Collections.Generic.Dictionary`2/ValueCollection<TKey,TValue> System.Collections.Generic.Dictionary`2::_values
	ValueCollection_t6D44D0A2B65933FB953BE36FD019130BBA243B59* ____values_8;
	// System.Object System.Collections.Generic.Dictionary`2::_syncRoot
	RuntimeObject* ____syncRoot_9;
};

// Agora.Rtc.Optional`1<Agora.Rtc.AUDIENCE_LATENCY_LEVEL_TYPE>
struct Optional_1_t3D985A7F63673DFB7B5DCD8CE9EE622EABB76D1F  : public RuntimeObject
{
	// T Agora.Rtc.Optional`1::value
	int32_t ___value_0;
	// System.Boolean Agora.Rtc.Optional`1::hasValue
	bool ___hasValue_1;
};

// Agora.Rtc.Optional`1<System.Boolean>
struct Optional_1_t5ECCECA11C3EA2B3D72FC80C3EEC85F541294665  : public RuntimeObject
{
	// T Agora.Rtc.Optional`1::value
	bool ___value_0;
	// System.Boolean Agora.Rtc.Optional`1::hasValue
	bool ___hasValue_1;
};

// Agora.Rtc.Optional`1<Agora.Rtc.CHANNEL_PROFILE_TYPE>
struct Optional_1_t6777AA03B6B6BCE1D48C4DFAA9F6499242C82F05  : public RuntimeObject
{
	// T Agora.Rtc.Optional`1::value
	int32_t ___value_0;
	// System.Boolean Agora.Rtc.Optional`1::hasValue
	bool ___hasValue_1;
};

// Agora.Rtc.Optional`1<Agora.Rtc.CLIENT_ROLE_TYPE>
struct Optional_1_t5C8656A1B957381763DED81AE837B5564B6B338C  : public RuntimeObject
{
	// T Agora.Rtc.Optional`1::value
	int32_t ___value_0;
	// System.Boolean Agora.Rtc.Optional`1::hasValue
	bool ___hasValue_1;
};

// Agora.Rtc.Optional`1<System.Double>
struct Optional_1_tD55CF2B24B2306B7B7CE9AFEE8C63C8C1C6A3C55  : public RuntimeObject
{
	// T Agora.Rtc.Optional`1::value
	double ___value_0;
	// System.Boolean Agora.Rtc.Optional`1::hasValue
	bool ___hasValue_1;
};

// Agora.Rtc.Optional`1<System.Int16>
struct Optional_1_t3E699351D46D874511D63581794E1D62BC1A2E12  : public RuntimeObject
{
	// T Agora.Rtc.Optional`1::value
	int16_t ___value_0;
	// System.Boolean Agora.Rtc.Optional`1::hasValue
	bool ___hasValue_1;
};

// Agora.Rtc.Optional`1<System.Int32>
struct Optional_1_t702276DAE9B7132B4ED017493544FE3162F72A13  : public RuntimeObject
{
	// T Agora.Rtc.Optional`1::value
	int32_t ___value_0;
	// System.Boolean Agora.Rtc.Optional`1::hasValue
	bool ___hasValue_1;
};

// Agora.Rtc.Optional`1<System.Int64>
struct Optional_1_tBB9FFF9D20636D333BC8766DBB02D617339F5001  : public RuntimeObject
{
	// T Agora.Rtc.Optional`1::value
	int64_t ___value_0;
	// System.Boolean Agora.Rtc.Optional`1::hasValue
	bool ___hasValue_1;
};

// Agora.Rtc.Optional`1<System.Single>
struct Optional_1_tF876A70CDF0D3ADF96F01942F0AEAC7EB19FC62A  : public RuntimeObject
{
	// T Agora.Rtc.Optional`1::value
	float ___value_0;
	// System.Boolean Agora.Rtc.Optional`1::hasValue
	bool ___hasValue_1;
};

// Agora.Rtc.Optional`1<System.String>
struct Optional_1_t3CE97B858328B754CADD94F152EB4D1D51932DB4  : public RuntimeObject
{
	// T Agora.Rtc.Optional`1::value
	String_t* ___value_0;
	// System.Boolean Agora.Rtc.Optional`1::hasValue
	bool ___hasValue_1;
};

// Agora.Rtc.Optional`1<Agora.Rtc.THREAD_PRIORITY_TYPE>
struct Optional_1_tF6D53E8DA343ADCA47506DF62B9921E5612BCA69  : public RuntimeObject
{
	// T Agora.Rtc.Optional`1::value
	int32_t ___value_0;
	// System.Boolean Agora.Rtc.Optional`1::hasValue
	bool ___hasValue_1;
};

// Agora.Rtc.Optional`1<System.UInt16>
struct Optional_1_tC0B7C5D987A3B3FBE615A0BA80C8AE46F260A6D5  : public RuntimeObject
{
	// T Agora.Rtc.Optional`1::value
	uint16_t ___value_0;
	// System.Boolean Agora.Rtc.Optional`1::hasValue
	bool ___hasValue_1;
};

// Agora.Rtc.Optional`1<System.UInt32>
struct Optional_1_t9D1D61BD0E1BAFD11E7902319403D52C0DF276FD  : public RuntimeObject
{
	// T Agora.Rtc.Optional`1::value
	uint32_t ___value_0;
	// System.Boolean Agora.Rtc.Optional`1::hasValue
	bool ___hasValue_1;
};

// Agora.Rtc.Optional`1<System.UInt64>
struct Optional_1_tD8A059C84DFD90B30DB7B4CAC4A0C5F232084498  : public RuntimeObject
{
	// T Agora.Rtc.Optional`1::value
	uint64_t ___value_0;
	// System.Boolean Agora.Rtc.Optional`1::hasValue
	bool ___hasValue_1;
};

// Agora.Rtc.Optional`1<Agora.Rtc.VIDEO_STREAM_TYPE>
struct Optional_1_tC5AB3A88C37AF5FA76EC96E7F6256F299BBA4827  : public RuntimeObject
{
	// T Agora.Rtc.Optional`1::value
	int32_t ___value_0;
	// System.Boolean Agora.Rtc.Optional`1::hasValue
	bool ___hasValue_1;
};

// System.Collections.Generic.Stack`1<System.Int32>
struct Stack_1_t3197E0F5EA36E611B259A88751D31FC2396FE4B6  : public RuntimeObject
{
	// T[] System.Collections.Generic.Stack`1::_array
	Int32U5BU5D_t19C97395396A72ECAF310612F0760F165060314C* ____array_0;
	// System.Int32 System.Collections.Generic.Stack`1::_size
	int32_t ____size_1;
	// System.Int32 System.Collections.Generic.Stack`1::_version
	int32_t ____version_2;
	// System.Object System.Collections.Generic.Stack`1::_syncRoot
	RuntimeObject* ____syncRoot_3;
};

// System.Collections.Generic.Stack`1<System.Object>
struct Stack_1_tAD790A47551563636908E21E4F08C54C0C323EB5  : public RuntimeObject
{
	// T[] System.Collections.Generic.Stack`1::_array
	ObjectU5BU5D_t8061030B0A12A55D5AD8652A20C922FE99450918* ____array_0;
	// System.Int32 System.Collections.Generic.Stack`1::_size
	int32_t ____size_1;
	// System.Int32 System.Collections.Generic.Stack`1::_version
	int32_t ____version_2;
	// System.Object System.Collections.Generic.Stack`1::_syncRoot
	RuntimeObject* ____syncRoot_3;
};

// System.Collections.Generic.Stack`1<Agora.Rtc.LitJson.WriterContext>
struct Stack_1_t7D2C4DA3105E485DD5491FB8B36FC2D66DA84336  : public RuntimeObject
{
	// T[] System.Collections.Generic.Stack`1::_array
	WriterContextU5BU5D_t5AD69F1BE0D77811ED5EF244CC68C1B422A2EE99* ____array_0;
	// System.Int32 System.Collections.Generic.Stack`1::_size
	int32_t ____size_1;
	// System.Int32 System.Collections.Generic.Stack`1::_version
	int32_t ____version_2;
	// System.Object System.Collections.Generic.Stack`1::_syncRoot
	RuntimeObject* ____syncRoot_3;
};

// Torymeta.Addressable.AddressableWrapper
struct AddressableWrapper_tE5A9032A2E5B8B8CC585239824D2603BFF52FC75  : public RuntimeObject
{
};

struct AddressableWrapper_tE5A9032A2E5B8B8CC585239824D2603BFF52FC75_StaticFields
{
	// System.Boolean Torymeta.Addressable.AddressableWrapper::isTest
	bool ___isTest_0;
	// System.String Torymeta.Addressable.AddressableWrapper::path
	String_t* ___path_1;
};
struct Il2CppArrayBounds;

// System.Globalization.CultureInfo
struct CultureInfo_t9BA817D41AD55AC8BD07480DD8AC22F8FFA378E0  : public RuntimeObject
{
	// System.Boolean System.Globalization.CultureInfo::m_isReadOnly
	bool ___m_isReadOnly_3;
	// System.Int32 System.Globalization.CultureInfo::cultureID
	int32_t ___cultureID_4;
	// System.Int32 System.Globalization.CultureInfo::parent_lcid
	int32_t ___parent_lcid_5;
	// System.Int32 System.Globalization.CultureInfo::datetime_index
	int32_t ___datetime_index_6;
	// System.Int32 System.Globalization.CultureInfo::number_index
	int32_t ___number_index_7;
	// System.Int32 System.Globalization.CultureInfo::default_calendar_type
	int32_t ___default_calendar_type_8;
	// System.Boolean System.Globalization.CultureInfo::m_useUserOverride
	bool ___m_useUserOverride_9;
	// System.Globalization.NumberFormatInfo modreq(System.Runtime.CompilerServices.IsVolatile) System.Globalization.CultureInfo::numInfo
	NumberFormatInfo_t8E26808B202927FEBF9064FCFEEA4D6E076E6472* ___numInfo_10;
	// System.Globalization.DateTimeFormatInfo modreq(System.Runtime.CompilerServices.IsVolatile) System.Globalization.CultureInfo::dateTimeInfo
	DateTimeFormatInfo_t0457520F9FA7B5C8EAAEB3AD50413B6AEEB7458A* ___dateTimeInfo_11;
	// System.Globalization.TextInfo modreq(System.Runtime.CompilerServices.IsVolatile) System.Globalization.CultureInfo::textInfo
	TextInfo_tD3BAFCFD77418851E7D5CB8D2588F47019E414B4* ___textInfo_12;
	// System.String System.Globalization.CultureInfo::m_name
	String_t* ___m_name_13;
	// System.String System.Globalization.CultureInfo::englishname
	String_t* ___englishname_14;
	// System.String System.Globalization.CultureInfo::nativename
	String_t* ___nativename_15;
	// System.String System.Globalization.CultureInfo::iso3lang
	String_t* ___iso3lang_16;
	// System.String System.Globalization.CultureInfo::iso2lang
	String_t* ___iso2lang_17;
	// System.String System.Globalization.CultureInfo::win3lang
	String_t* ___win3lang_18;
	// System.String System.Globalization.CultureInfo::territory
	String_t* ___territory_19;
	// System.String[] System.Globalization.CultureInfo::native_calendar_names
	StringU5BU5D_t7674CD946EC0CE7B3AE0BE70E6EE85F2ECD9F248* ___native_calendar_names_20;
	// System.Globalization.CompareInfo modreq(System.Runtime.CompilerServices.IsVolatile) System.Globalization.CultureInfo::compareInfo
	CompareInfo_t1B1A6AC3486B570C76ABA52149C9BD4CD82F9E57* ___compareInfo_21;
	// System.Void* System.Globalization.CultureInfo::textinfo_data
	void* ___textinfo_data_22;
	// System.Int32 System.Globalization.CultureInfo::m_dataItem
	int32_t ___m_dataItem_23;
	// System.Globalization.Calendar System.Globalization.CultureInfo::calendar
	Calendar_t0A117CC7532A54C17188C2EFEA1F79DB20DF3A3B* ___calendar_24;
	// System.Globalization.CultureInfo System.Globalization.CultureInfo::parent_culture
	CultureInfo_t9BA817D41AD55AC8BD07480DD8AC22F8FFA378E0* ___parent_culture_25;
	// System.Boolean System.Globalization.CultureInfo::constructed
	bool ___constructed_26;
	// System.Byte[] System.Globalization.CultureInfo::cached_serialized_form
	ByteU5BU5D_tA6237BF417AE52AD70CFB4EF24A7A82613DF9031* ___cached_serialized_form_27;
	// System.Globalization.CultureData System.Globalization.CultureInfo::m_cultureData
	CultureData_tEEFDCF4ECA1BBF6C0C8C94EB3541657245598F9D* ___m_cultureData_28;
	// System.Boolean System.Globalization.CultureInfo::m_isInherited
	bool ___m_isInherited_29;
};

struct CultureInfo_t9BA817D41AD55AC8BD07480DD8AC22F8FFA378E0_StaticFields
{
	// System.Globalization.CultureInfo modreq(System.Runtime.CompilerServices.IsVolatile) System.Globalization.CultureInfo::invariant_culture_info
	CultureInfo_t9BA817D41AD55AC8BD07480DD8AC22F8FFA378E0* ___invariant_culture_info_0;
	// System.Object System.Globalization.CultureInfo::shared_table_lock
	RuntimeObject* ___shared_table_lock_1;
	// System.Globalization.CultureInfo System.Globalization.CultureInfo::default_current_culture
	CultureInfo_t9BA817D41AD55AC8BD07480DD8AC22F8FFA378E0* ___default_current_culture_2;
	// System.Globalization.CultureInfo modreq(System.Runtime.CompilerServices.IsVolatile) System.Globalization.CultureInfo::s_DefaultThreadCurrentUICulture
	CultureInfo_t9BA817D41AD55AC8BD07480DD8AC22F8FFA378E0* ___s_DefaultThreadCurrentUICulture_34;
	// System.Globalization.CultureInfo modreq(System.Runtime.CompilerServices.IsVolatile) System.Globalization.CultureInfo::s_DefaultThreadCurrentCulture
	CultureInfo_t9BA817D41AD55AC8BD07480DD8AC22F8FFA378E0* ___s_DefaultThreadCurrentCulture_35;
	// System.Collections.Generic.Dictionary`2<System.Int32,System.Globalization.CultureInfo> System.Globalization.CultureInfo::shared_by_number
	Dictionary_2_t9FA6D82CAFC18769F7515BB51D1C56DAE09381C3* ___shared_by_number_36;
	// System.Collections.Generic.Dictionary`2<System.String,System.Globalization.CultureInfo> System.Globalization.CultureInfo::shared_by_name
	Dictionary_2_tE1603CE612C16451D1E56FF4D4859D4FE4087C28* ___shared_by_name_37;
	// System.Globalization.CultureInfo System.Globalization.CultureInfo::s_UserPreferredCultureInfoInAppX
	CultureInfo_t9BA817D41AD55AC8BD07480DD8AC22F8FFA378E0* ___s_UserPreferredCultureInfoInAppX_38;
	// System.Boolean System.Globalization.CultureInfo::IsTaiwanSku
	bool ___IsTaiwanSku_39;
};
// Native definition for P/Invoke marshalling of System.Globalization.CultureInfo
struct CultureInfo_t9BA817D41AD55AC8BD07480DD8AC22F8FFA378E0_marshaled_pinvoke
{
	int32_t ___m_isReadOnly_3;
	int32_t ___cultureID_4;
	int32_t ___parent_lcid_5;
	int32_t ___datetime_index_6;
	int32_t ___number_index_7;
	int32_t ___default_calendar_type_8;
	int32_t ___m_useUserOverride_9;
	NumberFormatInfo_t8E26808B202927FEBF9064FCFEEA4D6E076E6472* ___numInfo_10;
	DateTimeFormatInfo_t0457520F9FA7B5C8EAAEB3AD50413B6AEEB7458A* ___dateTimeInfo_11;
	TextInfo_tD3BAFCFD77418851E7D5CB8D2588F47019E414B4* ___textInfo_12;
	char* ___m_name_13;
	char* ___englishname_14;
	char* ___nativename_15;
	char* ___iso3lang_16;
	char* ___iso2lang_17;
	char* ___win3lang_18;
	char* ___territory_19;
	char** ___native_calendar_names_20;
	CompareInfo_t1B1A6AC3486B570C76ABA52149C9BD4CD82F9E57* ___compareInfo_21;
	void* ___textinfo_data_22;
	int32_t ___m_dataItem_23;
	Calendar_t0A117CC7532A54C17188C2EFEA1F79DB20DF3A3B* ___calendar_24;
	CultureInfo_t9BA817D41AD55AC8BD07480DD8AC22F8FFA378E0_marshaled_pinvoke* ___parent_culture_25;
	int32_t ___constructed_26;
	Il2CppSafeArray/*NONE*/* ___cached_serialized_form_27;
	CultureData_tEEFDCF4ECA1BBF6C0C8C94EB3541657245598F9D_marshaled_pinvoke* ___m_cultureData_28;
	int32_t ___m_isInherited_29;
};
// Native definition for COM marshalling of System.Globalization.CultureInfo
struct CultureInfo_t9BA817D41AD55AC8BD07480DD8AC22F8FFA378E0_marshaled_com
{
	int32_t ___m_isReadOnly_3;
	int32_t ___cultureID_4;
	int32_t ___parent_lcid_5;
	int32_t ___datetime_index_6;
	int32_t ___number_index_7;
	int32_t ___default_calendar_type_8;
	int32_t ___m_useUserOverride_9;
	NumberFormatInfo_t8E26808B202927FEBF9064FCFEEA4D6E076E6472* ___numInfo_10;
	DateTimeFormatInfo_t0457520F9FA7B5C8EAAEB3AD50413B6AEEB7458A* ___dateTimeInfo_11;
	TextInfo_tD3BAFCFD77418851E7D5CB8D2588F47019E414B4* ___textInfo_12;
	Il2CppChar* ___m_name_13;
	Il2CppChar* ___englishname_14;
	Il2CppChar* ___nativename_15;
	Il2CppChar* ___iso3lang_16;
	Il2CppChar* ___iso2lang_17;
	Il2CppChar* ___win3lang_18;
	Il2CppChar* ___territory_19;
	Il2CppChar** ___native_calendar_names_20;
	CompareInfo_t1B1A6AC3486B570C76ABA52149C9BD4CD82F9E57* ___compareInfo_21;
	void* ___textinfo_data_22;
	int32_t ___m_dataItem_23;
	Calendar_t0A117CC7532A54C17188C2EFEA1F79DB20DF3A3B* ___calendar_24;
	CultureInfo_t9BA817D41AD55AC8BD07480DD8AC22F8FFA378E0_marshaled_com* ___parent_culture_25;
	int32_t ___constructed_26;
	Il2CppSafeArray/*NONE*/* ___cached_serialized_form_27;
	CultureData_tEEFDCF4ECA1BBF6C0C8C94EB3541657245598F9D_marshaled_com* ___m_cultureData_28;
	int32_t ___m_isInherited_29;
};

// Agora.Rtc.LitJson.FsmContext
struct FsmContext_tC11B461D4D90680FC71416881106E6AF48CAE21F  : public RuntimeObject
{
	// System.Boolean Agora.Rtc.LitJson.FsmContext::Return
	bool ___Return_0;
	// System.Int32 Agora.Rtc.LitJson.FsmContext::NextState
	int32_t ___NextState_1;
	// Agora.Rtc.LitJson.Lexer Agora.Rtc.LitJson.FsmContext::L
	Lexer_tDC14CFA7B390E884510F554D9D1E03188A185E27* ___L_2;
	// System.Int32 Agora.Rtc.LitJson.FsmContext::StateStack
	int32_t ___StateStack_3;
};

// Agora.Rtc.LitJson.JsonData
struct JsonData_t84ADF600AA1B164B56CAFAAF965FE17B8A3543D5  : public RuntimeObject
{
	// System.Collections.Generic.IList`1<Agora.Rtc.LitJson.JsonData> Agora.Rtc.LitJson.JsonData::inst_array
	RuntimeObject* ___inst_array_0;
	// System.Boolean Agora.Rtc.LitJson.JsonData::inst_boolean
	bool ___inst_boolean_1;
	// System.Double Agora.Rtc.LitJson.JsonData::inst_double
	double ___inst_double_2;
	// System.Int32 Agora.Rtc.LitJson.JsonData::inst_int
	int32_t ___inst_int_3;
	// System.UInt32 Agora.Rtc.LitJson.JsonData::inst_uint
	uint32_t ___inst_uint_4;
	// System.Int64 Agora.Rtc.LitJson.JsonData::inst_long
	int64_t ___inst_long_5;
	// System.UInt64 Agora.Rtc.LitJson.JsonData::inst_ulong
	uint64_t ___inst_ulong_6;
	// System.Collections.Generic.IDictionary`2<System.String,Agora.Rtc.LitJson.JsonData> Agora.Rtc.LitJson.JsonData::inst_object
	RuntimeObject* ___inst_object_7;
	// System.String Agora.Rtc.LitJson.JsonData::inst_string
	String_t* ___inst_string_8;
	// System.String Agora.Rtc.LitJson.JsonData::json
	String_t* ___json_9;
	// Agora.Rtc.LitJson.JsonType Agora.Rtc.LitJson.JsonData::type
	int32_t ___type_10;
	// System.Collections.Generic.IList`1<System.Collections.Generic.KeyValuePair`2<System.String,Agora.Rtc.LitJson.JsonData>> Agora.Rtc.LitJson.JsonData::object_list
	RuntimeObject* ___object_list_11;
};

// Agora.Rtc.LitJson.JsonMapper
struct JsonMapper_t3A3F5A7CFFC63F7DF9A3563D52974D21D47798F2  : public RuntimeObject
{
};

struct JsonMapper_t3A3F5A7CFFC63F7DF9A3563D52974D21D47798F2_StaticFields
{
	// System.Int32 Agora.Rtc.LitJson.JsonMapper::max_nesting_depth
	int32_t ___max_nesting_depth_0;
	// System.IFormatProvider Agora.Rtc.LitJson.JsonMapper::datetime_format
	RuntimeObject* ___datetime_format_1;
	// System.Collections.Generic.IDictionary`2<System.Type,Agora.Rtc.LitJson.ExporterFunc> Agora.Rtc.LitJson.JsonMapper::base_exporters_table
	RuntimeObject* ___base_exporters_table_2;
	// System.Collections.Generic.IDictionary`2<System.Type,Agora.Rtc.LitJson.ExporterFunc> Agora.Rtc.LitJson.JsonMapper::custom_exporters_table
	RuntimeObject* ___custom_exporters_table_3;
	// System.Collections.Generic.IDictionary`2<System.Type,System.Collections.Generic.IDictionary`2<System.Type,Agora.Rtc.LitJson.ImporterFunc>> Agora.Rtc.LitJson.JsonMapper::base_importers_table
	RuntimeObject* ___base_importers_table_4;
	// System.Collections.Generic.IDictionary`2<System.Type,System.Collections.Generic.IDictionary`2<System.Type,Agora.Rtc.LitJson.ImporterFunc>> Agora.Rtc.LitJson.JsonMapper::custom_importers_table
	RuntimeObject* ___custom_importers_table_5;
	// System.Collections.Generic.IDictionary`2<System.Type,Agora.Rtc.LitJson.ArrayMetadata> Agora.Rtc.LitJson.JsonMapper::array_metadata
	RuntimeObject* ___array_metadata_6;
	// System.Object Agora.Rtc.LitJson.JsonMapper::array_metadata_lock
	RuntimeObject* ___array_metadata_lock_7;
	// System.Collections.Generic.IDictionary`2<System.Type,System.Collections.Generic.IDictionary`2<System.Type,System.Reflection.MethodInfo>> Agora.Rtc.LitJson.JsonMapper::conv_ops
	RuntimeObject* ___conv_ops_8;
	// System.Object Agora.Rtc.LitJson.JsonMapper::conv_ops_lock
	RuntimeObject* ___conv_ops_lock_9;
	// System.Collections.Generic.IDictionary`2<System.Type,Agora.Rtc.LitJson.ObjectMetadata> Agora.Rtc.LitJson.JsonMapper::object_metadata
	RuntimeObject* ___object_metadata_10;
	// System.Object Agora.Rtc.LitJson.JsonMapper::object_metadata_lock
	RuntimeObject* ___object_metadata_lock_11;
	// System.Collections.Generic.IDictionary`2<System.Type,System.Collections.Generic.IList`1<Agora.Rtc.LitJson.PropertyMetadata>> Agora.Rtc.LitJson.JsonMapper::type_properties
	RuntimeObject* ___type_properties_12;
	// System.Object Agora.Rtc.LitJson.JsonMapper::type_properties_lock
	RuntimeObject* ___type_properties_lock_13;
	// Agora.Rtc.LitJson.JsonWriter Agora.Rtc.LitJson.JsonMapper::static_writer
	JsonWriter_tC9B032D35ED4E85319A227892A43EB8627661732* ___static_writer_14;
	// System.Object Agora.Rtc.LitJson.JsonMapper::static_writer_lock
	RuntimeObject* ___static_writer_lock_15;
};

// Agora.Rtc.LitJson.JsonMockWrapper
struct JsonMockWrapper_tE04391F97D9A84CC02FF454281A59C54DE05355C  : public RuntimeObject
{
};

// Agora.Rtc.LitJson.JsonReader
struct JsonReader_tE72AF24875A229A65356715AAFF4C23E38105A3F  : public RuntimeObject
{
	// System.Collections.Generic.Stack`1<System.Int32> Agora.Rtc.LitJson.JsonReader::automaton_stack
	Stack_1_t3197E0F5EA36E611B259A88751D31FC2396FE4B6* ___automaton_stack_1;
	// System.Int32 Agora.Rtc.LitJson.JsonReader::current_input
	int32_t ___current_input_2;
	// System.Int32 Agora.Rtc.LitJson.JsonReader::current_symbol
	int32_t ___current_symbol_3;
	// System.Boolean Agora.Rtc.LitJson.JsonReader::end_of_json
	bool ___end_of_json_4;
	// System.Boolean Agora.Rtc.LitJson.JsonReader::end_of_input
	bool ___end_of_input_5;
	// Agora.Rtc.LitJson.Lexer Agora.Rtc.LitJson.JsonReader::lexer
	Lexer_tDC14CFA7B390E884510F554D9D1E03188A185E27* ___lexer_6;
	// System.Boolean Agora.Rtc.LitJson.JsonReader::parser_in_string
	bool ___parser_in_string_7;
	// System.Boolean Agora.Rtc.LitJson.JsonReader::parser_return
	bool ___parser_return_8;
	// System.Boolean Agora.Rtc.LitJson.JsonReader::read_started
	bool ___read_started_9;
	// System.IO.TextReader Agora.Rtc.LitJson.JsonReader::reader
	TextReader_tB8D43017CB6BE1633E5A86D64E7757366507C1F7* ___reader_10;
	// System.Boolean Agora.Rtc.LitJson.JsonReader::reader_is_owned
	bool ___reader_is_owned_11;
	// System.Boolean Agora.Rtc.LitJson.JsonReader::skip_non_members
	bool ___skip_non_members_12;
	// System.Object Agora.Rtc.LitJson.JsonReader::token_value
	RuntimeObject* ___token_value_13;
	// Agora.Rtc.LitJson.JsonToken Agora.Rtc.LitJson.JsonReader::token
	int32_t ___token_14;
};

struct JsonReader_tE72AF24875A229A65356715AAFF4C23E38105A3F_StaticFields
{
	// System.Collections.Generic.IDictionary`2<System.Int32,System.Collections.Generic.IDictionary`2<System.Int32,System.Int32[]>> Agora.Rtc.LitJson.JsonReader::parse_table
	RuntimeObject* ___parse_table_0;
};

// Agora.Rtc.LitJson.JsonWriter
struct JsonWriter_tC9B032D35ED4E85319A227892A43EB8627661732  : public RuntimeObject
{
	// Agora.Rtc.LitJson.WriterContext Agora.Rtc.LitJson.JsonWriter::context
	WriterContext_tAA13A82DA53BA6A99795422A71F6D19F331F30BA* ___context_1;
	// System.Collections.Generic.Stack`1<Agora.Rtc.LitJson.WriterContext> Agora.Rtc.LitJson.JsonWriter::ctx_stack
	Stack_1_t7D2C4DA3105E485DD5491FB8B36FC2D66DA84336* ___ctx_stack_2;
	// System.Boolean Agora.Rtc.LitJson.JsonWriter::has_reached_end
	bool ___has_reached_end_3;
	// System.Char[] Agora.Rtc.LitJson.JsonWriter::hex_seq
	CharU5BU5D_t799905CF001DD5F13F7DBB310181FC4D8B7D0AAB* ___hex_seq_4;
	// System.Int32 Agora.Rtc.LitJson.JsonWriter::indentation
	int32_t ___indentation_5;
	// System.Int32 Agora.Rtc.LitJson.JsonWriter::indent_value
	int32_t ___indent_value_6;
	// System.Text.StringBuilder Agora.Rtc.LitJson.JsonWriter::inst_string_builder
	StringBuilder_t* ___inst_string_builder_7;
	// System.Boolean Agora.Rtc.LitJson.JsonWriter::pretty_print
	bool ___pretty_print_8;
	// System.Boolean Agora.Rtc.LitJson.JsonWriter::validate
	bool ___validate_9;
	// System.Boolean Agora.Rtc.LitJson.JsonWriter::lower_case_properties
	bool ___lower_case_properties_10;
	// System.IO.TextWriter Agora.Rtc.LitJson.JsonWriter::writer
	TextWriter_tA9E5461506CF806E17B6BBBF2119359DEDA3F0F3* ___writer_11;
};

struct JsonWriter_tC9B032D35ED4E85319A227892A43EB8627661732_StaticFields
{
	// System.Globalization.NumberFormatInfo Agora.Rtc.LitJson.JsonWriter::number_format
	NumberFormatInfo_t8E26808B202927FEBF9064FCFEEA4D6E076E6472* ___number_format_0;
};

// Agora.Rtc.LitJson.Lexer
struct Lexer_tDC14CFA7B390E884510F554D9D1E03188A185E27  : public RuntimeObject
{
	// System.Boolean Agora.Rtc.LitJson.Lexer::allow_comments
	bool ___allow_comments_2;
	// System.Boolean Agora.Rtc.LitJson.Lexer::allow_single_quoted_strings
	bool ___allow_single_quoted_strings_3;
	// System.Boolean Agora.Rtc.LitJson.Lexer::end_of_input
	bool ___end_of_input_4;
	// Agora.Rtc.LitJson.FsmContext Agora.Rtc.LitJson.Lexer::fsm_context
	FsmContext_tC11B461D4D90680FC71416881106E6AF48CAE21F* ___fsm_context_5;
	// System.Int32 Agora.Rtc.LitJson.Lexer::input_buffer
	int32_t ___input_buffer_6;
	// System.Int32 Agora.Rtc.LitJson.Lexer::input_char
	int32_t ___input_char_7;
	// System.IO.TextReader Agora.Rtc.LitJson.Lexer::reader
	TextReader_tB8D43017CB6BE1633E5A86D64E7757366507C1F7* ___reader_8;
	// System.Int32 Agora.Rtc.LitJson.Lexer::state
	int32_t ___state_9;
	// System.Text.StringBuilder Agora.Rtc.LitJson.Lexer::string_buffer
	StringBuilder_t* ___string_buffer_10;
	// System.String Agora.Rtc.LitJson.Lexer::string_value
	String_t* ___string_value_11;
	// System.Int32 Agora.Rtc.LitJson.Lexer::token
	int32_t ___token_12;
	// System.Int32 Agora.Rtc.LitJson.Lexer::unichar
	int32_t ___unichar_13;
};

struct Lexer_tDC14CFA7B390E884510F554D9D1E03188A185E27_StaticFields
{
	// System.Int32[] Agora.Rtc.LitJson.Lexer::fsm_return_table
	Int32U5BU5D_t19C97395396A72ECAF310612F0760F165060314C* ___fsm_return_table_0;
	// Agora.Rtc.LitJson.Lexer/StateHandler[] Agora.Rtc.LitJson.Lexer::fsm_handler_table
	StateHandlerU5BU5D_t766A22C9C454D383614ED21CB99EAD5F5F15438B* ___fsm_handler_table_1;
};

// System.MarshalByRefObject
struct MarshalByRefObject_t8C2F4C5854177FD60439EB1FCCFC1B3CFAFE8DCE  : public RuntimeObject
{
	// System.Object System.MarshalByRefObject::_identity
	RuntimeObject* ____identity_0;
};
// Native definition for P/Invoke marshalling of System.MarshalByRefObject
struct MarshalByRefObject_t8C2F4C5854177FD60439EB1FCCFC1B3CFAFE8DCE_marshaled_pinvoke
{
	Il2CppIUnknown* ____identity_0;
};
// Native definition for COM marshalling of System.MarshalByRefObject
struct MarshalByRefObject_t8C2F4C5854177FD60439EB1FCCFC1B3CFAFE8DCE_marshaled_com
{
	Il2CppIUnknown* ____identity_0;
};

// System.Globalization.NumberFormatInfo
struct NumberFormatInfo_t8E26808B202927FEBF9064FCFEEA4D6E076E6472  : public RuntimeObject
{
	// System.Int32[] System.Globalization.NumberFormatInfo::numberGroupSizes
	Int32U5BU5D_t19C97395396A72ECAF310612F0760F165060314C* ___numberGroupSizes_1;
	// System.Int32[] System.Globalization.NumberFormatInfo::currencyGroupSizes
	Int32U5BU5D_t19C97395396A72ECAF310612F0760F165060314C* ___currencyGroupSizes_2;
	// System.Int32[] System.Globalization.NumberFormatInfo::percentGroupSizes
	Int32U5BU5D_t19C97395396A72ECAF310612F0760F165060314C* ___percentGroupSizes_3;
	// System.String System.Globalization.NumberFormatInfo::positiveSign
	String_t* ___positiveSign_4;
	// System.String System.Globalization.NumberFormatInfo::negativeSign
	String_t* ___negativeSign_5;
	// System.String System.Globalization.NumberFormatInfo::numberDecimalSeparator
	String_t* ___numberDecimalSeparator_6;
	// System.String System.Globalization.NumberFormatInfo::numberGroupSeparator
	String_t* ___numberGroupSeparator_7;
	// System.String System.Globalization.NumberFormatInfo::currencyGroupSeparator
	String_t* ___currencyGroupSeparator_8;
	// System.String System.Globalization.NumberFormatInfo::currencyDecimalSeparator
	String_t* ___currencyDecimalSeparator_9;
	// System.String System.Globalization.NumberFormatInfo::currencySymbol
	String_t* ___currencySymbol_10;
	// System.String System.Globalization.NumberFormatInfo::ansiCurrencySymbol
	String_t* ___ansiCurrencySymbol_11;
	// System.String System.Globalization.NumberFormatInfo::nanSymbol
	String_t* ___nanSymbol_12;
	// System.String System.Globalization.NumberFormatInfo::positiveInfinitySymbol
	String_t* ___positiveInfinitySymbol_13;
	// System.String System.Globalization.NumberFormatInfo::negativeInfinitySymbol
	String_t* ___negativeInfinitySymbol_14;
	// System.String System.Globalization.NumberFormatInfo::percentDecimalSeparator
	String_t* ___percentDecimalSeparator_15;
	// System.String System.Globalization.NumberFormatInfo::percentGroupSeparator
	String_t* ___percentGroupSeparator_16;
	// System.String System.Globalization.NumberFormatInfo::percentSymbol
	String_t* ___percentSymbol_17;
	// System.String System.Globalization.NumberFormatInfo::perMilleSymbol
	String_t* ___perMilleSymbol_18;
	// System.String[] System.Globalization.NumberFormatInfo::nativeDigits
	StringU5BU5D_t7674CD946EC0CE7B3AE0BE70E6EE85F2ECD9F248* ___nativeDigits_19;
	// System.Int32 System.Globalization.NumberFormatInfo::m_dataItem
	int32_t ___m_dataItem_20;
	// System.Int32 System.Globalization.NumberFormatInfo::numberDecimalDigits
	int32_t ___numberDecimalDigits_21;
	// System.Int32 System.Globalization.NumberFormatInfo::currencyDecimalDigits
	int32_t ___currencyDecimalDigits_22;
	// System.Int32 System.Globalization.NumberFormatInfo::currencyPositivePattern
	int32_t ___currencyPositivePattern_23;
	// System.Int32 System.Globalization.NumberFormatInfo::currencyNegativePattern
	int32_t ___currencyNegativePattern_24;
	// System.Int32 System.Globalization.NumberFormatInfo::numberNegativePattern
	int32_t ___numberNegativePattern_25;
	// System.Int32 System.Globalization.NumberFormatInfo::percentPositivePattern
	int32_t ___percentPositivePattern_26;
	// System.Int32 System.Globalization.NumberFormatInfo::percentNegativePattern
	int32_t ___percentNegativePattern_27;
	// System.Int32 System.Globalization.NumberFormatInfo::percentDecimalDigits
	int32_t ___percentDecimalDigits_28;
	// System.Int32 System.Globalization.NumberFormatInfo::digitSubstitution
	int32_t ___digitSubstitution_29;
	// System.Boolean System.Globalization.NumberFormatInfo::isReadOnly
	bool ___isReadOnly_30;
	// System.Boolean System.Globalization.NumberFormatInfo::m_useUserOverride
	bool ___m_useUserOverride_31;
	// System.Boolean System.Globalization.NumberFormatInfo::m_isInvariant
	bool ___m_isInvariant_32;
	// System.Boolean System.Globalization.NumberFormatInfo::validForParseAsNumber
	bool ___validForParseAsNumber_33;
	// System.Boolean System.Globalization.NumberFormatInfo::validForParseAsCurrency
	bool ___validForParseAsCurrency_34;
};

struct NumberFormatInfo_t8E26808B202927FEBF9064FCFEEA4D6E076E6472_StaticFields
{
	// System.Globalization.NumberFormatInfo modreq(System.Runtime.CompilerServices.IsVolatile) System.Globalization.NumberFormatInfo::invariantInfo
	NumberFormatInfo_t8E26808B202927FEBF9064FCFEEA4D6E076E6472* ___invariantInfo_0;
};

// System.String
struct String_t  : public RuntimeObject
{
	// System.Int32 System.String::_stringLength
	int32_t ____stringLength_4;
	// System.Char System.String::_firstChar
	Il2CppChar ____firstChar_5;
};

struct String_t_StaticFields
{
	// System.String System.String::Empty
	String_t* ___Empty_6;
};

// System.Text.StringBuilder
struct StringBuilder_t  : public RuntimeObject
{
	// System.Char[] System.Text.StringBuilder::m_ChunkChars
	CharU5BU5D_t799905CF001DD5F13F7DBB310181FC4D8B7D0AAB* ___m_ChunkChars_0;
	// System.Text.StringBuilder System.Text.StringBuilder::m_ChunkPrevious
	StringBuilder_t* ___m_ChunkPrevious_1;
	// System.Int32 System.Text.StringBuilder::m_ChunkLength
	int32_t ___m_ChunkLength_2;
	// System.Int32 System.Text.StringBuilder::m_ChunkOffset
	int32_t ___m_ChunkOffset_3;
	// System.Int32 System.Text.StringBuilder::m_MaxCapacity
	int32_t ___m_MaxCapacity_4;
};

// System.ValueType
struct ValueType_t6D9B272BD21782F0A9A14F2E41F85A50E97A986F  : public RuntimeObject
{
};
// Native definition for P/Invoke marshalling of System.ValueType
struct ValueType_t6D9B272BD21782F0A9A14F2E41F85A50E97A986F_marshaled_pinvoke
{
};
// Native definition for COM marshalling of System.ValueType
struct ValueType_t6D9B272BD21782F0A9A14F2E41F85A50E97A986F_marshaled_com
{
};

// Agora.Rtc.LitJson.WriterContext
struct WriterContext_tAA13A82DA53BA6A99795422A71F6D19F331F30BA  : public RuntimeObject
{
	// System.Int32 Agora.Rtc.LitJson.WriterContext::Count
	int32_t ___Count_0;
	// System.Boolean Agora.Rtc.LitJson.WriterContext::InArray
	bool ___InArray_1;
	// System.Boolean Agora.Rtc.LitJson.WriterContext::InObject
	bool ___InObject_2;
	// System.Boolean Agora.Rtc.LitJson.WriterContext::ExpectingValue
	bool ___ExpectingValue_3;
	// System.Int32 Agora.Rtc.LitJson.WriterContext::Padding
	int32_t ___Padding_4;
};

// Agora.Rtc.LitJson.JsonMapper/<>c
struct U3CU3Ec_tB2417947DB790EC3B314B9BB1046B04B68400CDA  : public RuntimeObject
{
};

struct U3CU3Ec_tB2417947DB790EC3B314B9BB1046B04B68400CDA_StaticFields
{
	// Agora.Rtc.LitJson.JsonMapper/<>c Agora.Rtc.LitJson.JsonMapper/<>c::<>9
	U3CU3Ec_tB2417947DB790EC3B314B9BB1046B04B68400CDA* ___U3CU3E9_0;
	// Agora.Rtc.LitJson.WrapperFactory Agora.Rtc.LitJson.JsonMapper/<>c::<>9__23_0
	WrapperFactory_t92E5AF7D73458CC8A0E1D25FE2B2D3A07CCE07B9* ___U3CU3E9__23_0_1;
	// Agora.Rtc.LitJson.ExporterFunc Agora.Rtc.LitJson.JsonMapper/<>c::<>9__24_0
	ExporterFunc_tB3923D0991F0FAE9055F93A0F7C67E5885568CC4* ___U3CU3E9__24_0_2;
	// Agora.Rtc.LitJson.ExporterFunc Agora.Rtc.LitJson.JsonMapper/<>c::<>9__24_1
	ExporterFunc_tB3923D0991F0FAE9055F93A0F7C67E5885568CC4* ___U3CU3E9__24_1_3;
	// Agora.Rtc.LitJson.ExporterFunc Agora.Rtc.LitJson.JsonMapper/<>c::<>9__24_2
	ExporterFunc_tB3923D0991F0FAE9055F93A0F7C67E5885568CC4* ___U3CU3E9__24_2_4;
	// Agora.Rtc.LitJson.ExporterFunc Agora.Rtc.LitJson.JsonMapper/<>c::<>9__24_3
	ExporterFunc_tB3923D0991F0FAE9055F93A0F7C67E5885568CC4* ___U3CU3E9__24_3_5;
	// Agora.Rtc.LitJson.ExporterFunc Agora.Rtc.LitJson.JsonMapper/<>c::<>9__24_4
	ExporterFunc_tB3923D0991F0FAE9055F93A0F7C67E5885568CC4* ___U3CU3E9__24_4_6;
	// Agora.Rtc.LitJson.ExporterFunc Agora.Rtc.LitJson.JsonMapper/<>c::<>9__24_5
	ExporterFunc_tB3923D0991F0FAE9055F93A0F7C67E5885568CC4* ___U3CU3E9__24_5_7;
	// Agora.Rtc.LitJson.ExporterFunc Agora.Rtc.LitJson.JsonMapper/<>c::<>9__24_6
	ExporterFunc_tB3923D0991F0FAE9055F93A0F7C67E5885568CC4* ___U3CU3E9__24_6_8;
	// Agora.Rtc.LitJson.ExporterFunc Agora.Rtc.LitJson.JsonMapper/<>c::<>9__24_7
	ExporterFunc_tB3923D0991F0FAE9055F93A0F7C67E5885568CC4* ___U3CU3E9__24_7_9;
	// Agora.Rtc.LitJson.ExporterFunc Agora.Rtc.LitJson.JsonMapper/<>c::<>9__24_8
	ExporterFunc_tB3923D0991F0FAE9055F93A0F7C67E5885568CC4* ___U3CU3E9__24_8_10;
	// Agora.Rtc.LitJson.ExporterFunc Agora.Rtc.LitJson.JsonMapper/<>c::<>9__24_9
	ExporterFunc_tB3923D0991F0FAE9055F93A0F7C67E5885568CC4* ___U3CU3E9__24_9_11;
	// Agora.Rtc.LitJson.ImporterFunc Agora.Rtc.LitJson.JsonMapper/<>c::<>9__26_0
	ImporterFunc_tC3095AD1938F844CD79CF79C1F2A2199CA03ABCD* ___U3CU3E9__26_0_12;
	// Agora.Rtc.LitJson.ImporterFunc Agora.Rtc.LitJson.JsonMapper/<>c::<>9__26_1
	ImporterFunc_tC3095AD1938F844CD79CF79C1F2A2199CA03ABCD* ___U3CU3E9__26_1_13;
	// Agora.Rtc.LitJson.ImporterFunc Agora.Rtc.LitJson.JsonMapper/<>c::<>9__26_2
	ImporterFunc_tC3095AD1938F844CD79CF79C1F2A2199CA03ABCD* ___U3CU3E9__26_2_14;
	// Agora.Rtc.LitJson.ImporterFunc Agora.Rtc.LitJson.JsonMapper/<>c::<>9__26_3
	ImporterFunc_tC3095AD1938F844CD79CF79C1F2A2199CA03ABCD* ___U3CU3E9__26_3_15;
	// Agora.Rtc.LitJson.ImporterFunc Agora.Rtc.LitJson.JsonMapper/<>c::<>9__26_4
	ImporterFunc_tC3095AD1938F844CD79CF79C1F2A2199CA03ABCD* ___U3CU3E9__26_4_16;
	// Agora.Rtc.LitJson.ImporterFunc Agora.Rtc.LitJson.JsonMapper/<>c::<>9__26_5
	ImporterFunc_tC3095AD1938F844CD79CF79C1F2A2199CA03ABCD* ___U3CU3E9__26_5_17;
	// Agora.Rtc.LitJson.ImporterFunc Agora.Rtc.LitJson.JsonMapper/<>c::<>9__26_6
	ImporterFunc_tC3095AD1938F844CD79CF79C1F2A2199CA03ABCD* ___U3CU3E9__26_6_18;
	// Agora.Rtc.LitJson.ImporterFunc Agora.Rtc.LitJson.JsonMapper/<>c::<>9__26_7
	ImporterFunc_tC3095AD1938F844CD79CF79C1F2A2199CA03ABCD* ___U3CU3E9__26_7_19;
	// Agora.Rtc.LitJson.ImporterFunc Agora.Rtc.LitJson.JsonMapper/<>c::<>9__26_8
	ImporterFunc_tC3095AD1938F844CD79CF79C1F2A2199CA03ABCD* ___U3CU3E9__26_8_20;
	// Agora.Rtc.LitJson.ImporterFunc Agora.Rtc.LitJson.JsonMapper/<>c::<>9__26_9
	ImporterFunc_tC3095AD1938F844CD79CF79C1F2A2199CA03ABCD* ___U3CU3E9__26_9_21;
	// Agora.Rtc.LitJson.ImporterFunc Agora.Rtc.LitJson.JsonMapper/<>c::<>9__26_10
	ImporterFunc_tC3095AD1938F844CD79CF79C1F2A2199CA03ABCD* ___U3CU3E9__26_10_22;
	// Agora.Rtc.LitJson.ImporterFunc Agora.Rtc.LitJson.JsonMapper/<>c::<>9__26_11
	ImporterFunc_tC3095AD1938F844CD79CF79C1F2A2199CA03ABCD* ___U3CU3E9__26_11_23;
	// Agora.Rtc.LitJson.ImporterFunc Agora.Rtc.LitJson.JsonMapper/<>c::<>9__26_12
	ImporterFunc_tC3095AD1938F844CD79CF79C1F2A2199CA03ABCD* ___U3CU3E9__26_12_24;
	// Agora.Rtc.LitJson.ImporterFunc Agora.Rtc.LitJson.JsonMapper/<>c::<>9__26_13
	ImporterFunc_tC3095AD1938F844CD79CF79C1F2A2199CA03ABCD* ___U3CU3E9__26_13_25;
	// Agora.Rtc.LitJson.ImporterFunc Agora.Rtc.LitJson.JsonMapper/<>c::<>9__26_14
	ImporterFunc_tC3095AD1938F844CD79CF79C1F2A2199CA03ABCD* ___U3CU3E9__26_14_26;
	// Agora.Rtc.LitJson.ImporterFunc Agora.Rtc.LitJson.JsonMapper/<>c::<>9__26_15
	ImporterFunc_tC3095AD1938F844CD79CF79C1F2A2199CA03ABCD* ___U3CU3E9__26_15_27;
	// Agora.Rtc.LitJson.ImporterFunc Agora.Rtc.LitJson.JsonMapper/<>c::<>9__26_16
	ImporterFunc_tC3095AD1938F844CD79CF79C1F2A2199CA03ABCD* ___U3CU3E9__26_16_28;
	// Agora.Rtc.LitJson.ImporterFunc Agora.Rtc.LitJson.JsonMapper/<>c::<>9__26_17
	ImporterFunc_tC3095AD1938F844CD79CF79C1F2A2199CA03ABCD* ___U3CU3E9__26_17_29;
	// Agora.Rtc.LitJson.ImporterFunc Agora.Rtc.LitJson.JsonMapper/<>c::<>9__26_18
	ImporterFunc_tC3095AD1938F844CD79CF79C1F2A2199CA03ABCD* ___U3CU3E9__26_18_30;
	// Agora.Rtc.LitJson.ImporterFunc Agora.Rtc.LitJson.JsonMapper/<>c::<>9__27_0
	ImporterFunc_tC3095AD1938F844CD79CF79C1F2A2199CA03ABCD* ___U3CU3E9__27_0_31;
	// Agora.Rtc.LitJson.ImporterFunc Agora.Rtc.LitJson.JsonMapper/<>c::<>9__27_1
	ImporterFunc_tC3095AD1938F844CD79CF79C1F2A2199CA03ABCD* ___U3CU3E9__27_1_32;
	// Agora.Rtc.LitJson.ImporterFunc Agora.Rtc.LitJson.JsonMapper/<>c::<>9__27_2
	ImporterFunc_tC3095AD1938F844CD79CF79C1F2A2199CA03ABCD* ___U3CU3E9__27_2_33;
	// Agora.Rtc.LitJson.ImporterFunc Agora.Rtc.LitJson.JsonMapper/<>c::<>9__27_3
	ImporterFunc_tC3095AD1938F844CD79CF79C1F2A2199CA03ABCD* ___U3CU3E9__27_3_34;
	// Agora.Rtc.LitJson.ImporterFunc Agora.Rtc.LitJson.JsonMapper/<>c::<>9__27_4
	ImporterFunc_tC3095AD1938F844CD79CF79C1F2A2199CA03ABCD* ___U3CU3E9__27_4_35;
	// Agora.Rtc.LitJson.ImporterFunc Agora.Rtc.LitJson.JsonMapper/<>c::<>9__27_5
	ImporterFunc_tC3095AD1938F844CD79CF79C1F2A2199CA03ABCD* ___U3CU3E9__27_5_36;
	// Agora.Rtc.LitJson.ImporterFunc Agora.Rtc.LitJson.JsonMapper/<>c::<>9__27_6
	ImporterFunc_tC3095AD1938F844CD79CF79C1F2A2199CA03ABCD* ___U3CU3E9__27_6_37;
	// Agora.Rtc.LitJson.ImporterFunc Agora.Rtc.LitJson.JsonMapper/<>c::<>9__27_7
	ImporterFunc_tC3095AD1938F844CD79CF79C1F2A2199CA03ABCD* ___U3CU3E9__27_7_38;
	// Agora.Rtc.LitJson.ImporterFunc Agora.Rtc.LitJson.JsonMapper/<>c::<>9__27_8
	ImporterFunc_tC3095AD1938F844CD79CF79C1F2A2199CA03ABCD* ___U3CU3E9__27_8_39;
	// Agora.Rtc.LitJson.ImporterFunc Agora.Rtc.LitJson.JsonMapper/<>c::<>9__27_9
	ImporterFunc_tC3095AD1938F844CD79CF79C1F2A2199CA03ABCD* ___U3CU3E9__27_9_40;
	// Agora.Rtc.LitJson.ImporterFunc Agora.Rtc.LitJson.JsonMapper/<>c::<>9__27_10
	ImporterFunc_tC3095AD1938F844CD79CF79C1F2A2199CA03ABCD* ___U3CU3E9__27_10_41;
	// Agora.Rtc.LitJson.ImporterFunc Agora.Rtc.LitJson.JsonMapper/<>c::<>9__27_11
	ImporterFunc_tC3095AD1938F844CD79CF79C1F2A2199CA03ABCD* ___U3CU3E9__27_11_42;
	// Agora.Rtc.LitJson.ImporterFunc Agora.Rtc.LitJson.JsonMapper/<>c::<>9__27_12
	ImporterFunc_tC3095AD1938F844CD79CF79C1F2A2199CA03ABCD* ___U3CU3E9__27_12_43;
	// Agora.Rtc.LitJson.ImporterFunc Agora.Rtc.LitJson.JsonMapper/<>c::<>9__27_13
	ImporterFunc_tC3095AD1938F844CD79CF79C1F2A2199CA03ABCD* ___U3CU3E9__27_13_44;
	// Agora.Rtc.LitJson.ImporterFunc Agora.Rtc.LitJson.JsonMapper/<>c::<>9__27_14
	ImporterFunc_tC3095AD1938F844CD79CF79C1F2A2199CA03ABCD* ___U3CU3E9__27_14_45;
	// Agora.Rtc.LitJson.ImporterFunc Agora.Rtc.LitJson.JsonMapper/<>c::<>9__27_15
	ImporterFunc_tC3095AD1938F844CD79CF79C1F2A2199CA03ABCD* ___U3CU3E9__27_15_46;
	// Agora.Rtc.LitJson.ImporterFunc Agora.Rtc.LitJson.JsonMapper/<>c::<>9__27_16
	ImporterFunc_tC3095AD1938F844CD79CF79C1F2A2199CA03ABCD* ___U3CU3E9__27_16_47;
	// Agora.Rtc.LitJson.ImporterFunc Agora.Rtc.LitJson.JsonMapper/<>c::<>9__27_17
	ImporterFunc_tC3095AD1938F844CD79CF79C1F2A2199CA03ABCD* ___U3CU3E9__27_17_48;
	// Agora.Rtc.LitJson.ImporterFunc Agora.Rtc.LitJson.JsonMapper/<>c::<>9__27_18
	ImporterFunc_tC3095AD1938F844CD79CF79C1F2A2199CA03ABCD* ___U3CU3E9__27_18_49;
	// Agora.Rtc.LitJson.ImporterFunc Agora.Rtc.LitJson.JsonMapper/<>c::<>9__27_19
	ImporterFunc_tC3095AD1938F844CD79CF79C1F2A2199CA03ABCD* ___U3CU3E9__27_19_50;
	// Agora.Rtc.LitJson.ImporterFunc Agora.Rtc.LitJson.JsonMapper/<>c::<>9__27_20
	ImporterFunc_tC3095AD1938F844CD79CF79C1F2A2199CA03ABCD* ___U3CU3E9__27_20_51;
	// Agora.Rtc.LitJson.ImporterFunc Agora.Rtc.LitJson.JsonMapper/<>c::<>9__27_21
	ImporterFunc_tC3095AD1938F844CD79CF79C1F2A2199CA03ABCD* ___U3CU3E9__27_21_52;
	// Agora.Rtc.LitJson.ImporterFunc Agora.Rtc.LitJson.JsonMapper/<>c::<>9__27_22
	ImporterFunc_tC3095AD1938F844CD79CF79C1F2A2199CA03ABCD* ___U3CU3E9__27_22_53;
	// Agora.Rtc.LitJson.ImporterFunc Agora.Rtc.LitJson.JsonMapper/<>c::<>9__27_23
	ImporterFunc_tC3095AD1938F844CD79CF79C1F2A2199CA03ABCD* ___U3CU3E9__27_23_54;
	// Agora.Rtc.LitJson.ImporterFunc Agora.Rtc.LitJson.JsonMapper/<>c::<>9__27_24
	ImporterFunc_tC3095AD1938F844CD79CF79C1F2A2199CA03ABCD* ___U3CU3E9__27_24_55;
	// Agora.Rtc.LitJson.ImporterFunc Agora.Rtc.LitJson.JsonMapper/<>c::<>9__27_25
	ImporterFunc_tC3095AD1938F844CD79CF79C1F2A2199CA03ABCD* ___U3CU3E9__27_25_56;
	// Agora.Rtc.LitJson.ImporterFunc Agora.Rtc.LitJson.JsonMapper/<>c::<>9__27_26
	ImporterFunc_tC3095AD1938F844CD79CF79C1F2A2199CA03ABCD* ___U3CU3E9__27_26_57;
	// Agora.Rtc.LitJson.ImporterFunc Agora.Rtc.LitJson.JsonMapper/<>c::<>9__27_27
	ImporterFunc_tC3095AD1938F844CD79CF79C1F2A2199CA03ABCD* ___U3CU3E9__27_27_58;
	// Agora.Rtc.LitJson.ImporterFunc Agora.Rtc.LitJson.JsonMapper/<>c::<>9__27_28
	ImporterFunc_tC3095AD1938F844CD79CF79C1F2A2199CA03ABCD* ___U3CU3E9__27_28_59;
	// Agora.Rtc.LitJson.ImporterFunc Agora.Rtc.LitJson.JsonMapper/<>c::<>9__27_29
	ImporterFunc_tC3095AD1938F844CD79CF79C1F2A2199CA03ABCD* ___U3CU3E9__27_29_60;
	// Agora.Rtc.LitJson.ImporterFunc Agora.Rtc.LitJson.JsonMapper/<>c::<>9__27_30
	ImporterFunc_tC3095AD1938F844CD79CF79C1F2A2199CA03ABCD* ___U3CU3E9__27_30_61;
	// Agora.Rtc.LitJson.ImporterFunc Agora.Rtc.LitJson.JsonMapper/<>c::<>9__27_31
	ImporterFunc_tC3095AD1938F844CD79CF79C1F2A2199CA03ABCD* ___U3CU3E9__27_31_62;
	// Agora.Rtc.LitJson.ImporterFunc Agora.Rtc.LitJson.JsonMapper/<>c::<>9__27_32
	ImporterFunc_tC3095AD1938F844CD79CF79C1F2A2199CA03ABCD* ___U3CU3E9__27_32_63;
	// Agora.Rtc.LitJson.ImporterFunc Agora.Rtc.LitJson.JsonMapper/<>c::<>9__27_33
	ImporterFunc_tC3095AD1938F844CD79CF79C1F2A2199CA03ABCD* ___U3CU3E9__27_33_64;
	// Agora.Rtc.LitJson.ImporterFunc Agora.Rtc.LitJson.JsonMapper/<>c::<>9__27_34
	ImporterFunc_tC3095AD1938F844CD79CF79C1F2A2199CA03ABCD* ___U3CU3E9__27_34_65;
	// Agora.Rtc.LitJson.ImporterFunc Agora.Rtc.LitJson.JsonMapper/<>c::<>9__27_35
	ImporterFunc_tC3095AD1938F844CD79CF79C1F2A2199CA03ABCD* ___U3CU3E9__27_35_66;
	// Agora.Rtc.LitJson.ImporterFunc Agora.Rtc.LitJson.JsonMapper/<>c::<>9__27_36
	ImporterFunc_tC3095AD1938F844CD79CF79C1F2A2199CA03ABCD* ___U3CU3E9__27_36_67;
	// Agora.Rtc.LitJson.ImporterFunc Agora.Rtc.LitJson.JsonMapper/<>c::<>9__27_37
	ImporterFunc_tC3095AD1938F844CD79CF79C1F2A2199CA03ABCD* ___U3CU3E9__27_37_68;
	// Agora.Rtc.LitJson.ImporterFunc Agora.Rtc.LitJson.JsonMapper/<>c::<>9__27_38
	ImporterFunc_tC3095AD1938F844CD79CF79C1F2A2199CA03ABCD* ___U3CU3E9__27_38_69;
	// Agora.Rtc.LitJson.ImporterFunc Agora.Rtc.LitJson.JsonMapper/<>c::<>9__27_39
	ImporterFunc_tC3095AD1938F844CD79CF79C1F2A2199CA03ABCD* ___U3CU3E9__27_39_70;
	// Agora.Rtc.LitJson.WrapperFactory Agora.Rtc.LitJson.JsonMapper/<>c::<>9__32_0
	WrapperFactory_t92E5AF7D73458CC8A0E1D25FE2B2D3A07CCE07B9* ___U3CU3E9__32_0_71;
	// Agora.Rtc.LitJson.WrapperFactory Agora.Rtc.LitJson.JsonMapper/<>c::<>9__33_0
	WrapperFactory_t92E5AF7D73458CC8A0E1D25FE2B2D3A07CCE07B9* ___U3CU3E9__33_0_72;
	// Agora.Rtc.LitJson.WrapperFactory Agora.Rtc.LitJson.JsonMapper/<>c::<>9__34_0
	WrapperFactory_t92E5AF7D73458CC8A0E1D25FE2B2D3A07CCE07B9* ___U3CU3E9__34_0_73;
};

// System.Boolean
struct Boolean_t09A6377A54BE2F9E6985A8149F19234FD7DDFE22 
{
	// System.Boolean System.Boolean::m_value
	bool ___m_value_0;
};

struct Boolean_t09A6377A54BE2F9E6985A8149F19234FD7DDFE22_StaticFields
{
	// System.String System.Boolean::TrueString
	String_t* ___TrueString_5;
	// System.String System.Boolean::FalseString
	String_t* ___FalseString_6;
};

// System.Byte
struct Byte_t94D9231AC217BE4D2E004C4CD32DF6D099EA41A3 
{
	// System.Byte System.Byte::m_value
	uint8_t ___m_value_0;
};

// System.Char
struct Char_t521A6F19B456D956AF452D926C32709DC03D6B17 
{
	// System.Char System.Char::m_value
	Il2CppChar ___m_value_0;
};

struct Char_t521A6F19B456D956AF452D926C32709DC03D6B17_StaticFields
{
	// System.Byte[] System.Char::s_categoryForLatin1
	ByteU5BU5D_tA6237BF417AE52AD70CFB4EF24A7A82613DF9031* ___s_categoryForLatin1_3;
};

// System.DateTime
struct DateTime_t66193957C73913903DDAD89FEDC46139BCA5802D 
{
	// System.UInt64 System.DateTime::_dateData
	uint64_t ____dateData_46;
};

struct DateTime_t66193957C73913903DDAD89FEDC46139BCA5802D_StaticFields
{
	// System.Int32[] System.DateTime::s_daysToMonth365
	Int32U5BU5D_t19C97395396A72ECAF310612F0760F165060314C* ___s_daysToMonth365_30;
	// System.Int32[] System.DateTime::s_daysToMonth366
	Int32U5BU5D_t19C97395396A72ECAF310612F0760F165060314C* ___s_daysToMonth366_31;
	// System.DateTime System.DateTime::MinValue
	DateTime_t66193957C73913903DDAD89FEDC46139BCA5802D ___MinValue_32;
	// System.DateTime System.DateTime::MaxValue
	DateTime_t66193957C73913903DDAD89FEDC46139BCA5802D ___MaxValue_33;
	// System.DateTime System.DateTime::UnixEpoch
	DateTime_t66193957C73913903DDAD89FEDC46139BCA5802D ___UnixEpoch_34;
};

// System.Decimal
struct Decimal_tDA6C877282B2D789CF97C0949661CC11D643969F 
{
	union
	{
		#pragma pack(push, tp, 1)
		struct
		{
			// System.Int32 System.Decimal::flags
			int32_t ___flags_8;
		};
		#pragma pack(pop, tp)
		struct
		{
			int32_t ___flags_8_forAlignmentOnly;
		};
		#pragma pack(push, tp, 1)
		struct
		{
			char ___hi_9_OffsetPadding[4];
			// System.Int32 System.Decimal::hi
			int32_t ___hi_9;
		};
		#pragma pack(pop, tp)
		struct
		{
			char ___hi_9_OffsetPadding_forAlignmentOnly[4];
			int32_t ___hi_9_forAlignmentOnly;
		};
		#pragma pack(push, tp, 1)
		struct
		{
			char ___lo_10_OffsetPadding[8];
			// System.Int32 System.Decimal::lo
			int32_t ___lo_10;
		};
		#pragma pack(pop, tp)
		struct
		{
			char ___lo_10_OffsetPadding_forAlignmentOnly[8];
			int32_t ___lo_10_forAlignmentOnly;
		};
		#pragma pack(push, tp, 1)
		struct
		{
			char ___mid_11_OffsetPadding[12];
			// System.Int32 System.Decimal::mid
			int32_t ___mid_11;
		};
		#pragma pack(pop, tp)
		struct
		{
			char ___mid_11_OffsetPadding_forAlignmentOnly[12];
			int32_t ___mid_11_forAlignmentOnly;
		};
		#pragma pack(push, tp, 1)
		struct
		{
			char ___ulomidLE_12_OffsetPadding[8];
			// System.UInt64 System.Decimal::ulomidLE
			uint64_t ___ulomidLE_12;
		};
		#pragma pack(pop, tp)
		struct
		{
			char ___ulomidLE_12_OffsetPadding_forAlignmentOnly[8];
			uint64_t ___ulomidLE_12_forAlignmentOnly;
		};
	};
};

struct Decimal_tDA6C877282B2D789CF97C0949661CC11D643969F_StaticFields
{
	// System.Decimal System.Decimal::Zero
	Decimal_tDA6C877282B2D789CF97C0949661CC11D643969F ___Zero_3;
	// System.Decimal System.Decimal::One
	Decimal_tDA6C877282B2D789CF97C0949661CC11D643969F ___One_4;
	// System.Decimal System.Decimal::MinusOne
	Decimal_tDA6C877282B2D789CF97C0949661CC11D643969F ___MinusOne_5;
	// System.Decimal System.Decimal::MaxValue
	Decimal_tDA6C877282B2D789CF97C0949661CC11D643969F ___MaxValue_6;
	// System.Decimal System.Decimal::MinValue
	Decimal_tDA6C877282B2D789CF97C0949661CC11D643969F ___MinValue_7;
};

// System.Double
struct Double_tE150EF3D1D43DEE85D533810AB4C742307EEDE5F 
{
	// System.Double System.Double::m_value
	double ___m_value_0;
};

// System.Int16
struct Int16_tB8EF286A9C33492FA6E6D6E67320BE93E794A175 
{
	// System.Int16 System.Int16::m_value
	int16_t ___m_value_0;
};

// System.Int32
struct Int32_t680FF22E76F6EFAD4375103CBBFFA0421349384C 
{
	// System.Int32 System.Int32::m_value
	int32_t ___m_value_0;
};

// System.Int64
struct Int64_t092CFB123BE63C28ACDAF65C68F21A526050DBA3 
{
	// System.Int64 System.Int64::m_value
	int64_t ___m_value_0;
};

// System.IntPtr
struct IntPtr_t 
{
	// System.Void* System.IntPtr::m_value
	void* ___m_value_0;
};

struct IntPtr_t_StaticFields
{
	// System.IntPtr System.IntPtr::Zero
	intptr_t ___Zero_1;
};

// System.SByte
struct SByte_tFEFFEF5D2FEBF5207950AE6FAC150FC53B668DB5 
{
	// System.SByte System.SByte::m_value
	int8_t ___m_value_0;
};

// System.Single
struct Single_t4530F2FF86FCB0DC29F35385CA1BD21BE294761C 
{
	// System.Single System.Single::m_value
	float ___m_value_0;
};

// System.IO.TextReader
struct TextReader_tB8D43017CB6BE1633E5A86D64E7757366507C1F7  : public MarshalByRefObject_t8C2F4C5854177FD60439EB1FCCFC1B3CFAFE8DCE
{
};

struct TextReader_tB8D43017CB6BE1633E5A86D64E7757366507C1F7_StaticFields
{
	// System.IO.TextReader System.IO.TextReader::Null
	TextReader_tB8D43017CB6BE1633E5A86D64E7757366507C1F7* ___Null_1;
};

// System.IO.TextWriter
struct TextWriter_tA9E5461506CF806E17B6BBBF2119359DEDA3F0F3  : public MarshalByRefObject_t8C2F4C5854177FD60439EB1FCCFC1B3CFAFE8DCE
{
	// System.Char[] System.IO.TextWriter::CoreNewLine
	CharU5BU5D_t799905CF001DD5F13F7DBB310181FC4D8B7D0AAB* ___CoreNewLine_3;
	// System.String System.IO.TextWriter::CoreNewLineStr
	String_t* ___CoreNewLineStr_4;
	// System.IFormatProvider System.IO.TextWriter::_internalFormatProvider
	RuntimeObject* ____internalFormatProvider_5;
};

struct TextWriter_tA9E5461506CF806E17B6BBBF2119359DEDA3F0F3_StaticFields
{
	// System.IO.TextWriter System.IO.TextWriter::Null
	TextWriter_tA9E5461506CF806E17B6BBBF2119359DEDA3F0F3* ___Null_1;
	// System.Char[] System.IO.TextWriter::s_coreNewLine
	CharU5BU5D_t799905CF001DD5F13F7DBB310181FC4D8B7D0AAB* ___s_coreNewLine_2;
};

// System.UInt16
struct UInt16_tF4C148C876015C212FD72652D0B6ED8CC247A455 
{
	// System.UInt16 System.UInt16::m_value
	uint16_t ___m_value_0;
};

// System.UInt32
struct UInt32_t1833D51FFA667B18A5AA4B8D34DE284F8495D29B 
{
	// System.UInt32 System.UInt32::m_value
	uint32_t ___m_value_0;
};

// System.UInt64
struct UInt64_t8F12534CC8FC4B5860F2A2CD1EE79D322E7A41AF 
{
	// System.UInt64 System.UInt64::m_value
	uint64_t ___m_value_0;
};

// System.Void
struct Void_t4861ACF8F4594C3437BB48B6E56783494B843915 
{
	union
	{
		struct
		{
		};
		uint8_t Void_t4861ACF8F4594C3437BB48B6E56783494B843915__padding[1];
	};
};

// <PrivateImplementationDetails>/__StaticArrayInitTypeSize=112
#pragma pack(push, tp, 1)
struct __StaticArrayInitTypeSizeU3D112_t338F22B6F3CC67FDBAE2DB73218458D355AA2089 
{
	union
	{
		struct
		{
			union
			{
			};
		};
		uint8_t __StaticArrayInitTypeSizeU3D112_t338F22B6F3CC67FDBAE2DB73218458D355AA2089__padding[112];
	};
};
#pragma pack(pop, tp)

// <PrivateImplementationDetails>/__StaticArrayInitTypeSize=12
#pragma pack(push, tp, 1)
struct __StaticArrayInitTypeSizeU3D12_t1BDD2193C3F925556BCD5FF35C0AC52DDB0CAB8F 
{
	union
	{
		struct
		{
			union
			{
			};
		};
		uint8_t __StaticArrayInitTypeSizeU3D12_t1BDD2193C3F925556BCD5FF35C0AC52DDB0CAB8F__padding[12];
	};
};
#pragma pack(pop, tp)

// <PrivateImplementationDetails>
struct U3CPrivateImplementationDetailsU3E_t0F5473E849A5A5185A9F4C5246F0C32816C49FCA  : public RuntimeObject
{
};

struct U3CPrivateImplementationDetailsU3E_t0F5473E849A5A5185A9F4C5246F0C32816C49FCA_StaticFields
{
	// <PrivateImplementationDetails>/__StaticArrayInitTypeSize=12 <PrivateImplementationDetails>::59B7E757844D3BF9299877BD1C17451611BFBAB493374D6B18D973FDE534151A
	__StaticArrayInitTypeSizeU3D12_t1BDD2193C3F925556BCD5FF35C0AC52DDB0CAB8F ___59B7E757844D3BF9299877BD1C17451611BFBAB493374D6B18D973FDE534151A_0;
	// <PrivateImplementationDetails>/__StaticArrayInitTypeSize=12 <PrivateImplementationDetails>::5B979F69B96A61586A09DD4ED26F20534C629B08732AE32FA34B6F8A0049ACDD
	__StaticArrayInitTypeSizeU3D12_t1BDD2193C3F925556BCD5FF35C0AC52DDB0CAB8F ___5B979F69B96A61586A09DD4ED26F20534C629B08732AE32FA34B6F8A0049ACDD_1;
	// <PrivateImplementationDetails>/__StaticArrayInitTypeSize=12 <PrivateImplementationDetails>::7FCA397EF25DB53B2C58A05F9BBFA4E8E0685FDBC8AAF39536123447056895C0
	__StaticArrayInitTypeSizeU3D12_t1BDD2193C3F925556BCD5FF35C0AC52DDB0CAB8F ___7FCA397EF25DB53B2C58A05F9BBFA4E8E0685FDBC8AAF39536123447056895C0_2;
	// <PrivateImplementationDetails>/__StaticArrayInitTypeSize=12 <PrivateImplementationDetails>::B257E85A5D3CAB5E738D5A0FD1A7AE96624BFE92CB7915726CBBE1518C3225CF
	__StaticArrayInitTypeSizeU3D12_t1BDD2193C3F925556BCD5FF35C0AC52DDB0CAB8F ___B257E85A5D3CAB5E738D5A0FD1A7AE96624BFE92CB7915726CBBE1518C3225CF_3;
	// <PrivateImplementationDetails>/__StaticArrayInitTypeSize=12 <PrivateImplementationDetails>::B7A918F6F138CA8137025633559198B529D28CCEC5A51B005376CC69A5B83D85
	__StaticArrayInitTypeSizeU3D12_t1BDD2193C3F925556BCD5FF35C0AC52DDB0CAB8F ___B7A918F6F138CA8137025633559198B529D28CCEC5A51B005376CC69A5B83D85_4;
	// <PrivateImplementationDetails>/__StaticArrayInitTypeSize=112 <PrivateImplementationDetails>::C84227140A8A7787B30DFF8BD5693C19AA5A430C4E89FFD0256D7F77B3FEAD82
	__StaticArrayInitTypeSizeU3D112_t338F22B6F3CC67FDBAE2DB73218458D355AA2089 ___C84227140A8A7787B30DFF8BD5693C19AA5A430C4E89FFD0256D7F77B3FEAD82_5;
	// <PrivateImplementationDetails>/__StaticArrayInitTypeSize=12 <PrivateImplementationDetails>::FC03ECB1D62767A5B31230F548FA4D4C02F01E3DA8CA1FC66C7C332EA16BF206
	__StaticArrayInitTypeSizeU3D12_t1BDD2193C3F925556BCD5FF35C0AC52DDB0CAB8F ___FC03ECB1D62767A5B31230F548FA4D4C02F01E3DA8CA1FC66C7C332EA16BF206_6;
};

// System.DateTimeOffset
struct DateTimeOffset_t4EE701FE2F386D6F932FAC9B11E4B74A5B30F0A4 
{
	// System.DateTime System.DateTimeOffset::_dateTime
	DateTime_t66193957C73913903DDAD89FEDC46139BCA5802D ____dateTime_3;
	// System.Int16 System.DateTimeOffset::_offsetMinutes
	int16_t ____offsetMinutes_4;
};

struct DateTimeOffset_t4EE701FE2F386D6F932FAC9B11E4B74A5B30F0A4_StaticFields
{
	// System.DateTimeOffset System.DateTimeOffset::MinValue
	DateTimeOffset_t4EE701FE2F386D6F932FAC9B11E4B74A5B30F0A4 ___MinValue_0;
	// System.DateTimeOffset System.DateTimeOffset::MaxValue
	DateTimeOffset_t4EE701FE2F386D6F932FAC9B11E4B74A5B30F0A4 ___MaxValue_1;
	// System.DateTimeOffset System.DateTimeOffset::UnixEpoch
	DateTimeOffset_t4EE701FE2F386D6F932FAC9B11E4B74A5B30F0A4 ___UnixEpoch_2;
};

// System.Delegate
struct Delegate_t  : public RuntimeObject
{
	// System.IntPtr System.Delegate::method_ptr
	Il2CppMethodPointer ___method_ptr_0;
	// System.IntPtr System.Delegate::invoke_impl
	intptr_t ___invoke_impl_1;
	// System.Object System.Delegate::m_target
	RuntimeObject* ___m_target_2;
	// System.IntPtr System.Delegate::method
	intptr_t ___method_3;
	// System.IntPtr System.Delegate::delegate_trampoline
	intptr_t ___delegate_trampoline_4;
	// System.IntPtr System.Delegate::extra_arg
	intptr_t ___extra_arg_5;
	// System.IntPtr System.Delegate::method_code
	intptr_t ___method_code_6;
	// System.IntPtr System.Delegate::interp_method
	intptr_t ___interp_method_7;
	// System.IntPtr System.Delegate::interp_invoke_impl
	intptr_t ___interp_invoke_impl_8;
	// System.Reflection.MethodInfo System.Delegate::method_info
	MethodInfo_t* ___method_info_9;
	// System.Reflection.MethodInfo System.Delegate::original_method_info
	MethodInfo_t* ___original_method_info_10;
	// System.DelegateData System.Delegate::data
	DelegateData_t9B286B493293CD2D23A5B2B5EF0E5B1324C2B77E* ___data_11;
	// System.Boolean System.Delegate::method_is_virtual
	bool ___method_is_virtual_12;
};
// Native definition for P/Invoke marshalling of System.Delegate
struct Delegate_t_marshaled_pinvoke
{
	intptr_t ___method_ptr_0;
	intptr_t ___invoke_impl_1;
	Il2CppIUnknown* ___m_target_2;
	intptr_t ___method_3;
	intptr_t ___delegate_trampoline_4;
	intptr_t ___extra_arg_5;
	intptr_t ___method_code_6;
	intptr_t ___interp_method_7;
	intptr_t ___interp_invoke_impl_8;
	MethodInfo_t* ___method_info_9;
	MethodInfo_t* ___original_method_info_10;
	DelegateData_t9B286B493293CD2D23A5B2B5EF0E5B1324C2B77E* ___data_11;
	int32_t ___method_is_virtual_12;
};
// Native definition for COM marshalling of System.Delegate
struct Delegate_t_marshaled_com
{
	intptr_t ___method_ptr_0;
	intptr_t ___invoke_impl_1;
	Il2CppIUnknown* ___m_target_2;
	intptr_t ___method_3;
	intptr_t ___delegate_trampoline_4;
	intptr_t ___extra_arg_5;
	intptr_t ___method_code_6;
	intptr_t ___interp_method_7;
	intptr_t ___interp_invoke_impl_8;
	MethodInfo_t* ___method_info_9;
	MethodInfo_t* ___original_method_info_10;
	DelegateData_t9B286B493293CD2D23A5B2B5EF0E5B1324C2B77E* ___data_11;
	int32_t ___method_is_virtual_12;
};

// System.Exception
struct Exception_t  : public RuntimeObject
{
	// System.String System.Exception::_className
	String_t* ____className_1;
	// System.String System.Exception::_message
	String_t* ____message_2;
	// System.Collections.IDictionary System.Exception::_data
	RuntimeObject* ____data_3;
	// System.Exception System.Exception::_innerException
	Exception_t* ____innerException_4;
	// System.String System.Exception::_helpURL
	String_t* ____helpURL_5;
	// System.Object System.Exception::_stackTrace
	RuntimeObject* ____stackTrace_6;
	// System.String System.Exception::_stackTraceString
	String_t* ____stackTraceString_7;
	// System.String System.Exception::_remoteStackTraceString
	String_t* ____remoteStackTraceString_8;
	// System.Int32 System.Exception::_remoteStackIndex
	int32_t ____remoteStackIndex_9;
	// System.Object System.Exception::_dynamicMethods
	RuntimeObject* ____dynamicMethods_10;
	// System.Int32 System.Exception::_HResult
	int32_t ____HResult_11;
	// System.String System.Exception::_source
	String_t* ____source_12;
	// System.Runtime.Serialization.SafeSerializationManager System.Exception::_safeSerializationManager
	SafeSerializationManager_tCBB85B95DFD1634237140CD892E82D06ECB3F5E6* ____safeSerializationManager_13;
	// System.Diagnostics.StackTrace[] System.Exception::captured_traces
	StackTraceU5BU5D_t32FBCB20930EAF5BAE3F450FF75228E5450DA0DF* ___captured_traces_14;
	// System.IntPtr[] System.Exception::native_trace_ips
	IntPtrU5BU5D_tFD177F8C806A6921AD7150264CCC62FA00CAD832* ___native_trace_ips_15;
	// System.Int32 System.Exception::caught_in_unmanaged
	int32_t ___caught_in_unmanaged_16;
};

struct Exception_t_StaticFields
{
	// System.Object System.Exception::s_EDILock
	RuntimeObject* ___s_EDILock_0;
};
// Native definition for P/Invoke marshalling of System.Exception
struct Exception_t_marshaled_pinvoke
{
	char* ____className_1;
	char* ____message_2;
	RuntimeObject* ____data_3;
	Exception_t_marshaled_pinvoke* ____innerException_4;
	char* ____helpURL_5;
	Il2CppIUnknown* ____stackTrace_6;
	char* ____stackTraceString_7;
	char* ____remoteStackTraceString_8;
	int32_t ____remoteStackIndex_9;
	Il2CppIUnknown* ____dynamicMethods_10;
	int32_t ____HResult_11;
	char* ____source_12;
	SafeSerializationManager_tCBB85B95DFD1634237140CD892E82D06ECB3F5E6* ____safeSerializationManager_13;
	StackTraceU5BU5D_t32FBCB20930EAF5BAE3F450FF75228E5450DA0DF* ___captured_traces_14;
	Il2CppSafeArray/*NONE*/* ___native_trace_ips_15;
	int32_t ___caught_in_unmanaged_16;
};
// Native definition for COM marshalling of System.Exception
struct Exception_t_marshaled_com
{
	Il2CppChar* ____className_1;
	Il2CppChar* ____message_2;
	RuntimeObject* ____data_3;
	Exception_t_marshaled_com* ____innerException_4;
	Il2CppChar* ____helpURL_5;
	Il2CppIUnknown* ____stackTrace_6;
	Il2CppChar* ____stackTraceString_7;
	Il2CppChar* ____remoteStackTraceString_8;
	int32_t ____remoteStackIndex_9;
	Il2CppIUnknown* ____dynamicMethods_10;
	int32_t ____HResult_11;
	Il2CppChar* ____source_12;
	SafeSerializationManager_tCBB85B95DFD1634237140CD892E82D06ECB3F5E6* ____safeSerializationManager_13;
	StackTraceU5BU5D_t32FBCB20930EAF5BAE3F450FF75228E5450DA0DF* ___captured_traces_14;
	Il2CppSafeArray/*NONE*/* ___native_trace_ips_15;
	int32_t ___caught_in_unmanaged_16;
};

// System.RuntimeFieldHandle
struct RuntimeFieldHandle_t6E4C45B6D2EA12FC99185805A7E77527899B25C5 
{
	// System.IntPtr System.RuntimeFieldHandle::value
	intptr_t ___value_0;
};

// System.IO.StringReader
struct StringReader_t1A336148FF22A9584E759A9D720CC96C23E35DD8  : public TextReader_tB8D43017CB6BE1633E5A86D64E7757366507C1F7
{
	// System.String System.IO.StringReader::_s
	String_t* ____s_2;
	// System.Int32 System.IO.StringReader::_pos
	int32_t ____pos_3;
	// System.Int32 System.IO.StringReader::_length
	int32_t ____length_4;
};

// System.IO.StringWriter
struct StringWriter_tF48052BE4F980E5C85403221E835768E4156267D  : public TextWriter_tA9E5461506CF806E17B6BBBF2119359DEDA3F0F3
{
	// System.Text.StringBuilder System.IO.StringWriter::_sb
	StringBuilder_t* ____sb_7;
	// System.Boolean System.IO.StringWriter::_isOpen
	bool ____isOpen_8;
};

struct StringWriter_tF48052BE4F980E5C85403221E835768E4156267D_StaticFields
{
	// System.Text.UnicodeEncoding modreq(System.Runtime.CompilerServices.IsVolatile) System.IO.StringWriter::m_encoding
	UnicodeEncoding_t2C90D9E1E55C16081FACA57B229053C1EF05DAF0* ___m_encoding_6;
};

// System.ApplicationException
struct ApplicationException_tA744BED4E90266BD255285CD4CF909BAB3EE811A  : public Exception_t
{
};

// System.MulticastDelegate
struct MulticastDelegate_t  : public Delegate_t
{
	// System.Delegate[] System.MulticastDelegate::delegates
	DelegateU5BU5D_tC5AB7E8F745616680F337909D3A8E6C722CDF771* ___delegates_13;
};
// Native definition for P/Invoke marshalling of System.MulticastDelegate
struct MulticastDelegate_t_marshaled_pinvoke : public Delegate_t_marshaled_pinvoke
{
	Delegate_t_marshaled_pinvoke** ___delegates_13;
};
// Native definition for COM marshalling of System.MulticastDelegate
struct MulticastDelegate_t_marshaled_com : public Delegate_t_marshaled_com
{
	Delegate_t_marshaled_com** ___delegates_13;
};

// System.SystemException
struct SystemException_tCC48D868298F4C0705279823E34B00F4FBDB7295  : public Exception_t
{
};

// System.ArgumentException
struct ArgumentException_tAD90411542A20A9C72D5CDA3A84181D8B947A263  : public SystemException_tCC48D868298F4C0705279823E34B00F4FBDB7295
{
	// System.String System.ArgumentException::_paramName
	String_t* ____paramName_18;
};

// System.AsyncCallback
struct AsyncCallback_t7FEF460CBDCFB9C5FA2EF776984778B9A4145F4C  : public MulticastDelegate_t
{
};

// Agora.Rtc.LitJson.JsonException
struct JsonException_t3B214813E48AA5E19793F9026831120B5B2254A1  : public ApplicationException_tA744BED4E90266BD255285CD4CF909BAB3EE811A
{
};

// System.Collections.Generic.KeyNotFoundException
struct KeyNotFoundException_tCE416EC9BCA9F396A3DFFF86D1B5209BA876079E  : public SystemException_tCC48D868298F4C0705279823E34B00F4FBDB7295
{
};

// Agora.Rtc.LitJson.Lexer/StateHandler
struct StateHandler_t8EA5CD11BFA1A958F305A2A0134A0BBB631FAFCB  : public MulticastDelegate_t
{
};

// System.ArgumentNullException
struct ArgumentNullException_t327031E412FAB2351B0022DD5DAD47E67E597129  : public ArgumentException_tAD90411542A20A9C72D5CDA3A84181D8B947A263
{
};
#ifdef __clang__
#pragma clang diagnostic pop
#endif
// System.Int32[]
struct Int32U5BU5D_t19C97395396A72ECAF310612F0760F165060314C  : public RuntimeArray
{
	ALIGN_FIELD (8) int32_t m_Items[1];

	inline int32_t GetAt(il2cpp_array_size_t index) const
	{
		IL2CPP_ARRAY_BOUNDS_CHECK(index, (uint32_t)(this)->max_length);
		return m_Items[index];
	}
	inline int32_t* GetAddressAt(il2cpp_array_size_t index)
	{
		IL2CPP_ARRAY_BOUNDS_CHECK(index, (uint32_t)(this)->max_length);
		return m_Items + index;
	}
	inline void SetAt(il2cpp_array_size_t index, int32_t value)
	{
		IL2CPP_ARRAY_BOUNDS_CHECK(index, (uint32_t)(this)->max_length);
		m_Items[index] = value;
	}
	inline int32_t GetAtUnchecked(il2cpp_array_size_t index) const
	{
		return m_Items[index];
	}
	inline int32_t* GetAddressAtUnchecked(il2cpp_array_size_t index)
	{
		return m_Items + index;
	}
	inline void SetAtUnchecked(il2cpp_array_size_t index, int32_t value)
	{
		m_Items[index] = value;
	}
};
// System.Char[]
struct CharU5BU5D_t799905CF001DD5F13F7DBB310181FC4D8B7D0AAB  : public RuntimeArray
{
	ALIGN_FIELD (8) Il2CppChar m_Items[1];

	inline Il2CppChar GetAt(il2cpp_array_size_t index) const
	{
		IL2CPP_ARRAY_BOUNDS_CHECK(index, (uint32_t)(this)->max_length);
		return m_Items[index];
	}
	inline Il2CppChar* GetAddressAt(il2cpp_array_size_t index)
	{
		IL2CPP_ARRAY_BOUNDS_CHECK(index, (uint32_t)(this)->max_length);
		return m_Items + index;
	}
	inline void SetAt(il2cpp_array_size_t index, Il2CppChar value)
	{
		IL2CPP_ARRAY_BOUNDS_CHECK(index, (uint32_t)(this)->max_length);
		m_Items[index] = value;
	}
	inline Il2CppChar GetAtUnchecked(il2cpp_array_size_t index) const
	{
		return m_Items[index];
	}
	inline Il2CppChar* GetAddressAtUnchecked(il2cpp_array_size_t index)
	{
		return m_Items + index;
	}
	inline void SetAtUnchecked(il2cpp_array_size_t index, Il2CppChar value)
	{
		m_Items[index] = value;
	}
};
// Agora.Rtc.LitJson.Lexer/StateHandler[]
struct StateHandlerU5BU5D_t766A22C9C454D383614ED21CB99EAD5F5F15438B  : public RuntimeArray
{
	ALIGN_FIELD (8) StateHandler_t8EA5CD11BFA1A958F305A2A0134A0BBB631FAFCB* m_Items[1];

	inline StateHandler_t8EA5CD11BFA1A958F305A2A0134A0BBB631FAFCB* GetAt(il2cpp_array_size_t index) const
	{
		IL2CPP_ARRAY_BOUNDS_CHECK(index, (uint32_t)(this)->max_length);
		return m_Items[index];
	}
	inline StateHandler_t8EA5CD11BFA1A958F305A2A0134A0BBB631FAFCB** GetAddressAt(il2cpp_array_size_t index)
	{
		IL2CPP_ARRAY_BOUNDS_CHECK(index, (uint32_t)(this)->max_length);
		return m_Items + index;
	}
	inline void SetAt(il2cpp_array_size_t index, StateHandler_t8EA5CD11BFA1A958F305A2A0134A0BBB631FAFCB* value)
	{
		IL2CPP_ARRAY_BOUNDS_CHECK(index, (uint32_t)(this)->max_length);
		m_Items[index] = value;
		Il2CppCodeGenWriteBarrier((void**)m_Items + index, (void*)value);
	}
	inline StateHandler_t8EA5CD11BFA1A958F305A2A0134A0BBB631FAFCB* GetAtUnchecked(il2cpp_array_size_t index) const
	{
		return m_Items[index];
	}
	inline StateHandler_t8EA5CD11BFA1A958F305A2A0134A0BBB631FAFCB** GetAddressAtUnchecked(il2cpp_array_size_t index)
	{
		return m_Items + index;
	}
	inline void SetAtUnchecked(il2cpp_array_size_t index, StateHandler_t8EA5CD11BFA1A958F305A2A0134A0BBB631FAFCB* value)
	{
		m_Items[index] = value;
		Il2CppCodeGenWriteBarrier((void**)m_Items + index, (void*)value);
	}
};
// System.Delegate[]
struct DelegateU5BU5D_tC5AB7E8F745616680F337909D3A8E6C722CDF771  : public RuntimeArray
{
	ALIGN_FIELD (8) Delegate_t* m_Items[1];

	inline Delegate_t* GetAt(il2cpp_array_size_t index) const
	{
		IL2CPP_ARRAY_BOUNDS_CHECK(index, (uint32_t)(this)->max_length);
		return m_Items[index];
	}
	inline Delegate_t** GetAddressAt(il2cpp_array_size_t index)
	{
		IL2CPP_ARRAY_BOUNDS_CHECK(index, (uint32_t)(this)->max_length);
		return m_Items + index;
	}
	inline void SetAt(il2cpp_array_size_t index, Delegate_t* value)
	{
		IL2CPP_ARRAY_BOUNDS_CHECK(index, (uint32_t)(this)->max_length);
		m_Items[index] = value;
		Il2CppCodeGenWriteBarrier((void**)m_Items + index, (void*)value);
	}
	inline Delegate_t* GetAtUnchecked(il2cpp_array_size_t index) const
	{
		return m_Items[index];
	}
	inline Delegate_t** GetAddressAtUnchecked(il2cpp_array_size_t index)
	{
		return m_Items + index;
	}
	inline void SetAtUnchecked(il2cpp_array_size_t index, Delegate_t* value)
	{
		m_Items[index] = value;
		Il2CppCodeGenWriteBarrier((void**)m_Items + index, (void*)value);
	}
};


// System.Void Agora.Rtc.Optional`1<System.Double>::.ctor()
IL2CPP_EXTERN_C IL2CPP_METHOD_ATTR void Optional_1__ctor_mA609C23EDD6086480DE074C6062697F841A89DE5_gshared (Optional_1_tD55CF2B24B2306B7B7CE9AFEE8C63C8C1C6A3C55* __this, const RuntimeMethod* method) ;
// System.Void Agora.Rtc.Optional`1<System.Double>::SetValue(T)
IL2CPP_EXTERN_C IL2CPP_METHOD_ATTR void Optional_1_SetValue_m3DE667644E7C516EB481AB0BEE32FE7EDFB435AF_gshared (Optional_1_tD55CF2B24B2306B7B7CE9AFEE8C63C8C1C6A3C55* __this, double ___val0, const RuntimeMethod* method) ;
// System.Void Agora.Rtc.Optional`1<System.Single>::.ctor()
IL2CPP_EXTERN_C IL2CPP_METHOD_ATTR void Optional_1__ctor_m9DF6F847C789BC17876C2CD77F24BEFB722B396B_gshared (Optional_1_tF876A70CDF0D3ADF96F01942F0AEAC7EB19FC62A* __this, const RuntimeMethod* method) ;
// System.Void Agora.Rtc.Optional`1<System.Single>::SetValue(T)
IL2CPP_EXTERN_C IL2CPP_METHOD_ATTR void Optional_1_SetValue_m63B29B35805A275BE9D1E1FEF8B269FF41763BBD_gshared (Optional_1_tF876A70CDF0D3ADF96F01942F0AEAC7EB19FC62A* __this, float ___val0, const RuntimeMethod* method) ;
// System.Void Agora.Rtc.Optional`1<System.Int16>::.ctor()
IL2CPP_EXTERN_C IL2CPP_METHOD_ATTR void Optional_1__ctor_mE58BCB3372AE04CCD5F9ED566F9364F5CC849D62_gshared (Optional_1_t3E699351D46D874511D63581794E1D62BC1A2E12* __this, const RuntimeMethod* method) ;
// System.Void Agora.Rtc.Optional`1<System.Int16>::SetValue(T)
IL2CPP_EXTERN_C IL2CPP_METHOD_ATTR void Optional_1_SetValue_m9451999734A371C8E4986D51E5019BD66C8A16D9_gshared (Optional_1_t3E699351D46D874511D63581794E1D62BC1A2E12* __this, int16_t ___val0, const RuntimeMethod* method) ;
// System.Void Agora.Rtc.Optional`1<System.UInt16>::.ctor()
IL2CPP_EXTERN_C IL2CPP_METHOD_ATTR void Optional_1__ctor_mE49D786DC8CA5DF649858A60CBFBBA062B92BD0C_gshared (Optional_1_tC0B7C5D987A3B3FBE615A0BA80C8AE46F260A6D5* __this, const RuntimeMethod* method) ;
// System.Void Agora.Rtc.Optional`1<System.UInt16>::SetValue(T)
IL2CPP_EXTERN_C IL2CPP_METHOD_ATTR void Optional_1_SetValue_m95F307C9D84062644F9AC400634290FF95E311AF_gshared (Optional_1_tC0B7C5D987A3B3FBE615A0BA80C8AE46F260A6D5* __this, uint16_t ___val0, const RuntimeMethod* method) ;
// System.Void Agora.Rtc.Optional`1<System.Int32>::.ctor()
IL2CPP_EXTERN_C IL2CPP_METHOD_ATTR void Optional_1__ctor_m4BCDD38353BEADF1738DB8386E39A5FE1AF02022_gshared (Optional_1_t702276DAE9B7132B4ED017493544FE3162F72A13* __this, const RuntimeMethod* method) ;
// System.Void Agora.Rtc.Optional`1<System.Int32>::SetValue(T)
IL2CPP_EXTERN_C IL2CPP_METHOD_ATTR void Optional_1_SetValue_mF3084568B1C3B43E1DF604DF0771558BE954DFFC_gshared (Optional_1_t702276DAE9B7132B4ED017493544FE3162F72A13* __this, int32_t ___val0, const RuntimeMethod* method) ;
// System.Void Agora.Rtc.Optional`1<System.UInt32>::.ctor()
IL2CPP_EXTERN_C IL2CPP_METHOD_ATTR void Optional_1__ctor_m56D215BBB37874E1671635AE7C29FEDA54E188DD_gshared (Optional_1_t9D1D61BD0E1BAFD11E7902319403D52C0DF276FD* __this, const RuntimeMethod* method) ;
// System.Void Agora.Rtc.Optional`1<System.UInt32>::SetValue(T)
IL2CPP_EXTERN_C IL2CPP_METHOD_ATTR void Optional_1_SetValue_mD23D4E22ECBEF9E399D3F72DD292DFBFFD63EC38_gshared (Optional_1_t9D1D61BD0E1BAFD11E7902319403D52C0DF276FD* __this, uint32_t ___val0, const RuntimeMethod* method) ;
// System.Void Agora.Rtc.Optional`1<System.Int64>::.ctor()
IL2CPP_EXTERN_C IL2CPP_METHOD_ATTR void Optional_1__ctor_m5760A6A5D2C28A6694EE100F6AFEC70D7756D2DF_gshared (Optional_1_tBB9FFF9D20636D333BC8766DBB02D617339F5001* __this, const RuntimeMethod* method) ;
// System.Void Agora.Rtc.Optional`1<System.Int64>::SetValue(T)
IL2CPP_EXTERN_C IL2CPP_METHOD_ATTR void Optional_1_SetValue_m43C38C7D77F2E17987091551FC38C2867EB8A66F_gshared (Optional_1_tBB9FFF9D20636D333BC8766DBB02D617339F5001* __this, int64_t ___val0, const RuntimeMethod* method) ;
// System.Void Agora.Rtc.Optional`1<System.UInt64>::.ctor()
IL2CPP_EXTERN_C IL2CPP_METHOD_ATTR void Optional_1__ctor_m79B26B02B0FF0383EC85B8E2E045C2C5B97A45D1_gshared (Optional_1_tD8A059C84DFD90B30DB7B4CAC4A0C5F232084498* __this, const RuntimeMethod* method) ;
// System.Void Agora.Rtc.Optional`1<System.UInt64>::SetValue(T)
IL2CPP_EXTERN_C IL2CPP_METHOD_ATTR void Optional_1_SetValue_m4536867BC951C653111124BBB2F692D695165773_gshared (Optional_1_tD8A059C84DFD90B30DB7B4CAC4A0C5F232084498* __this, uint64_t ___val0, const RuntimeMethod* method) ;
// System.Void Agora.Rtc.Optional`1<System.Boolean>::.ctor()
IL2CPP_EXTERN_C IL2CPP_METHOD_ATTR void Optional_1__ctor_m2ADDAA3E2FF62251E6B96683AC3D58EC6E8CE0AA_gshared (Optional_1_t5ECCECA11C3EA2B3D72FC80C3EEC85F541294665* __this, const RuntimeMethod* method) ;
// System.Void Agora.Rtc.Optional`1<System.Boolean>::SetValue(T)
IL2CPP_EXTERN_C IL2CPP_METHOD_ATTR void Optional_1_SetValue_mE51373D626F7E164049DB4371067C33F9229DC80_gshared (Optional_1_t5ECCECA11C3EA2B3D72FC80C3EEC85F541294665* __this, bool ___val0, const RuntimeMethod* method) ;
// System.Void Agora.Rtc.Optional`1<System.Object>::.ctor()
IL2CPP_EXTERN_C IL2CPP_METHOD_ATTR void Optional_1__ctor_mE445CA600DA6661BF4A466E7BE025C4929EB0EF5_gshared (Optional_1_tBE74ACADAF125EAA7731E765B4D8F7F002656BFF* __this, const RuntimeMethod* method) ;
// System.Void Agora.Rtc.Optional`1<System.Object>::SetValue(T)
IL2CPP_EXTERN_C IL2CPP_METHOD_ATTR void Optional_1_SetValue_m145E2CBA4B76C86404FD08024643A99C5E1100B3_gshared (Optional_1_tBE74ACADAF125EAA7731E765B4D8F7F002656BFF* __this, RuntimeObject* ___val0, const RuntimeMethod* method) ;
// System.Void Agora.Rtc.Optional`1<System.Int32Enum>::.ctor()
IL2CPP_EXTERN_C IL2CPP_METHOD_ATTR void Optional_1__ctor_m5C743D7DEF8FE0BBDB1398F4612A55D1C303649C_gshared (Optional_1_t2954B1B7E8E21A89BCCE60964639F2F7B046A240* __this, const RuntimeMethod* method) ;
// System.Void Agora.Rtc.Optional`1<System.Int32Enum>::SetValue(T)
IL2CPP_EXTERN_C IL2CPP_METHOD_ATTR void Optional_1_SetValue_m1AAF58229F17836ABA07C6682BDFA6EF786B900C_gshared (Optional_1_t2954B1B7E8E21A89BCCE60964639F2F7B046A240* __this, int32_t ___val0, const RuntimeMethod* method) ;
// System.Void System.Collections.Generic.Stack`1<System.Int32>::.ctor()
IL2CPP_EXTERN_C IL2CPP_METHOD_ATTR void Stack_1__ctor_mF63AE96E8925749CDACE05B89002A389DDD748D1_gshared (Stack_1_t3197E0F5EA36E611B259A88751D31FC2396FE4B6* __this, const RuntimeMethod* method) ;
// System.Void System.Collections.Generic.Stack`1<System.Int32>::Push(T)
IL2CPP_EXTERN_C IL2CPP_METHOD_ATTR void Stack_1_Push_mF7CC12CF73D9D4B66FFA2E2D264270212CAB3EDA_gshared (Stack_1_t3197E0F5EA36E611B259A88751D31FC2396FE4B6* __this, int32_t ___item0, const RuntimeMethod* method) ;
// System.Void System.Collections.Generic.Dictionary`2<System.Int32,System.Object>::.ctor()
IL2CPP_EXTERN_C IL2CPP_METHOD_ATTR void Dictionary_2__ctor_m92E9AB321FBD7147CA109C822D99C8B0610C27B7_gshared (Dictionary_2_tA75D1125AC9BE8F005BA9B868B373398E643C907* __this, const RuntimeMethod* method) ;
// System.Void System.Collections.Generic.Stack`1<System.Int32>::Clear()
IL2CPP_EXTERN_C IL2CPP_METHOD_ATTR void Stack_1_Clear_mEE1C6E0AF654AE01D41D12DAF62217D4FE3930E0_gshared (Stack_1_t3197E0F5EA36E611B259A88751D31FC2396FE4B6* __this, const RuntimeMethod* method) ;
// T System.Collections.Generic.Stack`1<System.Int32>::Peek()
IL2CPP_EXTERN_C IL2CPP_METHOD_ATTR int32_t Stack_1_Peek_m919AA48BFC239B260BB6A0639B8E027B60CB8B66_gshared (Stack_1_t3197E0F5EA36E611B259A88751D31FC2396FE4B6* __this, const RuntimeMethod* method) ;
// T System.Collections.Generic.Stack`1<System.Int32>::Pop()
IL2CPP_EXTERN_C IL2CPP_METHOD_ATTR int32_t Stack_1_Pop_m59DFD2B5EC8D9044532E0AD0BDB20DB33BA76748_gshared (Stack_1_t3197E0F5EA36E611B259A88751D31FC2396FE4B6* __this, const RuntimeMethod* method) ;
// System.Void System.Collections.Generic.Stack`1<System.Object>::.ctor()
IL2CPP_EXTERN_C IL2CPP_METHOD_ATTR void Stack_1__ctor_m70E8EDA96A608CE9BAB7FC8313B233AADA573BD4_gshared (Stack_1_tAD790A47551563636908E21E4F08C54C0C323EB5* __this, const RuntimeMethod* method) ;
// System.Void System.Collections.Generic.Stack`1<System.Object>::Push(T)
IL2CPP_EXTERN_C IL2CPP_METHOD_ATTR void Stack_1_Push_m709DD11BC1291A905814182CF9A367DE7399A778_gshared (Stack_1_tAD790A47551563636908E21E4F08C54C0C323EB5* __this, RuntimeObject* ___item0, const RuntimeMethod* method) ;
// System.Void System.Collections.Generic.Stack`1<System.Object>::Clear()
IL2CPP_EXTERN_C IL2CPP_METHOD_ATTR void Stack_1_Clear_mD550E89582979ECB0D6E6D68F0237FC14708BE85_gshared (Stack_1_tAD790A47551563636908E21E4F08C54C0C323EB5* __this, const RuntimeMethod* method) ;
// T System.Collections.Generic.Stack`1<System.Object>::Pop()
IL2CPP_EXTERN_C IL2CPP_METHOD_ATTR RuntimeObject* Stack_1_Pop_m2AFF69249659372F07EE25817DBCAFE74E1CF778_gshared (Stack_1_tAD790A47551563636908E21E4F08C54C0C323EB5* __this, const RuntimeMethod* method) ;
// System.Int32 System.Collections.Generic.Stack`1<System.Object>::get_Count()
IL2CPP_MANAGED_FORCE_INLINE IL2CPP_METHOD_ATTR int32_t Stack_1_get_Count_mD08AE71D49787D30DDD9D484BCD323D646744D2E_gshared_inline (Stack_1_tAD790A47551563636908E21E4F08C54C0C323EB5* __this, const RuntimeMethod* method) ;
// T System.Collections.Generic.Stack`1<System.Object>::Peek()
IL2CPP_EXTERN_C IL2CPP_METHOD_ATTR RuntimeObject* Stack_1_Peek_mF0ECF6A61726B66E6D9B33D8C4DEAA47E586E6E4_gshared (Stack_1_tAD790A47551563636908E21E4F08C54C0C323EB5* __this, const RuntimeMethod* method) ;

// System.Void Agora.Rtc.LitJson.JsonMapper/<>c::.ctor()
IL2CPP_EXTERN_C IL2CPP_METHOD_ATTR void U3CU3Ec__ctor_m2EDE631E41DFFEC6C5143F53EF3C5B7A5DE5DC00 (U3CU3Ec_tB2417947DB790EC3B314B9BB1046B04B68400CDA* __this, const RuntimeMethod* method) ;
// System.Void System.Object::.ctor()
IL2CPP_EXTERN_C IL2CPP_METHOD_ATTR void Object__ctor_mE837C6B9FA8C6D5D109F4B2EC885D79919AC0EA2 (RuntimeObject* __this, const RuntimeMethod* method) ;
// System.Void Agora.Rtc.LitJson.JsonMockWrapper::.ctor()
IL2CPP_EXTERN_C IL2CPP_METHOD_ATTR void JsonMockWrapper__ctor_m5DD911B1FCB226E895971B6F1F015398E9A25BFA (JsonMockWrapper_tE04391F97D9A84CC02FF454281A59C54DE05355C* __this, const RuntimeMethod* method) ;
// System.Int32 System.Convert::ToInt32(System.Byte)
IL2CPP_EXTERN_C IL2CPP_METHOD_ATTR int32_t Convert_ToInt32_mD8869793A34ED86D38EFDF4BFCDD8D03FBBCCAB6 (uint8_t ___value0, const RuntimeMethod* method) ;
// System.Void Agora.Rtc.LitJson.JsonWriter::Write(System.Int32)
IL2CPP_EXTERN_C IL2CPP_METHOD_ATTR void JsonWriter_Write_mCC3A77C46777F4FF87E8CD21ED0E8608CD06BD30 (JsonWriter_tC9B032D35ED4E85319A227892A43EB8627661732* __this, int32_t ___number0, const RuntimeMethod* method) ;
// System.String System.Convert::ToString(System.Char)
IL2CPP_EXTERN_C IL2CPP_METHOD_ATTR String_t* Convert_ToString_m8270C8361D2796C5C4659D441829CAFEEFBAC91C (Il2CppChar ___value0, const RuntimeMethod* method) ;
// System.Void Agora.Rtc.LitJson.JsonWriter::Write(System.String)
IL2CPP_EXTERN_C IL2CPP_METHOD_ATTR void JsonWriter_Write_mF5B2C30D93DE321FCBBEE50EB4D68895D210201A (JsonWriter_tC9B032D35ED4E85319A227892A43EB8627661732* __this, String_t* ___str0, const RuntimeMethod* method) ;
// System.String System.Convert::ToString(System.DateTime,System.IFormatProvider)
IL2CPP_EXTERN_C IL2CPP_METHOD_ATTR String_t* Convert_ToString_m942B26CABBBFDCE9F1E647B15CA98F03D50976A0 (DateTime_t66193957C73913903DDAD89FEDC46139BCA5802D ___value0, RuntimeObject* ___provider1, const RuntimeMethod* method) ;
// System.Void Agora.Rtc.LitJson.JsonWriter::Write(System.Decimal)
IL2CPP_EXTERN_C IL2CPP_METHOD_ATTR void JsonWriter_Write_m890E86088FDAB9171E16DEDD20FE3DA90C7339C9 (JsonWriter_tC9B032D35ED4E85319A227892A43EB8627661732* __this, Decimal_tDA6C877282B2D789CF97C0949661CC11D643969F ___number0, const RuntimeMethod* method) ;
// System.Int32 System.Convert::ToInt32(System.SByte)
IL2CPP_EXTERN_C IL2CPP_METHOD_ATTR int32_t Convert_ToInt32_m9FD81A0DC7D2A34B74068ACA2F311270937DA2A2 (int8_t ___value0, const RuntimeMethod* method) ;
// System.Int32 System.Convert::ToInt32(System.Int16)
IL2CPP_EXTERN_C IL2CPP_METHOD_ATTR int32_t Convert_ToInt32_m708CB4FF71A3D4E08CBAAF70F290D093BD80AFCC (int16_t ___value0, const RuntimeMethod* method) ;
// System.Int32 System.Convert::ToInt32(System.UInt16)
IL2CPP_EXTERN_C IL2CPP_METHOD_ATTR int32_t Convert_ToInt32_m350A3CBA3E031A3D53D14062D7E4ABB4A33F5438 (uint16_t ___value0, const RuntimeMethod* method) ;
// System.UInt64 System.Convert::ToUInt64(System.UInt32)
IL2CPP_EXTERN_C IL2CPP_METHOD_ATTR uint64_t Convert_ToUInt64_m91C774E0D3AA8368D12AB8E2036E823C4FA9CB92 (uint32_t ___value0, const RuntimeMethod* method) ;
// System.Void Agora.Rtc.LitJson.JsonWriter::Write(System.UInt64)
IL2CPP_EXTERN_C IL2CPP_METHOD_ATTR void JsonWriter_Write_mAE20584AB1461EFA3BB71203CC1A65BAC8C650AE (JsonWriter_tC9B032D35ED4E85319A227892A43EB8627661732* __this, uint64_t ___number0, const RuntimeMethod* method) ;
// System.String System.DateTimeOffset::ToString(System.String,System.IFormatProvider)
IL2CPP_EXTERN_C IL2CPP_METHOD_ATTR String_t* DateTimeOffset_ToString_m4B5BB65E069D2146E808A1CE5F424ACA2F4D2281 (DateTimeOffset_t4EE701FE2F386D6F932FAC9B11E4B74A5B30F0A4* __this, String_t* ___format0, RuntimeObject* ___formatProvider1, const RuntimeMethod* method) ;
// System.Byte System.Convert::ToByte(System.Int32)
IL2CPP_EXTERN_C IL2CPP_METHOD_ATTR uint8_t Convert_ToByte_mB200A29D6E5CE42D564544DF1DC8852BF3582833 (int32_t ___value0, const RuntimeMethod* method) ;
// System.UInt64 System.Convert::ToUInt64(System.Int32)
IL2CPP_EXTERN_C IL2CPP_METHOD_ATTR uint64_t Convert_ToUInt64_m53C3A45C87A06F25957619222B04EABFD214373C (int32_t ___value0, const RuntimeMethod* method) ;
// System.Int64 System.Convert::ToInt64(System.Int32)
IL2CPP_EXTERN_C IL2CPP_METHOD_ATTR int64_t Convert_ToInt64_m96FAEEA01C1BA082BB3925CC2099C0591DBF632A (int32_t ___value0, const RuntimeMethod* method) ;
// System.UInt32 System.Convert::ToUInt32(System.Int32)
IL2CPP_EXTERN_C IL2CPP_METHOD_ATTR uint32_t Convert_ToUInt32_m3BD840FA8B5073EDD04AD3D3A044785EB00511A3 (int32_t ___value0, const RuntimeMethod* method) ;
// System.SByte System.Convert::ToSByte(System.Int32)
IL2CPP_EXTERN_C IL2CPP_METHOD_ATTR int8_t Convert_ToSByte_mA336C42E413A5559B3F47FCD8B45EDB538693E63 (int32_t ___value0, const RuntimeMethod* method) ;
// System.Int16 System.Convert::ToInt16(System.Int32)
IL2CPP_EXTERN_C IL2CPP_METHOD_ATTR int16_t Convert_ToInt16_mF65D8227B8B6F0E30A135BC5F01F1562455AD382 (int32_t ___value0, const RuntimeMethod* method) ;
// System.UInt16 System.Convert::ToUInt16(System.Int32)
IL2CPP_EXTERN_C IL2CPP_METHOD_ATTR uint16_t Convert_ToUInt16_mA3ABC9268BA473D6F1C7801248D3200734180B2B (int32_t ___value0, const RuntimeMethod* method) ;
// System.Single System.Convert::ToSingle(System.Int32)
IL2CPP_EXTERN_C IL2CPP_METHOD_ATTR float Convert_ToSingle_mE54B145DE1F8A182C3D1A66AEF3A95CB399C28CE (int32_t ___value0, const RuntimeMethod* method) ;
// System.Double System.Convert::ToDouble(System.Int32)
IL2CPP_EXTERN_C IL2CPP_METHOD_ATTR double Convert_ToDouble_m21A92C91FFDA003BD27748AA55CA0A7D6C0E6694 (int32_t ___value0, const RuntimeMethod* method) ;
// System.Int64 System.Convert::ToInt64(System.UInt32)
IL2CPP_EXTERN_C IL2CPP_METHOD_ATTR int64_t Convert_ToInt64_mDBCA1C09FD81078B6BEC7A0767835B9ED158E732 (uint32_t ___value0, const RuntimeMethod* method) ;
// System.Decimal System.Convert::ToDecimal(System.Double)
IL2CPP_EXTERN_C IL2CPP_METHOD_ATTR Decimal_tDA6C877282B2D789CF97C0949661CC11D643969F Convert_ToDecimal_mAF1D2181BB8C5D3F25C0963245437B4AF4E6C575 (double ___value0, const RuntimeMethod* method) ;
// System.Single System.Convert::ToSingle(System.Double)
IL2CPP_EXTERN_C IL2CPP_METHOD_ATTR float Convert_ToSingle_mF6ADEF60A6A97E9E7E410D8D15B26F2D5995151E (double ___value0, const RuntimeMethod* method) ;
// System.UInt32 System.Convert::ToUInt32(System.Int64)
IL2CPP_EXTERN_C IL2CPP_METHOD_ATTR uint32_t Convert_ToUInt32_m8754C042D71DB6C81EB54D85B73B7EC2710E4FA0 (int64_t ___value0, const RuntimeMethod* method) ;
// System.UInt64 System.Convert::ToUInt64(System.Int64)
IL2CPP_EXTERN_C IL2CPP_METHOD_ATTR uint64_t Convert_ToUInt64_mDC842A03AB192EF47059253789BE224E41200D77 (int64_t ___value0, const RuntimeMethod* method) ;
// System.Char System.Convert::ToChar(System.String)
IL2CPP_EXTERN_C IL2CPP_METHOD_ATTR Il2CppChar Convert_ToChar_m1F2BBA9AD900A2570DE55F3E315BA7D9277E8230 (String_t* ___value0, const RuntimeMethod* method) ;
// System.DateTime System.Convert::ToDateTime(System.String,System.IFormatProvider)
IL2CPP_EXTERN_C IL2CPP_METHOD_ATTR DateTime_t66193957C73913903DDAD89FEDC46139BCA5802D Convert_ToDateTime_mA5FF0ECBE84ECB78B337E4E101423CC9AA95C8C3 (String_t* ___value0, RuntimeObject* ___provider1, const RuntimeMethod* method) ;
// System.DateTimeOffset System.DateTimeOffset::Parse(System.String,System.IFormatProvider)
IL2CPP_EXTERN_C IL2CPP_METHOD_ATTR DateTimeOffset_t4EE701FE2F386D6F932FAC9B11E4B74A5B30F0A4 DateTimeOffset_Parse_m8424EADCF014945BF1C47215B851C735B26BC341 (String_t* ___input0, RuntimeObject* ___formatProvider1, const RuntimeMethod* method) ;
// System.Void Agora.Rtc.Optional`1<System.Double>::.ctor()
inline void Optional_1__ctor_mA609C23EDD6086480DE074C6062697F841A89DE5 (Optional_1_tD55CF2B24B2306B7B7CE9AFEE8C63C8C1C6A3C55* __this, const RuntimeMethod* method)
{
	((  void (*) (Optional_1_tD55CF2B24B2306B7B7CE9AFEE8C63C8C1C6A3C55*, const RuntimeMethod*))Optional_1__ctor_mA609C23EDD6086480DE074C6062697F841A89DE5_gshared)(__this, method);
}
// System.Double System.Convert::ToDouble(System.Object)
IL2CPP_EXTERN_C IL2CPP_METHOD_ATTR double Convert_ToDouble_m86FF4F837721833186E883102C056A35F0860EB0 (RuntimeObject* ___value0, const RuntimeMethod* method) ;
// System.Void Agora.Rtc.Optional`1<System.Double>::SetValue(T)
inline void Optional_1_SetValue_m3DE667644E7C516EB481AB0BEE32FE7EDFB435AF (Optional_1_tD55CF2B24B2306B7B7CE9AFEE8C63C8C1C6A3C55* __this, double ___val0, const RuntimeMethod* method)
{
	((  void (*) (Optional_1_tD55CF2B24B2306B7B7CE9AFEE8C63C8C1C6A3C55*, double, const RuntimeMethod*))Optional_1_SetValue_m3DE667644E7C516EB481AB0BEE32FE7EDFB435AF_gshared)(__this, ___val0, method);
}
// System.Int32 System.Convert::ToInt32(System.Object)
IL2CPP_EXTERN_C IL2CPP_METHOD_ATTR int32_t Convert_ToInt32_m9FEA65DB96264479B5268014F10754787382D297 (RuntimeObject* ___value0, const RuntimeMethod* method) ;
// System.Int64 System.Convert::ToInt64(System.Object)
IL2CPP_EXTERN_C IL2CPP_METHOD_ATTR int64_t Convert_ToInt64_mB980D7B1AB7B7071D416EE892C2B736D712BE1B5 (RuntimeObject* ___value0, const RuntimeMethod* method) ;
// System.Void Agora.Rtc.Optional`1<System.Single>::.ctor()
inline void Optional_1__ctor_m9DF6F847C789BC17876C2CD77F24BEFB722B396B (Optional_1_tF876A70CDF0D3ADF96F01942F0AEAC7EB19FC62A* __this, const RuntimeMethod* method)
{
	((  void (*) (Optional_1_tF876A70CDF0D3ADF96F01942F0AEAC7EB19FC62A*, const RuntimeMethod*))Optional_1__ctor_m9DF6F847C789BC17876C2CD77F24BEFB722B396B_gshared)(__this, method);
}
// System.Void Agora.Rtc.Optional`1<System.Single>::SetValue(T)
inline void Optional_1_SetValue_m63B29B35805A275BE9D1E1FEF8B269FF41763BBD (Optional_1_tF876A70CDF0D3ADF96F01942F0AEAC7EB19FC62A* __this, float ___val0, const RuntimeMethod* method)
{
	((  void (*) (Optional_1_tF876A70CDF0D3ADF96F01942F0AEAC7EB19FC62A*, float, const RuntimeMethod*))Optional_1_SetValue_m63B29B35805A275BE9D1E1FEF8B269FF41763BBD_gshared)(__this, ___val0, method);
}
// System.Void Agora.Rtc.Optional`1<System.Int16>::.ctor()
inline void Optional_1__ctor_mE58BCB3372AE04CCD5F9ED566F9364F5CC849D62 (Optional_1_t3E699351D46D874511D63581794E1D62BC1A2E12* __this, const RuntimeMethod* method)
{
	((  void (*) (Optional_1_t3E699351D46D874511D63581794E1D62BC1A2E12*, const RuntimeMethod*))Optional_1__ctor_mE58BCB3372AE04CCD5F9ED566F9364F5CC849D62_gshared)(__this, method);
}
// System.Void Agora.Rtc.Optional`1<System.Int16>::SetValue(T)
inline void Optional_1_SetValue_m9451999734A371C8E4986D51E5019BD66C8A16D9 (Optional_1_t3E699351D46D874511D63581794E1D62BC1A2E12* __this, int16_t ___val0, const RuntimeMethod* method)
{
	((  void (*) (Optional_1_t3E699351D46D874511D63581794E1D62BC1A2E12*, int16_t, const RuntimeMethod*))Optional_1_SetValue_m9451999734A371C8E4986D51E5019BD66C8A16D9_gshared)(__this, ___val0, method);
}
// System.UInt64 System.Convert::ToUInt64(System.Object)
IL2CPP_EXTERN_C IL2CPP_METHOD_ATTR uint64_t Convert_ToUInt64_mAED581BDC2A2EC0295EC6FB7C7D525571FEA4A0B (RuntimeObject* ___value0, const RuntimeMethod* method) ;
// System.Void Agora.Rtc.Optional`1<System.UInt16>::.ctor()
inline void Optional_1__ctor_mE49D786DC8CA5DF649858A60CBFBBA062B92BD0C (Optional_1_tC0B7C5D987A3B3FBE615A0BA80C8AE46F260A6D5* __this, const RuntimeMethod* method)
{
	((  void (*) (Optional_1_tC0B7C5D987A3B3FBE615A0BA80C8AE46F260A6D5*, const RuntimeMethod*))Optional_1__ctor_mE49D786DC8CA5DF649858A60CBFBBA062B92BD0C_gshared)(__this, method);
}
// System.Void Agora.Rtc.Optional`1<System.UInt16>::SetValue(T)
inline void Optional_1_SetValue_m95F307C9D84062644F9AC400634290FF95E311AF (Optional_1_tC0B7C5D987A3B3FBE615A0BA80C8AE46F260A6D5* __this, uint16_t ___val0, const RuntimeMethod* method)
{
	((  void (*) (Optional_1_tC0B7C5D987A3B3FBE615A0BA80C8AE46F260A6D5*, uint16_t, const RuntimeMethod*))Optional_1_SetValue_m95F307C9D84062644F9AC400634290FF95E311AF_gshared)(__this, ___val0, method);
}
// System.Void Agora.Rtc.Optional`1<System.Int32>::.ctor()
inline void Optional_1__ctor_m4BCDD38353BEADF1738DB8386E39A5FE1AF02022 (Optional_1_t702276DAE9B7132B4ED017493544FE3162F72A13* __this, const RuntimeMethod* method)
{
	((  void (*) (Optional_1_t702276DAE9B7132B4ED017493544FE3162F72A13*, const RuntimeMethod*))Optional_1__ctor_m4BCDD38353BEADF1738DB8386E39A5FE1AF02022_gshared)(__this, method);
}
// System.Void Agora.Rtc.Optional`1<System.Int32>::SetValue(T)
inline void Optional_1_SetValue_mF3084568B1C3B43E1DF604DF0771558BE954DFFC (Optional_1_t702276DAE9B7132B4ED017493544FE3162F72A13* __this, int32_t ___val0, const RuntimeMethod* method)
{
	((  void (*) (Optional_1_t702276DAE9B7132B4ED017493544FE3162F72A13*, int32_t, const RuntimeMethod*))Optional_1_SetValue_mF3084568B1C3B43E1DF604DF0771558BE954DFFC_gshared)(__this, ___val0, method);
}
// System.Void Agora.Rtc.Optional`1<System.UInt32>::.ctor()
inline void Optional_1__ctor_m56D215BBB37874E1671635AE7C29FEDA54E188DD (Optional_1_t9D1D61BD0E1BAFD11E7902319403D52C0DF276FD* __this, const RuntimeMethod* method)
{
	((  void (*) (Optional_1_t9D1D61BD0E1BAFD11E7902319403D52C0DF276FD*, const RuntimeMethod*))Optional_1__ctor_m56D215BBB37874E1671635AE7C29FEDA54E188DD_gshared)(__this, method);
}
// System.Void Agora.Rtc.Optional`1<System.UInt32>::SetValue(T)
inline void Optional_1_SetValue_mD23D4E22ECBEF9E399D3F72DD292DFBFFD63EC38 (Optional_1_t9D1D61BD0E1BAFD11E7902319403D52C0DF276FD* __this, uint32_t ___val0, const RuntimeMethod* method)
{
	((  void (*) (Optional_1_t9D1D61BD0E1BAFD11E7902319403D52C0DF276FD*, uint32_t, const RuntimeMethod*))Optional_1_SetValue_mD23D4E22ECBEF9E399D3F72DD292DFBFFD63EC38_gshared)(__this, ___val0, method);
}
// System.Void Agora.Rtc.Optional`1<System.Int64>::.ctor()
inline void Optional_1__ctor_m5760A6A5D2C28A6694EE100F6AFEC70D7756D2DF (Optional_1_tBB9FFF9D20636D333BC8766DBB02D617339F5001* __this, const RuntimeMethod* method)
{
	((  void (*) (Optional_1_tBB9FFF9D20636D333BC8766DBB02D617339F5001*, const RuntimeMethod*))Optional_1__ctor_m5760A6A5D2C28A6694EE100F6AFEC70D7756D2DF_gshared)(__this, method);
}
// System.Void Agora.Rtc.Optional`1<System.Int64>::SetValue(T)
inline void Optional_1_SetValue_m43C38C7D77F2E17987091551FC38C2867EB8A66F (Optional_1_tBB9FFF9D20636D333BC8766DBB02D617339F5001* __this, int64_t ___val0, const RuntimeMethod* method)
{
	((  void (*) (Optional_1_tBB9FFF9D20636D333BC8766DBB02D617339F5001*, int64_t, const RuntimeMethod*))Optional_1_SetValue_m43C38C7D77F2E17987091551FC38C2867EB8A66F_gshared)(__this, ___val0, method);
}
// System.Void Agora.Rtc.Optional`1<System.UInt64>::.ctor()
inline void Optional_1__ctor_m79B26B02B0FF0383EC85B8E2E045C2C5B97A45D1 (Optional_1_tD8A059C84DFD90B30DB7B4CAC4A0C5F232084498* __this, const RuntimeMethod* method)
{
	((  void (*) (Optional_1_tD8A059C84DFD90B30DB7B4CAC4A0C5F232084498*, const RuntimeMethod*))Optional_1__ctor_m79B26B02B0FF0383EC85B8E2E045C2C5B97A45D1_gshared)(__this, method);
}
// System.Void Agora.Rtc.Optional`1<System.UInt64>::SetValue(T)
inline void Optional_1_SetValue_m4536867BC951C653111124BBB2F692D695165773 (Optional_1_tD8A059C84DFD90B30DB7B4CAC4A0C5F232084498* __this, uint64_t ___val0, const RuntimeMethod* method)
{
	((  void (*) (Optional_1_tD8A059C84DFD90B30DB7B4CAC4A0C5F232084498*, uint64_t, const RuntimeMethod*))Optional_1_SetValue_m4536867BC951C653111124BBB2F692D695165773_gshared)(__this, ___val0, method);
}
// System.Void Agora.Rtc.Optional`1<System.Boolean>::.ctor()
inline void Optional_1__ctor_m2ADDAA3E2FF62251E6B96683AC3D58EC6E8CE0AA (Optional_1_t5ECCECA11C3EA2B3D72FC80C3EEC85F541294665* __this, const RuntimeMethod* method)
{
	((  void (*) (Optional_1_t5ECCECA11C3EA2B3D72FC80C3EEC85F541294665*, const RuntimeMethod*))Optional_1__ctor_m2ADDAA3E2FF62251E6B96683AC3D58EC6E8CE0AA_gshared)(__this, method);
}
// System.Boolean System.Convert::ToBoolean(System.Object)
IL2CPP_EXTERN_C IL2CPP_METHOD_ATTR bool Convert_ToBoolean_m35ABFE9171C8E44E23C95CD872DFEF2F2B643214 (RuntimeObject* ___value0, const RuntimeMethod* method) ;
// System.Void Agora.Rtc.Optional`1<System.Boolean>::SetValue(T)
inline void Optional_1_SetValue_mE51373D626F7E164049DB4371067C33F9229DC80 (Optional_1_t5ECCECA11C3EA2B3D72FC80C3EEC85F541294665* __this, bool ___val0, const RuntimeMethod* method)
{
	((  void (*) (Optional_1_t5ECCECA11C3EA2B3D72FC80C3EEC85F541294665*, bool, const RuntimeMethod*))Optional_1_SetValue_mE51373D626F7E164049DB4371067C33F9229DC80_gshared)(__this, ___val0, method);
}
// System.Void Agora.Rtc.Optional`1<System.String>::.ctor()
inline void Optional_1__ctor_mA5DC848AD987E18C01F59A7A5289BAD0E6BCE9D2 (Optional_1_t3CE97B858328B754CADD94F152EB4D1D51932DB4* __this, const RuntimeMethod* method)
{
	((  void (*) (Optional_1_t3CE97B858328B754CADD94F152EB4D1D51932DB4*, const RuntimeMethod*))Optional_1__ctor_mE445CA600DA6661BF4A466E7BE025C4929EB0EF5_gshared)(__this, method);
}
// System.String System.Convert::ToString(System.Object)
IL2CPP_EXTERN_C IL2CPP_METHOD_ATTR String_t* Convert_ToString_m03249561BBE153E4ED7E2E130ECC65F08B322261 (RuntimeObject* ___value0, const RuntimeMethod* method) ;
// System.Void Agora.Rtc.Optional`1<System.String>::SetValue(T)
inline void Optional_1_SetValue_mB47C082042F2A87BF323DF623B36F42D9E9D7F57 (Optional_1_t3CE97B858328B754CADD94F152EB4D1D51932DB4* __this, String_t* ___val0, const RuntimeMethod* method)
{
	((  void (*) (Optional_1_t3CE97B858328B754CADD94F152EB4D1D51932DB4*, String_t*, const RuntimeMethod*))Optional_1_SetValue_m145E2CBA4B76C86404FD08024643A99C5E1100B3_gshared)(__this, ___val0, method);
}
// System.Void Agora.Rtc.Optional`1<Agora.Rtc.CLIENT_ROLE_TYPE>::.ctor()
inline void Optional_1__ctor_m5DC885CD5B69591EB08A40E04FA0FC5614236845 (Optional_1_t5C8656A1B957381763DED81AE837B5564B6B338C* __this, const RuntimeMethod* method)
{
	((  void (*) (Optional_1_t5C8656A1B957381763DED81AE837B5564B6B338C*, const RuntimeMethod*))Optional_1__ctor_m5C743D7DEF8FE0BBDB1398F4612A55D1C303649C_gshared)(__this, method);
}
// System.Int16 System.Convert::ToInt16(System.Object)
IL2CPP_EXTERN_C IL2CPP_METHOD_ATTR int16_t Convert_ToInt16_mD8FC1332F5EA5618C3765BA1EB756406A10FDDA6 (RuntimeObject* ___value0, const RuntimeMethod* method) ;
// System.Void Agora.Rtc.Optional`1<Agora.Rtc.CLIENT_ROLE_TYPE>::SetValue(T)
inline void Optional_1_SetValue_m9F830E4C0FE451B2678B622ABD1354E73E885BB3 (Optional_1_t5C8656A1B957381763DED81AE837B5564B6B338C* __this, int32_t ___val0, const RuntimeMethod* method)
{
	((  void (*) (Optional_1_t5C8656A1B957381763DED81AE837B5564B6B338C*, int32_t, const RuntimeMethod*))Optional_1_SetValue_m1AAF58229F17836ABA07C6682BDFA6EF786B900C_gshared)(__this, ___val0, method);
}
// System.Void Agora.Rtc.Optional`1<Agora.Rtc.AUDIENCE_LATENCY_LEVEL_TYPE>::.ctor()
inline void Optional_1__ctor_mE3FEC568347BCA235ECDF84A661CA953A0C3E6EC (Optional_1_t3D985A7F63673DFB7B5DCD8CE9EE622EABB76D1F* __this, const RuntimeMethod* method)
{
	((  void (*) (Optional_1_t3D985A7F63673DFB7B5DCD8CE9EE622EABB76D1F*, const RuntimeMethod*))Optional_1__ctor_m5C743D7DEF8FE0BBDB1398F4612A55D1C303649C_gshared)(__this, method);
}
// System.Void Agora.Rtc.Optional`1<Agora.Rtc.AUDIENCE_LATENCY_LEVEL_TYPE>::SetValue(T)
inline void Optional_1_SetValue_mFAD6E19EFE099CD86FA9A55C3185DE2351661769 (Optional_1_t3D985A7F63673DFB7B5DCD8CE9EE622EABB76D1F* __this, int32_t ___val0, const RuntimeMethod* method)
{
	((  void (*) (Optional_1_t3D985A7F63673DFB7B5DCD8CE9EE622EABB76D1F*, int32_t, const RuntimeMethod*))Optional_1_SetValue_m1AAF58229F17836ABA07C6682BDFA6EF786B900C_gshared)(__this, ___val0, method);
}
// System.Void Agora.Rtc.Optional`1<Agora.Rtc.VIDEO_STREAM_TYPE>::.ctor()
inline void Optional_1__ctor_mEC9461341FDABED29A99326920E7090D70BD3901 (Optional_1_tC5AB3A88C37AF5FA76EC96E7F6256F299BBA4827* __this, const RuntimeMethod* method)
{
	((  void (*) (Optional_1_tC5AB3A88C37AF5FA76EC96E7F6256F299BBA4827*, const RuntimeMethod*))Optional_1__ctor_m5C743D7DEF8FE0BBDB1398F4612A55D1C303649C_gshared)(__this, method);
}
// System.Void Agora.Rtc.Optional`1<Agora.Rtc.VIDEO_STREAM_TYPE>::SetValue(T)
inline void Optional_1_SetValue_m4DA972A9DB7CD324E7EAB9E82D7A394EAAC7C4CC (Optional_1_tC5AB3A88C37AF5FA76EC96E7F6256F299BBA4827* __this, int32_t ___val0, const RuntimeMethod* method)
{
	((  void (*) (Optional_1_tC5AB3A88C37AF5FA76EC96E7F6256F299BBA4827*, int32_t, const RuntimeMethod*))Optional_1_SetValue_m1AAF58229F17836ABA07C6682BDFA6EF786B900C_gshared)(__this, ___val0, method);
}
// System.Void Agora.Rtc.Optional`1<Agora.Rtc.CHANNEL_PROFILE_TYPE>::.ctor()
inline void Optional_1__ctor_mDCE5346C89F45F6878E2B214DF77B1B37CBD1265 (Optional_1_t6777AA03B6B6BCE1D48C4DFAA9F6499242C82F05* __this, const RuntimeMethod* method)
{
	((  void (*) (Optional_1_t6777AA03B6B6BCE1D48C4DFAA9F6499242C82F05*, const RuntimeMethod*))Optional_1__ctor_m5C743D7DEF8FE0BBDB1398F4612A55D1C303649C_gshared)(__this, method);
}
// System.Void Agora.Rtc.Optional`1<Agora.Rtc.CHANNEL_PROFILE_TYPE>::SetValue(T)
inline void Optional_1_SetValue_mFAAAF5769CD67501C36EBB483D13A1A015F82492 (Optional_1_t6777AA03B6B6BCE1D48C4DFAA9F6499242C82F05* __this, int32_t ___val0, const RuntimeMethod* method)
{
	((  void (*) (Optional_1_t6777AA03B6B6BCE1D48C4DFAA9F6499242C82F05*, int32_t, const RuntimeMethod*))Optional_1_SetValue_m1AAF58229F17836ABA07C6682BDFA6EF786B900C_gshared)(__this, ___val0, method);
}
// System.Void Agora.Rtc.Optional`1<Agora.Rtc.THREAD_PRIORITY_TYPE>::.ctor()
inline void Optional_1__ctor_mB7E1B789CD114B93E341606596E8E6CE6D5EB1D0 (Optional_1_tF6D53E8DA343ADCA47506DF62B9921E5612BCA69* __this, const RuntimeMethod* method)
{
	((  void (*) (Optional_1_tF6D53E8DA343ADCA47506DF62B9921E5612BCA69*, const RuntimeMethod*))Optional_1__ctor_m5C743D7DEF8FE0BBDB1398F4612A55D1C303649C_gshared)(__this, method);
}
// System.Void Agora.Rtc.Optional`1<Agora.Rtc.THREAD_PRIORITY_TYPE>::SetValue(T)
inline void Optional_1_SetValue_m2C9100B836AAA180D846DCC74A0ED4A4118E8863 (Optional_1_tF6D53E8DA343ADCA47506DF62B9921E5612BCA69* __this, int32_t ___val0, const RuntimeMethod* method)
{
	((  void (*) (Optional_1_tF6D53E8DA343ADCA47506DF62B9921E5612BCA69*, int32_t, const RuntimeMethod*))Optional_1_SetValue_m1AAF58229F17836ABA07C6682BDFA6EF786B900C_gshared)(__this, ___val0, method);
}
// System.IntPtr System.IntPtr::op_Explicit(System.Int32)
IL2CPP_EXTERN_C IL2CPP_METHOD_ATTR intptr_t IntPtr_op_Explicit_m931A344F16D4C65EFB0B492EB07C7A82AF0B9FA1 (int32_t ___value0, const RuntimeMethod* method) ;
// System.IntPtr System.IntPtr::op_Explicit(System.Int64)
IL2CPP_EXTERN_C IL2CPP_METHOD_ATTR intptr_t IntPtr_op_Explicit_mDDF1A91C58AC17347D735651A0D830CA1E86D4B0 (int64_t ___value0, const RuntimeMethod* method) ;
// System.Void Agora.Rtc.LitJson.JsonData::.ctor()
IL2CPP_EXTERN_C IL2CPP_METHOD_ATTR void JsonData__ctor_mD094650916BAA209E638A00FC1A2DD966ED6B5BC (JsonData_t84ADF600AA1B164B56CAFAAF965FE17B8A3543D5* __this, const RuntimeMethod* method) ;
// System.Boolean Agora.Rtc.LitJson.Lexer::get_AllowComments()
IL2CPP_MANAGED_FORCE_INLINE IL2CPP_METHOD_ATTR bool Lexer_get_AllowComments_mBD7811B449819997218E5052F2763E267EFF277B_inline (Lexer_tDC14CFA7B390E884510F554D9D1E03188A185E27* __this, const RuntimeMethod* method) ;
// System.Void Agora.Rtc.LitJson.Lexer::set_AllowComments(System.Boolean)
IL2CPP_MANAGED_FORCE_INLINE IL2CPP_METHOD_ATTR void Lexer_set_AllowComments_mA16354319A472743B6F147EAFD3175C774878914_inline (Lexer_tDC14CFA7B390E884510F554D9D1E03188A185E27* __this, bool ___value0, const RuntimeMethod* method) ;
// System.Boolean Agora.Rtc.LitJson.Lexer::get_AllowSingleQuotedStrings()
IL2CPP_MANAGED_FORCE_INLINE IL2CPP_METHOD_ATTR bool Lexer_get_AllowSingleQuotedStrings_mA6F77A0052FA0515743F21C5DA754BE68EF3C7AD_inline (Lexer_tDC14CFA7B390E884510F554D9D1E03188A185E27* __this, const RuntimeMethod* method) ;
// System.Void Agora.Rtc.LitJson.Lexer::set_AllowSingleQuotedStrings(System.Boolean)
IL2CPP_MANAGED_FORCE_INLINE IL2CPP_METHOD_ATTR void Lexer_set_AllowSingleQuotedStrings_mA3CBFDE99EF4FF5DCC41B861A2CE6E6271B7382D_inline (Lexer_tDC14CFA7B390E884510F554D9D1E03188A185E27* __this, bool ___value0, const RuntimeMethod* method) ;
// System.Collections.Generic.IDictionary`2<System.Int32,System.Collections.Generic.IDictionary`2<System.Int32,System.Int32[]>> Agora.Rtc.LitJson.JsonReader::PopulateParseTable()
IL2CPP_EXTERN_C IL2CPP_METHOD_ATTR RuntimeObject* JsonReader_PopulateParseTable_mFF40CD56EE19A80E03FEB78B71E53CFBBAEC22BE (const RuntimeMethod* method) ;
// System.Void System.IO.StringReader::.ctor(System.String)
IL2CPP_EXTERN_C IL2CPP_METHOD_ATTR void StringReader__ctor_m72556EC1062F49E05CF41B0825AC7FA2DB2A81C0 (StringReader_t1A336148FF22A9584E759A9D720CC96C23E35DD8* __this, String_t* ___s0, const RuntimeMethod* method) ;
// System.Void Agora.Rtc.LitJson.JsonReader::.ctor(System.IO.TextReader,System.Boolean)
IL2CPP_EXTERN_C IL2CPP_METHOD_ATTR void JsonReader__ctor_m8532B5B8E63218CC7A3123B9935E1C5E44A07BBC (JsonReader_tE72AF24875A229A65356715AAFF4C23E38105A3F* __this, TextReader_tB8D43017CB6BE1633E5A86D64E7757366507C1F7* ___reader0, bool ___owned1, const RuntimeMethod* method) ;
// System.Void System.ArgumentNullException::.ctor(System.String)
IL2CPP_EXTERN_C IL2CPP_METHOD_ATTR void ArgumentNullException__ctor_m444AE141157E333844FC1A9500224C2F9FD24F4B (ArgumentNullException_t327031E412FAB2351B0022DD5DAD47E67E597129* __this, String_t* ___paramName0, const RuntimeMethod* method) ;
// System.Void System.Collections.Generic.Stack`1<System.Int32>::.ctor()
inline void Stack_1__ctor_mF63AE96E8925749CDACE05B89002A389DDD748D1 (Stack_1_t3197E0F5EA36E611B259A88751D31FC2396FE4B6* __this, const RuntimeMethod* method)
{
	((  void (*) (Stack_1_t3197E0F5EA36E611B259A88751D31FC2396FE4B6*, const RuntimeMethod*))Stack_1__ctor_mF63AE96E8925749CDACE05B89002A389DDD748D1_gshared)(__this, method);
}
// System.Void System.Collections.Generic.Stack`1<System.Int32>::Push(T)
inline void Stack_1_Push_mF7CC12CF73D9D4B66FFA2E2D264270212CAB3EDA (Stack_1_t3197E0F5EA36E611B259A88751D31FC2396FE4B6* __this, int32_t ___item0, const RuntimeMethod* method)
{
	((  void (*) (Stack_1_t3197E0F5EA36E611B259A88751D31FC2396FE4B6*, int32_t, const RuntimeMethod*))Stack_1_Push_mF7CC12CF73D9D4B66FFA2E2D264270212CAB3EDA_gshared)(__this, ___item0, method);
}
// System.Void Agora.Rtc.LitJson.Lexer::.ctor(System.IO.TextReader)
IL2CPP_EXTERN_C IL2CPP_METHOD_ATTR void Lexer__ctor_mC0FA8A9D9BF9E529309C24F013B2A4F555F1727A (Lexer_tDC14CFA7B390E884510F554D9D1E03188A185E27* __this, TextReader_tB8D43017CB6BE1633E5A86D64E7757366507C1F7* ___reader0, const RuntimeMethod* method) ;
// System.Void System.Collections.Generic.Dictionary`2<System.Int32,System.Collections.Generic.IDictionary`2<System.Int32,System.Int32[]>>::.ctor()
inline void Dictionary_2__ctor_mF37C098D396E6388CF354D6F37970685A85B6FC0 (Dictionary_2_t403ABC2FA2D9740F9ADD28DB8815C00EE2DB4249* __this, const RuntimeMethod* method)
{
	((  void (*) (Dictionary_2_t403ABC2FA2D9740F9ADD28DB8815C00EE2DB4249*, const RuntimeMethod*))Dictionary_2__ctor_m92E9AB321FBD7147CA109C822D99C8B0610C27B7_gshared)(__this, method);
}
// System.Void Agora.Rtc.LitJson.JsonReader::TableAddRow(System.Collections.Generic.IDictionary`2<System.Int32,System.Collections.Generic.IDictionary`2<System.Int32,System.Int32[]>>,Agora.Rtc.LitJson.ParserToken)
IL2CPP_EXTERN_C IL2CPP_METHOD_ATTR void JsonReader_TableAddRow_mD4C19201516D293B36F4BC52B1BC41F2A837230B (RuntimeObject* ___parse_table0, int32_t ___rule1, const RuntimeMethod* method) ;
// System.Void Agora.Rtc.LitJson.JsonReader::TableAddCol(System.Collections.Generic.IDictionary`2<System.Int32,System.Collections.Generic.IDictionary`2<System.Int32,System.Int32[]>>,Agora.Rtc.LitJson.ParserToken,System.Int32,System.Int32[])
IL2CPP_EXTERN_C IL2CPP_METHOD_ATTR void JsonReader_TableAddCol_mC7A131F8C9F735843F03721B124116C59B9D2843 (RuntimeObject* ___parse_table0, int32_t ___row1, int32_t ___col2, Int32U5BU5D_t19C97395396A72ECAF310612F0760F165060314C* ___symbols3, const RuntimeMethod* method) ;
// System.Void System.Runtime.CompilerServices.RuntimeHelpers::InitializeArray(System.Array,System.RuntimeFieldHandle)
IL2CPP_EXTERN_C IL2CPP_METHOD_ATTR void RuntimeHelpers_InitializeArray_m751372AA3F24FBF6DA9B9D687CBFA2DE436CAB9B (RuntimeArray* ___array0, RuntimeFieldHandle_t6E4C45B6D2EA12FC99185805A7E77527899B25C5 ___fldHandle1, const RuntimeMethod* method) ;
// System.Void System.Collections.Generic.Dictionary`2<System.Int32,System.Int32[]>::.ctor()
inline void Dictionary_2__ctor_m3F530E7CD9CC3EB97DCC6E1669EAB9FCE984FA9A (Dictionary_2_t029F6A37F043A1B571A7DB746955ECB8DC548AD9* __this, const RuntimeMethod* method)
{
	((  void (*) (Dictionary_2_t029F6A37F043A1B571A7DB746955ECB8DC548AD9*, const RuntimeMethod*))Dictionary_2__ctor_m92E9AB321FBD7147CA109C822D99C8B0610C27B7_gshared)(__this, method);
}
// System.Int32 System.String::IndexOf(System.Char)
IL2CPP_EXTERN_C IL2CPP_METHOD_ATTR int32_t String_IndexOf_mE21E78F35EF4A7768E385A72814C88D22B689966 (String_t* __this, Il2CppChar ___value0, const RuntimeMethod* method) ;
// System.Globalization.CultureInfo System.Globalization.CultureInfo::get_InvariantCulture()
IL2CPP_EXTERN_C IL2CPP_METHOD_ATTR CultureInfo_t9BA817D41AD55AC8BD07480DD8AC22F8FFA378E0* CultureInfo_get_InvariantCulture_mD1E96DC845E34B10F78CB744B0CB5D7D63CEB1E6 (const RuntimeMethod* method) ;
// System.Boolean System.Double::TryParse(System.String,System.Globalization.NumberStyles,System.IFormatProvider,System.Double&)
IL2CPP_EXTERN_C IL2CPP_METHOD_ATTR bool Double_TryParse_m1D39DC22A45BC9A576B9D9130600BFD3CB6DA382 (String_t* ___s0, int32_t ___style1, RuntimeObject* ___provider2, double* ___result3, const RuntimeMethod* method) ;
// System.Boolean System.Int32::TryParse(System.String,System.Globalization.NumberStyles,System.IFormatProvider,System.Int32&)
IL2CPP_EXTERN_C IL2CPP_METHOD_ATTR bool Int32_TryParse_mB8E246A7D6D6308EF36DE3473643BDE4CF8F71FF (String_t* ___s0, int32_t ___style1, RuntimeObject* ___provider2, int32_t* ___result3, const RuntimeMethod* method) ;
// System.Boolean System.UInt32::TryParse(System.String,System.Globalization.NumberStyles,System.IFormatProvider,System.UInt32&)
IL2CPP_EXTERN_C IL2CPP_METHOD_ATTR bool UInt32_TryParse_m5F53514F97B4CF90C9F1D49D3794B52F6E07BBF3 (String_t* ___s0, int32_t ___style1, RuntimeObject* ___provider2, uint32_t* ___result3, const RuntimeMethod* method) ;
// System.Boolean System.Int64::TryParse(System.String,System.Globalization.NumberStyles,System.IFormatProvider,System.Int64&)
IL2CPP_EXTERN_C IL2CPP_METHOD_ATTR bool Int64_TryParse_m64CEDECE4C3F16B715CA1057801018B2957AE0E3 (String_t* ___s0, int32_t ___style1, RuntimeObject* ___provider2, int64_t* ___result3, const RuntimeMethod* method) ;
// System.Boolean System.UInt64::TryParse(System.String,System.Globalization.NumberStyles,System.IFormatProvider,System.UInt64&)
IL2CPP_EXTERN_C IL2CPP_METHOD_ATTR bool UInt64_TryParse_m33051106D55D2FDFB53461FF5DDB59F8C35B2388 (String_t* ___s0, int32_t ___style1, RuntimeObject* ___provider2, uint64_t* ___result3, const RuntimeMethod* method) ;
// System.String Agora.Rtc.LitJson.Lexer::get_StringValue()
IL2CPP_MANAGED_FORCE_INLINE IL2CPP_METHOD_ATTR String_t* Lexer_get_StringValue_mFCF7CD0EBB22B34F500B25C26360DFF643FE6132_inline (Lexer_tDC14CFA7B390E884510F554D9D1E03188A185E27* __this, const RuntimeMethod* method) ;
// System.Void Agora.Rtc.LitJson.JsonReader::ProcessNumber(System.String)
IL2CPP_EXTERN_C IL2CPP_METHOD_ATTR void JsonReader_ProcessNumber_m5E57D4151FE833AF991EA77CE4D9AADEC5E20D3D (JsonReader_tE72AF24875A229A65356715AAFF4C23E38105A3F* __this, String_t* ___number0, const RuntimeMethod* method) ;
// System.Boolean Agora.Rtc.LitJson.Lexer::NextToken()
IL2CPP_EXTERN_C IL2CPP_METHOD_ATTR bool Lexer_NextToken_mE34A5B2E9932497D86F3BCD0B7732A1454A2760E (Lexer_tDC14CFA7B390E884510F554D9D1E03188A185E27* __this, const RuntimeMethod* method) ;
// System.Boolean Agora.Rtc.LitJson.Lexer::get_EndOfInput()
IL2CPP_MANAGED_FORCE_INLINE IL2CPP_METHOD_ATTR bool Lexer_get_EndOfInput_mB1C09B97ED8A1B7141AB706DCA74D9EE4A6C423D_inline (Lexer_tDC14CFA7B390E884510F554D9D1E03188A185E27* __this, const RuntimeMethod* method) ;
// System.Void Agora.Rtc.LitJson.JsonReader::Close()
IL2CPP_EXTERN_C IL2CPP_METHOD_ATTR void JsonReader_Close_mACAF3ABE0D50A8EF37CDB7CE77CC1FB3AA552C10 (JsonReader_tE72AF24875A229A65356715AAFF4C23E38105A3F* __this, const RuntimeMethod* method) ;
// System.Int32 Agora.Rtc.LitJson.Lexer::get_Token()
IL2CPP_MANAGED_FORCE_INLINE IL2CPP_METHOD_ATTR int32_t Lexer_get_Token_m2A2C0BFC698B6DCE0F1C347A70A47449F9035FBF_inline (Lexer_tDC14CFA7B390E884510F554D9D1E03188A185E27* __this, const RuntimeMethod* method) ;
// System.Void System.Collections.Generic.Stack`1<System.Int32>::Clear()
inline void Stack_1_Clear_mEE1C6E0AF654AE01D41D12DAF62217D4FE3930E0 (Stack_1_t3197E0F5EA36E611B259A88751D31FC2396FE4B6* __this, const RuntimeMethod* method)
{
	((  void (*) (Stack_1_t3197E0F5EA36E611B259A88751D31FC2396FE4B6*, const RuntimeMethod*))Stack_1_Clear_mEE1C6E0AF654AE01D41D12DAF62217D4FE3930E0_gshared)(__this, method);
}
// System.Boolean Agora.Rtc.LitJson.JsonReader::ReadToken()
IL2CPP_EXTERN_C IL2CPP_METHOD_ATTR bool JsonReader_ReadToken_mEFA7D889C078F842BBF80886EA5BC51897E2B83A (JsonReader_tE72AF24875A229A65356715AAFF4C23E38105A3F* __this, const RuntimeMethod* method) ;
// T System.Collections.Generic.Stack`1<System.Int32>::Peek()
inline int32_t Stack_1_Peek_m919AA48BFC239B260BB6A0639B8E027B60CB8B66 (Stack_1_t3197E0F5EA36E611B259A88751D31FC2396FE4B6* __this, const RuntimeMethod* method)
{
	return ((  int32_t (*) (Stack_1_t3197E0F5EA36E611B259A88751D31FC2396FE4B6*, const RuntimeMethod*))Stack_1_Peek_m919AA48BFC239B260BB6A0639B8E027B60CB8B66_gshared)(__this, method);
}
// T System.Collections.Generic.Stack`1<System.Int32>::Pop()
inline int32_t Stack_1_Pop_m59DFD2B5EC8D9044532E0AD0BDB20DB33BA76748 (Stack_1_t3197E0F5EA36E611B259A88751D31FC2396FE4B6* __this, const RuntimeMethod* method)
{
	return ((  int32_t (*) (Stack_1_t3197E0F5EA36E611B259A88751D31FC2396FE4B6*, const RuntimeMethod*))Stack_1_Pop_m59DFD2B5EC8D9044532E0AD0BDB20DB33BA76748_gshared)(__this, method);
}
// System.Void Agora.Rtc.LitJson.JsonReader::ProcessSymbol()
IL2CPP_EXTERN_C IL2CPP_METHOD_ATTR void JsonReader_ProcessSymbol_m509DBD82CC0B635458155A8CF04E5FE56217D787 (JsonReader_tE72AF24875A229A65356715AAFF4C23E38105A3F* __this, const RuntimeMethod* method) ;
// System.Void Agora.Rtc.LitJson.JsonException::.ctor(System.String)
IL2CPP_EXTERN_C IL2CPP_METHOD_ATTR void JsonException__ctor_m8DBB1F40704DD3E03412DABF55AEE93485DCCBBF (JsonException_t3B214813E48AA5E19793F9026831120B5B2254A1* __this, String_t* ___message0, const RuntimeMethod* method) ;
// System.Void Agora.Rtc.LitJson.JsonException::.ctor(Agora.Rtc.LitJson.ParserToken,System.Exception)
IL2CPP_EXTERN_C IL2CPP_METHOD_ATTR void JsonException__ctor_mF7D218AE06BCCB8D56BE8BB7ABCEFE81360CC353 (JsonException_t3B214813E48AA5E19793F9026831120B5B2254A1* __this, int32_t ___token0, Exception_t* ___inner_exception1, const RuntimeMethod* method) ;
// System.Globalization.NumberFormatInfo System.Globalization.NumberFormatInfo::get_InvariantInfo()
IL2CPP_EXTERN_C IL2CPP_METHOD_ATTR NumberFormatInfo_t8E26808B202927FEBF9064FCFEEA4D6E076E6472* NumberFormatInfo_get_InvariantInfo_m4689F466D2607C7369BCE394E3FB3681A6E644FA (const RuntimeMethod* method) ;
// System.Void System.Text.StringBuilder::.ctor()
IL2CPP_EXTERN_C IL2CPP_METHOD_ATTR void StringBuilder__ctor_m1D99713357DE05DAFA296633639DB55F8C30587D (StringBuilder_t* __this, const RuntimeMethod* method) ;
// System.Void System.IO.StringWriter::.ctor(System.Text.StringBuilder)
IL2CPP_EXTERN_C IL2CPP_METHOD_ATTR void StringWriter__ctor_mF38CB8046B79DEF523E427B7F41CA3135671D0C8 (StringWriter_tF48052BE4F980E5C85403221E835768E4156267D* __this, StringBuilder_t* ___sb0, const RuntimeMethod* method) ;
// System.Void Agora.Rtc.LitJson.JsonWriter::Init()
IL2CPP_EXTERN_C IL2CPP_METHOD_ATTR void JsonWriter_Init_m1219982C70E6D0B90AB8552218D25C164613DCEF (JsonWriter_tC9B032D35ED4E85319A227892A43EB8627661732* __this, const RuntimeMethod* method) ;
// System.Void Agora.Rtc.LitJson.JsonWriter::.ctor(System.IO.TextWriter)
IL2CPP_EXTERN_C IL2CPP_METHOD_ATTR void JsonWriter__ctor_mDFC33F09AE54B24B0930A2B55C43B3B4EABD168D (JsonWriter_tC9B032D35ED4E85319A227892A43EB8627661732* __this, TextWriter_tA9E5461506CF806E17B6BBBF2119359DEDA3F0F3* ___writer0, const RuntimeMethod* method) ;
// System.Void System.Collections.Generic.Stack`1<Agora.Rtc.LitJson.WriterContext>::.ctor()
inline void Stack_1__ctor_m6F4B606D290A80B5EA37E96C0DE8A1C9C9C88769 (Stack_1_t7D2C4DA3105E485DD5491FB8B36FC2D66DA84336* __this, const RuntimeMethod* method)
{
	((  void (*) (Stack_1_t7D2C4DA3105E485DD5491FB8B36FC2D66DA84336*, const RuntimeMethod*))Stack_1__ctor_m70E8EDA96A608CE9BAB7FC8313B233AADA573BD4_gshared)(__this, method);
}
// System.Void Agora.Rtc.LitJson.WriterContext::.ctor()
IL2CPP_EXTERN_C IL2CPP_METHOD_ATTR void WriterContext__ctor_m91AF1613E06FA2DC16EBC0B70A80FB80F2AF22C3 (WriterContext_tAA13A82DA53BA6A99795422A71F6D19F331F30BA* __this, const RuntimeMethod* method) ;
// System.Void System.Collections.Generic.Stack`1<Agora.Rtc.LitJson.WriterContext>::Push(T)
inline void Stack_1_Push_m55AF25BEEA08E56F5C74631BB98562B8461303E9 (Stack_1_t7D2C4DA3105E485DD5491FB8B36FC2D66DA84336* __this, WriterContext_tAA13A82DA53BA6A99795422A71F6D19F331F30BA* ___item0, const RuntimeMethod* method)
{
	((  void (*) (Stack_1_t7D2C4DA3105E485DD5491FB8B36FC2D66DA84336*, WriterContext_tAA13A82DA53BA6A99795422A71F6D19F331F30BA*, const RuntimeMethod*))Stack_1_Push_m709DD11BC1291A905814182CF9A367DE7399A778_gshared)(__this, ___item0, method);
}
// System.Void Agora.Rtc.LitJson.JsonWriter::PutNewline(System.Boolean)
IL2CPP_EXTERN_C IL2CPP_METHOD_ATTR void JsonWriter_PutNewline_mCA284D695C145383C730CE1A87C87C5C5A6AA7C5 (JsonWriter_tC9B032D35ED4E85319A227892A43EB8627661732* __this, bool ___add_comma0, const RuntimeMethod* method) ;
// System.String System.Environment::get_NewLine()
IL2CPP_EXTERN_C IL2CPP_METHOD_ATTR String_t* Environment_get_NewLine_m8BF68A4EFDAFFB66500984CE779629811BA98FFF (const RuntimeMethod* method) ;
// System.Void Agora.Rtc.LitJson.JsonWriter::Put(System.String)
IL2CPP_EXTERN_C IL2CPP_METHOD_ATTR void JsonWriter_Put_m727B8E7799FDDF22D93C62522E33ABE198FC78E3 (JsonWriter_tC9B032D35ED4E85319A227892A43EB8627661732* __this, String_t* ___str0, const RuntimeMethod* method) ;
// System.Int32 System.String::get_Length()
IL2CPP_MANAGED_FORCE_INLINE IL2CPP_METHOD_ATTR int32_t String_get_Length_m42625D67623FA5CC7A44D47425CE86FB946542D2_inline (String_t* __this, const RuntimeMethod* method) ;
// System.Char System.String::get_Chars(System.Int32)
IL2CPP_EXTERN_C IL2CPP_METHOD_ATTR Il2CppChar String_get_Chars_mC49DF0CD2D3BE7BE97B3AD9C995BE3094F8E36D3 (String_t* __this, int32_t ___index0, const RuntimeMethod* method) ;
// System.Void Agora.Rtc.LitJson.JsonWriter::IntToHex(System.Int32,System.Char[])
IL2CPP_EXTERN_C IL2CPP_METHOD_ATTR void JsonWriter_IntToHex_mA83EFCC9493DC333D63E162215313A6E245018E3 (int32_t ___n0, CharU5BU5D_t799905CF001DD5F13F7DBB310181FC4D8B7D0AAB* ___hex1, const RuntimeMethod* method) ;
// System.Void System.Collections.Generic.Stack`1<Agora.Rtc.LitJson.WriterContext>::Clear()
inline void Stack_1_Clear_m6A6BD959A75D18D594176D96A28F64A48E06FF42 (Stack_1_t7D2C4DA3105E485DD5491FB8B36FC2D66DA84336* __this, const RuntimeMethod* method)
{
	((  void (*) (Stack_1_t7D2C4DA3105E485DD5491FB8B36FC2D66DA84336*, const RuntimeMethod*))Stack_1_Clear_mD550E89582979ECB0D6E6D68F0237FC14708BE85_gshared)(__this, method);
}
// System.Int32 System.Text.StringBuilder::get_Length()
IL2CPP_EXTERN_C IL2CPP_METHOD_ATTR int32_t StringBuilder_get_Length_mDEA041E7357C68CC3B5885276BB403676DAAE0D8 (StringBuilder_t* __this, const RuntimeMethod* method) ;
// System.Text.StringBuilder System.Text.StringBuilder::Remove(System.Int32,System.Int32)
IL2CPP_EXTERN_C IL2CPP_METHOD_ATTR StringBuilder_t* StringBuilder_Remove_m0D93692674D1C09795C7D6542420A3B6C5F81E90 (StringBuilder_t* __this, int32_t ___startIndex0, int32_t ___length1, const RuntimeMethod* method) ;
// System.Void Agora.Rtc.LitJson.JsonWriter::DoValidation(Agora.Rtc.LitJson.Condition)
IL2CPP_EXTERN_C IL2CPP_METHOD_ATTR void JsonWriter_DoValidation_mE5807100853E142A9F37794C4C13B30619720445 (JsonWriter_tC9B032D35ED4E85319A227892A43EB8627661732* __this, int32_t ___cond0, const RuntimeMethod* method) ;
// System.Void Agora.Rtc.LitJson.JsonWriter::PutNewline()
IL2CPP_EXTERN_C IL2CPP_METHOD_ATTR void JsonWriter_PutNewline_m75776BA10443F6494A562FEF05BF65291B861D1F (JsonWriter_tC9B032D35ED4E85319A227892A43EB8627661732* __this, const RuntimeMethod* method) ;
// System.String System.Convert::ToString(System.Decimal,System.IFormatProvider)
IL2CPP_EXTERN_C IL2CPP_METHOD_ATTR String_t* Convert_ToString_mF6A8BB10515230B099A7EDA9D28C2F8991F758CA (Decimal_tDA6C877282B2D789CF97C0949661CC11D643969F ___value0, RuntimeObject* ___provider1, const RuntimeMethod* method) ;
// System.String System.Convert::ToString(System.Double,System.IFormatProvider)
IL2CPP_EXTERN_C IL2CPP_METHOD_ATTR String_t* Convert_ToString_m7EBE84B1D453D12C9514AD3EF4F6B3F55A5E5C9B (double ___value0, RuntimeObject* ___provider1, const RuntimeMethod* method) ;
// System.String System.Convert::ToString(System.Single,System.IFormatProvider)
IL2CPP_EXTERN_C IL2CPP_METHOD_ATTR String_t* Convert_ToString_mBFBBE2F36FF6B3235848801940FD15A17028AC70 (float ___value0, RuntimeObject* ___provider1, const RuntimeMethod* method) ;
// System.String System.Convert::ToString(System.Int32,System.IFormatProvider)
IL2CPP_EXTERN_C IL2CPP_METHOD_ATTR String_t* Convert_ToString_mC65AC3BEDED3049732E8A67B496AAAEF4C732871 (int32_t ___value0, RuntimeObject* ___provider1, const RuntimeMethod* method) ;
// System.String System.Convert::ToString(System.Int64,System.IFormatProvider)
IL2CPP_EXTERN_C IL2CPP_METHOD_ATTR String_t* Convert_ToString_m03FCA4B41451E9A04705485B1C2FFC3D826B63E1 (int64_t ___value0, RuntimeObject* ___provider1, const RuntimeMethod* method) ;
// System.Void Agora.Rtc.LitJson.JsonWriter::PutString(System.String)
IL2CPP_EXTERN_C IL2CPP_METHOD_ATTR void JsonWriter_PutString_m1727A993A1F47158048BC2E3F6B150B3773E2716 (JsonWriter_tC9B032D35ED4E85319A227892A43EB8627661732* __this, String_t* ___str0, const RuntimeMethod* method) ;
// System.String System.Convert::ToString(System.UInt64,System.IFormatProvider)
IL2CPP_EXTERN_C IL2CPP_METHOD_ATTR String_t* Convert_ToString_mB35C9B82D948EFB22F235F65AC3996B9F44C6D38 (uint64_t ___value0, RuntimeObject* ___provider1, const RuntimeMethod* method) ;
// T System.Collections.Generic.Stack`1<Agora.Rtc.LitJson.WriterContext>::Pop()
inline WriterContext_tAA13A82DA53BA6A99795422A71F6D19F331F30BA* Stack_1_Pop_mCA172CFAE834614F947860C76631CFF9A995BBE3 (Stack_1_t7D2C4DA3105E485DD5491FB8B36FC2D66DA84336* __this, const RuntimeMethod* method)
{
	return ((  WriterContext_tAA13A82DA53BA6A99795422A71F6D19F331F30BA* (*) (Stack_1_t7D2C4DA3105E485DD5491FB8B36FC2D66DA84336*, const RuntimeMethod*))Stack_1_Pop_m2AFF69249659372F07EE25817DBCAFE74E1CF778_gshared)(__this, method);
}
// System.Int32 System.Collections.Generic.Stack`1<Agora.Rtc.LitJson.WriterContext>::get_Count()
inline int32_t Stack_1_get_Count_mDE5E5A58BFA286D4526261A83956911D0C00D06E_inline (Stack_1_t7D2C4DA3105E485DD5491FB8B36FC2D66DA84336* __this, const RuntimeMethod* method)
{
	return ((  int32_t (*) (Stack_1_t7D2C4DA3105E485DD5491FB8B36FC2D66DA84336*, const RuntimeMethod*))Stack_1_get_Count_mD08AE71D49787D30DDD9D484BCD323D646744D2E_gshared_inline)(__this, method);
}
// T System.Collections.Generic.Stack`1<Agora.Rtc.LitJson.WriterContext>::Peek()
inline WriterContext_tAA13A82DA53BA6A99795422A71F6D19F331F30BA* Stack_1_Peek_m0FEDB97EFD290B417A1782460FB52FDA59229146 (Stack_1_t7D2C4DA3105E485DD5491FB8B36FC2D66DA84336* __this, const RuntimeMethod* method)
{
	return ((  WriterContext_tAA13A82DA53BA6A99795422A71F6D19F331F30BA* (*) (Stack_1_t7D2C4DA3105E485DD5491FB8B36FC2D66DA84336*, const RuntimeMethod*))Stack_1_Peek_mF0ECF6A61726B66E6D9B33D8C4DEAA47E586E6E4_gshared)(__this, method);
}
// System.Void Agora.Rtc.LitJson.JsonWriter::Unindent()
IL2CPP_EXTERN_C IL2CPP_METHOD_ATTR void JsonWriter_Unindent_mCE6B680D58C2112946014AE15C9E7AF4D3D047B0 (JsonWriter_tC9B032D35ED4E85319A227892A43EB8627661732* __this, const RuntimeMethod* method) ;
// System.Void Agora.Rtc.LitJson.JsonWriter::Indent()
IL2CPP_EXTERN_C IL2CPP_METHOD_ATTR void JsonWriter_Indent_mC750E7984828750E95FCB795B0D3D6BA3A0D74DA (JsonWriter_tC9B032D35ED4E85319A227892A43EB8627661732* __this, const RuntimeMethod* method) ;
// System.String System.String::ToLowerInvariant()
IL2CPP_EXTERN_C IL2CPP_METHOD_ATTR String_t* String_ToLowerInvariant_mBE32C93DE27C5353FEA3FA654FC1DDBE3D0EB0F2 (String_t* __this, const RuntimeMethod* method) ;
// System.Void Agora.Rtc.LitJson.Lexer::PopulateFsmTables(Agora.Rtc.LitJson.Lexer/StateHandler[]&,System.Int32[]&)
IL2CPP_EXTERN_C IL2CPP_METHOD_ATTR void Lexer_PopulateFsmTables_m1D8CE22E3CB0D1384720CC855AF92D86BEE2B68E (StateHandlerU5BU5D_t766A22C9C454D383614ED21CB99EAD5F5F15438B** ___fsm_handler_table0, Int32U5BU5D_t19C97395396A72ECAF310612F0760F165060314C** ___fsm_return_table1, const RuntimeMethod* method) ;
// System.Void System.Text.StringBuilder::.ctor(System.Int32)
IL2CPP_EXTERN_C IL2CPP_METHOD_ATTR void StringBuilder__ctor_m2619CA8D2C3476DF1A302D9D941498BB1C6164C5 (StringBuilder_t* __this, int32_t ___capacity0, const RuntimeMethod* method) ;
// System.Void Agora.Rtc.LitJson.FsmContext::.ctor()
IL2CPP_EXTERN_C IL2CPP_METHOD_ATTR void FsmContext__ctor_mB83D75833878362DB092C21B06599CA0D363CBFD (FsmContext_tC11B461D4D90680FC71416881106E6AF48CAE21F* __this, const RuntimeMethod* method) ;
// System.Void Agora.Rtc.LitJson.Lexer/StateHandler::.ctor(System.Object,System.IntPtr)
IL2CPP_EXTERN_C IL2CPP_METHOD_ATTR void StateHandler__ctor_m7B636AFF08A3049222D6F82BF87AFF9012CE69D2 (StateHandler_t8EA5CD11BFA1A958F305A2A0134A0BBB631FAFCB* __this, RuntimeObject* ___object0, intptr_t ___method1, const RuntimeMethod* method) ;
// System.Char System.Convert::ToChar(System.Int32)
IL2CPP_EXTERN_C IL2CPP_METHOD_ATTR Il2CppChar Convert_ToChar_mF1B1B205DDEFDE52251235514E7DAFCAB37D1F24 (int32_t ___value0, const RuntimeMethod* method) ;
// System.Text.StringBuilder System.Text.StringBuilder::Append(System.Char)
IL2CPP_EXTERN_C IL2CPP_METHOD_ATTR StringBuilder_t* StringBuilder_Append_m71228B30F05724CD2CD96D9611DCD61BFB96A6E1 (StringBuilder_t* __this, Il2CppChar ___value0, const RuntimeMethod* method) ;
// System.Boolean Agora.Rtc.LitJson.Lexer::GetChar()
IL2CPP_EXTERN_C IL2CPP_METHOD_ATTR bool Lexer_GetChar_mB847D68CA0D5B450930406D4FBC986DA5C066FAA (Lexer_tDC14CFA7B390E884510F554D9D1E03188A185E27* __this, const RuntimeMethod* method) ;
// System.Void Agora.Rtc.LitJson.Lexer::UngetChar()
IL2CPP_EXTERN_C IL2CPP_METHOD_ATTR void Lexer_UngetChar_m46FD110F88E00E60F9E296833913BC84AD8C7BA7 (Lexer_tDC14CFA7B390E884510F554D9D1E03188A185E27* __this, const RuntimeMethod* method) ;
// System.Char Agora.Rtc.LitJson.Lexer::ProcessEscChar(System.Int32)
IL2CPP_EXTERN_C IL2CPP_METHOD_ATTR Il2CppChar Lexer_ProcessEscChar_m0E97C7D9F98BBEF906B17B4EDB0B93CA2B0BC11D (int32_t ___esc_char0, const RuntimeMethod* method) ;
// System.Int32 Agora.Rtc.LitJson.Lexer::HexValue(System.Int32)
IL2CPP_EXTERN_C IL2CPP_METHOD_ATTR int32_t Lexer_HexValue_mEC657936A38EA8E89F28359F9F244E906F637D1B (int32_t ___digit0, const RuntimeMethod* method) ;
// System.Int32 Agora.Rtc.LitJson.Lexer::NextChar()
IL2CPP_EXTERN_C IL2CPP_METHOD_ATTR int32_t Lexer_NextChar_m1CFDD13AAD5AAAB76EF810DBFED9DBA381B102BF (Lexer_tDC14CFA7B390E884510F554D9D1E03188A185E27* __this, const RuntimeMethod* method) ;
// System.Boolean Agora.Rtc.LitJson.Lexer/StateHandler::Invoke(Agora.Rtc.LitJson.FsmContext)
IL2CPP_MANAGED_FORCE_INLINE IL2CPP_METHOD_ATTR bool StateHandler_Invoke_m9CAA7FAB5C4F3F0EBCE63ECC8A3186D52B7FC97E_inline (StateHandler_t8EA5CD11BFA1A958F305A2A0134A0BBB631FAFCB* __this, FsmContext_tC11B461D4D90680FC71416881106E6AF48CAE21F* ___ctx0, const RuntimeMethod* method) ;
// System.Void Agora.Rtc.LitJson.JsonException::.ctor(System.Int32)
IL2CPP_EXTERN_C IL2CPP_METHOD_ATTR void JsonException__ctor_m30831B405CB7CE31F396F31A19E41B2F10FEE0D0 (JsonException_t3B214813E48AA5E19793F9026831120B5B2254A1* __this, int32_t ___c0, const RuntimeMethod* method) ;
// System.String System.String::Concat(System.String,System.String)
IL2CPP_EXTERN_C IL2CPP_METHOD_ATTR String_t* String_Concat_m9E3155FB84015C823606188F53B47CB44C444991 (String_t* ___str00, String_t* ___str11, const RuntimeMethod* method) ;
// System.Void UnityEngine.Debug::Log(System.Object)
IL2CPP_EXTERN_C IL2CPP_METHOD_ATTR void Debug_Log_m87A9A3C761FF5C43ED8A53B16190A53D08F818BB (RuntimeObject* ___message0, const RuntimeMethod* method) ;
#ifdef __clang__
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Winvalid-offsetof"
#pragma clang diagnostic ignored "-Wunused-variable"
#endif
// System.Void Agora.Rtc.LitJson.JsonMapper/<>c::.cctor()
IL2CPP_EXTERN_C IL2CPP_METHOD_ATTR void U3CU3Ec__cctor_mBC8F40A081CB35C58C073A6FD33B70F3EDED6152 (const RuntimeMethod* method) 
{
	static bool s_Il2CppMethodInitialized;
	if (!s_Il2CppMethodInitialized)
	{
		il2cpp_codegen_initialize_runtime_metadata((uintptr_t*)&U3CU3Ec_tB2417947DB790EC3B314B9BB1046B04B68400CDA_il2cpp_TypeInfo_var);
		s_Il2CppMethodInitialized = true;
	}
	{
		U3CU3Ec_tB2417947DB790EC3B314B9BB1046B04B68400CDA* L_0 = (U3CU3Ec_tB2417947DB790EC3B314B9BB1046B04B68400CDA*)il2cpp_codegen_object_new(U3CU3Ec_tB2417947DB790EC3B314B9BB1046B04B68400CDA_il2cpp_TypeInfo_var);
		NullCheck(L_0);
		U3CU3Ec__ctor_m2EDE631E41DFFEC6C5143F53EF3C5B7A5DE5DC00(L_0, NULL);
		((U3CU3Ec_tB2417947DB790EC3B314B9BB1046B04B68400CDA_StaticFields*)il2cpp_codegen_static_fields_for(U3CU3Ec_tB2417947DB790EC3B314B9BB1046B04B68400CDA_il2cpp_TypeInfo_var))->___U3CU3E9_0 = L_0;
		Il2CppCodeGenWriteBarrier((void**)(&((U3CU3Ec_tB2417947DB790EC3B314B9BB1046B04B68400CDA_StaticFields*)il2cpp_codegen_static_fields_for(U3CU3Ec_tB2417947DB790EC3B314B9BB1046B04B68400CDA_il2cpp_TypeInfo_var))->___U3CU3E9_0), (void*)L_0);
		return;
	}
}
// System.Void Agora.Rtc.LitJson.JsonMapper/<>c::.ctor()
IL2CPP_EXTERN_C IL2CPP_METHOD_ATTR void U3CU3Ec__ctor_m2EDE631E41DFFEC6C5143F53EF3C5B7A5DE5DC00 (U3CU3Ec_tB2417947DB790EC3B314B9BB1046B04B68400CDA* __this, const RuntimeMethod* method) 
{
	{
		Object__ctor_mE837C6B9FA8C6D5D109F4B2EC885D79919AC0EA2(__this, NULL);
		return;
	}
}
// Agora.Rtc.LitJson.IJsonWrapper Agora.Rtc.LitJson.JsonMapper/<>c::<ReadSkip>b__23_0()
IL2CPP_EXTERN_C IL2CPP_METHOD_ATTR RuntimeObject* U3CU3Ec_U3CReadSkipU3Eb__23_0_mBF947F336F67FA5040947994E4F3A24FB113BE5B (U3CU3Ec_tB2417947DB790EC3B314B9BB1046B04B68400CDA* __this, const RuntimeMethod* method) 
{
	static bool s_Il2CppMethodInitialized;
	if (!s_Il2CppMethodInitialized)
	{
		il2cpp_codegen_initialize_runtime_metadata((uintptr_t*)&JsonMockWrapper_tE04391F97D9A84CC02FF454281A59C54DE05355C_il2cpp_TypeInfo_var);
		s_Il2CppMethodInitialized = true;
	}
	{
		// delegate { return new JsonMockWrapper(); }, reader);
		JsonMockWrapper_tE04391F97D9A84CC02FF454281A59C54DE05355C* L_0 = (JsonMockWrapper_tE04391F97D9A84CC02FF454281A59C54DE05355C*)il2cpp_codegen_object_new(JsonMockWrapper_tE04391F97D9A84CC02FF454281A59C54DE05355C_il2cpp_TypeInfo_var);
		NullCheck(L_0);
		JsonMockWrapper__ctor_m5DD911B1FCB226E895971B6F1F015398E9A25BFA(L_0, NULL);
		return L_0;
	}
}
// System.Void Agora.Rtc.LitJson.JsonMapper/<>c::<RegisterBaseExporters>b__24_0(System.Object,Agora.Rtc.LitJson.JsonWriter)
IL2CPP_EXTERN_C IL2CPP_METHOD_ATTR void U3CU3Ec_U3CRegisterBaseExportersU3Eb__24_0_m3F10902FBB7856F402E9DAB9114A02C70797F3F7 (U3CU3Ec_tB2417947DB790EC3B314B9BB1046B04B68400CDA* __this, RuntimeObject* ___obj0, JsonWriter_tC9B032D35ED4E85319A227892A43EB8627661732* ___writer1, const RuntimeMethod* method) 
{
	static bool s_Il2CppMethodInitialized;
	if (!s_Il2CppMethodInitialized)
	{
		il2cpp_codegen_initialize_runtime_metadata((uintptr_t*)&Byte_t94D9231AC217BE4D2E004C4CD32DF6D099EA41A3_il2cpp_TypeInfo_var);
		il2cpp_codegen_initialize_runtime_metadata((uintptr_t*)&Convert_t7097FF336D592F7C06D88A98349A44646F91EFFC_il2cpp_TypeInfo_var);
		s_Il2CppMethodInitialized = true;
	}
	{
		// writer.Write(Convert.ToInt32((byte)obj));
		JsonWriter_tC9B032D35ED4E85319A227892A43EB8627661732* L_0 = ___writer1;
		RuntimeObject* L_1 = ___obj0;
		il2cpp_codegen_runtime_class_init_inline(Convert_t7097FF336D592F7C06D88A98349A44646F91EFFC_il2cpp_TypeInfo_var);
		int32_t L_2;
		L_2 = Convert_ToInt32_mD8869793A34ED86D38EFDF4BFCDD8D03FBBCCAB6(((*(uint8_t*)((uint8_t*)(uint8_t*)UnBox(L_1, Byte_t94D9231AC217BE4D2E004C4CD32DF6D099EA41A3_il2cpp_TypeInfo_var)))), NULL);
		NullCheck(L_0);
		JsonWriter_Write_mCC3A77C46777F4FF87E8CD21ED0E8608CD06BD30(L_0, L_2, NULL);
		// };
		return;
	}
}
// System.Void Agora.Rtc.LitJson.JsonMapper/<>c::<RegisterBaseExporters>b__24_1(System.Object,Agora.Rtc.LitJson.JsonWriter)
IL2CPP_EXTERN_C IL2CPP_METHOD_ATTR void U3CU3Ec_U3CRegisterBaseExportersU3Eb__24_1_mE8CD347B64B3524E8443AEDB540D6E012191F497 (U3CU3Ec_tB2417947DB790EC3B314B9BB1046B04B68400CDA* __this, RuntimeObject* ___obj0, JsonWriter_tC9B032D35ED4E85319A227892A43EB8627661732* ___writer1, const RuntimeMethod* method) 
{
	static bool s_Il2CppMethodInitialized;
	if (!s_Il2CppMethodInitialized)
	{
		il2cpp_codegen_initialize_runtime_metadata((uintptr_t*)&Char_t521A6F19B456D956AF452D926C32709DC03D6B17_il2cpp_TypeInfo_var);
		il2cpp_codegen_initialize_runtime_metadata((uintptr_t*)&Convert_t7097FF336D592F7C06D88A98349A44646F91EFFC_il2cpp_TypeInfo_var);
		s_Il2CppMethodInitialized = true;
	}
	{
		// writer.Write(Convert.ToString((char)obj));
		JsonWriter_tC9B032D35ED4E85319A227892A43EB8627661732* L_0 = ___writer1;
		RuntimeObject* L_1 = ___obj0;
		il2cpp_codegen_runtime_class_init_inline(Convert_t7097FF336D592F7C06D88A98349A44646F91EFFC_il2cpp_TypeInfo_var);
		String_t* L_2;
		L_2 = Convert_ToString_m8270C8361D2796C5C4659D441829CAFEEFBAC91C(((*(Il2CppChar*)((Il2CppChar*)(Il2CppChar*)UnBox(L_1, Char_t521A6F19B456D956AF452D926C32709DC03D6B17_il2cpp_TypeInfo_var)))), NULL);
		NullCheck(L_0);
		JsonWriter_Write_mF5B2C30D93DE321FCBBEE50EB4D68895D210201A(L_0, L_2, NULL);
		// };
		return;
	}
}
// System.Void Agora.Rtc.LitJson.JsonMapper/<>c::<RegisterBaseExporters>b__24_2(System.Object,Agora.Rtc.LitJson.JsonWriter)
IL2CPP_EXTERN_C IL2CPP_METHOD_ATTR void U3CU3Ec_U3CRegisterBaseExportersU3Eb__24_2_m6C133C70C14E0AFFFA92B1C5D2C537E0C33BA538 (U3CU3Ec_tB2417947DB790EC3B314B9BB1046B04B68400CDA* __this, RuntimeObject* ___obj0, JsonWriter_tC9B032D35ED4E85319A227892A43EB8627661732* ___writer1, const RuntimeMethod* method) 
{
	static bool s_Il2CppMethodInitialized;
	if (!s_Il2CppMethodInitialized)
	{
		il2cpp_codegen_initialize_runtime_metadata((uintptr_t*)&Convert_t7097FF336D592F7C06D88A98349A44646F91EFFC_il2cpp_TypeInfo_var);
		il2cpp_codegen_initialize_runtime_metadata((uintptr_t*)&DateTime_t66193957C73913903DDAD89FEDC46139BCA5802D_il2cpp_TypeInfo_var);
		il2cpp_codegen_initialize_runtime_metadata((uintptr_t*)&JsonMapper_t3A3F5A7CFFC63F7DF9A3563D52974D21D47798F2_il2cpp_TypeInfo_var);
		s_Il2CppMethodInitialized = true;
	}
	{
		// writer.Write(Convert.ToString((DateTime)obj,
		//                                 datetime_format));
		JsonWriter_tC9B032D35ED4E85319A227892A43EB8627661732* L_0 = ___writer1;
		RuntimeObject* L_1 = ___obj0;
		il2cpp_codegen_runtime_class_init_inline(JsonMapper_t3A3F5A7CFFC63F7DF9A3563D52974D21D47798F2_il2cpp_TypeInfo_var);
		RuntimeObject* L_2 = ((JsonMapper_t3A3F5A7CFFC63F7DF9A3563D52974D21D47798F2_StaticFields*)il2cpp_codegen_static_fields_for(JsonMapper_t3A3F5A7CFFC63F7DF9A3563D52974D21D47798F2_il2cpp_TypeInfo_var))->___datetime_format_1;
		il2cpp_codegen_runtime_class_init_inline(Convert_t7097FF336D592F7C06D88A98349A44646F91EFFC_il2cpp_TypeInfo_var);
		String_t* L_3;
		L_3 = Convert_ToString_m942B26CABBBFDCE9F1E647B15CA98F03D50976A0(((*(DateTime_t66193957C73913903DDAD89FEDC46139BCA5802D*)((DateTime_t66193957C73913903DDAD89FEDC46139BCA5802D*)(DateTime_t66193957C73913903DDAD89FEDC46139BCA5802D*)UnBox(L_1, DateTime_t66193957C73913903DDAD89FEDC46139BCA5802D_il2cpp_TypeInfo_var)))), L_2, NULL);
		NullCheck(L_0);
		JsonWriter_Write_mF5B2C30D93DE321FCBBEE50EB4D68895D210201A(L_0, L_3, NULL);
		// };
		return;
	}
}
// System.Void Agora.Rtc.LitJson.JsonMapper/<>c::<RegisterBaseExporters>b__24_3(System.Object,Agora.Rtc.LitJson.JsonWriter)
IL2CPP_EXTERN_C IL2CPP_METHOD_ATTR void U3CU3Ec_U3CRegisterBaseExportersU3Eb__24_3_m5EE815CE023E2FDF7DA72F15B0B076F4AF78204A (U3CU3Ec_tB2417947DB790EC3B314B9BB1046B04B68400CDA* __this, RuntimeObject* ___obj0, JsonWriter_tC9B032D35ED4E85319A227892A43EB8627661732* ___writer1, const RuntimeMethod* method) 
{
	static bool s_Il2CppMethodInitialized;
	if (!s_Il2CppMethodInitialized)
	{
		il2cpp_codegen_initialize_runtime_metadata((uintptr_t*)&Decimal_tDA6C877282B2D789CF97C0949661CC11D643969F_il2cpp_TypeInfo_var);
		s_Il2CppMethodInitialized = true;
	}
	{
		// writer.Write((decimal)obj);
		JsonWriter_tC9B032D35ED4E85319A227892A43EB8627661732* L_0 = ___writer1;
		RuntimeObject* L_1 = ___obj0;
		NullCheck(L_0);
		JsonWriter_Write_m890E86088FDAB9171E16DEDD20FE3DA90C7339C9(L_0, ((*(Decimal_tDA6C877282B2D789CF97C0949661CC11D643969F*)((Decimal_tDA6C877282B2D789CF97C0949661CC11D643969F*)(Decimal_tDA6C877282B2D789CF97C0949661CC11D643969F*)UnBox(L_1, Decimal_tDA6C877282B2D789CF97C0949661CC11D643969F_il2cpp_TypeInfo_var)))), NULL);
		// };
		return;
	}
}
// System.Void Agora.Rtc.LitJson.JsonMapper/<>c::<RegisterBaseExporters>b__24_4(System.Object,Agora.Rtc.LitJson.JsonWriter)
IL2CPP_EXTERN_C IL2CPP_METHOD_ATTR void U3CU3Ec_U3CRegisterBaseExportersU3Eb__24_4_m5B4E097752A41AE4B81136DC1630B5A502BAA1A1 (U3CU3Ec_tB2417947DB790EC3B314B9BB1046B04B68400CDA* __this, RuntimeObject* ___obj0, JsonWriter_tC9B032D35ED4E85319A227892A43EB8627661732* ___writer1, const RuntimeMethod* method) 
{
	static bool s_Il2CppMethodInitialized;
	if (!s_Il2CppMethodInitialized)
	{
		il2cpp_codegen_initialize_runtime_metadata((uintptr_t*)&Convert_t7097FF336D592F7C06D88A98349A44646F91EFFC_il2cpp_TypeInfo_var);
		il2cpp_codegen_initialize_runtime_metadata((uintptr_t*)&SByte_tFEFFEF5D2FEBF5207950AE6FAC150FC53B668DB5_il2cpp_TypeInfo_var);
		s_Il2CppMethodInitialized = true;
	}
	{
		// writer.Write(Convert.ToInt32((sbyte)obj));
		JsonWriter_tC9B032D35ED4E85319A227892A43EB8627661732* L_0 = ___writer1;
		RuntimeObject* L_1 = ___obj0;
		il2cpp_codegen_runtime_class_init_inline(Convert_t7097FF336D592F7C06D88A98349A44646F91EFFC_il2cpp_TypeInfo_var);
		int32_t L_2;
		L_2 = Convert_ToInt32_m9FD81A0DC7D2A34B74068ACA2F311270937DA2A2(((*(int8_t*)((int8_t*)(int8_t*)UnBox(L_1, SByte_tFEFFEF5D2FEBF5207950AE6FAC150FC53B668DB5_il2cpp_TypeInfo_var)))), NULL);
		NullCheck(L_0);
		JsonWriter_Write_mCC3A77C46777F4FF87E8CD21ED0E8608CD06BD30(L_0, L_2, NULL);
		// };
		return;
	}
}
// System.Void Agora.Rtc.LitJson.JsonMapper/<>c::<RegisterBaseExporters>b__24_5(System.Object,Agora.Rtc.LitJson.JsonWriter)
IL2CPP_EXTERN_C IL2CPP_METHOD_ATTR void U3CU3Ec_U3CRegisterBaseExportersU3Eb__24_5_m3420A6ED05BE2FC770FACEDBFBF262C27CBC4AE6 (U3CU3Ec_tB2417947DB790EC3B314B9BB1046B04B68400CDA* __this, RuntimeObject* ___obj0, JsonWriter_tC9B032D35ED4E85319A227892A43EB8627661732* ___writer1, const RuntimeMethod* method) 
{
	static bool s_Il2CppMethodInitialized;
	if (!s_Il2CppMethodInitialized)
	{
		il2cpp_codegen_initialize_runtime_metadata((uintptr_t*)&Convert_t7097FF336D592F7C06D88A98349A44646F91EFFC_il2cpp_TypeInfo_var);
		il2cpp_codegen_initialize_runtime_metadata((uintptr_t*)&Int16_tB8EF286A9C33492FA6E6D6E67320BE93E794A175_il2cpp_TypeInfo_var);
		s_Il2CppMethodInitialized = true;
	}
	{
		// writer.Write(Convert.ToInt32((short)obj));
		JsonWriter_tC9B032D35ED4E85319A227892A43EB8627661732* L_0 = ___writer1;
		RuntimeObject* L_1 = ___obj0;
		il2cpp_codegen_runtime_class_init_inline(Convert_t7097FF336D592F7C06D88A98349A44646F91EFFC_il2cpp_TypeInfo_var);
		int32_t L_2;
		L_2 = Convert_ToInt32_m708CB4FF71A3D4E08CBAAF70F290D093BD80AFCC(((*(int16_t*)((int16_t*)(int16_t*)UnBox(L_1, Int16_tB8EF286A9C33492FA6E6D6E67320BE93E794A175_il2cpp_TypeInfo_var)))), NULL);
		NullCheck(L_0);
		JsonWriter_Write_mCC3A77C46777F4FF87E8CD21ED0E8608CD06BD30(L_0, L_2, NULL);
		// };
		return;
	}
}
// System.Void Agora.Rtc.LitJson.JsonMapper/<>c::<RegisterBaseExporters>b__24_6(System.Object,Agora.Rtc.LitJson.JsonWriter)
IL2CPP_EXTERN_C IL2CPP_METHOD_ATTR void U3CU3Ec_U3CRegisterBaseExportersU3Eb__24_6_mDFDC93023131D2E2C8ACB74A6072FF3F9BA8F846 (U3CU3Ec_tB2417947DB790EC3B314B9BB1046B04B68400CDA* __this, RuntimeObject* ___obj0, JsonWriter_tC9B032D35ED4E85319A227892A43EB8627661732* ___writer1, const RuntimeMethod* method) 
{
	static bool s_Il2CppMethodInitialized;
	if (!s_Il2CppMethodInitialized)
	{
		il2cpp_codegen_initialize_runtime_metadata((uintptr_t*)&Convert_t7097FF336D592F7C06D88A98349A44646F91EFFC_il2cpp_TypeInfo_var);
		il2cpp_codegen_initialize_runtime_metadata((uintptr_t*)&UInt16_tF4C148C876015C212FD72652D0B6ED8CC247A455_il2cpp_TypeInfo_var);
		s_Il2CppMethodInitialized = true;
	}
	{
		// writer.Write(Convert.ToInt32((ushort)obj));
		JsonWriter_tC9B032D35ED4E85319A227892A43EB8627661732* L_0 = ___writer1;
		RuntimeObject* L_1 = ___obj0;
		il2cpp_codegen_runtime_class_init_inline(Convert_t7097FF336D592F7C06D88A98349A44646F91EFFC_il2cpp_TypeInfo_var);
		int32_t L_2;
		L_2 = Convert_ToInt32_m350A3CBA3E031A3D53D14062D7E4ABB4A33F5438(((*(uint16_t*)((uint16_t*)(uint16_t*)UnBox(L_1, UInt16_tF4C148C876015C212FD72652D0B6ED8CC247A455_il2cpp_TypeInfo_var)))), NULL);
		NullCheck(L_0);
		JsonWriter_Write_mCC3A77C46777F4FF87E8CD21ED0E8608CD06BD30(L_0, L_2, NULL);
		// };
		return;
	}
}
// System.Void Agora.Rtc.LitJson.JsonMapper/<>c::<RegisterBaseExporters>b__24_7(System.Object,Agora.Rtc.LitJson.JsonWriter)
IL2CPP_EXTERN_C IL2CPP_METHOD_ATTR void U3CU3Ec_U3CRegisterBaseExportersU3Eb__24_7_mC350A819766A37A516B3E57E29838E70C0AD22C5 (U3CU3Ec_tB2417947DB790EC3B314B9BB1046B04B68400CDA* __this, RuntimeObject* ___obj0, JsonWriter_tC9B032D35ED4E85319A227892A43EB8627661732* ___writer1, const RuntimeMethod* method) 
{
	static bool s_Il2CppMethodInitialized;
	if (!s_Il2CppMethodInitialized)
	{
		il2cpp_codegen_initialize_runtime_metadata((uintptr_t*)&Convert_t7097FF336D592F7C06D88A98349A44646F91EFFC_il2cpp_TypeInfo_var);
		il2cpp_codegen_initialize_runtime_metadata((uintptr_t*)&UInt32_t1833D51FFA667B18A5AA4B8D34DE284F8495D29B_il2cpp_TypeInfo_var);
		s_Il2CppMethodInitialized = true;
	}
	{
		// writer.Write(Convert.ToUInt64((uint)obj));
		JsonWriter_tC9B032D35ED4E85319A227892A43EB8627661732* L_0 = ___writer1;
		RuntimeObject* L_1 = ___obj0;
		il2cpp_codegen_runtime_class_init_inline(Convert_t7097FF336D592F7C06D88A98349A44646F91EFFC_il2cpp_TypeInfo_var);
		uint64_t L_2;
		L_2 = Convert_ToUInt64_m91C774E0D3AA8368D12AB8E2036E823C4FA9CB92(((*(uint32_t*)((uint32_t*)(uint32_t*)UnBox(L_1, UInt32_t1833D51FFA667B18A5AA4B8D34DE284F8495D29B_il2cpp_TypeInfo_var)))), NULL);
		NullCheck(L_0);
		JsonWriter_Write_mAE20584AB1461EFA3BB71203CC1A65BAC8C650AE(L_0, L_2, NULL);
		// };
		return;
	}
}
// System.Void Agora.Rtc.LitJson.JsonMapper/<>c::<RegisterBaseExporters>b__24_8(System.Object,Agora.Rtc.LitJson.JsonWriter)
IL2CPP_EXTERN_C IL2CPP_METHOD_ATTR void U3CU3Ec_U3CRegisterBaseExportersU3Eb__24_8_m27CE05DC04CAE503B68456560462299B07FC8DC1 (U3CU3Ec_tB2417947DB790EC3B314B9BB1046B04B68400CDA* __this, RuntimeObject* ___obj0, JsonWriter_tC9B032D35ED4E85319A227892A43EB8627661732* ___writer1, const RuntimeMethod* method) 
{
	static bool s_Il2CppMethodInitialized;
	if (!s_Il2CppMethodInitialized)
	{
		il2cpp_codegen_initialize_runtime_metadata((uintptr_t*)&UInt64_t8F12534CC8FC4B5860F2A2CD1EE79D322E7A41AF_il2cpp_TypeInfo_var);
		s_Il2CppMethodInitialized = true;
	}
	{
		// writer.Write((ulong)obj);
		JsonWriter_tC9B032D35ED4E85319A227892A43EB8627661732* L_0 = ___writer1;
		RuntimeObject* L_1 = ___obj0;
		NullCheck(L_0);
		JsonWriter_Write_mAE20584AB1461EFA3BB71203CC1A65BAC8C650AE(L_0, ((*(uint64_t*)((uint64_t*)(uint64_t*)UnBox(L_1, UInt64_t8F12534CC8FC4B5860F2A2CD1EE79D322E7A41AF_il2cpp_TypeInfo_var)))), NULL);
		// };
		return;
	}
}
// System.Void Agora.Rtc.LitJson.JsonMapper/<>c::<RegisterBaseExporters>b__24_9(System.Object,Agora.Rtc.LitJson.JsonWriter)
IL2CPP_EXTERN_C IL2CPP_METHOD_ATTR void U3CU3Ec_U3CRegisterBaseExportersU3Eb__24_9_m077B9316B10034D196467B995440507DCD393E40 (U3CU3Ec_tB2417947DB790EC3B314B9BB1046B04B68400CDA* __this, RuntimeObject* ___obj0, JsonWriter_tC9B032D35ED4E85319A227892A43EB8627661732* ___writer1, const RuntimeMethod* method) 
{
	static bool s_Il2CppMethodInitialized;
	if (!s_Il2CppMethodInitialized)
	{
		il2cpp_codegen_initialize_runtime_metadata((uintptr_t*)&DateTimeOffset_t4EE701FE2F386D6F932FAC9B11E4B74A5B30F0A4_il2cpp_TypeInfo_var);
		il2cpp_codegen_initialize_runtime_metadata((uintptr_t*)&JsonMapper_t3A3F5A7CFFC63F7DF9A3563D52974D21D47798F2_il2cpp_TypeInfo_var);
		il2cpp_codegen_initialize_runtime_metadata((uintptr_t*)&_stringLiteral242259752214E86B8CCBBF56AA4774B954BC34AD);
		s_Il2CppMethodInitialized = true;
	}
	DateTimeOffset_t4EE701FE2F386D6F932FAC9B11E4B74A5B30F0A4 V_0;
	memset((&V_0), 0, sizeof(V_0));
	{
		// writer.Write(((DateTimeOffset)obj).ToString("yyyy-MM-ddTHH:mm:ss.fffffffzzz", datetime_format));
		JsonWriter_tC9B032D35ED4E85319A227892A43EB8627661732* L_0 = ___writer1;
		RuntimeObject* L_1 = ___obj0;
		V_0 = ((*(DateTimeOffset_t4EE701FE2F386D6F932FAC9B11E4B74A5B30F0A4*)((DateTimeOffset_t4EE701FE2F386D6F932FAC9B11E4B74A5B30F0A4*)(DateTimeOffset_t4EE701FE2F386D6F932FAC9B11E4B74A5B30F0A4*)UnBox(L_1, DateTimeOffset_t4EE701FE2F386D6F932FAC9B11E4B74A5B30F0A4_il2cpp_TypeInfo_var))));
		il2cpp_codegen_runtime_class_init_inline(JsonMapper_t3A3F5A7CFFC63F7DF9A3563D52974D21D47798F2_il2cpp_TypeInfo_var);
		RuntimeObject* L_2 = ((JsonMapper_t3A3F5A7CFFC63F7DF9A3563D52974D21D47798F2_StaticFields*)il2cpp_codegen_static_fields_for(JsonMapper_t3A3F5A7CFFC63F7DF9A3563D52974D21D47798F2_il2cpp_TypeInfo_var))->___datetime_format_1;
		String_t* L_3;
		L_3 = DateTimeOffset_ToString_m4B5BB65E069D2146E808A1CE5F424ACA2F4D2281((&V_0), _stringLiteral242259752214E86B8CCBBF56AA4774B954BC34AD, L_2, NULL);
		NullCheck(L_0);
		JsonWriter_Write_mF5B2C30D93DE321FCBBEE50EB4D68895D210201A(L_0, L_3, NULL);
		// };
		return;
	}
}
// System.Object Agora.Rtc.LitJson.JsonMapper/<>c::<RegisterBaseImporters>b__26_0(System.Object)
IL2CPP_EXTERN_C IL2CPP_METHOD_ATTR RuntimeObject* U3CU3Ec_U3CRegisterBaseImportersU3Eb__26_0_m15074581DA6A3A24B5891D489C3A5AAC637C430D (U3CU3Ec_tB2417947DB790EC3B314B9BB1046B04B68400CDA* __this, RuntimeObject* ___input0, const RuntimeMethod* method) 
{
	static bool s_Il2CppMethodInitialized;
	if (!s_Il2CppMethodInitialized)
	{
		il2cpp_codegen_initialize_runtime_metadata((uintptr_t*)&Byte_t94D9231AC217BE4D2E004C4CD32DF6D099EA41A3_il2cpp_TypeInfo_var);
		il2cpp_codegen_initialize_runtime_metadata((uintptr_t*)&Convert_t7097FF336D592F7C06D88A98349A44646F91EFFC_il2cpp_TypeInfo_var);
		il2cpp_codegen_initialize_runtime_metadata((uintptr_t*)&Int32_t680FF22E76F6EFAD4375103CBBFFA0421349384C_il2cpp_TypeInfo_var);
		s_Il2CppMethodInitialized = true;
	}
	{
		// return Convert.ToByte((int)input);
		RuntimeObject* L_0 = ___input0;
		il2cpp_codegen_runtime_class_init_inline(Convert_t7097FF336D592F7C06D88A98349A44646F91EFFC_il2cpp_TypeInfo_var);
		uint8_t L_1;
		L_1 = Convert_ToByte_mB200A29D6E5CE42D564544DF1DC8852BF3582833(((*(int32_t*)((int32_t*)(int32_t*)UnBox(L_0, Int32_t680FF22E76F6EFAD4375103CBBFFA0421349384C_il2cpp_TypeInfo_var)))), NULL);
		uint8_t L_2 = L_1;
		RuntimeObject* L_3 = Box(Byte_t94D9231AC217BE4D2E004C4CD32DF6D099EA41A3_il2cpp_TypeInfo_var, &L_2);
		return L_3;
	}
}
// System.Object Agora.Rtc.LitJson.JsonMapper/<>c::<RegisterBaseImporters>b__26_1(System.Object)
IL2CPP_EXTERN_C IL2CPP_METHOD_ATTR RuntimeObject* U3CU3Ec_U3CRegisterBaseImportersU3Eb__26_1_mDF2DE0F7418D92EFCCBCB2F3BDC6441E15EFA7BB (U3CU3Ec_tB2417947DB790EC3B314B9BB1046B04B68400CDA* __this, RuntimeObject* ___input0, const RuntimeMethod* method) 
{
	static bool s_Il2CppMethodInitialized;
	if (!s_Il2CppMethodInitialized)
	{
		il2cpp_codegen_initialize_runtime_metadata((uintptr_t*)&Convert_t7097FF336D592F7C06D88A98349A44646F91EFFC_il2cpp_TypeInfo_var);
		il2cpp_codegen_initialize_runtime_metadata((uintptr_t*)&Int32_t680FF22E76F6EFAD4375103CBBFFA0421349384C_il2cpp_TypeInfo_var);
		il2cpp_codegen_initialize_runtime_metadata((uintptr_t*)&UInt64_t8F12534CC8FC4B5860F2A2CD1EE79D322E7A41AF_il2cpp_TypeInfo_var);
		s_Il2CppMethodInitialized = true;
	}
	{
		// return Convert.ToUInt64((int)input);
		RuntimeObject* L_0 = ___input0;
		il2cpp_codegen_runtime_class_init_inline(Convert_t7097FF336D592F7C06D88A98349A44646F91EFFC_il2cpp_TypeInfo_var);
		uint64_t L_1;
		L_1 = Convert_ToUInt64_m53C3A45C87A06F25957619222B04EABFD214373C(((*(int32_t*)((int32_t*)(int32_t*)UnBox(L_0, Int32_t680FF22E76F6EFAD4375103CBBFFA0421349384C_il2cpp_TypeInfo_var)))), NULL);
		uint64_t L_2 = L_1;
		RuntimeObject* L_3 = Box(UInt64_t8F12534CC8FC4B5860F2A2CD1EE79D322E7A41AF_il2cpp_TypeInfo_var, &L_2);
		return L_3;
	}
}
// System.Object Agora.Rtc.LitJson.JsonMapper/<>c::<RegisterBaseImporters>b__26_2(System.Object)
IL2CPP_EXTERN_C IL2CPP_METHOD_ATTR RuntimeObject* U3CU3Ec_U3CRegisterBaseImportersU3Eb__26_2_m702B98980D48E97172D0E591EE4624627C823E05 (U3CU3Ec_tB2417947DB790EC3B314B9BB1046B04B68400CDA* __this, RuntimeObject* ___input0, const RuntimeMethod* method) 
{
	static bool s_Il2CppMethodInitialized;
	if (!s_Il2CppMethodInitialized)
	{
		il2cpp_codegen_initialize_runtime_metadata((uintptr_t*)&Convert_t7097FF336D592F7C06D88A98349A44646F91EFFC_il2cpp_TypeInfo_var);
		il2cpp_codegen_initialize_runtime_metadata((uintptr_t*)&Int32_t680FF22E76F6EFAD4375103CBBFFA0421349384C_il2cpp_TypeInfo_var);
		il2cpp_codegen_initialize_runtime_metadata((uintptr_t*)&Int64_t092CFB123BE63C28ACDAF65C68F21A526050DBA3_il2cpp_TypeInfo_var);
		s_Il2CppMethodInitialized = true;
	}
	{
		// return Convert.ToInt64((int)input);
		RuntimeObject* L_0 = ___input0;
		il2cpp_codegen_runtime_class_init_inline(Convert_t7097FF336D592F7C06D88A98349A44646F91EFFC_il2cpp_TypeInfo_var);
		int64_t L_1;
		L_1 = Convert_ToInt64_m96FAEEA01C1BA082BB3925CC2099C0591DBF632A(((*(int32_t*)((int32_t*)(int32_t*)UnBox(L_0, Int32_t680FF22E76F6EFAD4375103CBBFFA0421349384C_il2cpp_TypeInfo_var)))), NULL);
		int64_t L_2 = L_1;
		RuntimeObject* L_3 = Box(Int64_t092CFB123BE63C28ACDAF65C68F21A526050DBA3_il2cpp_TypeInfo_var, &L_2);
		return L_3;
	}
}
// System.Object Agora.Rtc.LitJson.JsonMapper/<>c::<RegisterBaseImporters>b__26_3(System.Object)
IL2CPP_EXTERN_C IL2CPP_METHOD_ATTR RuntimeObject* U3CU3Ec_U3CRegisterBaseImportersU3Eb__26_3_mD92D81AEC478C0377EB2B983D3DF6A46E8F18EC9 (U3CU3Ec_tB2417947DB790EC3B314B9BB1046B04B68400CDA* __this, RuntimeObject* ___input0, const RuntimeMethod* method) 
{
	static bool s_Il2CppMethodInitialized;
	if (!s_Il2CppMethodInitialized)
	{
		il2cpp_codegen_initialize_runtime_metadata((uintptr_t*)&Convert_t7097FF336D592F7C06D88A98349A44646F91EFFC_il2cpp_TypeInfo_var);
		il2cpp_codegen_initialize_runtime_metadata((uintptr_t*)&Int32_t680FF22E76F6EFAD4375103CBBFFA0421349384C_il2cpp_TypeInfo_var);
		il2cpp_codegen_initialize_runtime_metadata((uintptr_t*)&UInt32_t1833D51FFA667B18A5AA4B8D34DE284F8495D29B_il2cpp_TypeInfo_var);
		s_Il2CppMethodInitialized = true;
	}
	{
		// return Convert.ToUInt32((int)input);
		RuntimeObject* L_0 = ___input0;
		il2cpp_codegen_runtime_class_init_inline(Convert_t7097FF336D592F7C06D88A98349A44646F91EFFC_il2cpp_TypeInfo_var);
		uint32_t L_1;
		L_1 = Convert_ToUInt32_m3BD840FA8B5073EDD04AD3D3A044785EB00511A3(((*(int32_t*)((int32_t*)(int32_t*)UnBox(L_0, Int32_t680FF22E76F6EFAD4375103CBBFFA0421349384C_il2cpp_TypeInfo_var)))), NULL);
		uint32_t L_2 = L_1;
		RuntimeObject* L_3 = Box(UInt32_t1833D51FFA667B18A5AA4B8D34DE284F8495D29B_il2cpp_TypeInfo_var, &L_2);
		return L_3;
	}
}
// System.Object Agora.Rtc.LitJson.JsonMapper/<>c::<RegisterBaseImporters>b__26_4(System.Object)
IL2CPP_EXTERN_C IL2CPP_METHOD_ATTR RuntimeObject* U3CU3Ec_U3CRegisterBaseImportersU3Eb__26_4_m16E446EED15B523C52C4BF4907F89642F5327A97 (U3CU3Ec_tB2417947DB790EC3B314B9BB1046B04B68400CDA* __this, RuntimeObject* ___input0, const RuntimeMethod* method) 
{
	static bool s_Il2CppMethodInitialized;
	if (!s_Il2CppMethodInitialized)
	{
		il2cpp_codegen_initialize_runtime_metadata((uintptr_t*)&Convert_t7097FF336D592F7C06D88A98349A44646F91EFFC_il2cpp_TypeInfo_var);
		il2cpp_codegen_initialize_runtime_metadata((uintptr_t*)&Int32_t680FF22E76F6EFAD4375103CBBFFA0421349384C_il2cpp_TypeInfo_var);
		il2cpp_codegen_initialize_runtime_metadata((uintptr_t*)&SByte_tFEFFEF5D2FEBF5207950AE6FAC150FC53B668DB5_il2cpp_TypeInfo_var);
		s_Il2CppMethodInitialized = true;
	}
	{
		// return Convert.ToSByte((int)input);
		RuntimeObject* L_0 = ___input0;
		il2cpp_codegen_runtime_class_init_inline(Convert_t7097FF336D592F7C06D88A98349A44646F91EFFC_il2cpp_TypeInfo_var);
		int8_t L_1;
		L_1 = Convert_ToSByte_mA336C42E413A5559B3F47FCD8B45EDB538693E63(((*(int32_t*)((int32_t*)(int32_t*)UnBox(L_0, Int32_t680FF22E76F6EFAD4375103CBBFFA0421349384C_il2cpp_TypeInfo_var)))), NULL);
		int8_t L_2 = L_1;
		RuntimeObject* L_3 = Box(SByte_tFEFFEF5D2FEBF5207950AE6FAC150FC53B668DB5_il2cpp_TypeInfo_var, &L_2);
		return L_3;
	}
}
// System.Object Agora.Rtc.LitJson.JsonMapper/<>c::<RegisterBaseImporters>b__26_5(System.Object)
IL2CPP_EXTERN_C IL2CPP_METHOD_ATTR RuntimeObject* U3CU3Ec_U3CRegisterBaseImportersU3Eb__26_5_mAAA53918C89FC490D8EA5B65037BEE33A05940A6 (U3CU3Ec_tB2417947DB790EC3B314B9BB1046B04B68400CDA* __this, RuntimeObject* ___input0, const RuntimeMethod* method) 
{
	static bool s_Il2CppMethodInitialized;
	if (!s_Il2CppMethodInitialized)
	{
		il2cpp_codegen_initialize_runtime_metadata((uintptr_t*)&Convert_t7097FF336D592F7C06D88A98349A44646F91EFFC_il2cpp_TypeInfo_var);
		il2cpp_codegen_initialize_runtime_metadata((uintptr_t*)&Int16_tB8EF286A9C33492FA6E6D6E67320BE93E794A175_il2cpp_TypeInfo_var);
		il2cpp_codegen_initialize_runtime_metadata((uintptr_t*)&Int32_t680FF22E76F6EFAD4375103CBBFFA0421349384C_il2cpp_TypeInfo_var);
		s_Il2CppMethodInitialized = true;
	}
	{
		// return Convert.ToInt16((int)input);
		RuntimeObject* L_0 = ___input0;
		il2cpp_codegen_runtime_class_init_inline(Convert_t7097FF336D592F7C06D88A98349A44646F91EFFC_il2cpp_TypeInfo_var);
		int16_t L_1;
		L_1 = Convert_ToInt16_mF65D8227B8B6F0E30A135BC5F01F1562455AD382(((*(int32_t*)((int32_t*)(int32_t*)UnBox(L_0, Int32_t680FF22E76F6EFAD4375103CBBFFA0421349384C_il2cpp_TypeInfo_var)))), NULL);
		int16_t L_2 = L_1;
		RuntimeObject* L_3 = Box(Int16_tB8EF286A9C33492FA6E6D6E67320BE93E794A175_il2cpp_TypeInfo_var, &L_2);
		return L_3;
	}
}
// System.Object Agora.Rtc.LitJson.JsonMapper/<>c::<RegisterBaseImporters>b__26_6(System.Object)
IL2CPP_EXTERN_C IL2CPP_METHOD_ATTR RuntimeObject* U3CU3Ec_U3CRegisterBaseImportersU3Eb__26_6_m0620DB79B0D7897704B3C73723F244D27473458E (U3CU3Ec_tB2417947DB790EC3B314B9BB1046B04B68400CDA* __this, RuntimeObject* ___input0, const RuntimeMethod* method) 
{
	static bool s_Il2CppMethodInitialized;
	if (!s_Il2CppMethodInitialized)
	{
		il2cpp_codegen_initialize_runtime_metadata((uintptr_t*)&Convert_t7097FF336D592F7C06D88A98349A44646F91EFFC_il2cpp_TypeInfo_var);
		il2cpp_codegen_initialize_runtime_metadata((uintptr_t*)&Int32_t680FF22E76F6EFAD4375103CBBFFA0421349384C_il2cpp_TypeInfo_var);
		il2cpp_codegen_initialize_runtime_metadata((uintptr_t*)&UInt16_tF4C148C876015C212FD72652D0B6ED8CC247A455_il2cpp_TypeInfo_var);
		s_Il2CppMethodInitialized = true;
	}
	{
		// return Convert.ToUInt16((int)input);
		RuntimeObject* L_0 = ___input0;
		il2cpp_codegen_runtime_class_init_inline(Convert_t7097FF336D592F7C06D88A98349A44646F91EFFC_il2cpp_TypeInfo_var);
		uint16_t L_1;
		L_1 = Convert_ToUInt16_mA3ABC9268BA473D6F1C7801248D3200734180B2B(((*(int32_t*)((int32_t*)(int32_t*)UnBox(L_0, Int32_t680FF22E76F6EFAD4375103CBBFFA0421349384C_il2cpp_TypeInfo_var)))), NULL);
		uint16_t L_2 = L_1;
		RuntimeObject* L_3 = Box(UInt16_tF4C148C876015C212FD72652D0B6ED8CC247A455_il2cpp_TypeInfo_var, &L_2);
		return L_3;
	}
}
// System.Object Agora.Rtc.LitJson.JsonMapper/<>c::<RegisterBaseImporters>b__26_7(System.Object)
IL2CPP_EXTERN_C IL2CPP_METHOD_ATTR RuntimeObject* U3CU3Ec_U3CRegisterBaseImportersU3Eb__26_7_m99784D890478A48CA7E8E4CB5F79C9097B030F98 (U3CU3Ec_tB2417947DB790EC3B314B9BB1046B04B68400CDA* __this, RuntimeObject* ___input0, const RuntimeMethod* method) 
{
	static bool s_Il2CppMethodInitialized;
	if (!s_Il2CppMethodInitialized)
	{
		il2cpp_codegen_initialize_runtime_metadata((uintptr_t*)&Convert_t7097FF336D592F7C06D88A98349A44646F91EFFC_il2cpp_TypeInfo_var);
		il2cpp_codegen_initialize_runtime_metadata((uintptr_t*)&Int32_t680FF22E76F6EFAD4375103CBBFFA0421349384C_il2cpp_TypeInfo_var);
		il2cpp_codegen_initialize_runtime_metadata((uintptr_t*)&UInt32_t1833D51FFA667B18A5AA4B8D34DE284F8495D29B_il2cpp_TypeInfo_var);
		s_Il2CppMethodInitialized = true;
	}
	{
		// return Convert.ToUInt32((int)input);
		RuntimeObject* L_0 = ___input0;
		il2cpp_codegen_runtime_class_init_inline(Convert_t7097FF336D592F7C06D88A98349A44646F91EFFC_il2cpp_TypeInfo_var);
		uint32_t L_1;
		L_1 = Convert_ToUInt32_m3BD840FA8B5073EDD04AD3D3A044785EB00511A3(((*(int32_t*)((int32_t*)(int32_t*)UnBox(L_0, Int32_t680FF22E76F6EFAD4375103CBBFFA0421349384C_il2cpp_TypeInfo_var)))), NULL);
		uint32_t L_2 = L_1;
		RuntimeObject* L_3 = Box(UInt32_t1833D51FFA667B18A5AA4B8D34DE284F8495D29B_il2cpp_TypeInfo_var, &L_2);
		return L_3;
	}
}
// System.Object Agora.Rtc.LitJson.JsonMapper/<>c::<RegisterBaseImporters>b__26_8(System.Object)
IL2CPP_EXTERN_C IL2CPP_METHOD_ATTR RuntimeObject* U3CU3Ec_U3CRegisterBaseImportersU3Eb__26_8_mCB16A2ABA3CBC612861BFB2A2ED312EA4E9CD3F3 (U3CU3Ec_tB2417947DB790EC3B314B9BB1046B04B68400CDA* __this, RuntimeObject* ___input0, const RuntimeMethod* method) 
{
	static bool s_Il2CppMethodInitialized;
	if (!s_Il2CppMethodInitialized)
	{
		il2cpp_codegen_initialize_runtime_metadata((uintptr_t*)&Convert_t7097FF336D592F7C06D88A98349A44646F91EFFC_il2cpp_TypeInfo_var);
		il2cpp_codegen_initialize_runtime_metadata((uintptr_t*)&Int32_t680FF22E76F6EFAD4375103CBBFFA0421349384C_il2cpp_TypeInfo_var);
		il2cpp_codegen_initialize_runtime_metadata((uintptr_t*)&Single_t4530F2FF86FCB0DC29F35385CA1BD21BE294761C_il2cpp_TypeInfo_var);
		s_Il2CppMethodInitialized = true;
	}
	{
		// return Convert.ToSingle((int)input);
		RuntimeObject* L_0 = ___input0;
		il2cpp_codegen_runtime_class_init_inline(Convert_t7097FF336D592F7C06D88A98349A44646F91EFFC_il2cpp_TypeInfo_var);
		float L_1;
		L_1 = Convert_ToSingle_mE54B145DE1F8A182C3D1A66AEF3A95CB399C28CE(((*(int32_t*)((int32_t*)(int32_t*)UnBox(L_0, Int32_t680FF22E76F6EFAD4375103CBBFFA0421349384C_il2cpp_TypeInfo_var)))), NULL);
		float L_2 = L_1;
		RuntimeObject* L_3 = Box(Single_t4530F2FF86FCB0DC29F35385CA1BD21BE294761C_il2cpp_TypeInfo_var, &L_2);
		return L_3;
	}
}
// System.Object Agora.Rtc.LitJson.JsonMapper/<>c::<RegisterBaseImporters>b__26_9(System.Object)
IL2CPP_EXTERN_C IL2CPP_METHOD_ATTR RuntimeObject* U3CU3Ec_U3CRegisterBaseImportersU3Eb__26_9_m0C3DA23C4FFC4FF820FE3310614E3FDBFD407496 (U3CU3Ec_tB2417947DB790EC3B314B9BB1046B04B68400CDA* __this, RuntimeObject* ___input0, const RuntimeMethod* method) 
{
	static bool s_Il2CppMethodInitialized;
	if (!s_Il2CppMethodInitialized)
	{
		il2cpp_codegen_initialize_runtime_metadata((uintptr_t*)&Convert_t7097FF336D592F7C06D88A98349A44646F91EFFC_il2cpp_TypeInfo_var);
		il2cpp_codegen_initialize_runtime_metadata((uintptr_t*)&Double_tE150EF3D1D43DEE85D533810AB4C742307EEDE5F_il2cpp_TypeInfo_var);
		il2cpp_codegen_initialize_runtime_metadata((uintptr_t*)&Int32_t680FF22E76F6EFAD4375103CBBFFA0421349384C_il2cpp_TypeInfo_var);
		s_Il2CppMethodInitialized = true;
	}
	{
		// return Convert.ToDouble((int)input);
		RuntimeObject* L_0 = ___input0;
		il2cpp_codegen_runtime_class_init_inline(Convert_t7097FF336D592F7C06D88A98349A44646F91EFFC_il2cpp_TypeInfo_var);
		double L_1;
		L_1 = Convert_ToDouble_m21A92C91FFDA003BD27748AA55CA0A7D6C0E6694(((*(int32_t*)((int32_t*)(int32_t*)UnBox(L_0, Int32_t680FF22E76F6EFAD4375103CBBFFA0421349384C_il2cpp_TypeInfo_var)))), NULL);
		double L_2 = L_1;
		RuntimeObject* L_3 = Box(Double_tE150EF3D1D43DEE85D533810AB4C742307EEDE5F_il2cpp_TypeInfo_var, &L_2);
		return L_3;
	}
}
// System.Object Agora.Rtc.LitJson.JsonMapper/<>c::<RegisterBaseImporters>b__26_10(System.Object)
IL2CPP_EXTERN_C IL2CPP_METHOD_ATTR RuntimeObject* U3CU3Ec_U3CRegisterBaseImportersU3Eb__26_10_mD6284E694A3F60C0E033B462A525C2CDFC2DE766 (U3CU3Ec_tB2417947DB790EC3B314B9BB1046B04B68400CDA* __this, RuntimeObject* ___input0, const RuntimeMethod* method) 
{
	static bool s_Il2CppMethodInitialized;
	if (!s_Il2CppMethodInitialized)
	{
		il2cpp_codegen_initialize_runtime_metadata((uintptr_t*)&Convert_t7097FF336D592F7C06D88A98349A44646F91EFFC_il2cpp_TypeInfo_var);
		il2cpp_codegen_initialize_runtime_metadata((uintptr_t*)&Int64_t092CFB123BE63C28ACDAF65C68F21A526050DBA3_il2cpp_TypeInfo_var);
		il2cpp_codegen_initialize_runtime_metadata((uintptr_t*)&UInt32_t1833D51FFA667B18A5AA4B8D34DE284F8495D29B_il2cpp_TypeInfo_var);
		s_Il2CppMethodInitialized = true;
	}
	{
		// return Convert.ToInt64((uint)input);
		RuntimeObject* L_0 = ___input0;
		il2cpp_codegen_runtime_class_init_inline(Convert_t7097FF336D592F7C06D88A98349A44646F91EFFC_il2cpp_TypeInfo_var);
		int64_t L_1;
		L_1 = Convert_ToInt64_mDBCA1C09FD81078B6BEC7A0767835B9ED158E732(((*(uint32_t*)((uint32_t*)(uint32_t*)UnBox(L_0, UInt32_t1833D51FFA667B18A5AA4B8D34DE284F8495D29B_il2cpp_TypeInfo_var)))), NULL);
		int64_t L_2 = L_1;
		RuntimeObject* L_3 = Box(Int64_t092CFB123BE63C28ACDAF65C68F21A526050DBA3_il2cpp_TypeInfo_var, &L_2);
		return L_3;
	}
}
// System.Object Agora.Rtc.LitJson.JsonMapper/<>c::<RegisterBaseImporters>b__26_11(System.Object)
IL2CPP_EXTERN_C IL2CPP_METHOD_ATTR RuntimeObject* U3CU3Ec_U3CRegisterBaseImportersU3Eb__26_11_mCF7A647855C16591DD6BDF701918E7B8A5959D63 (U3CU3Ec_tB2417947DB790EC3B314B9BB1046B04B68400CDA* __this, RuntimeObject* ___input0, const RuntimeMethod* method) 
{
	static bool s_Il2CppMethodInitialized;
	if (!s_Il2CppMethodInitialized)
	{
		il2cpp_codegen_initialize_runtime_metadata((uintptr_t*)&Convert_t7097FF336D592F7C06D88A98349A44646F91EFFC_il2cpp_TypeInfo_var);
		il2cpp_codegen_initialize_runtime_metadata((uintptr_t*)&UInt32_t1833D51FFA667B18A5AA4B8D34DE284F8495D29B_il2cpp_TypeInfo_var);
		il2cpp_codegen_initialize_runtime_metadata((uintptr_t*)&UInt64_t8F12534CC8FC4B5860F2A2CD1EE79D322E7A41AF_il2cpp_TypeInfo_var);
		s_Il2CppMethodInitialized = true;
	}
	{
		// return Convert.ToUInt64((uint)input);
		RuntimeObject* L_0 = ___input0;
		il2cpp_codegen_runtime_class_init_inline(Convert_t7097FF336D592F7C06D88A98349A44646F91EFFC_il2cpp_TypeInfo_var);
		uint64_t L_1;
		L_1 = Convert_ToUInt64_m91C774E0D3AA8368D12AB8E2036E823C4FA9CB92(((*(uint32_t*)((uint32_t*)(uint32_t*)UnBox(L_0, UInt32_t1833D51FFA667B18A5AA4B8D34DE284F8495D29B_il2cpp_TypeInfo_var)))), NULL);
		uint64_t L_2 = L_1;
		RuntimeObject* L_3 = Box(UInt64_t8F12534CC8FC4B5860F2A2CD1EE79D322E7A41AF_il2cpp_TypeInfo_var, &L_2);
		return L_3;
	}
}
// System.Object Agora.Rtc.LitJson.JsonMapper/<>c::<RegisterBaseImporters>b__26_12(System.Object)
IL2CPP_EXTERN_C IL2CPP_METHOD_ATTR RuntimeObject* U3CU3Ec_U3CRegisterBaseImportersU3Eb__26_12_m460C63359E7287CEBB38B0EAE439410AB27C0F21 (U3CU3Ec_tB2417947DB790EC3B314B9BB1046B04B68400CDA* __this, RuntimeObject* ___input0, const RuntimeMethod* method) 
{
	static bool s_Il2CppMethodInitialized;
	if (!s_Il2CppMethodInitialized)
	{
		il2cpp_codegen_initialize_runtime_metadata((uintptr_t*)&Convert_t7097FF336D592F7C06D88A98349A44646F91EFFC_il2cpp_TypeInfo_var);
		il2cpp_codegen_initialize_runtime_metadata((uintptr_t*)&Decimal_tDA6C877282B2D789CF97C0949661CC11D643969F_il2cpp_TypeInfo_var);
		il2cpp_codegen_initialize_runtime_metadata((uintptr_t*)&Double_tE150EF3D1D43DEE85D533810AB4C742307EEDE5F_il2cpp_TypeInfo_var);
		s_Il2CppMethodInitialized = true;
	}
	{
		// return Convert.ToDecimal((double)input);
		RuntimeObject* L_0 = ___input0;
		il2cpp_codegen_runtime_class_init_inline(Convert_t7097FF336D592F7C06D88A98349A44646F91EFFC_il2cpp_TypeInfo_var);
		Decimal_tDA6C877282B2D789CF97C0949661CC11D643969F L_1;
		L_1 = Convert_ToDecimal_mAF1D2181BB8C5D3F25C0963245437B4AF4E6C575(((*(double*)((double*)(double*)UnBox(L_0, Double_tE150EF3D1D43DEE85D533810AB4C742307EEDE5F_il2cpp_TypeInfo_var)))), NULL);
		Decimal_tDA6C877282B2D789CF97C0949661CC11D643969F L_2 = L_1;
		RuntimeObject* L_3 = Box(Decimal_tDA6C877282B2D789CF97C0949661CC11D643969F_il2cpp_TypeInfo_var, &L_2);
		return L_3;
	}
}
// System.Object Agora.Rtc.LitJson.JsonMapper/<>c::<RegisterBaseImporters>b__26_13(System.Object)
IL2CPP_EXTERN_C IL2CPP_METHOD_ATTR RuntimeObject* U3CU3Ec_U3CRegisterBaseImportersU3Eb__26_13_mB864E6F3658766EE1291B31448D9EEC3056B2B57 (U3CU3Ec_tB2417947DB790EC3B314B9BB1046B04B68400CDA* __this, RuntimeObject* ___input0, const RuntimeMethod* method) 
{
	static bool s_Il2CppMethodInitialized;
	if (!s_Il2CppMethodInitialized)
	{
		il2cpp_codegen_initialize_runtime_metadata((uintptr_t*)&Convert_t7097FF336D592F7C06D88A98349A44646F91EFFC_il2cpp_TypeInfo_var);
		il2cpp_codegen_initialize_runtime_metadata((uintptr_t*)&Double_tE150EF3D1D43DEE85D533810AB4C742307EEDE5F_il2cpp_TypeInfo_var);
		il2cpp_codegen_initialize_runtime_metadata((uintptr_t*)&Single_t4530F2FF86FCB0DC29F35385CA1BD21BE294761C_il2cpp_TypeInfo_var);
		s_Il2CppMethodInitialized = true;
	}
	{
		// return Convert.ToSingle((double)input);
		RuntimeObject* L_0 = ___input0;
		il2cpp_codegen_runtime_class_init_inline(Convert_t7097FF336D592F7C06D88A98349A44646F91EFFC_il2cpp_TypeInfo_var);
		float L_1;
		L_1 = Convert_ToSingle_mF6ADEF60A6A97E9E7E410D8D15B26F2D5995151E(((*(double*)((double*)(double*)UnBox(L_0, Double_tE150EF3D1D43DEE85D533810AB4C742307EEDE5F_il2cpp_TypeInfo_var)))), NULL);
		float L_2 = L_1;
		RuntimeObject* L_3 = Box(Single_t4530F2FF86FCB0DC29F35385CA1BD21BE294761C_il2cpp_TypeInfo_var, &L_2);
		return L_3;
	}
}
// System.Object Agora.Rtc.LitJson.JsonMapper/<>c::<RegisterBaseImporters>b__26_14(System.Object)
IL2CPP_EXTERN_C IL2CPP_METHOD_ATTR RuntimeObject* U3CU3Ec_U3CRegisterBaseImportersU3Eb__26_14_m6F10A338E50077E9536A459FBC79BA4FFE770ACD (U3CU3Ec_tB2417947DB790EC3B314B9BB1046B04B68400CDA* __this, RuntimeObject* ___input0, const RuntimeMethod* method) 
{
	static bool s_Il2CppMethodInitialized;
	if (!s_Il2CppMethodInitialized)
	{
		il2cpp_codegen_initialize_runtime_metadata((uintptr_t*)&Convert_t7097FF336D592F7C06D88A98349A44646F91EFFC_il2cpp_TypeInfo_var);
		il2cpp_codegen_initialize_runtime_metadata((uintptr_t*)&Int64_t092CFB123BE63C28ACDAF65C68F21A526050DBA3_il2cpp_TypeInfo_var);
		il2cpp_codegen_initialize_runtime_metadata((uintptr_t*)&UInt32_t1833D51FFA667B18A5AA4B8D34DE284F8495D29B_il2cpp_TypeInfo_var);
		s_Il2CppMethodInitialized = true;
	}
	{
		// return Convert.ToUInt32((long)input);
		RuntimeObject* L_0 = ___input0;
		il2cpp_codegen_runtime_class_init_inline(Convert_t7097FF336D592F7C06D88A98349A44646F91EFFC_il2cpp_TypeInfo_var);
		uint32_t L_1;
		L_1 = Convert_ToUInt32_m8754C042D71DB6C81EB54D85B73B7EC2710E4FA0(((*(int64_t*)((int64_t*)(int64_t*)UnBox(L_0, Int64_t092CFB123BE63C28ACDAF65C68F21A526050DBA3_il2cpp_TypeInfo_var)))), NULL);
		uint32_t L_2 = L_1;
		RuntimeObject* L_3 = Box(UInt32_t1833D51FFA667B18A5AA4B8D34DE284F8495D29B_il2cpp_TypeInfo_var, &L_2);
		return L_3;
	}
}
// System.Object Agora.Rtc.LitJson.JsonMapper/<>c::<RegisterBaseImporters>b__26_15(System.Object)
IL2CPP_EXTERN_C IL2CPP_METHOD_ATTR RuntimeObject* U3CU3Ec_U3CRegisterBaseImportersU3Eb__26_15_m6DD79423A39EFBCFBC1CD645A973585695FE2380 (U3CU3Ec_tB2417947DB790EC3B314B9BB1046B04B68400CDA* __this, RuntimeObject* ___input0, const RuntimeMethod* method) 
{
	static bool s_Il2CppMethodInitialized;
	if (!s_Il2CppMethodInitialized)
	{
		il2cpp_codegen_initialize_runtime_metadata((uintptr_t*)&Convert_t7097FF336D592F7C06D88A98349A44646F91EFFC_il2cpp_TypeInfo_var);
		il2cpp_codegen_initialize_runtime_metadata((uintptr_t*)&Int64_t092CFB123BE63C28ACDAF65C68F21A526050DBA3_il2cpp_TypeInfo_var);
		il2cpp_codegen_initialize_runtime_metadata((uintptr_t*)&UInt64_t8F12534CC8FC4B5860F2A2CD1EE79D322E7A41AF_il2cpp_TypeInfo_var);
		s_Il2CppMethodInitialized = true;
	}
	{
		// return Convert.ToUInt64((long)input);
		RuntimeObject* L_0 = ___input0;
		il2cpp_codegen_runtime_class_init_inline(Convert_t7097FF336D592F7C06D88A98349A44646F91EFFC_il2cpp_TypeInfo_var);
		uint64_t L_1;
		L_1 = Convert_ToUInt64_mDC842A03AB192EF47059253789BE224E41200D77(((*(int64_t*)((int64_t*)(int64_t*)UnBox(L_0, Int64_t092CFB123BE63C28ACDAF65C68F21A526050DBA3_il2cpp_TypeInfo_var)))), NULL);
		uint64_t L_2 = L_1;
		RuntimeObject* L_3 = Box(UInt64_t8F12534CC8FC4B5860F2A2CD1EE79D322E7A41AF_il2cpp_TypeInfo_var, &L_2);
		return L_3;
	}
}
// System.Object Agora.Rtc.LitJson.JsonMapper/<>c::<RegisterBaseImporters>b__26_16(System.Object)
IL2CPP_EXTERN_C IL2CPP_METHOD_ATTR RuntimeObject* U3CU3Ec_U3CRegisterBaseImportersU3Eb__26_16_m0B9E87A933F355E0A789632C52ED27457BA688E6 (U3CU3Ec_tB2417947DB790EC3B314B9BB1046B04B68400CDA* __this, RuntimeObject* ___input0, const RuntimeMethod* method) 
{
	static bool s_Il2CppMethodInitialized;
	if (!s_Il2CppMethodInitialized)
	{
		il2cpp_codegen_initialize_runtime_metadata((uintptr_t*)&Char_t521A6F19B456D956AF452D926C32709DC03D6B17_il2cpp_TypeInfo_var);
		il2cpp_codegen_initialize_runtime_metadata((uintptr_t*)&Convert_t7097FF336D592F7C06D88A98349A44646F91EFFC_il2cpp_TypeInfo_var);
		il2cpp_codegen_initialize_runtime_metadata((uintptr_t*)&String_t_il2cpp_TypeInfo_var);
		s_Il2CppMethodInitialized = true;
	}
	{
		// return Convert.ToChar((string)input);
		RuntimeObject* L_0 = ___input0;
		il2cpp_codegen_runtime_class_init_inline(Convert_t7097FF336D592F7C06D88A98349A44646F91EFFC_il2cpp_TypeInfo_var);
		Il2CppChar L_1;
		L_1 = Convert_ToChar_m1F2BBA9AD900A2570DE55F3E315BA7D9277E8230(((String_t*)CastclassSealed((RuntimeObject*)L_0, String_t_il2cpp_TypeInfo_var)), NULL);
		Il2CppChar L_2 = L_1;
		RuntimeObject* L_3 = Box(Char_t521A6F19B456D956AF452D926C32709DC03D6B17_il2cpp_TypeInfo_var, &L_2);
		return L_3;
	}
}
// System.Object Agora.Rtc.LitJson.JsonMapper/<>c::<RegisterBaseImporters>b__26_17(System.Object)
IL2CPP_EXTERN_C IL2CPP_METHOD_ATTR RuntimeObject* U3CU3Ec_U3CRegisterBaseImportersU3Eb__26_17_m2D37E31A819B770D503230A19F68CFE8CDE07C8F (U3CU3Ec_tB2417947DB790EC3B314B9BB1046B04B68400CDA* __this, RuntimeObject* ___input0, const RuntimeMethod* method) 
{
	static bool s_Il2CppMethodInitialized;
	if (!s_Il2CppMethodInitialized)
	{
		il2cpp_codegen_initialize_runtime_metadata((uintptr_t*)&Convert_t7097FF336D592F7C06D88A98349A44646F91EFFC_il2cpp_TypeInfo_var);
		il2cpp_codegen_initialize_runtime_metadata((uintptr_t*)&DateTime_t66193957C73913903DDAD89FEDC46139BCA5802D_il2cpp_TypeInfo_var);
		il2cpp_codegen_initialize_runtime_metadata((uintptr_t*)&JsonMapper_t3A3F5A7CFFC63F7DF9A3563D52974D21D47798F2_il2cpp_TypeInfo_var);
		il2cpp_codegen_initialize_runtime_metadata((uintptr_t*)&String_t_il2cpp_TypeInfo_var);
		s_Il2CppMethodInitialized = true;
	}
	{
		// return Convert.ToDateTime((string)input, datetime_format);
		RuntimeObject* L_0 = ___input0;
		il2cpp_codegen_runtime_class_init_inline(JsonMapper_t3A3F5A7CFFC63F7DF9A3563D52974D21D47798F2_il2cpp_TypeInfo_var);
		RuntimeObject* L_1 = ((JsonMapper_t3A3F5A7CFFC63F7DF9A3563D52974D21D47798F2_StaticFields*)il2cpp_codegen_static_fields_for(JsonMapper_t3A3F5A7CFFC63F7DF9A3563D52974D21D47798F2_il2cpp_TypeInfo_var))->___datetime_format_1;
		il2cpp_codegen_runtime_class_init_inline(Convert_t7097FF336D592F7C06D88A98349A44646F91EFFC_il2cpp_TypeInfo_var);
		DateTime_t66193957C73913903DDAD89FEDC46139BCA5802D L_2;
		L_2 = Convert_ToDateTime_mA5FF0ECBE84ECB78B337E4E101423CC9AA95C8C3(((String_t*)CastclassSealed((RuntimeObject*)L_0, String_t_il2cpp_TypeInfo_var)), L_1, NULL);
		DateTime_t66193957C73913903DDAD89FEDC46139BCA5802D L_3 = L_2;
		RuntimeObject* L_4 = Box(DateTime_t66193957C73913903DDAD89FEDC46139BCA5802D_il2cpp_TypeInfo_var, &L_3);
		return L_4;
	}
}
// System.Object Agora.Rtc.LitJson.JsonMapper/<>c::<RegisterBaseImporters>b__26_18(System.Object)
IL2CPP_EXTERN_C IL2CPP_METHOD_ATTR RuntimeObject* U3CU3Ec_U3CRegisterBaseImportersU3Eb__26_18_mB05F4FAC5E4E5A073FB3FA9657A11077B9B7A5EE (U3CU3Ec_tB2417947DB790EC3B314B9BB1046B04B68400CDA* __this, RuntimeObject* ___input0, const RuntimeMethod* method) 
{
	static bool s_Il2CppMethodInitialized;
	if (!s_Il2CppMethodInitialized)
	{
		il2cpp_codegen_initialize_runtime_metadata((uintptr_t*)&DateTimeOffset_t4EE701FE2F386D6F932FAC9B11E4B74A5B30F0A4_il2cpp_TypeInfo_var);
		il2cpp_codegen_initialize_runtime_metadata((uintptr_t*)&JsonMapper_t3A3F5A7CFFC63F7DF9A3563D52974D21D47798F2_il2cpp_TypeInfo_var);
		il2cpp_codegen_initialize_runtime_metadata((uintptr_t*)&String_t_il2cpp_TypeInfo_var);
		s_Il2CppMethodInitialized = true;
	}
	{
		// return DateTimeOffset.Parse((string)input, datetime_format);
		RuntimeObject* L_0 = ___input0;
		il2cpp_codegen_runtime_class_init_inline(JsonMapper_t3A3F5A7CFFC63F7DF9A3563D52974D21D47798F2_il2cpp_TypeInfo_var);
		RuntimeObject* L_1 = ((JsonMapper_t3A3F5A7CFFC63F7DF9A3563D52974D21D47798F2_StaticFields*)il2cpp_codegen_static_fields_for(JsonMapper_t3A3F5A7CFFC63F7DF9A3563D52974D21D47798F2_il2cpp_TypeInfo_var))->___datetime_format_1;
		il2cpp_codegen_runtime_class_init_inline(DateTimeOffset_t4EE701FE2F386D6F932FAC9B11E4B74A5B30F0A4_il2cpp_TypeInfo_var);
		DateTimeOffset_t4EE701FE2F386D6F932FAC9B11E4B74A5B30F0A4 L_2;
		L_2 = DateTimeOffset_Parse_m8424EADCF014945BF1C47215B851C735B26BC341(((String_t*)CastclassSealed((RuntimeObject*)L_0, String_t_il2cpp_TypeInfo_var)), L_1, NULL);
		DateTimeOffset_t4EE701FE2F386D6F932FAC9B11E4B74A5B30F0A4 L_3 = L_2;
		RuntimeObject* L_4 = Box(DateTimeOffset_t4EE701FE2F386D6F932FAC9B11E4B74A5B30F0A4_il2cpp_TypeInfo_var, &L_3);
		return L_4;
	}
}
// System.Object Agora.Rtc.LitJson.JsonMapper/<>c::<RegisterCustomImporters>b__27_0(System.Object)
IL2CPP_EXTERN_C IL2CPP_METHOD_ATTR RuntimeObject* U3CU3Ec_U3CRegisterCustomImportersU3Eb__27_0_m851C1E32284B3297C7F7790575A42E883226B45C (U3CU3Ec_tB2417947DB790EC3B314B9BB1046B04B68400CDA* __this, RuntimeObject* ___input0, const RuntimeMethod* method) 
{
	static bool s_Il2CppMethodInitialized;
	if (!s_Il2CppMethodInitialized)
	{
		il2cpp_codegen_initialize_runtime_metadata((uintptr_t*)&Convert_t7097FF336D592F7C06D88A98349A44646F91EFFC_il2cpp_TypeInfo_var);
		il2cpp_codegen_initialize_runtime_metadata((uintptr_t*)&Optional_1_SetValue_m3DE667644E7C516EB481AB0BEE32FE7EDFB435AF_RuntimeMethod_var);
		il2cpp_codegen_initialize_runtime_metadata((uintptr_t*)&Optional_1__ctor_mA609C23EDD6086480DE074C6062697F841A89DE5_RuntimeMethod_var);
		il2cpp_codegen_initialize_runtime_metadata((uintptr_t*)&Optional_1_tD55CF2B24B2306B7B7CE9AFEE8C63C8C1C6A3C55_il2cpp_TypeInfo_var);
		s_Il2CppMethodInitialized = true;
	}
	{
		// Optional<double> ret = new Optional<double>();
		Optional_1_tD55CF2B24B2306B7B7CE9AFEE8C63C8C1C6A3C55* L_0 = (Optional_1_tD55CF2B24B2306B7B7CE9AFEE8C63C8C1C6A3C55*)il2cpp_codegen_object_new(Optional_1_tD55CF2B24B2306B7B7CE9AFEE8C63C8C1C6A3C55_il2cpp_TypeInfo_var);
		NullCheck(L_0);
		Optional_1__ctor_mA609C23EDD6086480DE074C6062697F841A89DE5(L_0, Optional_1__ctor_mA609C23EDD6086480DE074C6062697F841A89DE5_RuntimeMethod_var);
		// ret.SetValue(Convert.ToDouble(input));
		Optional_1_tD55CF2B24B2306B7B7CE9AFEE8C63C8C1C6A3C55* L_1 = L_0;
		RuntimeObject* L_2 = ___input0;
		il2cpp_codegen_runtime_class_init_inline(Convert_t7097FF336D592F7C06D88A98349A44646F91EFFC_il2cpp_TypeInfo_var);
		double L_3;
		L_3 = Convert_ToDouble_m86FF4F837721833186E883102C056A35F0860EB0(L_2, NULL);
		NullCheck(L_1);
		Optional_1_SetValue_m3DE667644E7C516EB481AB0BEE32FE7EDFB435AF(L_1, L_3, Optional_1_SetValue_m3DE667644E7C516EB481AB0BEE32FE7EDFB435AF_RuntimeMethod_var);
		// return ret;
		return L_1;
	}
}
// System.Object Agora.Rtc.LitJson.JsonMapper/<>c::<RegisterCustomImporters>b__27_1(System.Object)
IL2CPP_EXTERN_C IL2CPP_METHOD_ATTR RuntimeObject* U3CU3Ec_U3CRegisterCustomImportersU3Eb__27_1_mB2B0214885E30A7C9CF7A9D2DEFEE626C0703EC0 (U3CU3Ec_tB2417947DB790EC3B314B9BB1046B04B68400CDA* __this, RuntimeObject* ___input0, const RuntimeMethod* method) 
{
	static bool s_Il2CppMethodInitialized;
	if (!s_Il2CppMethodInitialized)
	{
		il2cpp_codegen_initialize_runtime_metadata((uintptr_t*)&Convert_t7097FF336D592F7C06D88A98349A44646F91EFFC_il2cpp_TypeInfo_var);
		il2cpp_codegen_initialize_runtime_metadata((uintptr_t*)&Optional_1_SetValue_m3DE667644E7C516EB481AB0BEE32FE7EDFB435AF_RuntimeMethod_var);
		il2cpp_codegen_initialize_runtime_metadata((uintptr_t*)&Optional_1__ctor_mA609C23EDD6086480DE074C6062697F841A89DE5_RuntimeMethod_var);
		il2cpp_codegen_initialize_runtime_metadata((uintptr_t*)&Optional_1_tD55CF2B24B2306B7B7CE9AFEE8C63C8C1C6A3C55_il2cpp_TypeInfo_var);
		s_Il2CppMethodInitialized = true;
	}
	{
		// Optional<double> ret = new Optional<double>();
		Optional_1_tD55CF2B24B2306B7B7CE9AFEE8C63C8C1C6A3C55* L_0 = (Optional_1_tD55CF2B24B2306B7B7CE9AFEE8C63C8C1C6A3C55*)il2cpp_codegen_object_new(Optional_1_tD55CF2B24B2306B7B7CE9AFEE8C63C8C1C6A3C55_il2cpp_TypeInfo_var);
		NullCheck(L_0);
		Optional_1__ctor_mA609C23EDD6086480DE074C6062697F841A89DE5(L_0, Optional_1__ctor_mA609C23EDD6086480DE074C6062697F841A89DE5_RuntimeMethod_var);
		// ret.SetValue(Convert.ToInt32(input));
		Optional_1_tD55CF2B24B2306B7B7CE9AFEE8C63C8C1C6A3C55* L_1 = L_0;
		RuntimeObject* L_2 = ___input0;
		il2cpp_codegen_runtime_class_init_inline(Convert_t7097FF336D592F7C06D88A98349A44646F91EFFC_il2cpp_TypeInfo_var);
		int32_t L_3;
		L_3 = Convert_ToInt32_m9FEA65DB96264479B5268014F10754787382D297(L_2, NULL);
		NullCheck(L_1);
		Optional_1_SetValue_m3DE667644E7C516EB481AB0BEE32FE7EDFB435AF(L_1, ((double)L_3), Optional_1_SetValue_m3DE667644E7C516EB481AB0BEE32FE7EDFB435AF_RuntimeMethod_var);
		// return ret;
		return L_1;
	}
}
// System.Object Agora.Rtc.LitJson.JsonMapper/<>c::<RegisterCustomImporters>b__27_2(System.Object)
IL2CPP_EXTERN_C IL2CPP_METHOD_ATTR RuntimeObject* U3CU3Ec_U3CRegisterCustomImportersU3Eb__27_2_m7449A68CE4520DE1E714BEE7593C61839418BA3E (U3CU3Ec_tB2417947DB790EC3B314B9BB1046B04B68400CDA* __this, RuntimeObject* ___input0, const RuntimeMethod* method) 
{
	static bool s_Il2CppMethodInitialized;
	if (!s_Il2CppMethodInitialized)
	{
		il2cpp_codegen_initialize_runtime_metadata((uintptr_t*)&Convert_t7097FF336D592F7C06D88A98349A44646F91EFFC_il2cpp_TypeInfo_var);
		il2cpp_codegen_initialize_runtime_metadata((uintptr_t*)&Optional_1_SetValue_m3DE667644E7C516EB481AB0BEE32FE7EDFB435AF_RuntimeMethod_var);
		il2cpp_codegen_initialize_runtime_metadata((uintptr_t*)&Optional_1__ctor_mA609C23EDD6086480DE074C6062697F841A89DE5_RuntimeMethod_var);
		il2cpp_codegen_initialize_runtime_metadata((uintptr_t*)&Optional_1_tD55CF2B24B2306B7B7CE9AFEE8C63C8C1C6A3C55_il2cpp_TypeInfo_var);
		s_Il2CppMethodInitialized = true;
	}
	{
		// Optional<double> ret = new Optional<double>();
		Optional_1_tD55CF2B24B2306B7B7CE9AFEE8C63C8C1C6A3C55* L_0 = (Optional_1_tD55CF2B24B2306B7B7CE9AFEE8C63C8C1C6A3C55*)il2cpp_codegen_object_new(Optional_1_tD55CF2B24B2306B7B7CE9AFEE8C63C8C1C6A3C55_il2cpp_TypeInfo_var);
		NullCheck(L_0);
		Optional_1__ctor_mA609C23EDD6086480DE074C6062697F841A89DE5(L_0, Optional_1__ctor_mA609C23EDD6086480DE074C6062697F841A89DE5_RuntimeMethod_var);
		// ret.SetValue(Convert.ToInt64(input));
		Optional_1_tD55CF2B24B2306B7B7CE9AFEE8C63C8C1C6A3C55* L_1 = L_0;
		RuntimeObject* L_2 = ___input0;
		il2cpp_codegen_runtime_class_init_inline(Convert_t7097FF336D592F7C06D88A98349A44646F91EFFC_il2cpp_TypeInfo_var);
		int64_t L_3;
		L_3 = Convert_ToInt64_mB980D7B1AB7B7071D416EE892C2B736D712BE1B5(L_2, NULL);
		NullCheck(L_1);
		Optional_1_SetValue_m3DE667644E7C516EB481AB0BEE32FE7EDFB435AF(L_1, ((double)L_3), Optional_1_SetValue_m3DE667644E7C516EB481AB0BEE32FE7EDFB435AF_RuntimeMethod_var);
		// return ret;
		return L_1;
	}
}
// System.Object Agora.Rtc.LitJson.JsonMapper/<>c::<RegisterCustomImporters>b__27_3(System.Object)
IL2CPP_EXTERN_C IL2CPP_METHOD_ATTR RuntimeObject* U3CU3Ec_U3CRegisterCustomImportersU3Eb__27_3_mDCE8A3293DBE1C6BB13F6ECE7ACE115DC5141327 (U3CU3Ec_tB2417947DB790EC3B314B9BB1046B04B68400CDA* __this, RuntimeObject* ___input0, const RuntimeMethod* method) 
{
	static bool s_Il2CppMethodInitialized;
	if (!s_Il2CppMethodInitialized)
	{
		il2cpp_codegen_initialize_runtime_metadata((uintptr_t*)&Convert_t7097FF336D592F7C06D88A98349A44646F91EFFC_il2cpp_TypeInfo_var);
		il2cpp_codegen_initialize_runtime_metadata((uintptr_t*)&Optional_1_SetValue_m63B29B35805A275BE9D1E1FEF8B269FF41763BBD_RuntimeMethod_var);
		il2cpp_codegen_initialize_runtime_metadata((uintptr_t*)&Optional_1__ctor_m9DF6F847C789BC17876C2CD77F24BEFB722B396B_RuntimeMethod_var);
		il2cpp_codegen_initialize_runtime_metadata((uintptr_t*)&Optional_1_tF876A70CDF0D3ADF96F01942F0AEAC7EB19FC62A_il2cpp_TypeInfo_var);
		s_Il2CppMethodInitialized = true;
	}
	{
		// Optional<float> ret = new Optional<float>();
		Optional_1_tF876A70CDF0D3ADF96F01942F0AEAC7EB19FC62A* L_0 = (Optional_1_tF876A70CDF0D3ADF96F01942F0AEAC7EB19FC62A*)il2cpp_codegen_object_new(Optional_1_tF876A70CDF0D3ADF96F01942F0AEAC7EB19FC62A_il2cpp_TypeInfo_var);
		NullCheck(L_0);
		Optional_1__ctor_m9DF6F847C789BC17876C2CD77F24BEFB722B396B(L_0, Optional_1__ctor_m9DF6F847C789BC17876C2CD77F24BEFB722B396B_RuntimeMethod_var);
		// ret.SetValue((float)Convert.ToDouble(input));
		Optional_1_tF876A70CDF0D3ADF96F01942F0AEAC7EB19FC62A* L_1 = L_0;
		RuntimeObject* L_2 = ___input0;
		il2cpp_codegen_runtime_class_init_inline(Convert_t7097FF336D592F7C06D88A98349A44646F91EFFC_il2cpp_TypeInfo_var);
		double L_3;
		L_3 = Convert_ToDouble_m86FF4F837721833186E883102C056A35F0860EB0(L_2, NULL);
		NullCheck(L_1);
		Optional_1_SetValue_m63B29B35805A275BE9D1E1FEF8B269FF41763BBD(L_1, ((float)L_3), Optional_1_SetValue_m63B29B35805A275BE9D1E1FEF8B269FF41763BBD_RuntimeMethod_var);
		// return ret;
		return L_1;
	}
}
// System.Object Agora.Rtc.LitJson.JsonMapper/<>c::<RegisterCustomImporters>b__27_4(System.Object)
IL2CPP_EXTERN_C IL2CPP_METHOD_ATTR RuntimeObject* U3CU3Ec_U3CRegisterCustomImportersU3Eb__27_4_m9F6FED70FF142433566A78CC157FDCCFB86BFBBD (U3CU3Ec_tB2417947DB790EC3B314B9BB1046B04B68400CDA* __this, RuntimeObject* ___input0, const RuntimeMethod* method) 
{
	static bool s_Il2CppMethodInitialized;
	if (!s_Il2CppMethodInitialized)
	{
		il2cpp_codegen_initialize_runtime_metadata((uintptr_t*)&Convert_t7097FF336D592F7C06D88A98349A44646F91EFFC_il2cpp_TypeInfo_var);
		il2cpp_codegen_initialize_runtime_metadata((uintptr_t*)&Optional_1_SetValue_m63B29B35805A275BE9D1E1FEF8B269FF41763BBD_RuntimeMethod_var);
		il2cpp_codegen_initialize_runtime_metadata((uintptr_t*)&Optional_1__ctor_m9DF6F847C789BC17876C2CD77F24BEFB722B396B_RuntimeMethod_var);
		il2cpp_codegen_initialize_runtime_metadata((uintptr_t*)&Optional_1_tF876A70CDF0D3ADF96F01942F0AEAC7EB19FC62A_il2cpp_TypeInfo_var);
		s_Il2CppMethodInitialized = true;
	}
	{
		// Optional<float> ret = new Optional<float>();
		Optional_1_tF876A70CDF0D3ADF96F01942F0AEAC7EB19FC62A* L_0 = (Optional_1_tF876A70CDF0D3ADF96F01942F0AEAC7EB19FC62A*)il2cpp_codegen_object_new(Optional_1_tF876A70CDF0D3ADF96F01942F0AEAC7EB19FC62A_il2cpp_TypeInfo_var);
		NullCheck(L_0);
		Optional_1__ctor_m9DF6F847C789BC17876C2CD77F24BEFB722B396B(L_0, Optional_1__ctor_m9DF6F847C789BC17876C2CD77F24BEFB722B396B_RuntimeMethod_var);
		// ret.SetValue((float)Convert.ToInt32(input));
		Optional_1_tF876A70CDF0D3ADF96F01942F0AEAC7EB19FC62A* L_1 = L_0;
		RuntimeObject* L_2 = ___input0;
		il2cpp_codegen_runtime_class_init_inline(Convert_t7097FF336D592F7C06D88A98349A44646F91EFFC_il2cpp_TypeInfo_var);
		int32_t L_3;
		L_3 = Convert_ToInt32_m9FEA65DB96264479B5268014F10754787382D297(L_2, NULL);
		NullCheck(L_1);
		Optional_1_SetValue_m63B29B35805A275BE9D1E1FEF8B269FF41763BBD(L_1, ((float)L_3), Optional_1_SetValue_m63B29B35805A275BE9D1E1FEF8B269FF41763BBD_RuntimeMethod_var);
		// return ret;
		return L_1;
	}
}
// System.Object Agora.Rtc.LitJson.JsonMapper/<>c::<RegisterCustomImporters>b__27_5(System.Object)
IL2CPP_EXTERN_C IL2CPP_METHOD_ATTR RuntimeObject* U3CU3Ec_U3CRegisterCustomImportersU3Eb__27_5_m8A64E7980A3C5DA60A499B3A3ED13DA81D2EA9C3 (U3CU3Ec_tB2417947DB790EC3B314B9BB1046B04B68400CDA* __this, RuntimeObject* ___input0, const RuntimeMethod* method) 
{
	static bool s_Il2CppMethodInitialized;
	if (!s_Il2CppMethodInitialized)
	{
		il2cpp_codegen_initialize_runtime_metadata((uintptr_t*)&Convert_t7097FF336D592F7C06D88A98349A44646F91EFFC_il2cpp_TypeInfo_var);
		il2cpp_codegen_initialize_runtime_metadata((uintptr_t*)&Optional_1_SetValue_m63B29B35805A275BE9D1E1FEF8B269FF41763BBD_RuntimeMethod_var);
		il2cpp_codegen_initialize_runtime_metadata((uintptr_t*)&Optional_1__ctor_m9DF6F847C789BC17876C2CD77F24BEFB722B396B_RuntimeMethod_var);
		il2cpp_codegen_initialize_runtime_metadata((uintptr_t*)&Optional_1_tF876A70CDF0D3ADF96F01942F0AEAC7EB19FC62A_il2cpp_TypeInfo_var);
		s_Il2CppMethodInitialized = true;
	}
	{
		// Optional<float> ret = new Optional<float>();
		Optional_1_tF876A70CDF0D3ADF96F01942F0AEAC7EB19FC62A* L_0 = (Optional_1_tF876A70CDF0D3ADF96F01942F0AEAC7EB19FC62A*)il2cpp_codegen_object_new(Optional_1_tF876A70CDF0D3ADF96F01942F0AEAC7EB19FC62A_il2cpp_TypeInfo_var);
		NullCheck(L_0);
		Optional_1__ctor_m9DF6F847C789BC17876C2CD77F24BEFB722B396B(L_0, Optional_1__ctor_m9DF6F847C789BC17876C2CD77F24BEFB722B396B_RuntimeMethod_var);
		// ret.SetValue((float)Convert.ToInt64(input));
		Optional_1_tF876A70CDF0D3ADF96F01942F0AEAC7EB19FC62A* L_1 = L_0;
		RuntimeObject* L_2 = ___input0;
		il2cpp_codegen_runtime_class_init_inline(Convert_t7097FF336D592F7C06D88A98349A44646F91EFFC_il2cpp_TypeInfo_var);
		int64_t L_3;
		L_3 = Convert_ToInt64_mB980D7B1AB7B7071D416EE892C2B736D712BE1B5(L_2, NULL);
		NullCheck(L_1);
		Optional_1_SetValue_m63B29B35805A275BE9D1E1FEF8B269FF41763BBD(L_1, ((float)L_3), Optional_1_SetValue_m63B29B35805A275BE9D1E1FEF8B269FF41763BBD_RuntimeMethod_var);
		// return ret;
		return L_1;
	}
}
// System.Object Agora.Rtc.LitJson.JsonMapper/<>c::<RegisterCustomImporters>b__27_6(System.Object)
IL2CPP_EXTERN_C IL2CPP_METHOD_ATTR RuntimeObject* U3CU3Ec_U3CRegisterCustomImportersU3Eb__27_6_m2B81F7948C07640F5B85ED16F17B552B17DD89E4 (U3CU3Ec_tB2417947DB790EC3B314B9BB1046B04B68400CDA* __this, RuntimeObject* ___input0, const RuntimeMethod* method) 
{
	static bool s_Il2CppMethodInitialized;
	if (!s_Il2CppMethodInitialized)
	{
		il2cpp_codegen_initialize_runtime_metadata((uintptr_t*)&Convert_t7097FF336D592F7C06D88A98349A44646F91EFFC_il2cpp_TypeInfo_var);
		il2cpp_codegen_initialize_runtime_metadata((uintptr_t*)&Optional_1_SetValue_m9451999734A371C8E4986D51E5019BD66C8A16D9_RuntimeMethod_var);
		il2cpp_codegen_initialize_runtime_metadata((uintptr_t*)&Optional_1__ctor_mE58BCB3372AE04CCD5F9ED566F9364F5CC849D62_RuntimeMethod_var);
		il2cpp_codegen_initialize_runtime_metadata((uintptr_t*)&Optional_1_t3E699351D46D874511D63581794E1D62BC1A2E12_il2cpp_TypeInfo_var);
		s_Il2CppMethodInitialized = true;
	}
	{
		// Optional<short> ret = new Optional<short>();
		Optional_1_t3E699351D46D874511D63581794E1D62BC1A2E12* L_0 = (Optional_1_t3E699351D46D874511D63581794E1D62BC1A2E12*)il2cpp_codegen_object_new(Optional_1_t3E699351D46D874511D63581794E1D62BC1A2E12_il2cpp_TypeInfo_var);
		NullCheck(L_0);
		Optional_1__ctor_mE58BCB3372AE04CCD5F9ED566F9364F5CC849D62(L_0, Optional_1__ctor_mE58BCB3372AE04CCD5F9ED566F9364F5CC849D62_RuntimeMethod_var);
		// ret.SetValue((short)Convert.ToInt32(input));
		Optional_1_t3E699351D46D874511D63581794E1D62BC1A2E12* L_1 = L_0;
		RuntimeObject* L_2 = ___input0;
		il2cpp_codegen_runtime_class_init_inline(Convert_t7097FF336D592F7C06D88A98349A44646F91EFFC_il2cpp_TypeInfo_var);
		int32_t L_3;
		L_3 = Convert_ToInt32_m9FEA65DB96264479B5268014F10754787382D297(L_2, NULL);
		NullCheck(L_1);
		Optional_1_SetValue_m9451999734A371C8E4986D51E5019BD66C8A16D9(L_1, ((int16_t)L_3), Optional_1_SetValue_m9451999734A371C8E4986D51E5019BD66C8A16D9_RuntimeMethod_var);
		// return ret;
		return L_1;
	}
}
// System.Object Agora.Rtc.LitJson.JsonMapper/<>c::<RegisterCustomImporters>b__27_7(System.Object)
IL2CPP_EXTERN_C IL2CPP_METHOD_ATTR RuntimeObject* U3CU3Ec_U3CRegisterCustomImportersU3Eb__27_7_mF8875B51CBC0FCFC7BD4BF4F142EA771AD5668DA (U3CU3Ec_tB2417947DB790EC3B314B9BB1046B04B68400CDA* __this, RuntimeObject* ___input0, const RuntimeMethod* method) 
{
	static bool s_Il2CppMethodInitialized;
	if (!s_Il2CppMethodInitialized)
	{
		il2cpp_codegen_initialize_runtime_metadata((uintptr_t*)&Convert_t7097FF336D592F7C06D88A98349A44646F91EFFC_il2cpp_TypeInfo_var);
		il2cpp_codegen_initialize_runtime_metadata((uintptr_t*)&Optional_1_SetValue_m9451999734A371C8E4986D51E5019BD66C8A16D9_RuntimeMethod_var);
		il2cpp_codegen_initialize_runtime_metadata((uintptr_t*)&Optional_1__ctor_mE58BCB3372AE04CCD5F9ED566F9364F5CC849D62_RuntimeMethod_var);
		il2cpp_codegen_initialize_runtime_metadata((uintptr_t*)&Optional_1_t3E699351D46D874511D63581794E1D62BC1A2E12_il2cpp_TypeInfo_var);
		s_Il2CppMethodInitialized = true;
	}
	{
		// Optional<short> ret = new Optional<short>();
		Optional_1_t3E699351D46D874511D63581794E1D62BC1A2E12* L_0 = (Optional_1_t3E699351D46D874511D63581794E1D62BC1A2E12*)il2cpp_codegen_object_new(Optional_1_t3E699351D46D874511D63581794E1D62BC1A2E12_il2cpp_TypeInfo_var);
		NullCheck(L_0);
		Optional_1__ctor_mE58BCB3372AE04CCD5F9ED566F9364F5CC849D62(L_0, Optional_1__ctor_mE58BCB3372AE04CCD5F9ED566F9364F5CC849D62_RuntimeMethod_var);
		// ret.SetValue((short)Convert.ToUInt64(input));
		Optional_1_t3E699351D46D874511D63581794E1D62BC1A2E12* L_1 = L_0;
		RuntimeObject* L_2 = ___input0;
		il2cpp_codegen_runtime_class_init_inline(Convert_t7097FF336D592F7C06D88A98349A44646F91EFFC_il2cpp_TypeInfo_var);
		uint64_t L_3;
		L_3 = Convert_ToUInt64_mAED581BDC2A2EC0295EC6FB7C7D525571FEA4A0B(L_2, NULL);
		NullCheck(L_1);
		Optional_1_SetValue_m9451999734A371C8E4986D51E5019BD66C8A16D9(L_1, ((int16_t)L_3), Optional_1_SetValue_m9451999734A371C8E4986D51E5019BD66C8A16D9_RuntimeMethod_var);
		// return ret;
		return L_1;
	}
}
// System.Object Agora.Rtc.LitJson.JsonMapper/<>c::<RegisterCustomImporters>b__27_8(System.Object)
IL2CPP_EXTERN_C IL2CPP_METHOD_ATTR RuntimeObject* U3CU3Ec_U3CRegisterCustomImportersU3Eb__27_8_m97603E587DB3737E9971220E4AE8CDCF20F1FE3E (U3CU3Ec_tB2417947DB790EC3B314B9BB1046B04B68400CDA* __this, RuntimeObject* ___input0, const RuntimeMethod* method) 
{
	static bool s_Il2CppMethodInitialized;
	if (!s_Il2CppMethodInitialized)
	{
		il2cpp_codegen_initialize_runtime_metadata((uintptr_t*)&Convert_t7097FF336D592F7C06D88A98349A44646F91EFFC_il2cpp_TypeInfo_var);
		il2cpp_codegen_initialize_runtime_metadata((uintptr_t*)&Optional_1_SetValue_m9451999734A371C8E4986D51E5019BD66C8A16D9_RuntimeMethod_var);
		il2cpp_codegen_initialize_runtime_metadata((uintptr_t*)&Optional_1__ctor_mE58BCB3372AE04CCD5F9ED566F9364F5CC849D62_RuntimeMethod_var);
		il2cpp_codegen_initialize_runtime_metadata((uintptr_t*)&Optional_1_t3E699351D46D874511D63581794E1D62BC1A2E12_il2cpp_TypeInfo_var);
		s_Il2CppMethodInitialized = true;
	}
	{
		// Optional<short> ret = new Optional<short>();
		Optional_1_t3E699351D46D874511D63581794E1D62BC1A2E12* L_0 = (Optional_1_t3E699351D46D874511D63581794E1D62BC1A2E12*)il2cpp_codegen_object_new(Optional_1_t3E699351D46D874511D63581794E1D62BC1A2E12_il2cpp_TypeInfo_var);
		NullCheck(L_0);
		Optional_1__ctor_mE58BCB3372AE04CCD5F9ED566F9364F5CC849D62(L_0, Optional_1__ctor_mE58BCB3372AE04CCD5F9ED566F9364F5CC849D62_RuntimeMethod_var);
		// ret.SetValue((short)Convert.ToDouble(input));
		Optional_1_t3E699351D46D874511D63581794E1D62BC1A2E12* L_1 = L_0;
		RuntimeObject* L_2 = ___input0;
		il2cpp_codegen_runtime_class_init_inline(Convert_t7097FF336D592F7C06D88A98349A44646F91EFFC_il2cpp_TypeInfo_var);
		double L_3;
		L_3 = Convert_ToDouble_m86FF4F837721833186E883102C056A35F0860EB0(L_2, NULL);
		NullCheck(L_1);
		Optional_1_SetValue_m9451999734A371C8E4986D51E5019BD66C8A16D9(L_1, il2cpp_codegen_cast_double_to_int<int16_t>(L_3), Optional_1_SetValue_m9451999734A371C8E4986D51E5019BD66C8A16D9_RuntimeMethod_var);
		// return ret;
		return L_1;
	}
}
// System.Object Agora.Rtc.LitJson.JsonMapper/<>c::<RegisterCustomImporters>b__27_9(System.Object)
IL2CPP_EXTERN_C IL2CPP_METHOD_ATTR RuntimeObject* U3CU3Ec_U3CRegisterCustomImportersU3Eb__27_9_m060D64AD2C02A69B63230DCF31E2D8FC9B7B5E15 (U3CU3Ec_tB2417947DB790EC3B314B9BB1046B04B68400CDA* __this, RuntimeObject* ___input0, const RuntimeMethod* method) 
{
	static bool s_Il2CppMethodInitialized;
	if (!s_Il2CppMethodInitialized)
	{
		il2cpp_codegen_initialize_runtime_metadata((uintptr_t*)&Convert_t7097FF336D592F7C06D88A98349A44646F91EFFC_il2cpp_TypeInfo_var);
		il2cpp_codegen_initialize_runtime_metadata((uintptr_t*)&Optional_1_SetValue_m95F307C9D84062644F9AC400634290FF95E311AF_RuntimeMethod_var);
		il2cpp_codegen_initialize_runtime_metadata((uintptr_t*)&Optional_1__ctor_mE49D786DC8CA5DF649858A60CBFBBA062B92BD0C_RuntimeMethod_var);
		il2cpp_codegen_initialize_runtime_metadata((uintptr_t*)&Optional_1_tC0B7C5D987A3B3FBE615A0BA80C8AE46F260A6D5_il2cpp_TypeInfo_var);
		s_Il2CppMethodInitialized = true;
	}
	{
		// Optional<ushort> ret = new Optional<ushort>();
		Optional_1_tC0B7C5D987A3B3FBE615A0BA80C8AE46F260A6D5* L_0 = (Optional_1_tC0B7C5D987A3B3FBE615A0BA80C8AE46F260A6D5*)il2cpp_codegen_object_new(Optional_1_tC0B7C5D987A3B3FBE615A0BA80C8AE46F260A6D5_il2cpp_TypeInfo_var);
		NullCheck(L_0);
		Optional_1__ctor_mE49D786DC8CA5DF649858A60CBFBBA062B92BD0C(L_0, Optional_1__ctor_mE49D786DC8CA5DF649858A60CBFBBA062B92BD0C_RuntimeMethod_var);
		// ret.SetValue((ushort)Convert.ToInt32(input));
		Optional_1_tC0B7C5D987A3B3FBE615A0BA80C8AE46F260A6D5* L_1 = L_0;
		RuntimeObject* L_2 = ___input0;
		il2cpp_codegen_runtime_class_init_inline(Convert_t7097FF336D592F7C06D88A98349A44646F91EFFC_il2cpp_TypeInfo_var);
		int32_t L_3;
		L_3 = Convert_ToInt32_m9FEA65DB96264479B5268014F10754787382D297(L_2, NULL);
		NullCheck(L_1);
		Optional_1_SetValue_m95F307C9D84062644F9AC400634290FF95E311AF(L_1, (uint16_t)((int32_t)(uint16_t)L_3), Optional_1_SetValue_m95F307C9D84062644F9AC400634290FF95E311AF_RuntimeMethod_var);
		// return ret;
		return L_1;
	}
}
// System.Object Agora.Rtc.LitJson.JsonMapper/<>c::<RegisterCustomImporters>b__27_10(System.Object)
IL2CPP_EXTERN_C IL2CPP_METHOD_ATTR RuntimeObject* U3CU3Ec_U3CRegisterCustomImportersU3Eb__27_10_mBB810A4E970FD100C5C1AC065E30A10995B20C77 (U3CU3Ec_tB2417947DB790EC3B314B9BB1046B04B68400CDA* __this, RuntimeObject* ___input0, const RuntimeMethod* method) 
{
	static bool s_Il2CppMethodInitialized;
	if (!s_Il2CppMethodInitialized)
	{
		il2cpp_codegen_initialize_runtime_metadata((uintptr_t*)&Convert_t7097FF336D592F7C06D88A98349A44646F91EFFC_il2cpp_TypeInfo_var);
		il2cpp_codegen_initialize_runtime_metadata((uintptr_t*)&Optional_1_SetValue_m95F307C9D84062644F9AC400634290FF95E311AF_RuntimeMethod_var);
		il2cpp_codegen_initialize_runtime_metadata((uintptr_t*)&Optional_1__ctor_mE49D786DC8CA5DF649858A60CBFBBA062B92BD0C_RuntimeMethod_var);
		il2cpp_codegen_initialize_runtime_metadata((uintptr_t*)&Optional_1_tC0B7C5D987A3B3FBE615A0BA80C8AE46F260A6D5_il2cpp_TypeInfo_var);
		s_Il2CppMethodInitialized = true;
	}
	{
		// Optional<ushort> ret = new Optional<ushort>();
		Optional_1_tC0B7C5D987A3B3FBE615A0BA80C8AE46F260A6D5* L_0 = (Optional_1_tC0B7C5D987A3B3FBE615A0BA80C8AE46F260A6D5*)il2cpp_codegen_object_new(Optional_1_tC0B7C5D987A3B3FBE615A0BA80C8AE46F260A6D5_il2cpp_TypeInfo_var);
		NullCheck(L_0);
		Optional_1__ctor_mE49D786DC8CA5DF649858A60CBFBBA062B92BD0C(L_0, Optional_1__ctor_mE49D786DC8CA5DF649858A60CBFBBA062B92BD0C_RuntimeMethod_var);
		// ret.SetValue((ushort)Convert.ToUInt64(input));
		Optional_1_tC0B7C5D987A3B3FBE615A0BA80C8AE46F260A6D5* L_1 = L_0;
		RuntimeObject* L_2 = ___input0;
		il2cpp_codegen_runtime_class_init_inline(Convert_t7097FF336D592F7C06D88A98349A44646F91EFFC_il2cpp_TypeInfo_var);
		uint64_t L_3;
		L_3 = Convert_ToUInt64_mAED581BDC2A2EC0295EC6FB7C7D525571FEA4A0B(L_2, NULL);
		NullCheck(L_1);
		Optional_1_SetValue_m95F307C9D84062644F9AC400634290FF95E311AF(L_1, (uint16_t)((int32_t)(uint16_t)L_3), Optional_1_SetValue_m95F307C9D84062644F9AC400634290FF95E311AF_RuntimeMethod_var);
		// return ret;
		return L_1;
	}
}
// System.Object Agora.Rtc.LitJson.JsonMapper/<>c::<RegisterCustomImporters>b__27_11(System.Object)
IL2CPP_EXTERN_C IL2CPP_METHOD_ATTR RuntimeObject* U3CU3Ec_U3CRegisterCustomImportersU3Eb__27_11_m84A1A3CF4D278C4B196022B78ECE53F0B78A4242 (U3CU3Ec_tB2417947DB790EC3B314B9BB1046B04B68400CDA* __this, RuntimeObject* ___input0, const RuntimeMethod* method) 
{
	static bool s_Il2CppMethodInitialized;
	if (!s_Il2CppMethodInitialized)
	{
		il2cpp_codegen_initialize_runtime_metadata((uintptr_t*)&Convert_t7097FF336D592F7C06D88A98349A44646F91EFFC_il2cpp_TypeInfo_var);
		il2cpp_codegen_initialize_runtime_metadata((uintptr_t*)&Optional_1_SetValue_m95F307C9D84062644F9AC400634290FF95E311AF_RuntimeMethod_var);
		il2cpp_codegen_initialize_runtime_metadata((uintptr_t*)&Optional_1__ctor_mE49D786DC8CA5DF649858A60CBFBBA062B92BD0C_RuntimeMethod_var);
		il2cpp_codegen_initialize_runtime_metadata((uintptr_t*)&Optional_1_tC0B7C5D987A3B3FBE615A0BA80C8AE46F260A6D5_il2cpp_TypeInfo_var);
		s_Il2CppMethodInitialized = true;
	}
	{
		// Optional<ushort> ret = new Optional<ushort>();
		Optional_1_tC0B7C5D987A3B3FBE615A0BA80C8AE46F260A6D5* L_0 = (Optional_1_tC0B7C5D987A3B3FBE615A0BA80C8AE46F260A6D5*)il2cpp_codegen_object_new(Optional_1_tC0B7C5D987A3B3FBE615A0BA80C8AE46F260A6D5_il2cpp_TypeInfo_var);
		NullCheck(L_0);
		Optional_1__ctor_mE49D786DC8CA5DF649858A60CBFBBA062B92BD0C(L_0, Optional_1__ctor_mE49D786DC8CA5DF649858A60CBFBBA062B92BD0C_RuntimeMethod_var);
		// ret.SetValue((ushort)Convert.ToDouble(input));
		Optional_1_tC0B7C5D987A3B3FBE615A0BA80C8AE46F260A6D5* L_1 = L_0;
		RuntimeObject* L_2 = ___input0;
		il2cpp_codegen_runtime_class_init_inline(Convert_t7097FF336D592F7C06D88A98349A44646F91EFFC_il2cpp_TypeInfo_var);
		double L_3;
		L_3 = Convert_ToDouble_m86FF4F837721833186E883102C056A35F0860EB0(L_2, NULL);
		NullCheck(L_1);
		Optional_1_SetValue_m95F307C9D84062644F9AC400634290FF95E311AF(L_1, (uint16_t)il2cpp_codegen_cast_floating_point<uint16_t, int32_t, double>(L_3), Optional_1_SetValue_m95F307C9D84062644F9AC400634290FF95E311AF_RuntimeMethod_var);
		// return ret;
		return L_1;
	}
}
// System.Object Agora.Rtc.LitJson.JsonMapper/<>c::<RegisterCustomImporters>b__27_12(System.Object)
IL2CPP_EXTERN_C IL2CPP_METHOD_ATTR RuntimeObject* U3CU3Ec_U3CRegisterCustomImportersU3Eb__27_12_mB63286CA436A58BAB8E6E29D568D0318AB058887 (U3CU3Ec_tB2417947DB790EC3B314B9BB1046B04B68400CDA* __this, RuntimeObject* ___input0, const RuntimeMethod* method) 
{
	static bool s_Il2CppMethodInitialized;
	if (!s_Il2CppMethodInitialized)
	{
		il2cpp_codegen_initialize_runtime_metadata((uintptr_t*)&Convert_t7097FF336D592F7C06D88A98349A44646F91EFFC_il2cpp_TypeInfo_var);
		il2cpp_codegen_initialize_runtime_metadata((uintptr_t*)&Optional_1_SetValue_mF3084568B1C3B43E1DF604DF0771558BE954DFFC_RuntimeMethod_var);
		il2cpp_codegen_initialize_runtime_metadata((uintptr_t*)&Optional_1__ctor_m4BCDD38353BEADF1738DB8386E39A5FE1AF02022_RuntimeMethod_var);
		il2cpp_codegen_initialize_runtime_metadata((uintptr_t*)&Optional_1_t702276DAE9B7132B4ED017493544FE3162F72A13_il2cpp_TypeInfo_var);
		s_Il2CppMethodInitialized = true;
	}
	{
		// Optional<int> ret = new Optional<int>();
		Optional_1_t702276DAE9B7132B4ED017493544FE3162F72A13* L_0 = (Optional_1_t702276DAE9B7132B4ED017493544FE3162F72A13*)il2cpp_codegen_object_new(Optional_1_t702276DAE9B7132B4ED017493544FE3162F72A13_il2cpp_TypeInfo_var);
		NullCheck(L_0);
		Optional_1__ctor_m4BCDD38353BEADF1738DB8386E39A5FE1AF02022(L_0, Optional_1__ctor_m4BCDD38353BEADF1738DB8386E39A5FE1AF02022_RuntimeMethod_var);
		// ret.SetValue(Convert.ToInt32(input));
		Optional_1_t702276DAE9B7132B4ED017493544FE3162F72A13* L_1 = L_0;
		RuntimeObject* L_2 = ___input0;
		il2cpp_codegen_runtime_class_init_inline(Convert_t7097FF336D592F7C06D88A98349A44646F91EFFC_il2cpp_TypeInfo_var);
		int32_t L_3;
		L_3 = Convert_ToInt32_m9FEA65DB96264479B5268014F10754787382D297(L_2, NULL);
		NullCheck(L_1);
		Optional_1_SetValue_mF3084568B1C3B43E1DF604DF0771558BE954DFFC(L_1, L_3, Optional_1_SetValue_mF3084568B1C3B43E1DF604DF0771558BE954DFFC_RuntimeMethod_var);
		// return ret;
		return L_1;
	}
}
// System.Object Agora.Rtc.LitJson.JsonMapper/<>c::<RegisterCustomImporters>b__27_13(System.Object)
IL2CPP_EXTERN_C IL2CPP_METHOD_ATTR RuntimeObject* U3CU3Ec_U3CRegisterCustomImportersU3Eb__27_13_m152F8D400EBDC97C19569661ABDE78BD3960E2FB (U3CU3Ec_tB2417947DB790EC3B314B9BB1046B04B68400CDA* __this, RuntimeObject* ___input0, const RuntimeMethod* method) 
{
	static bool s_Il2CppMethodInitialized;
	if (!s_Il2CppMethodInitialized)
	{
		il2cpp_codegen_initialize_runtime_metadata((uintptr_t*)&Convert_t7097FF336D592F7C06D88A98349A44646F91EFFC_il2cpp_TypeInfo_var);
		il2cpp_codegen_initialize_runtime_metadata((uintptr_t*)&Optional_1_SetValue_mF3084568B1C3B43E1DF604DF0771558BE954DFFC_RuntimeMethod_var);
		il2cpp_codegen_initialize_runtime_metadata((uintptr_t*)&Optional_1__ctor_m4BCDD38353BEADF1738DB8386E39A5FE1AF02022_RuntimeMethod_var);
		il2cpp_codegen_initialize_runtime_metadata((uintptr_t*)&Optional_1_t702276DAE9B7132B4ED017493544FE3162F72A13_il2cpp_TypeInfo_var);
		s_Il2CppMethodInitialized = true;
	}
	{
		// Optional<int> ret = new Optional<int>();
		Optional_1_t702276DAE9B7132B4ED017493544FE3162F72A13* L_0 = (Optional_1_t702276DAE9B7132B4ED017493544FE3162F72A13*)il2cpp_codegen_object_new(Optional_1_t702276DAE9B7132B4ED017493544FE3162F72A13_il2cpp_TypeInfo_var);
		NullCheck(L_0);
		Optional_1__ctor_m4BCDD38353BEADF1738DB8386E39A5FE1AF02022(L_0, Optional_1__ctor_m4BCDD38353BEADF1738DB8386E39A5FE1AF02022_RuntimeMethod_var);
		// ret.SetValue((int)Convert.ToDouble(input));
		Optional_1_t702276DAE9B7132B4ED017493544FE3162F72A13* L_1 = L_0;
		RuntimeObject* L_2 = ___input0;
		il2cpp_codegen_runtime_class_init_inline(Convert_t7097FF336D592F7C06D88A98349A44646F91EFFC_il2cpp_TypeInfo_var);
		double L_3;
		L_3 = Convert_ToDouble_m86FF4F837721833186E883102C056A35F0860EB0(L_2, NULL);
		NullCheck(L_1);
		Optional_1_SetValue_mF3084568B1C3B43E1DF604DF0771558BE954DFFC(L_1, il2cpp_codegen_cast_double_to_int<int32_t>(L_3), Optional_1_SetValue_mF3084568B1C3B43E1DF604DF0771558BE954DFFC_RuntimeMethod_var);
		// return ret;
		return L_1;
	}
}
// System.Object Agora.Rtc.LitJson.JsonMapper/<>c::<RegisterCustomImporters>b__27_14(System.Object)
IL2CPP_EXTERN_C IL2CPP_METHOD_ATTR RuntimeObject* U3CU3Ec_U3CRegisterCustomImportersU3Eb__27_14_m3FB2BD06E172086E8F8FCEAACE443DC12E22D883 (U3CU3Ec_tB2417947DB790EC3B314B9BB1046B04B68400CDA* __this, RuntimeObject* ___input0, const RuntimeMethod* method) 
{
	static bool s_Il2CppMethodInitialized;
	if (!s_Il2CppMethodInitialized)
	{
		il2cpp_codegen_initialize_runtime_metadata((uintptr_t*)&Convert_t7097FF336D592F7C06D88A98349A44646F91EFFC_il2cpp_TypeInfo_var);
		il2cpp_codegen_initialize_runtime_metadata((uintptr_t*)&Optional_1_SetValue_mF3084568B1C3B43E1DF604DF0771558BE954DFFC_RuntimeMethod_var);
		il2cpp_codegen_initialize_runtime_metadata((uintptr_t*)&Optional_1__ctor_m4BCDD38353BEADF1738DB8386E39A5FE1AF02022_RuntimeMethod_var);
		il2cpp_codegen_initialize_runtime_metadata((uintptr_t*)&Optional_1_t702276DAE9B7132B4ED017493544FE3162F72A13_il2cpp_TypeInfo_var);
		s_Il2CppMethodInitialized = true;
	}
	{
		// Optional<int> ret = new Optional<int>();
		Optional_1_t702276DAE9B7132B4ED017493544FE3162F72A13* L_0 = (Optional_1_t702276DAE9B7132B4ED017493544FE3162F72A13*)il2cpp_codegen_object_new(Optional_1_t702276DAE9B7132B4ED017493544FE3162F72A13_il2cpp_TypeInfo_var);
		NullCheck(L_0);
		Optional_1__ctor_m4BCDD38353BEADF1738DB8386E39A5FE1AF02022(L_0, Optional_1__ctor_m4BCDD38353BEADF1738DB8386E39A5FE1AF02022_RuntimeMethod_var);
		// ret.SetValue((int)Convert.ToUInt64(input));
		Optional_1_t702276DAE9B7132B4ED017493544FE3162F72A13* L_1 = L_0;
		RuntimeObject* L_2 = ___input0;
		il2cpp_codegen_runtime_class_init_inline(Convert_t7097FF336D592F7C06D88A98349A44646F91EFFC_il2cpp_TypeInfo_var);
		uint64_t L_3;
		L_3 = Convert_ToUInt64_mAED581BDC2A2EC0295EC6FB7C7D525571FEA4A0B(L_2, NULL);
		NullCheck(L_1);
		Optional_1_SetValue_mF3084568B1C3B43E1DF604DF0771558BE954DFFC(L_1, ((int32_t)L_3), Optional_1_SetValue_mF3084568B1C3B43E1DF604DF0771558BE954DFFC_RuntimeMethod_var);
		// return ret;
		return L_1;
	}
}
// System.Object Agora.Rtc.LitJson.JsonMapper/<>c::<RegisterCustomImporters>b__27_15(System.Object)
IL2CPP_EXTERN_C IL2CPP_METHOD_ATTR RuntimeObject* U3CU3Ec_U3CRegisterCustomImportersU3Eb__27_15_m846D73BC18282875EB248934D8DCDD61969CF4B0 (U3CU3Ec_tB2417947DB790EC3B314B9BB1046B04B68400CDA* __this, RuntimeObject* ___input0, const RuntimeMethod* method) 
{
	static bool s_Il2CppMethodInitialized;
	if (!s_Il2CppMethodInitialized)
	{
		il2cpp_codegen_initialize_runtime_metadata((uintptr_t*)&Convert_t7097FF336D592F7C06D88A98349A44646F91EFFC_il2cpp_TypeInfo_var);
		il2cpp_codegen_initialize_runtime_metadata((uintptr_t*)&Optional_1_SetValue_mD23D4E22ECBEF9E399D3F72DD292DFBFFD63EC38_RuntimeMethod_var);
		il2cpp_codegen_initialize_runtime_metadata((uintptr_t*)&Optional_1__ctor_m56D215BBB37874E1671635AE7C29FEDA54E188DD_RuntimeMethod_var);
		il2cpp_codegen_initialize_runtime_metadata((uintptr_t*)&Optional_1_t9D1D61BD0E1BAFD11E7902319403D52C0DF276FD_il2cpp_TypeInfo_var);
		s_Il2CppMethodInitialized = true;
	}
	{
		// Optional<uint> ret = new Optional<uint>();
		Optional_1_t9D1D61BD0E1BAFD11E7902319403D52C0DF276FD* L_0 = (Optional_1_t9D1D61BD0E1BAFD11E7902319403D52C0DF276FD*)il2cpp_codegen_object_new(Optional_1_t9D1D61BD0E1BAFD11E7902319403D52C0DF276FD_il2cpp_TypeInfo_var);
		NullCheck(L_0);
		Optional_1__ctor_m56D215BBB37874E1671635AE7C29FEDA54E188DD(L_0, Optional_1__ctor_m56D215BBB37874E1671635AE7C29FEDA54E188DD_RuntimeMethod_var);
		// ret.SetValue((uint)Convert.ToInt32(input));
		Optional_1_t9D1D61BD0E1BAFD11E7902319403D52C0DF276FD* L_1 = L_0;
		RuntimeObject* L_2 = ___input0;
		il2cpp_codegen_runtime_class_init_inline(Convert_t7097FF336D592F7C06D88A98349A44646F91EFFC_il2cpp_TypeInfo_var);
		int32_t L_3;
		L_3 = Convert_ToInt32_m9FEA65DB96264479B5268014F10754787382D297(L_2, NULL);
		NullCheck(L_1);
		Optional_1_SetValue_mD23D4E22ECBEF9E399D3F72DD292DFBFFD63EC38(L_1, L_3, Optional_1_SetValue_mD23D4E22ECBEF9E399D3F72DD292DFBFFD63EC38_RuntimeMethod_var);
		// return ret;
		return L_1;
	}
}
// System.Object Agora.Rtc.LitJson.JsonMapper/<>c::<RegisterCustomImporters>b__27_16(System.Object)
IL2CPP_EXTERN_C IL2CPP_METHOD_ATTR RuntimeObject* U3CU3Ec_U3CRegisterCustomImportersU3Eb__27_16_m95BE94D53AB44C15E81D247860B78C6F8913D7A6 (U3CU3Ec_tB2417947DB790EC3B314B9BB1046B04B68400CDA* __this, RuntimeObject* ___input0, const RuntimeMethod* method) 
{
	static bool s_Il2CppMethodInitialized;
	if (!s_Il2CppMethodInitialized)
	{
		il2cpp_codegen_initialize_runtime_metadata((uintptr_t*)&Convert_t7097FF336D592F7C06D88A98349A44646F91EFFC_il2cpp_TypeInfo_var);
		il2cpp_codegen_initialize_runtime_metadata((uintptr_t*)&Optional_1_SetValue_mD23D4E22ECBEF9E399D3F72DD292DFBFFD63EC38_RuntimeMethod_var);
		il2cpp_codegen_initialize_runtime_metadata((uintptr_t*)&Optional_1__ctor_m56D215BBB37874E1671635AE7C29FEDA54E188DD_RuntimeMethod_var);
		il2cpp_codegen_initialize_runtime_metadata((uintptr_t*)&Optional_1_t9D1D61BD0E1BAFD11E7902319403D52C0DF276FD_il2cpp_TypeInfo_var);
		s_Il2CppMethodInitialized = true;
	}
	{
		// Optional<uint> ret = new Optional<uint>();
		Optional_1_t9D1D61BD0E1BAFD11E7902319403D52C0DF276FD* L_0 = (Optional_1_t9D1D61BD0E1BAFD11E7902319403D52C0DF276FD*)il2cpp_codegen_object_new(Optional_1_t9D1D61BD0E1BAFD11E7902319403D52C0DF276FD_il2cpp_TypeInfo_var);
		NullCheck(L_0);
		Optional_1__ctor_m56D215BBB37874E1671635AE7C29FEDA54E188DD(L_0, Optional_1__ctor_m56D215BBB37874E1671635AE7C29FEDA54E188DD_RuntimeMethod_var);
		// ret.SetValue((uint)Convert.ToDouble(input));
		Optional_1_t9D1D61BD0E1BAFD11E7902319403D52C0DF276FD* L_1 = L_0;
		RuntimeObject* L_2 = ___input0;
		il2cpp_codegen_runtime_class_init_inline(Convert_t7097FF336D592F7C06D88A98349A44646F91EFFC_il2cpp_TypeInfo_var);
		double L_3;
		L_3 = Convert_ToDouble_m86FF4F837721833186E883102C056A35F0860EB0(L_2, NULL);
		NullCheck(L_1);
		Optional_1_SetValue_mD23D4E22ECBEF9E399D3F72DD292DFBFFD63EC38(L_1, il2cpp_codegen_cast_floating_point<uint32_t, int32_t, double>(L_3), Optional_1_SetValue_mD23D4E22ECBEF9E399D3F72DD292DFBFFD63EC38_RuntimeMethod_var);
		// return ret;
		return L_1;
	}
}
// System.Object Agora.Rtc.LitJson.JsonMapper/<>c::<RegisterCustomImporters>b__27_17(System.Object)
IL2CPP_EXTERN_C IL2CPP_METHOD_ATTR RuntimeObject* U3CU3Ec_U3CRegisterCustomImportersU3Eb__27_17_m77F83701905C21374D5E556508276574CBC5AC26 (U3CU3Ec_tB2417947DB790EC3B314B9BB1046B04B68400CDA* __this, RuntimeObject* ___input0, const RuntimeMethod* method) 
{
	static bool s_Il2CppMethodInitialized;
	if (!s_Il2CppMethodInitialized)
	{
		il2cpp_codegen_initialize_runtime_metadata((uintptr_t*)&Convert_t7097FF336D592F7C06D88A98349A44646F91EFFC_il2cpp_TypeInfo_var);
		il2cpp_codegen_initialize_runtime_metadata((uintptr_t*)&Optional_1_SetValue_mD23D4E22ECBEF9E399D3F72DD292DFBFFD63EC38_RuntimeMethod_var);
		il2cpp_codegen_initialize_runtime_metadata((uintptr_t*)&Optional_1__ctor_m56D215BBB37874E1671635AE7C29FEDA54E188DD_RuntimeMethod_var);
		il2cpp_codegen_initialize_runtime_metadata((uintptr_t*)&Optional_1_t9D1D61BD0E1BAFD11E7902319403D52C0DF276FD_il2cpp_TypeInfo_var);
		s_Il2CppMethodInitialized = true;
	}
	{
		// Optional<uint> ret = new Optional<uint>();
		Optional_1_t9D1D61BD0E1BAFD11E7902319403D52C0DF276FD* L_0 = (Optional_1_t9D1D61BD0E1BAFD11E7902319403D52C0DF276FD*)il2cpp_codegen_object_new(Optional_1_t9D1D61BD0E1BAFD11E7902319403D52C0DF276FD_il2cpp_TypeInfo_var);
		NullCheck(L_0);
		Optional_1__ctor_m56D215BBB37874E1671635AE7C29FEDA54E188DD(L_0, Optional_1__ctor_m56D215BBB37874E1671635AE7C29FEDA54E188DD_RuntimeMethod_var);
		// ret.SetValue((uint)Convert.ToUInt64(input));
		Optional_1_t9D1D61BD0E1BAFD11E7902319403D52C0DF276FD* L_1 = L_0;
		RuntimeObject* L_2 = ___input0;
		il2cpp_codegen_runtime_class_init_inline(Convert_t7097FF336D592F7C06D88A98349A44646F91EFFC_il2cpp_TypeInfo_var);
		uint64_t L_3;
		L_3 = Convert_ToUInt64_mAED581BDC2A2EC0295EC6FB7C7D525571FEA4A0B(L_2, NULL);
		NullCheck(L_1);
		Optional_1_SetValue_mD23D4E22ECBEF9E399D3F72DD292DFBFFD63EC38(L_1, ((int32_t)(uint32_t)L_3), Optional_1_SetValue_mD23D4E22ECBEF9E399D3F72DD292DFBFFD63EC38_RuntimeMethod_var);
		// return ret;
		return L_1;
	}
}
// System.Object Agora.Rtc.LitJson.JsonMapper/<>c::<RegisterCustomImporters>b__27_18(System.Object)
IL2CPP_EXTERN_C IL2CPP_METHOD_ATTR RuntimeObject* U3CU3Ec_U3CRegisterCustomImportersU3Eb__27_18_m22487D486D49814A5BCAEFDEF4373C85FD730AC8 (U3CU3Ec_tB2417947DB790EC3B314B9BB1046B04B68400CDA* __this, RuntimeObject* ___input0, const RuntimeMethod* method) 
{
	static bool s_Il2CppMethodInitialized;
	if (!s_Il2CppMethodInitialized)
	{
		il2cpp_codegen_initialize_runtime_metadata((uintptr_t*)&Convert_t7097FF336D592F7C06D88A98349A44646F91EFFC_il2cpp_TypeInfo_var);
		il2cpp_codegen_initialize_runtime_metadata((uintptr_t*)&Optional_1_SetValue_m43C38C7D77F2E17987091551FC38C2867EB8A66F_RuntimeMethod_var);
		il2cpp_codegen_initialize_runtime_metadata((uintptr_t*)&Optional_1__ctor_m5760A6A5D2C28A6694EE100F6AFEC70D7756D2DF_RuntimeMethod_var);
		il2cpp_codegen_initialize_runtime_metadata((uintptr_t*)&Optional_1_tBB9FFF9D20636D333BC8766DBB02D617339F5001_il2cpp_TypeInfo_var);
		s_Il2CppMethodInitialized = true;
	}
	{
		// Optional<long> ret = new Optional<long>();
		Optional_1_tBB9FFF9D20636D333BC8766DBB02D617339F5001* L_0 = (Optional_1_tBB9FFF9D20636D333BC8766DBB02D617339F5001*)il2cpp_codegen_object_new(Optional_1_tBB9FFF9D20636D333BC8766DBB02D617339F5001_il2cpp_TypeInfo_var);
		NullCheck(L_0);
		Optional_1__ctor_m5760A6A5D2C28A6694EE100F6AFEC70D7756D2DF(L_0, Optional_1__ctor_m5760A6A5D2C28A6694EE100F6AFEC70D7756D2DF_RuntimeMethod_var);
		// ret.SetValue((long)Convert.ToInt32(input));
		Optional_1_tBB9FFF9D20636D333BC8766DBB02D617339F5001* L_1 = L_0;
		RuntimeObject* L_2 = ___input0;
		il2cpp_codegen_runtime_class_init_inline(Convert_t7097FF336D592F7C06D88A98349A44646F91EFFC_il2cpp_TypeInfo_var);
		int32_t L_3;
		L_3 = Convert_ToInt32_m9FEA65DB96264479B5268014F10754787382D297(L_2, NULL);
		NullCheck(L_1);
		Optional_1_SetValue_m43C38C7D77F2E17987091551FC38C2867EB8A66F(L_1, ((int64_t)L_3), Optional_1_SetValue_m43C38C7D77F2E17987091551FC38C2867EB8A66F_RuntimeMethod_var);
		// return ret;
		return L_1;
	}
}
// System.Object Agora.Rtc.LitJson.JsonMapper/<>c::<RegisterCustomImporters>b__27_19(System.Object)
IL2CPP_EXTERN_C IL2CPP_METHOD_ATTR RuntimeObject* U3CU3Ec_U3CRegisterCustomImportersU3Eb__27_19_m4FDFA491E286C911E5E6BC7DEBCDFC9479921D3F (U3CU3Ec_tB2417947DB790EC3B314B9BB1046B04B68400CDA* __this, RuntimeObject* ___input0, const RuntimeMethod* method) 
{
	static bool s_Il2CppMethodInitialized;
	if (!s_Il2CppMethodInitialized)
	{
		il2cpp_codegen_initialize_runtime_metadata((uintptr_t*)&Convert_t7097FF336D592F7C06D88A98349A44646F91EFFC_il2cpp_TypeInfo_var);
		il2cpp_codegen_initialize_runtime_metadata((uintptr_t*)&Optional_1_SetValue_m43C38C7D77F2E17987091551FC38C2867EB8A66F_RuntimeMethod_var);
		il2cpp_codegen_initialize_runtime_metadata((uintptr_t*)&Optional_1__ctor_m5760A6A5D2C28A6694EE100F6AFEC70D7756D2DF_RuntimeMethod_var);
		il2cpp_codegen_initialize_runtime_metadata((uintptr_t*)&Optional_1_tBB9FFF9D20636D333BC8766DBB02D617339F5001_il2cpp_TypeInfo_var);
		s_Il2CppMethodInitialized = true;
	}
	{
		// Optional<long> ret = new Optional<long>();
		Optional_1_tBB9FFF9D20636D333BC8766DBB02D617339F5001* L_0 = (Optional_1_tBB9FFF9D20636D333BC8766DBB02D617339F5001*)il2cpp_codegen_object_new(Optional_1_tBB9FFF9D20636D333BC8766DBB02D617339F5001_il2cpp_TypeInfo_var);
		NullCheck(L_0);
		Optional_1__ctor_m5760A6A5D2C28A6694EE100F6AFEC70D7756D2DF(L_0, Optional_1__ctor_m5760A6A5D2C28A6694EE100F6AFEC70D7756D2DF_RuntimeMethod_var);
		// ret.SetValue((long)Convert.ToDouble(input));
		Optional_1_tBB9FFF9D20636D333BC8766DBB02D617339F5001* L_1 = L_0;
		RuntimeObject* L_2 = ___input0;
		il2cpp_codegen_runtime_class_init_inline(Convert_t7097FF336D592F7C06D88A98349A44646F91EFFC_il2cpp_TypeInfo_var);
		double L_3;
		L_3 = Convert_ToDouble_m86FF4F837721833186E883102C056A35F0860EB0(L_2, NULL);
		NullCheck(L_1);
		Optional_1_SetValue_m43C38C7D77F2E17987091551FC38C2867EB8A66F(L_1, il2cpp_codegen_cast_double_to_int<int64_t>(L_3), Optional_1_SetValue_m43C38C7D77F2E17987091551FC38C2867EB8A66F_RuntimeMethod_var);
		// return ret;
		return L_1;
	}
}
// System.Object Agora.Rtc.LitJson.JsonMapper/<>c::<RegisterCustomImporters>b__27_20(System.Object)
IL2CPP_EXTERN_C IL2CPP_METHOD_ATTR RuntimeObject* U3CU3Ec_U3CRegisterCustomImportersU3Eb__27_20_mA1A8132DD7DC5160F11D4B08A673BA51035212F9 (U3CU3Ec_tB2417947DB790EC3B314B9BB1046B04B68400CDA* __this, RuntimeObject* ___input0, const RuntimeMethod* method) 
{
	static bool s_Il2CppMethodInitialized;
	if (!s_Il2CppMethodInitialized)
	{
		il2cpp_codegen_initialize_runtime_metadata((uintptr_t*)&Convert_t7097FF336D592F7C06D88A98349A44646F91EFFC_il2cpp_TypeInfo_var);
		il2cpp_codegen_initialize_runtime_metadata((uintptr_t*)&Optional_1_SetValue_m43C38C7D77F2E17987091551FC38C2867EB8A66F_RuntimeMethod_var);
		il2cpp_codegen_initialize_runtime_metadata((uintptr_t*)&Optional_1__ctor_m5760A6A5D2C28A6694EE100F6AFEC70D7756D2DF_RuntimeMethod_var);
		il2cpp_codegen_initialize_runtime_metadata((uintptr_t*)&Optional_1_tBB9FFF9D20636D333BC8766DBB02D617339F5001_il2cpp_TypeInfo_var);
		s_Il2CppMethodInitialized = true;
	}
	{
		// Optional<long> ret = new Optional<long>();
		Optional_1_tBB9FFF9D20636D333BC8766DBB02D617339F5001* L_0 = (Optional_1_tBB9FFF9D20636D333BC8766DBB02D617339F5001*)il2cpp_codegen_object_new(Optional_1_tBB9FFF9D20636D333BC8766DBB02D617339F5001_il2cpp_TypeInfo_var);
		NullCheck(L_0);
		Optional_1__ctor_m5760A6A5D2C28A6694EE100F6AFEC70D7756D2DF(L_0, Optional_1__ctor_m5760A6A5D2C28A6694EE100F6AFEC70D7756D2DF_RuntimeMethod_var);
		// ret.SetValue((long)Convert.ToUInt64(input));
		Optional_1_tBB9FFF9D20636D333BC8766DBB02D617339F5001* L_1 = L_0;
		RuntimeObject* L_2 = ___input0;
		il2cpp_codegen_runtime_class_init_inline(Convert_t7097FF336D592F7C06D88A98349A44646F91EFFC_il2cpp_TypeInfo_var);
		uint64_t L_3;
		L_3 = Convert_ToUInt64_mAED581BDC2A2EC0295EC6FB7C7D525571FEA4A0B(L_2, NULL);
		NullCheck(L_1);
		Optional_1_SetValue_m43C38C7D77F2E17987091551FC38C2867EB8A66F(L_1, L_3, Optional_1_SetValue_m43C38C7D77F2E17987091551FC38C2867EB8A66F_RuntimeMethod_var);
		// return ret;
		return L_1;
	}
}
// System.Object Agora.Rtc.LitJson.JsonMapper/<>c::<RegisterCustomImporters>b__27_21(System.Object)
IL2CPP_EXTERN_C IL2CPP_METHOD_ATTR RuntimeObject* U3CU3Ec_U3CRegisterCustomImportersU3Eb__27_21_mF29B8F3002837B919723BE1D2EAB3897B4213523 (U3CU3Ec_tB2417947DB790EC3B314B9BB1046B04B68400CDA* __this, RuntimeObject* ___input0, const RuntimeMethod* method) 
{
	static bool s_Il2CppMethodInitialized;
	if (!s_Il2CppMethodInitialized)
	{
		il2cpp_codegen_initialize_runtime_metadata((uintptr_t*)&Convert_t7097FF336D592F7C06D88A98349A44646F91EFFC_il2cpp_TypeInfo_var);
		il2cpp_codegen_initialize_runtime_metadata((uintptr_t*)&Optional_1_SetValue_m4536867BC951C653111124BBB2F692D695165773_RuntimeMethod_var);
		il2cpp_codegen_initialize_runtime_metadata((uintptr_t*)&Optional_1__ctor_m79B26B02B0FF0383EC85B8E2E045C2C5B97A45D1_RuntimeMethod_var);
		il2cpp_codegen_initialize_runtime_metadata((uintptr_t*)&Optional_1_tD8A059C84DFD90B30DB7B4CAC4A0C5F232084498_il2cpp_TypeInfo_var);
		s_Il2CppMethodInitialized = true;
	}
	{
		// Optional<ulong> ret = new Optional<ulong>();
		Optional_1_tD8A059C84DFD90B30DB7B4CAC4A0C5F232084498* L_0 = (Optional_1_tD8A059C84DFD90B30DB7B4CAC4A0C5F232084498*)il2cpp_codegen_object_new(Optional_1_tD8A059C84DFD90B30DB7B4CAC4A0C5F232084498_il2cpp_TypeInfo_var);
		NullCheck(L_0);
		Optional_1__ctor_m79B26B02B0FF0383EC85B8E2E045C2C5B97A45D1(L_0, Optional_1__ctor_m79B26B02B0FF0383EC85B8E2E045C2C5B97A45D1_RuntimeMethod_var);
		// ret.SetValue((ulong)Convert.ToInt32(input));
		Optional_1_tD8A059C84DFD90B30DB7B4CAC4A0C5F232084498* L_1 = L_0;
		RuntimeObject* L_2 = ___input0;
		il2cpp_codegen_runtime_class_init_inline(Convert_t7097FF336D592F7C06D88A98349A44646F91EFFC_il2cpp_TypeInfo_var);
		int32_t L_3;
		L_3 = Convert_ToInt32_m9FEA65DB96264479B5268014F10754787382D297(L_2, NULL);
		NullCheck(L_1);
		Optional_1_SetValue_m4536867BC951C653111124BBB2F692D695165773(L_1, ((int64_t)L_3), Optional_1_SetValue_m4536867BC951C653111124BBB2F692D695165773_RuntimeMethod_var);
		// return ret;
		return L_1;
	}
}
// System.Object Agora.Rtc.LitJson.JsonMapper/<>c::<RegisterCustomImporters>b__27_22(System.Object)
IL2CPP_EXTERN_C IL2CPP_METHOD_ATTR RuntimeObject* U3CU3Ec_U3CRegisterCustomImportersU3Eb__27_22_mEFD9BA7AF9E1FE71416683C8C96CE019324968ED (U3CU3Ec_tB2417947DB790EC3B314B9BB1046B04B68400CDA* __this, RuntimeObject* ___input0, const RuntimeMethod* method) 
{
	static bool s_Il2CppMethodInitialized;
	if (!s_Il2CppMethodInitialized)
	{
		il2cpp_codegen_initialize_runtime_metadata((uintptr_t*)&Convert_t7097FF336D592F7C06D88A98349A44646F91EFFC_il2cpp_TypeInfo_var);
		il2cpp_codegen_initialize_runtime_metadata((uintptr_t*)&Optional_1_SetValue_m4536867BC951C653111124BBB2F692D695165773_RuntimeMethod_var);
		il2cpp_codegen_initialize_runtime_metadata((uintptr_t*)&Optional_1__ctor_m79B26B02B0FF0383EC85B8E2E045C2C5B97A45D1_RuntimeMethod_var);
		il2cpp_codegen_initialize_runtime_metadata((uintptr_t*)&Optional_1_tD8A059C84DFD90B30DB7B4CAC4A0C5F232084498_il2cpp_TypeInfo_var);
		s_Il2CppMethodInitialized = true;
	}
	{
		// Optional<ulong> ret = new Optional<ulong>();
		Optional_1_tD8A059C84DFD90B30DB7B4CAC4A0C5F232084498* L_0 = (Optional_1_tD8A059C84DFD90B30DB7B4CAC4A0C5F232084498*)il2cpp_codegen_object_new(Optional_1_tD8A059C84DFD90B30DB7B4CAC4A0C5F232084498_il2cpp_TypeInfo_var);
		NullCheck(L_0);
		Optional_1__ctor_m79B26B02B0FF0383EC85B8E2E045C2C5B97A45D1(L_0, Optional_1__ctor_m79B26B02B0FF0383EC85B8E2E045C2C5B97A45D1_RuntimeMethod_var);
		// ret.SetValue((ulong)Convert.ToDouble(input));
		Optional_1_tD8A059C84DFD90B30DB7B4CAC4A0C5F232084498* L_1 = L_0;
		RuntimeObject* L_2 = ___input0;
		il2cpp_codegen_runtime_class_init_inline(Convert_t7097FF336D592F7C06D88A98349A44646F91EFFC_il2cpp_TypeInfo_var);
		double L_3;
		L_3 = Convert_ToDouble_m86FF4F837721833186E883102C056A35F0860EB0(L_2, NULL);
		NullCheck(L_1);
		Optional_1_SetValue_m4536867BC951C653111124BBB2F692D695165773(L_1, il2cpp_codegen_cast_floating_point<uint64_t, int64_t, double>(L_3), Optional_1_SetValue_m4536867BC951C653111124BBB2F692D695165773_RuntimeMethod_var);
		// return ret;
		return L_1;
	}
}
// System.Object Agora.Rtc.LitJson.JsonMapper/<>c::<RegisterCustomImporters>b__27_23(System.Object)
IL2CPP_EXTERN_C IL2CPP_METHOD_ATTR RuntimeObject* U3CU3Ec_U3CRegisterCustomImportersU3Eb__27_23_m70AFE05F3E6903018A51864A719E51C5EE29071C (U3CU3Ec_tB2417947DB790EC3B314B9BB1046B04B68400CDA* __this, RuntimeObject* ___input0, const RuntimeMethod* method) 
{
	static bool s_Il2CppMethodInitialized;
	if (!s_Il2CppMethodInitialized)
	{
		il2cpp_codegen_initialize_runtime_metadata((uintptr_t*)&Convert_t7097FF336D592F7C06D88A98349A44646F91EFFC_il2cpp_TypeInfo_var);
		il2cpp_codegen_initialize_runtime_metadata((uintptr_t*)&Optional_1_SetValue_m4536867BC951C653111124BBB2F692D695165773_RuntimeMethod_var);
		il2cpp_codegen_initialize_runtime_metadata((uintptr_t*)&Optional_1__ctor_m79B26B02B0FF0383EC85B8E2E045C2C5B97A45D1_RuntimeMethod_var);
		il2cpp_codegen_initialize_runtime_metadata((uintptr_t*)&Optional_1_tD8A059C84DFD90B30DB7B4CAC4A0C5F232084498_il2cpp_TypeInfo_var);
		s_Il2CppMethodInitialized = true;
	}
	{
		// Optional<ulong> ret = new Optional<ulong>();
		Optional_1_tD8A059C84DFD90B30DB7B4CAC4A0C5F232084498* L_0 = (Optional_1_tD8A059C84DFD90B30DB7B4CAC4A0C5F232084498*)il2cpp_codegen_object_new(Optional_1_tD8A059C84DFD90B30DB7B4CAC4A0C5F232084498_il2cpp_TypeInfo_var);
		NullCheck(L_0);
		Optional_1__ctor_m79B26B02B0FF0383EC85B8E2E045C2C5B97A45D1(L_0, Optional_1__ctor_m79B26B02B0FF0383EC85B8E2E045C2C5B97A45D1_RuntimeMethod_var);
		// ret.SetValue((ulong)Convert.ToUInt64(input));
		Optional_1_tD8A059C84DFD90B30DB7B4CAC4A0C5F232084498* L_1 = L_0;
		RuntimeObject* L_2 = ___input0;
		il2cpp_codegen_runtime_class_init_inline(Convert_t7097FF336D592F7C06D88A98349A44646F91EFFC_il2cpp_TypeInfo_var);
		uint64_t L_3;
		L_3 = Convert_ToUInt64_mAED581BDC2A2EC0295EC6FB7C7D525571FEA4A0B(L_2, NULL);
		NullCheck(L_1);
		Optional_1_SetValue_m4536867BC951C653111124BBB2F692D695165773(L_1, L_3, Optional_1_SetValue_m4536867BC951C653111124BBB2F692D695165773_RuntimeMethod_var);
		// return ret;
		return L_1;
	}
}
// System.Object Agora.Rtc.LitJson.JsonMapper/<>c::<RegisterCustomImporters>b__27_24(System.Object)
IL2CPP_EXTERN_C IL2CPP_METHOD_ATTR RuntimeObject* U3CU3Ec_U3CRegisterCustomImportersU3Eb__27_24_m24145D4EC70B2E0CAD5A9B9A2D7D0014A87BEF04 (U3CU3Ec_tB2417947DB790EC3B314B9BB1046B04B68400CDA* __this, RuntimeObject* ___input0, const RuntimeMethod* method) 
{
	static bool s_Il2CppMethodInitialized;
	if (!s_Il2CppMethodInitialized)
	{
		il2cpp_codegen_initialize_runtime_metadata((uintptr_t*)&Convert_t7097FF336D592F7C06D88A98349A44646F91EFFC_il2cpp_TypeInfo_var);
		il2cpp_codegen_initialize_runtime_metadata((uintptr_t*)&Optional_1_SetValue_mE51373D626F7E164049DB4371067C33F9229DC80_RuntimeMethod_var);
		il2cpp_codegen_initialize_runtime_metadata((uintptr_t*)&Optional_1__ctor_m2ADDAA3E2FF62251E6B96683AC3D58EC6E8CE0AA_RuntimeMethod_var);
		il2cpp_codegen_initialize_runtime_metadata((uintptr_t*)&Optional_1_t5ECCECA11C3EA2B3D72FC80C3EEC85F541294665_il2cpp_TypeInfo_var);
		s_Il2CppMethodInitialized = true;
	}
	{
		// Optional<bool> ret = new Optional<bool>();
		Optional_1_t5ECCECA11C3EA2B3D72FC80C3EEC85F541294665* L_0 = (Optional_1_t5ECCECA11C3EA2B3D72FC80C3EEC85F541294665*)il2cpp_codegen_object_new(Optional_1_t5ECCECA11C3EA2B3D72FC80C3EEC85F541294665_il2cpp_TypeInfo_var);
		NullCheck(L_0);
		Optional_1__ctor_m2ADDAA3E2FF62251E6B96683AC3D58EC6E8CE0AA(L_0, Optional_1__ctor_m2ADDAA3E2FF62251E6B96683AC3D58EC6E8CE0AA_RuntimeMethod_var);
		// ret.SetValue((bool)Convert.ToBoolean(input));
		Optional_1_t5ECCECA11C3EA2B3D72FC80C3EEC85F541294665* L_1 = L_0;
		RuntimeObject* L_2 = ___input0;
		il2cpp_codegen_runtime_class_init_inline(Convert_t7097FF336D592F7C06D88A98349A44646F91EFFC_il2cpp_TypeInfo_var);
		bool L_3;
		L_3 = Convert_ToBoolean_m35ABFE9171C8E44E23C95CD872DFEF2F2B643214(L_2, NULL);
		NullCheck(L_1);
		Optional_1_SetValue_mE51373D626F7E164049DB4371067C33F9229DC80(L_1, L_3, Optional_1_SetValue_mE51373D626F7E164049DB4371067C33F9229DC80_RuntimeMethod_var);
		// return ret;
		return L_1;
	}
}
// System.Object Agora.Rtc.LitJson.JsonMapper/<>c::<RegisterCustomImporters>b__27_25(System.Object)
IL2CPP_EXTERN_C IL2CPP_METHOD_ATTR RuntimeObject* U3CU3Ec_U3CRegisterCustomImportersU3Eb__27_25_m2CF7E9E62C75CCABCC43F1B5E3406DFBA4DC12B0 (U3CU3Ec_tB2417947DB790EC3B314B9BB1046B04B68400CDA* __this, RuntimeObject* ___input0, const RuntimeMethod* method) 
{
	static bool s_Il2CppMethodInitialized;
	if (!s_Il2CppMethodInitialized)
	{
		il2cpp_codegen_initialize_runtime_metadata((uintptr_t*)&Convert_t7097FF336D592F7C06D88A98349A44646F91EFFC_il2cpp_TypeInfo_var);
		il2cpp_codegen_initialize_runtime_metadata((uintptr_t*)&Optional_1_SetValue_mB47C082042F2A87BF323DF623B36F42D9E9D7F57_RuntimeMethod_var);
		il2cpp_codegen_initialize_runtime_metadata((uintptr_t*)&Optional_1__ctor_mA5DC848AD987E18C01F59A7A5289BAD0E6BCE9D2_RuntimeMethod_var);
		il2cpp_codegen_initialize_runtime_metadata((uintptr_t*)&Optional_1_t3CE97B858328B754CADD94F152EB4D1D51932DB4_il2cpp_TypeInfo_var);
		s_Il2CppMethodInitialized = true;
	}
	{
		// Optional<string> ret = new Optional<string>();
		Optional_1_t3CE97B858328B754CADD94F152EB4D1D51932DB4* L_0 = (Optional_1_t3CE97B858328B754CADD94F152EB4D1D51932DB4*)il2cpp_codegen_object_new(Optional_1_t3CE97B858328B754CADD94F152EB4D1D51932DB4_il2cpp_TypeInfo_var);
		NullCheck(L_0);
		Optional_1__ctor_mA5DC848AD987E18C01F59A7A5289BAD0E6BCE9D2(L_0, Optional_1__ctor_mA5DC848AD987E18C01F59A7A5289BAD0E6BCE9D2_RuntimeMethod_var);
		// ret.SetValue((string)Convert.ToString(input));
		Optional_1_t3CE97B858328B754CADD94F152EB4D1D51932DB4* L_1 = L_0;
		RuntimeObject* L_2 = ___input0;
		il2cpp_codegen_runtime_class_init_inline(Convert_t7097FF336D592F7C06D88A98349A44646F91EFFC_il2cpp_TypeInfo_var);
		String_t* L_3;
		L_3 = Convert_ToString_m03249561BBE153E4ED7E2E130ECC65F08B322261(L_2, NULL);
		NullCheck(L_1);
		Optional_1_SetValue_mB47C082042F2A87BF323DF623B36F42D9E9D7F57(L_1, L_3, Optional_1_SetValue_mB47C082042F2A87BF323DF623B36F42D9E9D7F57_RuntimeMethod_var);
		// return ret;
		return L_1;
	}
}
// System.Object Agora.Rtc.LitJson.JsonMapper/<>c::<RegisterCustomImporters>b__27_26(System.Object)
IL2CPP_EXTERN_C IL2CPP_METHOD_ATTR RuntimeObject* U3CU3Ec_U3CRegisterCustomImportersU3Eb__27_26_m2C0F3C6B0288E34290C4656681B987BEF9397A7B (U3CU3Ec_tB2417947DB790EC3B314B9BB1046B04B68400CDA* __this, RuntimeObject* ___input0, const RuntimeMethod* method) 
{
	static bool s_Il2CppMethodInitialized;
	if (!s_Il2CppMethodInitialized)
	{
		il2cpp_codegen_initialize_runtime_metadata((uintptr_t*)&Convert_t7097FF336D592F7C06D88A98349A44646F91EFFC_il2cpp_TypeInfo_var);
		il2cpp_codegen_initialize_runtime_metadata((uintptr_t*)&Optional_1_SetValue_m9F830E4C0FE451B2678B622ABD1354E73E885BB3_RuntimeMethod_var);
		il2cpp_codegen_initialize_runtime_metadata((uintptr_t*)&Optional_1__ctor_m5DC885CD5B69591EB08A40E04FA0FC5614236845_RuntimeMethod_var);
		il2cpp_codegen_initialize_runtime_metadata((uintptr_t*)&Optional_1_t5C8656A1B957381763DED81AE837B5564B6B338C_il2cpp_TypeInfo_var);
		s_Il2CppMethodInitialized = true;
	}
	{
		// Optional<CLIENT_ROLE_TYPE> ret = new Optional<CLIENT_ROLE_TYPE>();
		Optional_1_t5C8656A1B957381763DED81AE837B5564B6B338C* L_0 = (Optional_1_t5C8656A1B957381763DED81AE837B5564B6B338C*)il2cpp_codegen_object_new(Optional_1_t5C8656A1B957381763DED81AE837B5564B6B338C_il2cpp_TypeInfo_var);
		NullCheck(L_0);
		Optional_1__ctor_m5DC885CD5B69591EB08A40E04FA0FC5614236845(L_0, Optional_1__ctor_m5DC885CD5B69591EB08A40E04FA0FC5614236845_RuntimeMethod_var);
		// ret.SetValue((CLIENT_ROLE_TYPE)Convert.ToInt16(input));
		Optional_1_t5C8656A1B957381763DED81AE837B5564B6B338C* L_1 = L_0;
		RuntimeObject* L_2 = ___input0;
		il2cpp_codegen_runtime_class_init_inline(Convert_t7097FF336D592F7C06D88A98349A44646F91EFFC_il2cpp_TypeInfo_var);
		int16_t L_3;
		L_3 = Convert_ToInt16_mD8FC1332F5EA5618C3765BA1EB756406A10FDDA6(L_2, NULL);
		NullCheck(L_1);
		Optional_1_SetValue_m9F830E4C0FE451B2678B622ABD1354E73E885BB3(L_1, L_3, Optional_1_SetValue_m9F830E4C0FE451B2678B622ABD1354E73E885BB3_RuntimeMethod_var);
		// return ret;
		return L_1;
	}
}
// System.Object Agora.Rtc.LitJson.JsonMapper/<>c::<RegisterCustomImporters>b__27_27(System.Object)
IL2CPP_EXTERN_C IL2CPP_METHOD_ATTR RuntimeObject* U3CU3Ec_U3CRegisterCustomImportersU3Eb__27_27_m865A721F1AEBB886984DE5FC746CA8BA1B8BFDAF (U3CU3Ec_tB2417947DB790EC3B314B9BB1046B04B68400CDA* __this, RuntimeObject* ___input0, const RuntimeMethod* method) 
{
	static bool s_Il2CppMethodInitialized;
	if (!s_Il2CppMethodInitialized)
	{
		il2cpp_codegen_initialize_runtime_metadata((uintptr_t*)&Convert_t7097FF336D592F7C06D88A98349A44646F91EFFC_il2cpp_TypeInfo_var);
		il2cpp_codegen_initialize_runtime_metadata((uintptr_t*)&Optional_1_SetValue_m9F830E4C0FE451B2678B622ABD1354E73E885BB3_RuntimeMethod_var);
		il2cpp_codegen_initialize_runtime_metadata((uintptr_t*)&Optional_1__ctor_m5DC885CD5B69591EB08A40E04FA0FC5614236845_RuntimeMethod_var);
		il2cpp_codegen_initialize_runtime_metadata((uintptr_t*)&Optional_1_t5C8656A1B957381763DED81AE837B5564B6B338C_il2cpp_TypeInfo_var);
		s_Il2CppMethodInitialized = true;
	}
	{
		// Optional<CLIENT_ROLE_TYPE> ret = new Optional<CLIENT_ROLE_TYPE>();
		Optional_1_t5C8656A1B957381763DED81AE837B5564B6B338C* L_0 = (Optional_1_t5C8656A1B957381763DED81AE837B5564B6B338C*)il2cpp_codegen_object_new(Optional_1_t5C8656A1B957381763DED81AE837B5564B6B338C_il2cpp_TypeInfo_var);
		NullCheck(L_0);
		Optional_1__ctor_m5DC885CD5B69591EB08A40E04FA0FC5614236845(L_0, Optional_1__ctor_m5DC885CD5B69591EB08A40E04FA0FC5614236845_RuntimeMethod_var);
		// ret.SetValue((CLIENT_ROLE_TYPE)Convert.ToUInt64(input));
		Optional_1_t5C8656A1B957381763DED81AE837B5564B6B338C* L_1 = L_0;
		RuntimeObject* L_2 = ___input0;
		il2cpp_codegen_runtime_class_init_inline(Convert_t7097FF336D592F7C06D88A98349A44646F91EFFC_il2cpp_TypeInfo_var);
		uint64_t L_3;
		L_3 = Convert_ToUInt64_mAED581BDC2A2EC0295EC6FB7C7D525571FEA4A0B(L_2, NULL);
		NullCheck(L_1);
		Optional_1_SetValue_m9F830E4C0FE451B2678B622ABD1354E73E885BB3(L_1, ((int32_t)L_3), Optional_1_SetValue_m9F830E4C0FE451B2678B622ABD1354E73E885BB3_RuntimeMethod_var);
		// return ret;
		return L_1;
	}
}
// System.Object Agora.Rtc.LitJson.JsonMapper/<>c::<RegisterCustomImporters>b__27_28(System.Object)
IL2CPP_EXTERN_C IL2CPP_METHOD_ATTR RuntimeObject* U3CU3Ec_U3CRegisterCustomImportersU3Eb__27_28_m64402964AB52CEB6B35DD16C9C1A4D2D8B5C610E (U3CU3Ec_tB2417947DB790EC3B314B9BB1046B04B68400CDA* __this, RuntimeObject* ___input0, const RuntimeMethod* method) 
{
	static bool s_Il2CppMethodInitialized;
	if (!s_Il2CppMethodInitialized)
	{
		il2cpp_codegen_initialize_runtime_metadata((uintptr_t*)&Convert_t7097FF336D592F7C06D88A98349A44646F91EFFC_il2cpp_TypeInfo_var);
		il2cpp_codegen_initialize_runtime_metadata((uintptr_t*)&Optional_1_SetValue_mFAD6E19EFE099CD86FA9A55C3185DE2351661769_RuntimeMethod_var);
		il2cpp_codegen_initialize_runtime_metadata((uintptr_t*)&Optional_1__ctor_mE3FEC568347BCA235ECDF84A661CA953A0C3E6EC_RuntimeMethod_var);
		il2cpp_codegen_initialize_runtime_metadata((uintptr_t*)&Optional_1_t3D985A7F63673DFB7B5DCD8CE9EE622EABB76D1F_il2cpp_TypeInfo_var);
		s_Il2CppMethodInitialized = true;
	}
	{
		// Optional<AUDIENCE_LATENCY_LEVEL_TYPE> ret = new Optional<AUDIENCE_LATENCY_LEVEL_TYPE>();
		Optional_1_t3D985A7F63673DFB7B5DCD8CE9EE622EABB76D1F* L_0 = (Optional_1_t3D985A7F63673DFB7B5DCD8CE9EE622EABB76D1F*)il2cpp_codegen_object_new(Optional_1_t3D985A7F63673DFB7B5DCD8CE9EE622EABB76D1F_il2cpp_TypeInfo_var);
		NullCheck(L_0);
		Optional_1__ctor_mE3FEC568347BCA235ECDF84A661CA953A0C3E6EC(L_0, Optional_1__ctor_mE3FEC568347BCA235ECDF84A661CA953A0C3E6EC_RuntimeMethod_var);
		// ret.SetValue((AUDIENCE_LATENCY_LEVEL_TYPE)Convert.ToInt16(input));
		Optional_1_t3D985A7F63673DFB7B5DCD8CE9EE622EABB76D1F* L_1 = L_0;
		RuntimeObject* L_2 = ___input0;
		il2cpp_codegen_runtime_class_init_inline(Convert_t7097FF336D592F7C06D88A98349A44646F91EFFC_il2cpp_TypeInfo_var);
		int16_t L_3;
		L_3 = Convert_ToInt16_mD8FC1332F5EA5618C3765BA1EB756406A10FDDA6(L_2, NULL);
		NullCheck(L_1);
		Optional_1_SetValue_mFAD6E19EFE099CD86FA9A55C3185DE2351661769(L_1, L_3, Optional_1_SetValue_mFAD6E19EFE099CD86FA9A55C3185DE2351661769_RuntimeMethod_var);
		// return ret;
		return L_1;
	}
}
// System.Object Agora.Rtc.LitJson.JsonMapper/<>c::<RegisterCustomImporters>b__27_29(System.Object)
IL2CPP_EXTERN_C IL2CPP_METHOD_ATTR RuntimeObject* U3CU3Ec_U3CRegisterCustomImportersU3Eb__27_29_mECC9FC951EDE70D941405DB6B377A7ABAF825422 (U3CU3Ec_tB2417947DB790EC3B314B9BB1046B04B68400CDA* __this, RuntimeObject* ___input0, const RuntimeMethod* method) 
{
	static bool s_Il2CppMethodInitialized;
	if (!s_Il2CppMethodInitialized)
	{
		il2cpp_codegen_initialize_runtime_metadata((uintptr_t*)&Convert_t7097FF336D592F7C06D88A98349A44646F91EFFC_il2cpp_TypeInfo_var);
		il2cpp_codegen_initialize_runtime_metadata((uintptr_t*)&Optional_1_SetValue_mFAD6E19EFE099CD86FA9A55C3185DE2351661769_RuntimeMethod_var);
		il2cpp_codegen_initialize_runtime_metadata((uintptr_t*)&Optional_1__ctor_mE3FEC568347BCA235ECDF84A661CA953A0C3E6EC_RuntimeMethod_var);
		il2cpp_codegen_initialize_runtime_metadata((uintptr_t*)&Optional_1_t3D985A7F63673DFB7B5DCD8CE9EE622EABB76D1F_il2cpp_TypeInfo_var);
		s_Il2CppMethodInitialized = true;
	}
	{
		// Optional<AUDIENCE_LATENCY_LEVEL_TYPE> ret = new Optional<AUDIENCE_LATENCY_LEVEL_TYPE>();
		Optional_1_t3D985A7F63673DFB7B5DCD8CE9EE622EABB76D1F* L_0 = (Optional_1_t3D985A7F63673DFB7B5DCD8CE9EE622EABB76D1F*)il2cpp_codegen_object_new(Optional_1_t3D985A7F63673DFB7B5DCD8CE9EE622EABB76D1F_il2cpp_TypeInfo_var);
		NullCheck(L_0);
		Optional_1__ctor_mE3FEC568347BCA235ECDF84A661CA953A0C3E6EC(L_0, Optional_1__ctor_mE3FEC568347BCA235ECDF84A661CA953A0C3E6EC_RuntimeMethod_var);
		// ret.SetValue((AUDIENCE_LATENCY_LEVEL_TYPE)Convert.ToUInt64(input));
		Optional_1_t3D985A7F63673DFB7B5DCD8CE9EE622EABB76D1F* L_1 = L_0;
		RuntimeObject* L_2 = ___input0;
		il2cpp_codegen_runtime_class_init_inline(Convert_t7097FF336D592F7C06D88A98349A44646F91EFFC_il2cpp_TypeInfo_var);
		uint64_t L_3;
		L_3 = Convert_ToUInt64_mAED581BDC2A2EC0295EC6FB7C7D525571FEA4A0B(L_2, NULL);
		NullCheck(L_1);
		Optional_1_SetValue_mFAD6E19EFE099CD86FA9A55C3185DE2351661769(L_1, ((int32_t)L_3), Optional_1_SetValue_mFAD6E19EFE099CD86FA9A55C3185DE2351661769_RuntimeMethod_var);
		// return ret;
		return L_1;
	}
}
// System.Object Agora.Rtc.LitJson.JsonMapper/<>c::<RegisterCustomImporters>b__27_30(System.Object)
IL2CPP_EXTERN_C IL2CPP_METHOD_ATTR RuntimeObject* U3CU3Ec_U3CRegisterCustomImportersU3Eb__27_30_mA38D3A0AA60288909582DDC8314ABAE9C487FACE (U3CU3Ec_tB2417947DB790EC3B314B9BB1046B04B68400CDA* __this, RuntimeObject* ___input0, const RuntimeMethod* method) 
{
	static bool s_Il2CppMethodInitialized;
	if (!s_Il2CppMethodInitialized)
	{
		il2cpp_codegen_initialize_runtime_metadata((uintptr_t*)&Convert_t7097FF336D592F7C06D88A98349A44646F91EFFC_il2cpp_TypeInfo_var);
		il2cpp_codegen_initialize_runtime_metadata((uintptr_t*)&Optional_1_SetValue_m4DA972A9DB7CD324E7EAB9E82D7A394EAAC7C4CC_RuntimeMethod_var);
		il2cpp_codegen_initialize_runtime_metadata((uintptr_t*)&Optional_1__ctor_mEC9461341FDABED29A99326920E7090D70BD3901_RuntimeMethod_var);
		il2cpp_codegen_initialize_runtime_metadata((uintptr_t*)&Optional_1_tC5AB3A88C37AF5FA76EC96E7F6256F299BBA4827_il2cpp_TypeInfo_var);
		s_Il2CppMethodInitialized = true;
	}
	{
		// Optional<VIDEO_STREAM_TYPE> ret = new Optional<VIDEO_STREAM_TYPE>();
		Optional_1_tC5AB3A88C37AF5FA76EC96E7F6256F299BBA4827* L_0 = (Optional_1_tC5AB3A88C37AF5FA76EC96E7F6256F299BBA4827*)il2cpp_codegen_object_new(Optional_1_tC5AB3A88C37AF5FA76EC96E7F6256F299BBA4827_il2cpp_TypeInfo_var);
		NullCheck(L_0);
		Optional_1__ctor_mEC9461341FDABED29A99326920E7090D70BD3901(L_0, Optional_1__ctor_mEC9461341FDABED29A99326920E7090D70BD3901_RuntimeMethod_var);
		// ret.SetValue((VIDEO_STREAM_TYPE)Convert.ToInt16(input));
		Optional_1_tC5AB3A88C37AF5FA76EC96E7F6256F299BBA4827* L_1 = L_0;
		RuntimeObject* L_2 = ___input0;
		il2cpp_codegen_runtime_class_init_inline(Convert_t7097FF336D592F7C06D88A98349A44646F91EFFC_il2cpp_TypeInfo_var);
		int16_t L_3;
		L_3 = Convert_ToInt16_mD8FC1332F5EA5618C3765BA1EB756406A10FDDA6(L_2, NULL);
		NullCheck(L_1);
		Optional_1_SetValue_m4DA972A9DB7CD324E7EAB9E82D7A394EAAC7C4CC(L_1, L_3, Optional_1_SetValue_m4DA972A9DB7CD324E7EAB9E82D7A394EAAC7C4CC_RuntimeMethod_var);
		// return ret;
		return L_1;
	}
}
// System.Object Agora.Rtc.LitJson.JsonMapper/<>c::<RegisterCustomImporters>b__27_31(System.Object)
IL2CPP_EXTERN_C IL2CPP_METHOD_ATTR RuntimeObject* U3CU3Ec_U3CRegisterCustomImportersU3Eb__27_31_mA94A688E0AB59396545973F882C3BBA39D8D99D6 (U3CU3Ec_tB2417947DB790EC3B314B9BB1046B04B68400CDA* __this, RuntimeObject* ___input0, const RuntimeMethod* method) 
{
	static bool s_Il2CppMethodInitialized;
	if (!s_Il2CppMethodInitialized)
	{
		il2cpp_codegen_initialize_runtime_metadata((uintptr_t*)&Convert_t7097FF336D592F7C06D88A98349A44646F91EFFC_il2cpp_TypeInfo_var);
		il2cpp_codegen_initialize_runtime_metadata((uintptr_t*)&Optional_1_SetValue_m4DA972A9DB7CD324E7EAB9E82D7A394EAAC7C4CC_RuntimeMethod_var);
		il2cpp_codegen_initialize_runtime_metadata((uintptr_t*)&Optional_1__ctor_mEC9461341FDABED29A99326920E7090D70BD3901_RuntimeMethod_var);
		il2cpp_codegen_initialize_runtime_metadata((uintptr_t*)&Optional_1_tC5AB3A88C37AF5FA76EC96E7F6256F299BBA4827_il2cpp_TypeInfo_var);
		s_Il2CppMethodInitialized = true;
	}
	{
		// Optional<VIDEO_STREAM_TYPE> ret = new Optional<VIDEO_STREAM_TYPE>();
		Optional_1_tC5AB3A88C37AF5FA76EC96E7F6256F299BBA4827* L_0 = (Optional_1_tC5AB3A88C37AF5FA76EC96E7F6256F299BBA4827*)il2cpp_codegen_object_new(Optional_1_tC5AB3A88C37AF5FA76EC96E7F6256F299BBA4827_il2cpp_TypeInfo_var);
		NullCheck(L_0);
		Optional_1__ctor_mEC9461341FDABED29A99326920E7090D70BD3901(L_0, Optional_1__ctor_mEC9461341FDABED29A99326920E7090D70BD3901_RuntimeMethod_var);
		// ret.SetValue((VIDEO_STREAM_TYPE)Convert.ToUInt64(input));
		Optional_1_tC5AB3A88C37AF5FA76EC96E7F6256F299BBA4827* L_1 = L_0;
		RuntimeObject* L_2 = ___input0;
		il2cpp_codegen_runtime_class_init_inline(Convert_t7097FF336D592F7C06D88A98349A44646F91EFFC_il2cpp_TypeInfo_var);
		uint64_t L_3;
		L_3 = Convert_ToUInt64_mAED581BDC2A2EC0295EC6FB7C7D525571FEA4A0B(L_2, NULL);
		NullCheck(L_1);
		Optional_1_SetValue_m4DA972A9DB7CD324E7EAB9E82D7A394EAAC7C4CC(L_1, ((int32_t)L_3), Optional_1_SetValue_m4DA972A9DB7CD324E7EAB9E82D7A394EAAC7C4CC_RuntimeMethod_var);
		// return ret;
		return L_1;
	}
}
// System.Object Agora.Rtc.LitJson.JsonMapper/<>c::<RegisterCustomImporters>b__27_32(System.Object)
IL2CPP_EXTERN_C IL2CPP_METHOD_ATTR RuntimeObject* U3CU3Ec_U3CRegisterCustomImportersU3Eb__27_32_mDC9C8E6B941FA3F5137B3607132932CD1C84A0D9 (U3CU3Ec_tB2417947DB790EC3B314B9BB1046B04B68400CDA* __this, RuntimeObject* ___input0, const RuntimeMethod* method) 
{
	static bool s_Il2CppMethodInitialized;
	if (!s_Il2CppMethodInitialized)
	{
		il2cpp_codegen_initialize_runtime_metadata((uintptr_t*)&Convert_t7097FF336D592F7C06D88A98349A44646F91EFFC_il2cpp_TypeInfo_var);
		il2cpp_codegen_initialize_runtime_metadata((uintptr_t*)&Optional_1_SetValue_mFAAAF5769CD67501C36EBB483D13A1A015F82492_RuntimeMethod_var);
		il2cpp_codegen_initialize_runtime_metadata((uintptr_t*)&Optional_1__ctor_mDCE5346C89F45F6878E2B214DF77B1B37CBD1265_RuntimeMethod_var);
		il2cpp_codegen_initialize_runtime_metadata((uintptr_t*)&Optional_1_t6777AA03B6B6BCE1D48C4DFAA9F6499242C82F05_il2cpp_TypeInfo_var);
		s_Il2CppMethodInitialized = true;
	}
	{
		// Optional<CHANNEL_PROFILE_TYPE> ret = new Optional<CHANNEL_PROFILE_TYPE>();
		Optional_1_t6777AA03B6B6BCE1D48C4DFAA9F6499242C82F05* L_0 = (Optional_1_t6777AA03B6B6BCE1D48C4DFAA9F6499242C82F05*)il2cpp_codegen_object_new(Optional_1_t6777AA03B6B6BCE1D48C4DFAA9F6499242C82F05_il2cpp_TypeInfo_var);
		NullCheck(L_0);
		Optional_1__ctor_mDCE5346C89F45F6878E2B214DF77B1B37CBD1265(L_0, Optional_1__ctor_mDCE5346C89F45F6878E2B214DF77B1B37CBD1265_RuntimeMethod_var);
		// ret.SetValue((CHANNEL_PROFILE_TYPE)Convert.ToInt16(input));
		Optional_1_t6777AA03B6B6BCE1D48C4DFAA9F6499242C82F05* L_1 = L_0;
		RuntimeObject* L_2 = ___input0;
		il2cpp_codegen_runtime_class_init_inline(Convert_t7097FF336D592F7C06D88A98349A44646F91EFFC_il2cpp_TypeInfo_var);
		int16_t L_3;
		L_3 = Convert_ToInt16_mD8FC1332F5EA5618C3765BA1EB756406A10FDDA6(L_2, NULL);
		NullCheck(L_1);
		Optional_1_SetValue_mFAAAF5769CD67501C36EBB483D13A1A015F82492(L_1, L_3, Optional_1_SetValue_mFAAAF5769CD67501C36EBB483D13A1A015F82492_RuntimeMethod_var);
		// return ret;
		return L_1;
	}
}
// System.Object Agora.Rtc.LitJson.JsonMapper/<>c::<RegisterCustomImporters>b__27_33(System.Object)
IL2CPP_EXTERN_C IL2CPP_METHOD_ATTR RuntimeObject* U3CU3Ec_U3CRegisterCustomImportersU3Eb__27_33_m519BE44E4C5ACC0A10BA6CC0DD1C4EB403748FDD (U3CU3Ec_tB2417947DB790EC3B314B9BB1046B04B68400CDA* __this, RuntimeObject* ___input0, const RuntimeMethod* method) 
{
	static bool s_Il2CppMethodInitialized;
	if (!s_Il2CppMethodInitialized)
	{
		il2cpp_codegen_initialize_runtime_metadata((uintptr_t*)&Convert_t7097FF336D592F7C06D88A98349A44646F91EFFC_il2cpp_TypeInfo_var);
		il2cpp_codegen_initialize_runtime_metadata((uintptr_t*)&Optional_1_SetValue_mFAAAF5769CD67501C36EBB483D13A1A015F82492_RuntimeMethod_var);
		il2cpp_codegen_initialize_runtime_metadata((uintptr_t*)&Optional_1__ctor_mDCE5346C89F45F6878E2B214DF77B1B37CBD1265_RuntimeMethod_var);
		il2cpp_codegen_initialize_runtime_metadata((uintptr_t*)&Optional_1_t6777AA03B6B6BCE1D48C4DFAA9F6499242C82F05_il2cpp_TypeInfo_var);
		s_Il2CppMethodInitialized = true;
	}
	{
		// Optional<CHANNEL_PROFILE_TYPE> ret = new Optional<CHANNEL_PROFILE_TYPE>();
		Optional_1_t6777AA03B6B6BCE1D48C4DFAA9F6499242C82F05* L_0 = (Optional_1_t6777AA03B6B6BCE1D48C4DFAA9F6499242C82F05*)il2cpp_codegen_object_new(Optional_1_t6777AA03B6B6BCE1D48C4DFAA9F6499242C82F05_il2cpp_TypeInfo_var);
		NullCheck(L_0);
		Optional_1__ctor_mDCE5346C89F45F6878E2B214DF77B1B37CBD1265(L_0, Optional_1__ctor_mDCE5346C89F45F6878E2B214DF77B1B37CBD1265_RuntimeMethod_var);
		// ret.SetValue((CHANNEL_PROFILE_TYPE)Convert.ToUInt64(input));
		Optional_1_t6777AA03B6B6BCE1D48C4DFAA9F6499242C82F05* L_1 = L_0;
		RuntimeObject* L_2 = ___input0;
		il2cpp_codegen_runtime_class_init_inline(Convert_t7097FF336D592F7C06D88A98349A44646F91EFFC_il2cpp_TypeInfo_var);
		uint64_t L_3;
		L_3 = Convert_ToUInt64_mAED581BDC2A2EC0295EC6FB7C7D525571FEA4A0B(L_2, NULL);
		NullCheck(L_1);
		Optional_1_SetValue_mFAAAF5769CD67501C36EBB483D13A1A015F82492(L_1, ((int32_t)L_3), Optional_1_SetValue_mFAAAF5769CD67501C36EBB483D13A1A015F82492_RuntimeMethod_var);
		// return ret;
		return L_1;
	}
}
// System.Object Agora.Rtc.LitJson.JsonMapper/<>c::<RegisterCustomImporters>b__27_34(System.Object)
IL2CPP_EXTERN_C IL2CPP_METHOD_ATTR RuntimeObject* U3CU3Ec_U3CRegisterCustomImportersU3Eb__27_34_mDD5CC96FF65CEBA9B8F85CAA868AC5398B330E72 (U3CU3Ec_tB2417947DB790EC3B314B9BB1046B04B68400CDA* __this, RuntimeObject* ___input0, const RuntimeMethod* method) 
{
	static bool s_Il2CppMethodInitialized;
	if (!s_Il2CppMethodInitialized)
	{
		il2cpp_codegen_initialize_runtime_metadata((uintptr_t*)&Convert_t7097FF336D592F7C06D88A98349A44646F91EFFC_il2cpp_TypeInfo_var);
		il2cpp_codegen_initialize_runtime_metadata((uintptr_t*)&Optional_1_SetValue_m2C9100B836AAA180D846DCC74A0ED4A4118E8863_RuntimeMethod_var);
		il2cpp_codegen_initialize_runtime_metadata((uintptr_t*)&Optional_1__ctor_mB7E1B789CD114B93E341606596E8E6CE6D5EB1D0_RuntimeMethod_var);
		il2cpp_codegen_initialize_runtime_metadata((uintptr_t*)&Optional_1_tF6D53E8DA343ADCA47506DF62B9921E5612BCA69_il2cpp_TypeInfo_var);
		s_Il2CppMethodInitialized = true;
	}
	{
		// Optional<THREAD_PRIORITY_TYPE> ret = new Optional<THREAD_PRIORITY_TYPE>();
		Optional_1_tF6D53E8DA343ADCA47506DF62B9921E5612BCA69* L_0 = (Optional_1_tF6D53E8DA343ADCA47506DF62B9921E5612BCA69*)il2cpp_codegen_object_new(Optional_1_tF6D53E8DA343ADCA47506DF62B9921E5612BCA69_il2cpp_TypeInfo_var);
		NullCheck(L_0);
		Optional_1__ctor_mB7E1B789CD114B93E341606596E8E6CE6D5EB1D0(L_0, Optional_1__ctor_mB7E1B789CD114B93E341606596E8E6CE6D5EB1D0_RuntimeMethod_var);
		// ret.SetValue((THREAD_PRIORITY_TYPE)Convert.ToInt16(input));
		Optional_1_tF6D53E8DA343ADCA47506DF62B9921E5612BCA69* L_1 = L_0;
		RuntimeObject* L_2 = ___input0;
		il2cpp_codegen_runtime_class_init_inline(Convert_t7097FF336D592F7C06D88A98349A44646F91EFFC_il2cpp_TypeInfo_var);
		int16_t L_3;
		L_3 = Convert_ToInt16_mD8FC1332F5EA5618C3765BA1EB756406A10FDDA6(L_2, NULL);
		NullCheck(L_1);
		Optional_1_SetValue_m2C9100B836AAA180D846DCC74A0ED4A4118E8863(L_1, L_3, Optional_1_SetValue_m2C9100B836AAA180D846DCC74A0ED4A4118E8863_RuntimeMethod_var);
		// return ret;
		return L_1;
	}
}
// System.Object Agora.Rtc.LitJson.JsonMapper/<>c::<RegisterCustomImporters>b__27_35(System.Object)
IL2CPP_EXTERN_C IL2CPP_METHOD_ATTR RuntimeObject* U3CU3Ec_U3CRegisterCustomImportersU3Eb__27_35_m5389F4F3F525FF3092DD9BF6B8B79D6B81FBB3C2 (U3CU3Ec_tB2417947DB790EC3B314B9BB1046B04B68400CDA* __this, RuntimeObject* ___input0, const RuntimeMethod* method) 
{
	static bool s_Il2CppMethodInitialized;
	if (!s_Il2CppMethodInitialized)
	{
		il2cpp_codegen_initialize_runtime_metadata((uintptr_t*)&Convert_t7097FF336D592F7C06D88A98349A44646F91EFFC_il2cpp_TypeInfo_var);
		il2cpp_codegen_initialize_runtime_metadata((uintptr_t*)&Optional_1_SetValue_m2C9100B836AAA180D846DCC74A0ED4A4118E8863_RuntimeMethod_var);
		il2cpp_codegen_initialize_runtime_metadata((uintptr_t*)&Optional_1__ctor_mB7E1B789CD114B93E341606596E8E6CE6D5EB1D0_RuntimeMethod_var);
		il2cpp_codegen_initialize_runtime_metadata((uintptr_t*)&Optional_1_tF6D53E8DA343ADCA47506DF62B9921E5612BCA69_il2cpp_TypeInfo_var);
		s_Il2CppMethodInitialized = true;
	}
	{
		// Optional<THREAD_PRIORITY_TYPE> ret = new Optional<THREAD_PRIORITY_TYPE>();
		Optional_1_tF6D53E8DA343ADCA47506DF62B9921E5612BCA69* L_0 = (Optional_1_tF6D53E8DA343ADCA47506DF62B9921E5612BCA69*)il2cpp_codegen_object_new(Optional_1_tF6D53E8DA343ADCA47506DF62B9921E5612BCA69_il2cpp_TypeInfo_var);
		NullCheck(L_0);
		Optional_1__ctor_mB7E1B789CD114B93E341606596E8E6CE6D5EB1D0(L_0, Optional_1__ctor_mB7E1B789CD114B93E341606596E8E6CE6D5EB1D0_RuntimeMethod_var);
		// ret.SetValue((THREAD_PRIORITY_TYPE)Convert.ToUInt64(input));
		Optional_1_tF6D53E8DA343ADCA47506DF62B9921E5612BCA69* L_1 = L_0;
		RuntimeObject* L_2 = ___input0;
		il2cpp_codegen_runtime_class_init_inline(Convert_t7097FF336D592F7C06D88A98349A44646F91EFFC_il2cpp_TypeInfo_var);
		uint64_t L_3;
		L_3 = Convert_ToUInt64_mAED581BDC2A2EC0295EC6FB7C7D525571FEA4A0B(L_2, NULL);
		NullCheck(L_1);
		Optional_1_SetValue_m2C9100B836AAA180D846DCC74A0ED4A4118E8863(L_1, ((int32_t)L_3), Optional_1_SetValue_m2C9100B836AAA180D846DCC74A0ED4A4118E8863_RuntimeMethod_var);
		// return ret;
		return L_1;
	}
}
// System.Object Agora.Rtc.LitJson.JsonMapper/<>c::<RegisterCustomImporters>b__27_36(System.Object)
IL2CPP_EXTERN_C IL2CPP_METHOD_ATTR RuntimeObject* U3CU3Ec_U3CRegisterCustomImportersU3Eb__27_36_m5354A261B493EF44C5D0C481898521FAC1A3A2EC (U3CU3Ec_tB2417947DB790EC3B314B9BB1046B04B68400CDA* __this, RuntimeObject* ___input0, const RuntimeMethod* method) 
{
	static bool s_Il2CppMethodInitialized;
	if (!s_Il2CppMethodInitialized)
	{
		il2cpp_codegen_initialize_runtime_metadata((uintptr_t*)&Int32_t680FF22E76F6EFAD4375103CBBFFA0421349384C_il2cpp_TypeInfo_var);
		il2cpp_codegen_initialize_runtime_metadata((uintptr_t*)&IntPtr_t_il2cpp_TypeInfo_var);
		s_Il2CppMethodInitialized = true;
	}
	{
		// IntPtr ret = (IntPtr)(int)(input);
		RuntimeObject* L_0 = ___input0;
		intptr_t L_1;
		L_1 = IntPtr_op_Explicit_m931A344F16D4C65EFB0B492EB07C7A82AF0B9FA1(((*(int32_t*)((int32_t*)(int32_t*)UnBox(L_0, Int32_t680FF22E76F6EFAD4375103CBBFFA0421349384C_il2cpp_TypeInfo_var)))), NULL);
		// return ret;
		intptr_t L_2 = L_1;
		RuntimeObject* L_3 = Box(IntPtr_t_il2cpp_TypeInfo_var, &L_2);
		return L_3;
	}
}
// System.Object Agora.Rtc.LitJson.JsonMapper/<>c::<RegisterCustomImporters>b__27_37(System.Object)
IL2CPP_EXTERN_C IL2CPP_METHOD_ATTR RuntimeObject* U3CU3Ec_U3CRegisterCustomImportersU3Eb__27_37_mDABC9E7A885EEFE5935A15DEE814E434570E9CA7 (U3CU3Ec_tB2417947DB790EC3B314B9BB1046B04B68400CDA* __this, RuntimeObject* ___input0, const RuntimeMethod* method) 
{
	static bool s_Il2CppMethodInitialized;
	if (!s_Il2CppMethodInitialized)
	{
		il2cpp_codegen_initialize_runtime_metadata((uintptr_t*)&IntPtr_t_il2cpp_TypeInfo_var);
		il2cpp_codegen_initialize_runtime_metadata((uintptr_t*)&UInt32_t1833D51FFA667B18A5AA4B8D34DE284F8495D29B_il2cpp_TypeInfo_var);
		s_Il2CppMethodInitialized = true;
	}
	{
		// IntPtr ret = (IntPtr)(uint)(input);
		RuntimeObject* L_0 = ___input0;
		intptr_t L_1;
		L_1 = IntPtr_op_Explicit_mDDF1A91C58AC17347D735651A0D830CA1E86D4B0(((int64_t)(uint64_t)((*(uint32_t*)((uint32_t*)(uint32_t*)UnBox(L_0, UInt32_t1833D51FFA667B18A5AA4B8D34DE284F8495D29B_il2cpp_TypeInfo_var))))), NULL);
		// return ret;
		intptr_t L_2 = L_1;
		RuntimeObject* L_3 = Box(IntPtr_t_il2cpp_TypeInfo_var, &L_2);
		return L_3;
	}
}
// System.Object Agora.Rtc.LitJson.JsonMapper/<>c::<RegisterCustomImporters>b__27_38(System.Object)
IL2CPP_EXTERN_C IL2CPP_METHOD_ATTR RuntimeObject* U3CU3Ec_U3CRegisterCustomImportersU3Eb__27_38_m56FEEAC9249F9689D453F570E5AAB3F70F0F65FE (U3CU3Ec_tB2417947DB790EC3B314B9BB1046B04B68400CDA* __this, RuntimeObject* ___input0, const RuntimeMethod* method) 
{
	static bool s_Il2CppMethodInitialized;
	if (!s_Il2CppMethodInitialized)
	{
		il2cpp_codegen_initialize_runtime_metadata((uintptr_t*)&Int64_t092CFB123BE63C28ACDAF65C68F21A526050DBA3_il2cpp_TypeInfo_var);
		il2cpp_codegen_initialize_runtime_metadata((uintptr_t*)&IntPtr_t_il2cpp_TypeInfo_var);
		s_Il2CppMethodInitialized = true;
	}
	{
		// IntPtr ret = (IntPtr)(long)(input);
		RuntimeObject* L_0 = ___input0;
		intptr_t L_1;
		L_1 = IntPtr_op_Explicit_mDDF1A91C58AC17347D735651A0D830CA1E86D4B0(((*(int64_t*)((int64_t*)(int64_t*)UnBox(L_0, Int64_t092CFB123BE63C28ACDAF65C68F21A526050DBA3_il2cpp_TypeInfo_var)))), NULL);
		// return ret;
		intptr_t L_2 = L_1;
		RuntimeObject* L_3 = Box(IntPtr_t_il2cpp_TypeInfo_var, &L_2);
		return L_3;
	}
}
// System.Object Agora.Rtc.LitJson.JsonMapper/<>c::<RegisterCustomImporters>b__27_39(System.Object)
IL2CPP_EXTERN_C IL2CPP_METHOD_ATTR RuntimeObject* U3CU3Ec_U3CRegisterCustomImportersU3Eb__27_39_mEC9FEA5099DEC07DA429C9AEB233810517B0097B (U3CU3Ec_tB2417947DB790EC3B314B9BB1046B04B68400CDA* __this, RuntimeObject* ___input0, const RuntimeMethod* method) 
{
	static bool s_Il2CppMethodInitialized;
	if (!s_Il2CppMethodInitialized)
	{
		il2cpp_codegen_initialize_runtime_metadata((uintptr_t*)&IntPtr_t_il2cpp_TypeInfo_var);
		il2cpp_codegen_initialize_runtime_metadata((uintptr_t*)&UInt64_t8F12534CC8FC4B5860F2A2CD1EE79D322E7A41AF_il2cpp_TypeInfo_var);
		s_Il2CppMethodInitialized = true;
	}
	{
		// IntPtr ret = (IntPtr)(ulong)(input);
		RuntimeObject* L_0 = ___input0;
		intptr_t L_1;
		L_1 = IntPtr_op_Explicit_mDDF1A91C58AC17347D735651A0D830CA1E86D4B0(((*(uint64_t*)((uint64_t*)(uint64_t*)UnBox(L_0, UInt64_t8F12534CC8FC4B5860F2A2CD1EE79D322E7A41AF_il2cpp_TypeInfo_var)))), NULL);
		// return ret;
		intptr_t L_2 = L_1;
		RuntimeObject* L_3 = Box(IntPtr_t_il2cpp_TypeInfo_var, &L_2);
		return L_3;
	}
}
// Agora.Rtc.LitJson.IJsonWrapper Agora.Rtc.LitJson.JsonMapper/<>c::<ToObject>b__32_0()
IL2CPP_EXTERN_C IL2CPP_METHOD_ATTR RuntimeObject* U3CU3Ec_U3CToObjectU3Eb__32_0_mB7056159DBECEC57F9EC3ACFA7A4B957754DADD1 (U3CU3Ec_tB2417947DB790EC3B314B9BB1046B04B68400CDA* __this, const RuntimeMethod* method) 
{
	static bool s_Il2CppMethodInitialized;
	if (!s_Il2CppMethodInitialized)
	{
		il2cpp_codegen_initialize_runtime_metadata((uintptr_t*)&JsonData_t84ADF600AA1B164B56CAFAAF965FE17B8A3543D5_il2cpp_TypeInfo_var);
		s_Il2CppMethodInitialized = true;
	}
	{
		// delegate { return new JsonData(); }, reader);
		JsonData_t84ADF600AA1B164B56CAFAAF965FE17B8A3543D5* L_0 = (JsonData_t84ADF600AA1B164B56CAFAAF965FE17B8A3543D5*)il2cpp_codegen_object_new(JsonData_t84ADF600AA1B164B56CAFAAF965FE17B8A3543D5_il2cpp_TypeInfo_var);
		NullCheck(L_0);
		JsonData__ctor_mD094650916BAA209E638A00FC1A2DD966ED6B5BC(L_0, NULL);
		return L_0;
	}
}
// Agora.Rtc.LitJson.IJsonWrapper Agora.Rtc.LitJson.JsonMapper/<>c::<ToObject>b__33_0()
IL2CPP_EXTERN_C IL2CPP_METHOD_ATTR RuntimeObject* U3CU3Ec_U3CToObjectU3Eb__33_0_mFDE8B294569BAC0A7DAF1419C128D94242C5B34D (U3CU3Ec_tB2417947DB790EC3B314B9BB1046B04B68400CDA* __this, const RuntimeMethod* method) 
{
	static bool s_Il2CppMethodInitialized;
	if (!s_Il2CppMethodInitialized)
	{
		il2cpp_codegen_initialize_runtime_metadata((uintptr_t*)&JsonData_t84ADF600AA1B164B56CAFAAF965FE17B8A3543D5_il2cpp_TypeInfo_var);
		s_Il2CppMethodInitialized = true;
	}
	{
		// delegate { return new JsonData(); }, json_reader);
		JsonData_t84ADF600AA1B164B56CAFAAF965FE17B8A3543D5* L_0 = (JsonData_t84ADF600AA1B164B56CAFAAF965FE17B8A3543D5*)il2cpp_codegen_object_new(JsonData_t84ADF600AA1B164B56CAFAAF965FE17B8A3543D5_il2cpp_TypeInfo_var);
		NullCheck(L_0);
		JsonData__ctor_mD094650916BAA209E638A00FC1A2DD966ED6B5BC(L_0, NULL);
		return L_0;
	}
}
// Agora.Rtc.LitJson.IJsonWrapper Agora.Rtc.LitJson.JsonMapper/<>c::<ToObject>b__34_0()
IL2CPP_EXTERN_C IL2CPP_METHOD_ATTR RuntimeObject* U3CU3Ec_U3CToObjectU3Eb__34_0_m392262FDD0397D4A568AEF1F47AE9CEB201CFCCF (U3CU3Ec_tB2417947DB790EC3B314B9BB1046B04B68400CDA* __this, const RuntimeMethod* method) 
{
	static bool s_Il2CppMethodInitialized;
	if (!s_Il2CppMethodInitialized)
	{
		il2cpp_codegen_initialize_runtime_metadata((uintptr_t*)&JsonData_t84ADF600AA1B164B56CAFAAF965FE17B8A3543D5_il2cpp_TypeInfo_var);
		s_Il2CppMethodInitialized = true;
	}
	{
		// delegate { return new JsonData(); }, json);
		JsonData_t84ADF600AA1B164B56CAFAAF965FE17B8A3543D5* L_0 = (JsonData_t84ADF600AA1B164B56CAFAAF965FE17B8A3543D5*)il2cpp_codegen_object_new(JsonData_t84ADF600AA1B164B56CAFAAF965FE17B8A3543D5_il2cpp_TypeInfo_var);
		NullCheck(L_0);
		JsonData__ctor_mD094650916BAA209E638A00FC1A2DD966ED6B5BC(L_0, NULL);
		return L_0;
	}
}
#ifdef __clang__
#pragma clang diagnostic pop
#endif
#ifdef __clang__
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Winvalid-offsetof"
#pragma clang diagnostic ignored "-Wunused-variable"
#endif
// System.Boolean Agora.Rtc.LitJson.JsonMockWrapper::get_IsArray()
IL2CPP_EXTERN_C IL2CPP_METHOD_ATTR bool JsonMockWrapper_get_IsArray_mB1DA10F265361B6069E535FDBAFEEB886A2FC597 (JsonMockWrapper_tE04391F97D9A84CC02FF454281A59C54DE05355C* __this, const RuntimeMethod* method) 
{
	{
		// public bool IsArray   { get { return false; } }
		return (bool)0;
	}
}
// System.Boolean Agora.Rtc.LitJson.JsonMockWrapper::get_IsBoolean()
IL2CPP_EXTERN_C IL2CPP_METHOD_ATTR bool JsonMockWrapper_get_IsBoolean_m1321FC5DF591B39B74B08B11144ACCE4193193E0 (JsonMockWrapper_tE04391F97D9A84CC02FF454281A59C54DE05355C* __this, const RuntimeMethod* method) 
{
	{
		// public bool IsBoolean { get { return false; } }
		return (bool)0;
	}
}
// System.Boolean Agora.Rtc.LitJson.JsonMockWrapper::get_IsDouble()
IL2CPP_EXTERN_C IL2CPP_METHOD_ATTR bool JsonMockWrapper_get_IsDouble_m3F867CDC2566DAC713EE2653CB50D9C4169D0246 (JsonMockWrapper_tE04391F97D9A84CC02FF454281A59C54DE05355C* __this, const RuntimeMethod* method) 
{
	{
		// public bool IsDouble  { get { return false; } }
		return (bool)0;
	}
}
// System.Boolean Agora.Rtc.LitJson.JsonMockWrapper::get_IsInt()
IL2CPP_EXTERN_C IL2CPP_METHOD_ATTR bool JsonMockWrapper_get_IsInt_mAF788D8641D066CD9D2F6C899D166E0ADB31C41E (JsonMockWrapper_tE04391F97D9A84CC02FF454281A59C54DE05355C* __this, const RuntimeMethod* method) 
{
	{
		// public bool IsInt     { get { return false; } }
		return (bool)0;
	}
}
// System.Boolean Agora.Rtc.LitJson.JsonMockWrapper::get_IsUInt()
IL2CPP_EXTERN_C IL2CPP_METHOD_ATTR bool JsonMockWrapper_get_IsUInt_m9C082C28AA4F1949548DD0A6B66D7450097CBB0A (JsonMockWrapper_tE04391F97D9A84CC02FF454281A59C54DE05355C* __this, const RuntimeMethod* method) 
{
	{
		// public bool IsUInt    { get { return false; } }
		return (bool)0;
	}
}
// System.Boolean Agora.Rtc.LitJson.JsonMockWrapper::get_IsLong()
IL2CPP_EXTERN_C IL2CPP_METHOD_ATTR bool JsonMockWrapper_get_IsLong_m4742BCFF079E4D74918B6F9D70A6F6D842CBE6CD (JsonMockWrapper_tE04391F97D9A84CC02FF454281A59C54DE05355C* __this, const RuntimeMethod* method) 
{
	{
		// public bool IsLong    { get { return false; } }
		return (bool)0;
	}
}
// System.Boolean Agora.Rtc.LitJson.JsonMockWrapper::get_IsULong()
IL2CPP_EXTERN_C IL2CPP_METHOD_ATTR bool JsonMockWrapper_get_IsULong_m0556BB3FAE5634CBA3FA9F79EFA7121A97F58039 (JsonMockWrapper_tE04391F97D9A84CC02FF454281A59C54DE05355C* __this, const RuntimeMethod* method) 
{
	{
		// public bool IsULong   { get { return false; } }
		return (bool)0;
	}
}
// System.Boolean Agora.Rtc.LitJson.JsonMockWrapper::get_IsObject()
IL2CPP_EXTERN_C IL2CPP_METHOD_ATTR bool JsonMockWrapper_get_IsObject_mB0D31F48FCD71E581E76983FEA3C0511F3109167 (JsonMockWrapper_tE04391F97D9A84CC02FF454281A59C54DE05355C* __this, const RuntimeMethod* method) 
{
	{
		// public bool IsObject  { get { return false; } }
		return (bool)0;
	}
}
// System.Boolean Agora.Rtc.LitJson.JsonMockWrapper::get_IsString()
IL2CPP_EXTERN_C IL2CPP_METHOD_ATTR bool JsonMockWrapper_get_IsString_m570254F807B8B112954CDC00406141C892CD07A6 (JsonMockWrapper_tE04391F97D9A84CC02FF454281A59C54DE05355C* __this, const RuntimeMethod* method) 
{
	{
		// public bool IsString  { get { return false; } }
		return (bool)0;
	}
}
// System.Boolean Agora.Rtc.LitJson.JsonMockWrapper::GetBoolean()
IL2CPP_EXTERN_C IL2CPP_METHOD_ATTR bool JsonMockWrapper_GetBoolean_m278AE575BAAFDC07584CF59BB7F2A467A17773B3 (JsonMockWrapper_tE04391F97D9A84CC02FF454281A59C54DE05355C* __this, const RuntimeMethod* method) 
{
	{
		// public bool     GetBoolean ()  { return false; }
		return (bool)0;
	}
}
// System.Double Agora.Rtc.LitJson.JsonMockWrapper::GetDouble()
IL2CPP_EXTERN_C IL2CPP_METHOD_ATTR double JsonMockWrapper_GetDouble_m7120052FC5F47D44C52124922E536CCFCF6637F4 (JsonMockWrapper_tE04391F97D9A84CC02FF454281A59C54DE05355C* __this, const RuntimeMethod* method) 
{
	{
		// public double   GetDouble ()   { return 0.0; }
		return (0.0);
	}
}
// System.Int32 Agora.Rtc.LitJson.JsonMockWrapper::GetInt()
IL2CPP_EXTERN_C IL2CPP_METHOD_ATTR int32_t JsonMockWrapper_GetInt_mBCFC9E27F8196BA2B03E00E107F003521B16319E (JsonMockWrapper_tE04391F97D9A84CC02FF454281A59C54DE05355C* __this, const RuntimeMethod* method) 
{
	{
		// public int      GetInt ()      { return 0; }
		return 0;
	}
}
// System.UInt32 Agora.Rtc.LitJson.JsonMockWrapper::GetUInt()
IL2CPP_EXTERN_C IL2CPP_METHOD_ATTR uint32_t JsonMockWrapper_GetUInt_m9DCD1A9DA22D2D4DA4464E999824571A74C3827D (JsonMockWrapper_tE04391F97D9A84CC02FF454281A59C54DE05355C* __this, const RuntimeMethod* method) 
{
	{
		// public uint     GetUInt()      { return 0; }
		return 0;
	}
}
// Agora.Rtc.LitJson.JsonType Agora.Rtc.LitJson.JsonMockWrapper::GetJsonType()
IL2CPP_EXTERN_C IL2CPP_METHOD_ATTR int32_t JsonMockWrapper_GetJsonType_mBF54DF8C96C50BE2454533E76B69B9E35E42F94D (JsonMockWrapper_tE04391F97D9A84CC02FF454281A59C54DE05355C* __this, const RuntimeMethod* method) 
{
	{
		// public JsonType GetJsonType () { return JsonType.None; }
		return (int32_t)(0);
	}
}
// System.Int64 Agora.Rtc.LitJson.JsonMockWrapper::GetLong()
IL2CPP_EXTERN_C IL2CPP_METHOD_ATTR int64_t JsonMockWrapper_GetLong_mBE623B79D5E461BD72046EB2EBDF80AF5C97F480 (JsonMockWrapper_tE04391F97D9A84CC02FF454281A59C54DE05355C* __this, const RuntimeMethod* method) 
{
	{
		// public long     GetLong ()     { return 0L; }
		return ((int64_t)0);
	}
}
// System.UInt64 Agora.Rtc.LitJson.JsonMockWrapper::GetULong()
IL2CPP_EXTERN_C IL2CPP_METHOD_ATTR uint64_t JsonMockWrapper_GetULong_m2D704175F8DF597EA3E38C76F1124EC787E004A6 (JsonMockWrapper_tE04391F97D9A84CC02FF454281A59C54DE05355C* __this, const RuntimeMethod* method) 
{
	{
		// public ulong    GetULong()     { return 0L; }
		return ((int64_t)0);
	}
}
// System.String Agora.Rtc.LitJson.JsonMockWrapper::GetString()
IL2CPP_EXTERN_C IL2CPP_METHOD_ATTR String_t* JsonMockWrapper_GetString_m280F495A3E3A3E906B9A033A3C0A33FD141B5644 (JsonMockWrapper_tE04391F97D9A84CC02FF454281A59C54DE05355C* __this, const RuntimeMethod* method) 
{
	static bool s_Il2CppMethodInitialized;
	if (!s_Il2CppMethodInitialized)
	{
		il2cpp_codegen_initialize_runtime_metadata((uintptr_t*)&_stringLiteralDA39A3EE5E6B4B0D3255BFEF95601890AFD80709);
		s_Il2CppMethodInitialized = true;
	}
	{
		// public string   GetString ()   { return ""; }
		return _stringLiteralDA39A3EE5E6B4B0D3255BFEF95601890AFD80709;
	}
}
// System.Void Agora.Rtc.LitJson.JsonMockWrapper::SetBoolean(System.Boolean)
IL2CPP_EXTERN_C IL2CPP_METHOD_ATTR void JsonMockWrapper_SetBoolean_m34073F3D0BCA6ED2175B3206801F3AF2556AFCEF (JsonMockWrapper_tE04391F97D9A84CC02FF454281A59C54DE05355C* __this, bool ___val0, const RuntimeMethod* method) 
{
	{
		// public void SetBoolean  (bool val)      {}
		return;
	}
}
// System.Void Agora.Rtc.LitJson.JsonMockWrapper::SetDouble(System.Double)
IL2CPP_EXTERN_C IL2CPP_METHOD_ATTR void JsonMockWrapper_SetDouble_m2E1FA4056C402310D13D94E3C454F752DB125F28 (JsonMockWrapper_tE04391F97D9A84CC02FF454281A59C54DE05355C* __this, double ___val0, const RuntimeMethod* method) 
{
	{
		// public void SetDouble   (double val)    {}
		return;
	}
}
// System.Void Agora.Rtc.LitJson.JsonMockWrapper::SetInt(System.Int32)
IL2CPP_EXTERN_C IL2CPP_METHOD_ATTR void JsonMockWrapper_SetInt_m15F3B0F8628DA9DA01833A4167CAFC8BB9EF3F50 (JsonMockWrapper_tE04391F97D9A84CC02FF454281A59C54DE05355C* __this, int32_t ___val0, const RuntimeMethod* method) 
{
	{
		// public void SetInt      (int val)       {}
		return;
	}
}
// System.Void Agora.Rtc.LitJson.JsonMockWrapper::SetUInt(System.UInt32)
IL2CPP_EXTERN_C IL2CPP_METHOD_ATTR void JsonMockWrapper_SetUInt_mA5AF0963D9DF2E57DAEA8C47E2FF6017EC1E5AD7 (JsonMockWrapper_tE04391F97D9A84CC02FF454281A59C54DE05355C* __this, uint32_t ___val0, const RuntimeMethod* method) 
{
	{
		// public void SetUInt     (uint val)      {}
		return;
	}
}
// System.Void Agora.Rtc.LitJson.JsonMockWrapper::SetJsonType(Agora.Rtc.LitJson.JsonType)
IL2CPP_EXTERN_C IL2CPP_METHOD_ATTR void JsonMockWrapper_SetJsonType_mCA6A878FEC8FC9758A2D370492394665224C4C21 (JsonMockWrapper_tE04391F97D9A84CC02FF454281A59C54DE05355C* __this, int32_t ___type0, const RuntimeMethod* method) 
{
	{
		// public void SetJsonType (JsonType type) {}
		return;
	}
}
// System.Void Agora.Rtc.LitJson.JsonMockWrapper::SetLong(System.Int64)
IL2CPP_EXTERN_C IL2CPP_METHOD_ATTR void JsonMockWrapper_SetLong_m658543332EA69DE715C18BC220CD99BF0D5F6CD3 (JsonMockWrapper_tE04391F97D9A84CC02FF454281A59C54DE05355C* __this, int64_t ___val0, const RuntimeMethod* method) 
{
	{
		// public void SetLong     (long val)      {}
		return;
	}
}
// System.Void Agora.Rtc.LitJson.JsonMockWrapper::SetULong(System.UInt64)
IL2CPP_EXTERN_C IL2CPP_METHOD_ATTR void JsonMockWrapper_SetULong_mC912C5FFE1938A652D1AD3ABC576FE363B8880B2 (JsonMockWrapper_tE04391F97D9A84CC02FF454281A59C54DE05355C* __this, uint64_t ___val0, const RuntimeMethod* method) 
{
	{
		// public void SetULong    (ulong val)      {}
		return;
	}
}
// System.Void Agora.Rtc.LitJson.JsonMockWrapper::SetString(System.String)
IL2CPP_EXTERN_C IL2CPP_METHOD_ATTR void JsonMockWrapper_SetString_mC08F08149747329425BD5023BB4FE63584E1B3E9 (JsonMockWrapper_tE04391F97D9A84CC02FF454281A59C54DE05355C* __this, String_t* ___val0, const RuntimeMethod* method) 
{
	{
		// public void SetString   (string val)    {}
		return;
	}
}
// System.String Agora.Rtc.LitJson.JsonMockWrapper::ToJson()
IL2CPP_EXTERN_C IL2CPP_METHOD_ATTR String_t* JsonMockWrapper_ToJson_m33A1F0F3F83BEDBE39D5C3D2381BA88A6FEF644B (JsonMockWrapper_tE04391F97D9A84CC02FF454281A59C54DE05355C* __this, const RuntimeMethod* method) 
{
	static bool s_Il2CppMethodInitialized;
	if (!s_Il2CppMethodInitialized)
	{
		il2cpp_codegen_initialize_runtime_metadata((uintptr_t*)&_stringLiteralDA39A3EE5E6B4B0D3255BFEF95601890AFD80709);
		s_Il2CppMethodInitialized = true;
	}
	{
		// public string ToJson ()                  { return ""; }
		return _stringLiteralDA39A3EE5E6B4B0D3255BFEF95601890AFD80709;
	}
}
// System.Void Agora.Rtc.LitJson.JsonMockWrapper::ToJson(Agora.Rtc.LitJson.JsonWriter)
IL2CPP_EXTERN_C IL2CPP_METHOD_ATTR void JsonMockWrapper_ToJson_m7FCD8415660AEA7E0DED98D3CB1E941258CB7AA4 (JsonMockWrapper_tE04391F97D9A84CC02FF454281A59C54DE05355C* __this, JsonWriter_tC9B032D35ED4E85319A227892A43EB8627661732* ___writer0, const RuntimeMethod* method) 
{
	{
		// public void   ToJson (JsonWriter writer) {}
		return;
	}
}
// System.Boolean Agora.Rtc.LitJson.JsonMockWrapper::System.Collections.IList.get_IsFixedSize()
IL2CPP_EXTERN_C IL2CPP_METHOD_ATTR bool JsonMockWrapper_System_Collections_IList_get_IsFixedSize_m222EAAF7CF63D2C7F9E2E6259D3079C77D9C3F9F (JsonMockWrapper_tE04391F97D9A84CC02FF454281A59C54DE05355C* __this, const RuntimeMethod* method) 
{
	{
		// bool IList.IsFixedSize { get { return true; } }
		return (bool)1;
	}
}
// System.Boolean Agora.Rtc.LitJson.JsonMockWrapper::System.Collections.IList.get_IsReadOnly()
IL2CPP_EXTERN_C IL2CPP_METHOD_ATTR bool JsonMockWrapper_System_Collections_IList_get_IsReadOnly_m5C4F6063A007E5382DFF98D974C97BECE50F4F69 (JsonMockWrapper_tE04391F97D9A84CC02FF454281A59C54DE05355C* __this, const RuntimeMethod* method) 
{
	{
		// bool IList.IsReadOnly  { get { return true; } }
		return (bool)1;
	}
}
// System.Object Agora.Rtc.LitJson.JsonMockWrapper::System.Collections.IList.get_Item(System.Int32)
IL2CPP_EXTERN_C IL2CPP_METHOD_ATTR RuntimeObject* JsonMockWrapper_System_Collections_IList_get_Item_mBDF42746B3DE478A477B5567C198F3B3E0DF412C (JsonMockWrapper_tE04391F97D9A84CC02FF454281A59C54DE05355C* __this, int32_t ___index0, const RuntimeMethod* method) 
{
	{
		// get { return null; }
		return NULL;
	}
}
// System.Void Agora.Rtc.LitJson.JsonMockWrapper::System.Collections.IList.set_Item(System.Int32,System.Object)
IL2CPP_EXTERN_C IL2CPP_METHOD_ATTR void JsonMockWrapper_System_Collections_IList_set_Item_m8E2A325E7356009F1C82A2AED6FE4290C0C6F54D (JsonMockWrapper_tE04391F97D9A84CC02FF454281A59C54DE05355C* __this, int32_t ___index0, RuntimeObject* ___value1, const RuntimeMethod* method) 
{
	{
		// set {}
		return;
	}
}
// System.Int32 Agora.Rtc.LitJson.JsonMockWrapper::System.Collections.IList.Add(System.Object)
IL2CPP_EXTERN_C IL2CPP_METHOD_ATTR int32_t JsonMockWrapper_System_Collections_IList_Add_mD4300F1C34C9B7AE5E662D93F495612B3340D40A (JsonMockWrapper_tE04391F97D9A84CC02FF454281A59C54DE05355C* __this, RuntimeObject* ___value0, const RuntimeMethod* method) 
{
	{
		// int  IList.Add (object value)       { return 0; }
		return 0;
	}
}
// System.Void Agora.Rtc.LitJson.JsonMockWrapper::System.Collections.IList.Clear()
IL2CPP_EXTERN_C IL2CPP_METHOD_ATTR void JsonMockWrapper_System_Collections_IList_Clear_mACCED7C4A270BC34C242763198C22AB0B02C65E3 (JsonMockWrapper_tE04391F97D9A84CC02FF454281A59C54DE05355C* __this, const RuntimeMethod* method) 
{
	{
		// void IList.Clear ()                 {}
		return;
	}
}
// System.Boolean Agora.Rtc.LitJson.JsonMockWrapper::System.Collections.IList.Contains(System.Object)
IL2CPP_EXTERN_C IL2CPP_METHOD_ATTR bool JsonMockWrapper_System_Collections_IList_Contains_mEE643AE8A9F2C3C85E219E6617378C091310EA98 (JsonMockWrapper_tE04391F97D9A84CC02FF454281A59C54DE05355C* __this, RuntimeObject* ___value0, const RuntimeMethod* method) 
{
	{
		// bool IList.Contains (object value)  { return false; }
		return (bool)0;
	}
}
// System.Int32 Agora.Rtc.LitJson.JsonMockWrapper::System.Collections.IList.IndexOf(System.Object)
IL2CPP_EXTERN_C IL2CPP_METHOD_ATTR int32_t JsonMockWrapper_System_Collections_IList_IndexOf_m0EB9B0A5DF8ADB4E6996D4D3C20502396B5826EB (JsonMockWrapper_tE04391F97D9A84CC02FF454281A59C54DE05355C* __this, RuntimeObject* ___value0, const RuntimeMethod* method) 
{
	{
		// int  IList.IndexOf (object value)   { return -1; }
		return (-1);
	}
}
// System.Void Agora.Rtc.LitJson.JsonMockWrapper::System.Collections.IList.Insert(System.Int32,System.Object)
IL2CPP_EXTERN_C IL2CPP_METHOD_ATTR void JsonMockWrapper_System_Collections_IList_Insert_m0072D5ADAB360BF9FEAE23A0A04DBF3EE26581F8 (JsonMockWrapper_tE04391F97D9A84CC02FF454281A59C54DE05355C* __this, int32_t ___i0, RuntimeObject* ___v1, const RuntimeMethod* method) 
{
	{
		// void IList.Insert (int i, object v) {}
		return;
	}
}
// System.Void Agora.Rtc.LitJson.JsonMockWrapper::System.Collections.IList.Remove(System.Object)
IL2CPP_EXTERN_C IL2CPP_METHOD_ATTR void JsonMockWrapper_System_Collections_IList_Remove_m94C3B9E6570BEE131174163033B2B7107F58ADC3 (JsonMockWrapper_tE04391F97D9A84CC02FF454281A59C54DE05355C* __this, RuntimeObject* ___value0, const RuntimeMethod* method) 
{
	{
		// void IList.Remove (object value)    {}
		return;
	}
}
// System.Void Agora.Rtc.LitJson.JsonMockWrapper::System.Collections.IList.RemoveAt(System.Int32)
IL2CPP_EXTERN_C IL2CPP_METHOD_ATTR void JsonMockWrapper_System_Collections_IList_RemoveAt_m4ECD9B17825A5AB81D1470B864B748B9A831FCD9 (JsonMockWrapper_tE04391F97D9A84CC02FF454281A59C54DE05355C* __this, int32_t ___index0, const RuntimeMethod* method) 
{
	{
		// void IList.RemoveAt (int index)     {}
		return;
	}
}
// System.Int32 Agora.Rtc.LitJson.JsonMockWrapper::System.Collections.ICollection.get_Count()
IL2CPP_EXTERN_C IL2CPP_METHOD_ATTR int32_t JsonMockWrapper_System_Collections_ICollection_get_Count_m4F6615D997E25D5091F78CB9318050CDACD6F08B (JsonMockWrapper_tE04391F97D9A84CC02FF454281A59C54DE05355C* __this, const RuntimeMethod* method) 
{
	{
		// int    ICollection.Count          { get { return 0; } }
		return 0;
	}
}
// System.Boolean Agora.Rtc.LitJson.JsonMockWrapper::System.Collections.ICollection.get_IsSynchronized()
IL2CPP_EXTERN_C IL2CPP_METHOD_ATTR bool JsonMockWrapper_System_Collections_ICollection_get_IsSynchronized_m92F7485D92179D76D1A3294A00E63C16AF76ADDD (JsonMockWrapper_tE04391F97D9A84CC02FF454281A59C54DE05355C* __this, const RuntimeMethod* method) 
{
	{
		// bool   ICollection.IsSynchronized { get { return false; } }
		return (bool)0;
	}
}
// System.Object Agora.Rtc.LitJson.JsonMockWrapper::System.Collections.ICollection.get_SyncRoot()
IL2CPP_EXTERN_C IL2CPP_METHOD_ATTR RuntimeObject* JsonMockWrapper_System_Collections_ICollection_get_SyncRoot_mDB8CC472F6745B18306EEE5BC2ED7E9E57B80F06 (JsonMockWrapper_tE04391F97D9A84CC02FF454281A59C54DE05355C* __this, const RuntimeMethod* method) 
{
	{
		// object ICollection.SyncRoot       { get { return null; } }
		return NULL;
	}
}
// System.Void Agora.Rtc.LitJson.JsonMockWrapper::System.Collections.ICollection.CopyTo(System.Array,System.Int32)
IL2CPP_EXTERN_C IL2CPP_METHOD_ATTR void JsonMockWrapper_System_Collections_ICollection_CopyTo_m3E4C66E9D5BAAD78719B57027CC3D47E44E77474 (JsonMockWrapper_tE04391F97D9A84CC02FF454281A59C54DE05355C* __this, RuntimeArray* ___array0, int32_t ___index1, const RuntimeMethod* method) 
{
	{
		// void ICollection.CopyTo (Array array, int index) {}
		return;
	}
}
// System.Collections.IEnumerator Agora.Rtc.LitJson.JsonMockWrapper::System.Collections.IEnumerable.GetEnumerator()
IL2CPP_EXTERN_C IL2CPP_METHOD_ATTR RuntimeObject* JsonMockWrapper_System_Collections_IEnumerable_GetEnumerator_m8199924145E6B7A6CEA310CE4B9DDFB496396FF1 (JsonMockWrapper_tE04391F97D9A84CC02FF454281A59C54DE05355C* __this, const RuntimeMethod* method) 
{
	{
		// IEnumerator IEnumerable.GetEnumerator () { return null; }
		return (RuntimeObject*)NULL;
	}
}
// System.Boolean Agora.Rtc.LitJson.JsonMockWrapper::System.Collections.IDictionary.get_IsFixedSize()
IL2CPP_EXTERN_C IL2CPP_METHOD_ATTR bool JsonMockWrapper_System_Collections_IDictionary_get_IsFixedSize_m60D7FF23B23932128901FF1BC12C7F1706415A03 (JsonMockWrapper_tE04391F97D9A84CC02FF454281A59C54DE05355C* __this, const RuntimeMethod* method) 
{
	{
		// bool IDictionary.IsFixedSize { get { return true; } }
		return (bool)1;
	}
}
// System.Boolean Agora.Rtc.LitJson.JsonMockWrapper::System.Collections.IDictionary.get_IsReadOnly()
IL2CPP_EXTERN_C IL2CPP_METHOD_ATTR bool JsonMockWrapper_System_Collections_IDictionary_get_IsReadOnly_mFB87AB6B8264D6559117804675AFF4895F5B8DDB (JsonMockWrapper_tE04391F97D9A84CC02FF454281A59C54DE05355C* __this, const RuntimeMethod* method) 
{
	{
		// bool IDictionary.IsReadOnly  { get { return true; } }
		return (bool)1;
	}
}
// System.Collections.ICollection Agora.Rtc.LitJson.JsonMockWrapper::System.Collections.IDictionary.get_Keys()
IL2CPP_EXTERN_C IL2CPP_METHOD_ATTR RuntimeObject* JsonMockWrapper_System_Collections_IDictionary_get_Keys_mFC3C3D2FF1E5696278233AEBACA6032F3A67CD65 (JsonMockWrapper_tE04391F97D9A84CC02FF454281A59C54DE05355C* __this, const RuntimeMethod* method) 
{
	{
		// ICollection IDictionary.Keys   { get { return null; } }
		return (RuntimeObject*)NULL;
	}
}
// System.Collections.ICollection Agora.Rtc.LitJson.JsonMockWrapper::System.Collections.IDictionary.get_Values()
IL2CPP_EXTERN_C IL2CPP_METHOD_ATTR RuntimeObject* JsonMockWrapper_System_Collections_IDictionary_get_Values_m1E1418699B7106B57B967487315446DCD8053C2F (JsonMockWrapper_tE04391F97D9A84CC02FF454281A59C54DE05355C* __this, const RuntimeMethod* method) 
{
	{
		// ICollection IDictionary.Values { get { return null; } }
		return (RuntimeObject*)NULL;
	}
}
// System.Object Agora.Rtc.LitJson.JsonMockWrapper::System.Collections.IDictionary.get_Item(System.Object)
IL2CPP_EXTERN_C IL2CPP_METHOD_ATTR RuntimeObject* JsonMockWrapper_System_Collections_IDictionary_get_Item_m7907234B7E6D2DB2700121B4B51045E2EDEFC92D (JsonMockWrapper_tE04391F97D9A84CC02FF454281A59C54DE05355C* __this, RuntimeObject* ___key0, const RuntimeMethod* method) 
{
	{
		// get { return null; }
		return NULL;
	}
}
// System.Void Agora.Rtc.LitJson.JsonMockWrapper::System.Collections.IDictionary.set_Item(System.Object,System.Object)
IL2CPP_EXTERN_C IL2CPP_METHOD_ATTR void JsonMockWrapper_System_Collections_IDictionary_set_Item_m3B410F9E5BCD3AF3F3215E88EA2260D7FD976C82 (JsonMockWrapper_tE04391F97D9A84CC02FF454281A59C54DE05355C* __this, RuntimeObject* ___key0, RuntimeObject* ___value1, const RuntimeMethod* method) 
{
	{
		// set {}
		return;
	}
}
// System.Void Agora.Rtc.LitJson.JsonMockWrapper::System.Collections.IDictionary.Add(System.Object,System.Object)
IL2CPP_EXTERN_C IL2CPP_METHOD_ATTR void JsonMockWrapper_System_Collections_IDictionary_Add_m46E6E9D8C194E144E9E3FA1529D5CAB7CF294028 (JsonMockWrapper_tE04391F97D9A84CC02FF454281A59C54DE05355C* __this, RuntimeObject* ___k0, RuntimeObject* ___v1, const RuntimeMethod* method) 
{
	{
		// void IDictionary.Add (object k, object v) {}
		return;
	}
}
// System.Void Agora.Rtc.LitJson.JsonMockWrapper::System.Collections.IDictionary.Clear()
IL2CPP_EXTERN_C IL2CPP_METHOD_ATTR void JsonMockWrapper_System_Collections_IDictionary_Clear_m663CCCAD811978658AF809563B5297BCADBD5DA3 (JsonMockWrapper_tE04391F97D9A84CC02FF454281A59C54DE05355C* __this, const RuntimeMethod* method) 
{
	{
		// void IDictionary.Clear ()                 {}
		return;
	}
}
// System.Boolean Agora.Rtc.LitJson.JsonMockWrapper::System.Collections.IDictionary.Contains(System.Object)
IL2CPP_EXTERN_C IL2CPP_METHOD_ATTR bool JsonMockWrapper_System_Collections_IDictionary_Contains_m26F4F1AB6A00ECE66925E4EC86A05E478B45EADE (JsonMockWrapper_tE04391F97D9A84CC02FF454281A59C54DE05355C* __this, RuntimeObject* ___key0, const RuntimeMethod* method) 
{
	{
		// bool IDictionary.Contains (object key)    { return false; }
		return (bool)0;
	}
}
// System.Void Agora.Rtc.LitJson.JsonMockWrapper::System.Collections.IDictionary.Remove(System.Object)
IL2CPP_EXTERN_C IL2CPP_METHOD_ATTR void JsonMockWrapper_System_Collections_IDictionary_Remove_m15FCC273217AFE2736C9B7CB4E7C21D88D8FC74D (JsonMockWrapper_tE04391F97D9A84CC02FF454281A59C54DE05355C* __this, RuntimeObject* ___key0, const RuntimeMethod* method) 
{
	{
		// void IDictionary.Remove (object key)      {}
		return;
	}
}
// System.Collections.IDictionaryEnumerator Agora.Rtc.LitJson.JsonMockWrapper::System.Collections.IDictionary.GetEnumerator()
IL2CPP_EXTERN_C IL2CPP_METHOD_ATTR RuntimeObject* JsonMockWrapper_System_Collections_IDictionary_GetEnumerator_mDD999F016D7E153280CF3D94F11CF1A8815B2E86 (JsonMockWrapper_tE04391F97D9A84CC02FF454281A59C54DE05355C* __this, const RuntimeMethod* method) 
{
	{
		// IDictionaryEnumerator IDictionary.GetEnumerator () { return null; }
		return (RuntimeObject*)NULL;
	}
}
// System.Object Agora.Rtc.LitJson.JsonMockWrapper::System.Collections.Specialized.IOrderedDictionary.get_Item(System.Int32)
IL2CPP_EXTERN_C IL2CPP_METHOD_ATTR RuntimeObject* JsonMockWrapper_System_Collections_Specialized_IOrderedDictionary_get_Item_m1CDBCE1AF7CB98BEBED83373DF33520AC117107E (JsonMockWrapper_tE04391F97D9A84CC02FF454281A59C54DE05355C* __this, int32_t ___idx0, const RuntimeMethod* method) 
{
	{
		// get { return null; }
		return NULL;
	}
}
// System.Void Agora.Rtc.LitJson.JsonMockWrapper::System.Collections.Specialized.IOrderedDictionary.set_Item(System.Int32,System.Object)
IL2CPP_EXTERN_C IL2CPP_METHOD_ATTR void JsonMockWrapper_System_Collections_Specialized_IOrderedDictionary_set_Item_m5633ECB552882B614CE69CC4A92E2983ECC4810B (JsonMockWrapper_tE04391F97D9A84CC02FF454281A59C54DE05355C* __this, int32_t ___idx0, RuntimeObject* ___value1, const RuntimeMethod* method) 
{
	{
		// set {}
		return;
	}
}
// System.Collections.IDictionaryEnumerator Agora.Rtc.LitJson.JsonMockWrapper::System.Collections.Specialized.IOrderedDictionary.GetEnumerator()
IL2CPP_EXTERN_C IL2CPP_METHOD_ATTR RuntimeObject* JsonMockWrapper_System_Collections_Specialized_IOrderedDictionary_GetEnumerator_mB642A0829CCE27326FC63BCDD6FEEC00FF6172AA (JsonMockWrapper_tE04391F97D9A84CC02FF454281A59C54DE05355C* __this, const RuntimeMethod* method) 
{
	{
		// return null;
		return (RuntimeObject*)NULL;
	}
}
// System.Void Agora.Rtc.LitJson.JsonMockWrapper::System.Collections.Specialized.IOrderedDictionary.Insert(System.Int32,System.Object,System.Object)
IL2CPP_EXTERN_C IL2CPP_METHOD_ATTR void JsonMockWrapper_System_Collections_Specialized_IOrderedDictionary_Insert_mCAACDF0A587463E7DE9DFF69F62259B7F2B53E59 (JsonMockWrapper_tE04391F97D9A84CC02FF454281A59C54DE05355C* __this, int32_t ___i0, RuntimeObject* ___k1, RuntimeObject* ___v2, const RuntimeMethod* method) 
{
	{
		// void IOrderedDictionary.Insert   (int i, object k, object v) {}
		return;
	}
}
// System.Void Agora.Rtc.LitJson.JsonMockWrapper::System.Collections.Specialized.IOrderedDictionary.RemoveAt(System.Int32)
IL2CPP_EXTERN_C IL2CPP_METHOD_ATTR void JsonMockWrapper_System_Collections_Specialized_IOrderedDictionary_RemoveAt_mD5144D1E7E486308B371C95E73C705931D860222 (JsonMockWrapper_tE04391F97D9A84CC02FF454281A59C54DE05355C* __this, int32_t ___i0, const RuntimeMethod* method) 
{
	{
		// void IOrderedDictionary.RemoveAt (int i) {}
		return;
	}
}
// System.Void Agora.Rtc.LitJson.JsonMockWrapper::.ctor()
IL2CPP_EXTERN_C IL2CPP_METHOD_ATTR void JsonMockWrapper__ctor_m5DD911B1FCB226E895971B6F1F015398E9A25BFA (JsonMockWrapper_tE04391F97D9A84CC02FF454281A59C54DE05355C* __this, const RuntimeMethod* method) 
{
	{
		Object__ctor_mE837C6B9FA8C6D5D109F4B2EC885D79919AC0EA2(__this, NULL);
		return;
	}
}
#ifdef __clang__
#pragma clang diagnostic pop
#endif
#ifdef __clang__
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Winvalid-offsetof"
#pragma clang diagnostic ignored "-Wunused-variable"
#endif
// System.Boolean Agora.Rtc.LitJson.JsonReader::get_AllowComments()
IL2CPP_EXTERN_C IL2CPP_METHOD_ATTR bool JsonReader_get_AllowComments_mC758E697158247A4705C2F8607C7FEDBAFD2A721 (JsonReader_tE72AF24875A229A65356715AAFF4C23E38105A3F* __this, const RuntimeMethod* method) 
{
	{
		// get { return lexer.AllowComments; }
		Lexer_tDC14CFA7B390E884510F554D9D1E03188A185E27* L_0 = __this->___lexer_6;
		NullCheck(L_0);
		bool L_1;
		L_1 = Lexer_get_AllowComments_mBD7811B449819997218E5052F2763E267EFF277B_inline(L_0, NULL);
		return L_1;
	}
}
// System.Void Agora.Rtc.LitJson.JsonReader::set_AllowComments(System.Boolean)
IL2CPP_EXTERN_C IL2CPP_METHOD_ATTR void JsonReader_set_AllowComments_mDA9ABBB46CB6DC1E84D03DD7A0A85D6A8E34FDBD (JsonReader_tE72AF24875A229A65356715AAFF4C23E38105A3F* __this, bool ___value0, const RuntimeMethod* method) 
{
	{
		// set { lexer.AllowComments = value; }
		Lexer_tDC14CFA7B390E884510F554D9D1E03188A185E27* L_0 = __this->___lexer_6;
		bool L_1 = ___value0;
		NullCheck(L_0);
		Lexer_set_AllowComments_mA16354319A472743B6F147EAFD3175C774878914_inline(L_0, L_1, NULL);
		// set { lexer.AllowComments = value; }
		return;
	}
}
// System.Boolean Agora.Rtc.LitJson.JsonReader::get_AllowSingleQuotedStrings()
IL2CPP_EXTERN_C IL2CPP_METHOD_ATTR bool JsonReader_get_AllowSingleQuotedStrings_m6FBAB6125667DAEB2B869D6A99F95FF3F7B3727F (JsonReader_tE72AF24875A229A65356715AAFF4C23E38105A3F* __this, const RuntimeMethod* method) 
{
	{
		// get { return lexer.AllowSingleQuotedStrings; }
		Lexer_tDC14CFA7B390E884510F554D9D1E03188A185E27* L_0 = __this->___lexer_6;
		NullCheck(L_0);
		bool L_1;
		L_1 = Lexer_get_AllowSingleQuotedStrings_mA6F77A0052FA0515743F21C5DA754BE68EF3C7AD_inline(L_0, NULL);
		return L_1;
	}
}
// System.Void Agora.Rtc.LitJson.JsonReader::set_AllowSingleQuotedStrings(System.Boolean)
IL2CPP_EXTERN_C IL2CPP_METHOD_ATTR void JsonReader_set_AllowSingleQuotedStrings_m23DD509690B264821D50DBDE2DC0777D149177D7 (JsonReader_tE72AF24875A229A65356715AAFF4C23E38105A3F* __this, bool ___value0, const RuntimeMethod* method) 
{
	{
		// set { lexer.AllowSingleQuotedStrings = value; }
		Lexer_tDC14CFA7B390E884510F554D9D1E03188A185E27* L_0 = __this->___lexer_6;
		bool L_1 = ___value0;
		NullCheck(L_0);
		Lexer_set_AllowSingleQuotedStrings_mA3CBFDE99EF4FF5DCC41B861A2CE6E6271B7382D_inline(L_0, L_1, NULL);
		// set { lexer.AllowSingleQuotedStrings = value; }
		return;
	}
}
// System.Boolean Agora.Rtc.LitJson.JsonReader::get_SkipNonMembers()
IL2CPP_EXTERN_C IL2CPP_METHOD_ATTR bool JsonReader_get_SkipNonMembers_m4086014AB1019E85C4B794723F613E5637ECAC96 (JsonReader_tE72AF24875A229A65356715AAFF4C23E38105A3F* __this, const RuntimeMethod* method) 
{
	{
		// get { return skip_non_members; }
		bool L_0 = __this->___skip_non_members_12;
		return L_0;
	}
}
// System.Void Agora.Rtc.LitJson.JsonReader::set_SkipNonMembers(System.Boolean)
IL2CPP_EXTERN_C IL2CPP_METHOD_ATTR void JsonReader_set_SkipNonMembers_m039F83583A3D4E046C2D2A79BA546D7D9B3F55E1 (JsonReader_tE72AF24875A229A65356715AAFF4C23E38105A3F* __this, bool ___value0, const RuntimeMethod* method) 
{
	{
		// set { skip_non_members = value; }
		bool L_0 = ___value0;
		__this->___skip_non_members_12 = L_0;
		// set { skip_non_members = value; }
		return;
	}
}
// System.Boolean Agora.Rtc.LitJson.JsonReader::get_EndOfInput()
IL2CPP_EXTERN_C IL2CPP_METHOD_ATTR bool JsonReader_get_EndOfInput_m2CC750A54DBFCF2A6353E8EB2DEAAA05CC3479F3 (JsonReader_tE72AF24875A229A65356715AAFF4C23E38105A3F* __this, const RuntimeMethod* method) 
{
	{
		// get { return end_of_input; }
		bool L_0 = __this->___end_of_input_5;
		return L_0;
	}
}
// System.Boolean Agora.Rtc.LitJson.JsonReader::get_EndOfJson()
IL2CPP_EXTERN_C IL2CPP_METHOD_ATTR bool JsonReader_get_EndOfJson_mF160CD9075FA8C478C6B941D6A3F8931FBBCE633 (JsonReader_tE72AF24875A229A65356715AAFF4C23E38105A3F* __this, const RuntimeMethod* method) 
{
	{
		// get { return end_of_json; }
		bool L_0 = __this->___end_of_json_4;
		return L_0;
	}
}
// Agora.Rtc.LitJson.JsonToken Agora.Rtc.LitJson.JsonReader::get_Token()
IL2CPP_EXTERN_C IL2CPP_METHOD_ATTR int32_t JsonReader_get_Token_m7F5CC436CA0047F296F3220A29D530263317294E (JsonReader_tE72AF24875A229A65356715AAFF4C23E38105A3F* __this, const RuntimeMethod* method) 
{
	{
		// get { return token; }
		int32_t L_0 = __this->___token_14;
		return L_0;
	}
}
// System.Object Agora.Rtc.LitJson.JsonReader::get_Value()
IL2CPP_EXTERN_C IL2CPP_METHOD_ATTR RuntimeObject* JsonReader_get_Value_m30473E55683480477392957E2AFD136CD6929D06 (JsonReader_tE72AF24875A229A65356715AAFF4C23E38105A3F* __this, const RuntimeMethod* method) 
{
	{
		// get { return token_value; }
		RuntimeObject* L_0 = __this->___token_value_13;
		return L_0;
	}
}
// System.Void Agora.Rtc.LitJson.JsonReader::.cctor()
IL2CPP_EXTERN_C IL2CPP_METHOD_ATTR void JsonReader__cctor_m320E136906C2A89861E8F91CE28EEB0B9883849C (const RuntimeMethod* method) 
{
	static bool s_Il2CppMethodInitialized;
	if (!s_Il2CppMethodInitialized)
	{
		il2cpp_codegen_initialize_runtime_metadata((uintptr_t*)&JsonReader_tE72AF24875A229A65356715AAFF4C23E38105A3F_il2cpp_TypeInfo_var);
		s_Il2CppMethodInitialized = true;
	}
	{
		// parse_table = PopulateParseTable ();
		RuntimeObject* L_0;
		L_0 = JsonReader_PopulateParseTable_mFF40CD56EE19A80E03FEB78B71E53CFBBAEC22BE(NULL);
		((JsonReader_tE72AF24875A229A65356715AAFF4C23E38105A3F_StaticFields*)il2cpp_codegen_static_fields_for(JsonReader_tE72AF24875A229A65356715AAFF4C23E38105A3F_il2cpp_TypeInfo_var))->___parse_table_0 = L_0;
		Il2CppCodeGenWriteBarrier((void**)(&((JsonReader_tE72AF24875A229A65356715AAFF4C23E38105A3F_StaticFields*)il2cpp_codegen_static_fields_for(JsonReader_tE72AF24875A229A65356715AAFF4C23E38105A3F_il2cpp_TypeInfo_var))->___parse_table_0), (void*)L_0);
		// }
		return;
	}
}
// System.Void Agora.Rtc.LitJson.JsonReader::.ctor(System.String)
IL2CPP_EXTERN_C IL2CPP_METHOD_ATTR void JsonReader__ctor_mF53EB07B07A53E350ADA3A4F501075AE2ABEF89A (JsonReader_tE72AF24875A229A65356715AAFF4C23E38105A3F* __this, String_t* ___json_text0, const RuntimeMethod* method) 
{
	static bool s_Il2CppMethodInitialized;
	if (!s_Il2CppMethodInitialized)
	{
		il2cpp_codegen_initialize_runtime_metadata((uintptr_t*)&StringReader_t1A336148FF22A9584E759A9D720CC96C23E35DD8_il2cpp_TypeInfo_var);
		s_Il2CppMethodInitialized = true;
	}
	{
		// this (new StringReader (json_text), true)
		String_t* L_0 = ___json_text0;
		StringReader_t1A336148FF22A9584E759A9D720CC96C23E35DD8* L_1 = (StringReader_t1A336148FF22A9584E759A9D720CC96C23E35DD8*)il2cpp_codegen_object_new(StringReader_t1A336148FF22A9584E759A9D720CC96C23E35DD8_il2cpp_TypeInfo_var);
		NullCheck(L_1);
		StringReader__ctor_m72556EC1062F49E05CF41B0825AC7FA2DB2A81C0(L_1, L_0, NULL);
		JsonReader__ctor_m8532B5B8E63218CC7A3123B9935E1C5E44A07BBC(__this, L_1, (bool)1, NULL);
		// }
		return;
	}
}
// System.Void Agora.Rtc.LitJson.JsonReader::.ctor(System.IO.TextReader)
IL2CPP_EXTERN_C IL2CPP_METHOD_ATTR void JsonReader__ctor_m82DA8B1C74DC0B47222FA2CF62CC597B8789D182 (JsonReader_tE72AF24875A229A65356715AAFF4C23E38105A3F* __this, TextReader_tB8D43017CB6BE1633E5A86D64E7757366507C1F7* ___reader0, const RuntimeMethod* method) 
{
	{
		// this (reader, false)
		TextReader_tB8D43017CB6BE1633E5A86D64E7757366507C1F7* L_0 = ___reader0;
		JsonReader__ctor_m8532B5B8E63218CC7A3123B9935E1C5E44A07BBC(__this, L_0, (bool)0, NULL);
		// }
		return;
	}
}
// System.Void Agora.Rtc.LitJson.JsonReader::.ctor(System.IO.TextReader,System.Boolean)
IL2CPP_EXTERN_C IL2CPP_METHOD_ATTR void JsonReader__ctor_m8532B5B8E63218CC7A3123B9935E1C5E44A07BBC (JsonReader_tE72AF24875A229A65356715AAFF4C23E38105A3F* __this, TextReader_tB8D43017CB6BE1633E5A86D64E7757366507C1F7* ___reader0, bool ___owned1, const RuntimeMethod* method) 
{
	static bool s_Il2CppMethodInitialized;
	if (!s_Il2CppMethodInitialized)
	{
		il2cpp_codegen_initialize_runtime_metadata((uintptr_t*)&Lexer_tDC14CFA7B390E884510F554D9D1E03188A185E27_il2cpp_TypeInfo_var);
		il2cpp_codegen_initialize_runtime_metadata((uintptr_t*)&Stack_1_Push_mF7CC12CF73D9D4B66FFA2E2D264270212CAB3EDA_RuntimeMethod_var);
		il2cpp_codegen_initialize_runtime_metadata((uintptr_t*)&Stack_1__ctor_mF63AE96E8925749CDACE05B89002A389DDD748D1_RuntimeMethod_var);
		il2cpp_codegen_initialize_runtime_metadata((uintptr_t*)&Stack_1_t3197E0F5EA36E611B259A88751D31FC2396FE4B6_il2cpp_TypeInfo_var);
		s_Il2CppMethodInitialized = true;
	}
	{
		// private JsonReader (TextReader reader, bool owned)
		Object__ctor_mE837C6B9FA8C6D5D109F4B2EC885D79919AC0EA2(__this, NULL);
		// if (reader == null)
		TextReader_tB8D43017CB6BE1633E5A86D64E7757366507C1F7* L_0 = ___reader0;
		if (L_0)
		{
			goto IL_0014;
		}
	}
	{
		// throw new ArgumentNullException ("reader");
		ArgumentNullException_t327031E412FAB2351B0022DD5DAD47E67E597129* L_1 = (ArgumentNullException_t327031E412FAB2351B0022DD5DAD47E67E597129*)il2cpp_codegen_object_new(((RuntimeClass*)il2cpp_codegen_initialize_runtime_metadata_inline((uintptr_t*)&ArgumentNullException_t327031E412FAB2351B0022DD5DAD47E67E597129_il2cpp_TypeInfo_var)));
		NullCheck(L_1);
		ArgumentNullException__ctor_m444AE141157E333844FC1A9500224C2F9FD24F4B(L_1, ((String_t*)il2cpp_codegen_initialize_runtime_metadata_inline((uintptr_t*)&_stringLiteralECAC83771A00C701043A940F621CC1C765D30D31)), NULL);
		IL2CPP_RAISE_MANAGED_EXCEPTION(L_1, ((RuntimeMethod*)il2cpp_codegen_initialize_runtime_metadata_inline((uintptr_t*)&JsonReader__ctor_m8532B5B8E63218CC7A3123B9935E1C5E44A07BBC_RuntimeMethod_var)));
	}

IL_0014:
	{
		// parser_in_string = false;
		__this->___parser_in_string_7 = (bool)0;
		// parser_return    = false;
		__this->___parser_return_8 = (bool)0;
		// read_started = false;
		__this->___read_started_9 = (bool)0;
		// automaton_stack = new Stack<int> ();
		Stack_1_t3197E0F5EA36E611B259A88751D31FC2396FE4B6* L_2 = (Stack_1_t3197E0F5EA36E611B259A88751D31FC2396FE4B6*)il2cpp_codegen_object_new(Stack_1_t3197E0F5EA36E611B259A88751D31FC2396FE4B6_il2cpp_TypeInfo_var);
		NullCheck(L_2);
		Stack_1__ctor_mF63AE96E8925749CDACE05B89002A389DDD748D1(L_2, Stack_1__ctor_mF63AE96E8925749CDACE05B89002A389DDD748D1_RuntimeMethod_var);
		__this->___automaton_stack_1 = L_2;
		Il2CppCodeGenWriteBarrier((void**)(&__this->___automaton_stack_1), (void*)L_2);
		// automaton_stack.Push ((int) ParserToken.End);
		Stack_1_t3197E0F5EA36E611B259A88751D31FC2396FE4B6* L_3 = __this->___automaton_stack_1;
		NullCheck(L_3);
		Stack_1_Push_mF7CC12CF73D9D4B66FFA2E2D264270212CAB3EDA(L_3, ((int32_t)65553), Stack_1_Push_mF7CC12CF73D9D4B66FFA2E2D264270212CAB3EDA_RuntimeMethod_var);
		// automaton_stack.Push ((int) ParserToken.Text);
		Stack_1_t3197E0F5EA36E611B259A88751D31FC2396FE4B6* L_4 = __this->___automaton_stack_1;
		NullCheck(L_4);
		Stack_1_Push_mF7CC12CF73D9D4B66FFA2E2D264270212CAB3EDA(L_4, ((int32_t)65543), Stack_1_Push_mF7CC12CF73D9D4B66FFA2E2D264270212CAB3EDA_RuntimeMethod_var);
		// lexer = new Lexer (reader);
		TextReader_tB8D43017CB6BE1633E5A86D64E7757366507C1F7* L_5 = ___reader0;
		Lexer_tDC14CFA7B390E884510F554D9D1E03188A185E27* L_6 = (Lexer_tDC14CFA7B390E884510F554D9D1E03188A185E27*)il2cpp_codegen_object_new(Lexer_tDC14CFA7B390E884510F554D9D1E03188A185E27_il2cpp_TypeInfo_var);
		NullCheck(L_6);
		Lexer__ctor_mC0FA8A9D9BF9E529309C24F013B2A4F555F1727A(L_6, L_5, NULL);
		__this->___lexer_6 = L_6;
		Il2CppCodeGenWriteBarrier((void**)(&__this->___lexer_6), (void*)L_6);
		// end_of_input = false;
		__this->___end_of_input_5 = (bool)0;
		// end_of_json  = false;
		__this->___end_of_json_4 = (bool)0;
		// skip_non_members = true;
		__this->___skip_non_members_12 = (bool)1;
		// this.reader = reader;
		TextReader_tB8D43017CB6BE1633E5A86D64E7757366507C1F7* L_7 = ___reader0;
		__this->___reader_10 = L_7;
		Il2CppCodeGenWriteBarrier((void**)(&__this->___reader_10), (void*)L_7);
		// reader_is_owned = owned;
		bool L_8 = ___owned1;
		__this->___reader_is_owned_11 = L_8;
		// }
		return;
	}
}
// System.Collections.Generic.IDictionary`2<System.Int32,System.Collections.Generic.IDictionary`2<System.Int32,System.Int32[]>> Agora.Rtc.LitJson.JsonReader::PopulateParseTable()
IL2CPP_EXTERN_C IL2CPP_METHOD_ATTR RuntimeObject* JsonReader_PopulateParseTable_mFF40CD56EE19A80E03FEB78B71E53CFBBAEC22BE (const RuntimeMethod* method) 
{
	static bool s_Il2CppMethodInitialized;
	if (!s_Il2CppMethodInitialized)
	{
		il2cpp_codegen_initialize_runtime_metadata((uintptr_t*)&Dictionary_2__ctor_mF37C098D396E6388CF354D6F37970685A85B6FC0_RuntimeMethod_var);
		il2cpp_codegen_initialize_runtime_metadata((uintptr_t*)&Dictionary_2_t403ABC2FA2D9740F9ADD28DB8815C00EE2DB4249_il2cpp_TypeInfo_var);
		il2cpp_codegen_initialize_runtime_metadata((uintptr_t*)&Int32U5BU5D_t19C97395396A72ECAF310612F0760F165060314C_il2cpp_TypeInfo_var);
		il2cpp_codegen_initialize_runtime_metadata((uintptr_t*)&JsonReader_tE72AF24875A229A65356715AAFF4C23E38105A3F_il2cpp_TypeInfo_var);
		il2cpp_codegen_initialize_runtime_metadata((uintptr_t*)&U3CPrivateImplementationDetailsU3E_t0F5473E849A5A5185A9F4C5246F0C32816C49FCA____59B7E757844D3BF9299877BD1C17451611BFBAB493374D6B18D973FDE534151A_0_FieldInfo_var);
		il2cpp_codegen_initialize_runtime_metadata((uintptr_t*)&U3CPrivateImplementationDetailsU3E_t0F5473E849A5A5185A9F4C5246F0C32816C49FCA____5B979F69B96A61586A09DD4ED26F20534C629B08732AE32FA34B6F8A0049ACDD_1_FieldInfo_var);
		il2cpp_codegen_initialize_runtime_metadata((uintptr_t*)&U3CPrivateImplementationDetailsU3E_t0F5473E849A5A5185A9F4C5246F0C32816C49FCA____7FCA397EF25DB53B2C58A05F9BBFA4E8E0685FDBC8AAF39536123447056895C0_2_FieldInfo_var);
		il2cpp_codegen_initialize_runtime_metadata((uintptr_t*)&U3CPrivateImplementationDetailsU3E_t0F5473E849A5A5185A9F4C5246F0C32816C49FCA____B257E85A5D3CAB5E738D5A0FD1A7AE96624BFE92CB7915726CBBE1518C3225CF_3_FieldInfo_var);
		il2cpp_codegen_initialize_runtime_metadata((uintptr_t*)&U3CPrivateImplementationDetailsU3E_t0F5473E849A5A5185A9F4C5246F0C32816C49FCA____B7A918F6F138CA8137025633559198B529D28CCEC5A51B005376CC69A5B83D85_4_FieldInfo_var);
		il2cpp_codegen_initialize_runtime_metadata((uintptr_t*)&U3CPrivateImplementationDetailsU3E_t0F5473E849A5A5185A9F4C5246F0C32816C49FCA____FC03ECB1D62767A5B31230F548FA4D4C02F01E3DA8CA1FC66C7C332EA16BF206_6_FieldInfo_var);
		s_Il2CppMethodInitialized = true;
	}
	RuntimeObject* V_0 = NULL;
	{
		// IDictionary<int, IDictionary<int, int[]>> parse_table = new Dictionary<int, IDictionary<int, int[]>> ();
		Dictionary_2_t403ABC2FA2D9740F9ADD28DB8815C00EE2DB4249* L_0 = (Dictionary_2_t403ABC2FA2D9740F9ADD28DB8815C00EE2DB4249*)il2cpp_codegen_object_new(Dictionary_2_t403ABC2FA2D9740F9ADD28DB8815C00EE2DB4249_il2cpp_TypeInfo_var);
		NullCheck(L_0);
		Dictionary_2__ctor_mF37C098D396E6388CF354D6F37970685A85B6FC0(L_0, Dictionary_2__ctor_mF37C098D396E6388CF354D6F37970685A85B6FC0_RuntimeMethod_var);
		V_0 = L_0;
		// TableAddRow (parse_table, ParserToken.Array);
		RuntimeObject* L_1 = V_0;
		il2cpp_codegen_runtime_class_init_inline(JsonReader_tE72AF24875A229A65356715AAFF4C23E38105A3F_il2cpp_TypeInfo_var);
		JsonReader_TableAddRow_mD4C19201516D293B36F4BC52B1BC41F2A837230B(L_1, ((int32_t)65548), NULL);
		// TableAddCol (parse_table, ParserToken.Array, '[',
		//                 '[',
		//                 (int) ParserToken.ArrayPrime);
		RuntimeObject* L_2 = V_0;
		Int32U5BU5D_t19C97395396A72ECAF310612F0760F165060314C* L_3 = (Int32U5BU5D_t19C97395396A72ECAF310612F0760F165060314C*)(Int32U5BU5D_t19C97395396A72ECAF310612F0760F165060314C*)SZArrayNew(Int32U5BU5D_t19C97395396A72ECAF310612F0760F165060314C_il2cpp_TypeInfo_var, (uint32_t)2);
		Int32U5BU5D_t19C97395396A72ECAF310612F0760F165060314C* L_4 = L_3;
		NullCheck(L_4);
		(L_4)->SetAt(static_cast<il2cpp_array_size_t>(0), (int32_t)((int32_t)91));
		Int32U5BU5D_t19C97395396A72ECAF310612F0760F165060314C* L_5 = L_4;
		NullCheck(L_5);
		(L_5)->SetAt(static_cast<il2cpp_array_size_t>(1), (int32_t)((int32_t)65549));
		JsonReader_TableAddCol_mC7A131F8C9F735843F03721B124116C59B9D2843(L_2, ((int32_t)65548), ((int32_t)91), L_5, NULL);
		// TableAddRow (parse_table, ParserToken.ArrayPrime);
		RuntimeObject* L_6 = V_0;
		JsonReader_TableAddRow_mD4C19201516D293B36F4BC52B1BC41F2A837230B(L_6, ((int32_t)65549), NULL);
		// TableAddCol (parse_table, ParserToken.ArrayPrime, '"',
		//                 (int) ParserToken.Value,
		// 
		//                 (int) ParserToken.ValueRest,
		//                 ']');
		RuntimeObject* L_7 = V_0;
		Int32U5BU5D_t19C97395396A72ECAF310612F0760F165060314C* L_8 = (Int32U5BU5D_t19C97395396A72ECAF310612F0760F165060314C*)(Int32U5BU5D_t19C97395396A72ECAF310612F0760F165060314C*)SZArrayNew(Int32U5BU5D_t19C97395396A72ECAF310612F0760F165060314C_il2cpp_TypeInfo_var, (uint32_t)3);
		Int32U5BU5D_t19C97395396A72ECAF310612F0760F165060314C* L_9 = L_8;
		RuntimeFieldHandle_t6E4C45B6D2EA12FC99185805A7E77527899B25C5 L_10 = { reinterpret_cast<intptr_t> (U3CPrivateImplementationDetailsU3E_t0F5473E849A5A5185A9F4C5246F0C32816C49FCA____7FCA397EF25DB53B2C58A05F9BBFA4E8E0685FDBC8AAF39536123447056895C0_2_FieldInfo_var) };
		RuntimeHelpers_InitializeArray_m751372AA3F24FBF6DA9B9D687CBFA2DE436CAB9B((RuntimeArray*)L_9, L_10, NULL);
		JsonReader_TableAddCol_mC7A131F8C9F735843F03721B124116C59B9D2843(L_7, ((int32_t)65549), ((int32_t)34), L_9, NULL);
		// TableAddCol (parse_table, ParserToken.ArrayPrime, '[',
		//                 (int) ParserToken.Value,
		//                 (int) ParserToken.ValueRest,
		//                 ']');
		RuntimeObject* L_11 = V_0;
		Int32U5BU5D_t19C97395396A72ECAF310612F0760F165060314C* L_12 = (Int32U5BU5D_t19C97395396A72ECAF310612F0760F165060314C*)(Int32U5BU5D_t19C97395396A72ECAF310612F0760F165060314C*)SZArrayNew(Int32U5BU5D_t19C97395396A72ECAF310612F0760F165060314C_il2cpp_TypeInfo_var, (uint32_t)3);
		Int32U5BU5D_t19C97395396A72ECAF310612F0760F165060314C* L_13 = L_12;
		RuntimeFieldHandle_t6E4C45B6D2EA12FC99185805A7E77527899B25C5 L_14 = { reinterpret_cast<intptr_t> (U3CPrivateImplementationDetailsU3E_t0F5473E849A5A5185A9F4C5246F0C32816C49FCA____7FCA397EF25DB53B2C58A05F9BBFA4E8E0685FDBC8AAF39536123447056895C0_2_FieldInfo_var) };
		RuntimeHelpers_InitializeArray_m751372AA3F24FBF6DA9B9D687CBFA2DE436CAB9B((RuntimeArray*)L_13, L_14, NULL);
		JsonReader_TableAddCol_mC7A131F8C9F735843F03721B124116C59B9D2843(L_11, ((int32_t)65549), ((int32_t)91), L_13, NULL);
		// TableAddCol (parse_table, ParserToken.ArrayPrime, ']',
		//                 ']');
		RuntimeObject* L_15 = V_0;
		Int32U5BU5D_t19C97395396A72ECAF310612F0760F165060314C* L_16 = (Int32U5BU5D_t19C97395396A72ECAF310612F0760F165060314C*)(Int32U5BU5D_t19C97395396A72ECAF310612F0760F165060314C*)SZArrayNew(Int32U5BU5D_t19C97395396A72ECAF310612F0760F165060314C_il2cpp_TypeInfo_var, (uint32_t)1);
		Int32U5BU5D_t19C97395396A72ECAF310612F0760F165060314C* L_17 = L_16;
		NullCheck(L_17);
		(L_17)->SetAt(static_cast<il2cpp_array_size_t>(0), (int32_t)((int32_t)93));
		JsonReader_TableAddCol_mC7A131F8C9F735843F03721B124116C59B9D2843(L_15, ((int32_t)65549), ((int32_t)93), L_17, NULL);
		// TableAddCol (parse_table, ParserToken.ArrayPrime, '{',
		//                 (int) ParserToken.Value,
		//                 (int) ParserToken.ValueRest,
		//                 ']');
		RuntimeObject* L_18 = V_0;
		Int32U5BU5D_t19C97395396A72ECAF310612F0760F165060314C* L_19 = (Int32U5BU5D_t19C97395396A72ECAF310612F0760F165060314C*)(Int32U5BU5D_t19C97395396A72ECAF310612F0760F165060314C*)SZArrayNew(Int32U5BU5D_t19C97395396A72ECAF310612F0760F165060314C_il2cpp_TypeInfo_var, (uint32_t)3);
		Int32U5BU5D_t19C97395396A72ECAF310612F0760F165060314C* L_20 = L_19;
		RuntimeFieldHandle_t6E4C45B6D2EA12FC99185805A7E77527899B25C5 L_21 = { reinterpret_cast<intptr_t> (U3CPrivateImplementationDetailsU3E_t0F5473E849A5A5185A9F4C5246F0C32816C49FCA____7FCA397EF25DB53B2C58A05F9BBFA4E8E0685FDBC8AAF39536123447056895C0_2_FieldInfo_var) };
		RuntimeHelpers_InitializeArray_m751372AA3F24FBF6DA9B9D687CBFA2DE436CAB9B((RuntimeArray*)L_20, L_21, NULL);
		JsonReader_TableAddCol_mC7A131F8C9F735843F03721B124116C59B9D2843(L_18, ((int32_t)65549), ((int32_t)123), L_20, NULL);
		// TableAddCol (parse_table, ParserToken.ArrayPrime, (int) ParserToken.Number,
		//                 (int) ParserToken.Value,
		//                 (int) ParserToken.ValueRest,
		//                 ']');
		RuntimeObject* L_22 = V_0;
		Int32U5BU5D_t19C97395396A72ECAF310612F0760F165060314C* L_23 = (Int32U5BU5D_t19C97395396A72ECAF310612F0760F165060314C*)(Int32U5BU5D_t19C97395396A72ECAF310612F0760F165060314C*)SZArrayNew(Int32U5BU5D_t19C97395396A72ECAF310612F0760F165060314C_il2cpp_TypeInfo_var, (uint32_t)3);
		Int32U5BU5D_t19C97395396A72ECAF310612F0760F165060314C* L_24 = L_23;
		RuntimeFieldHandle_t6E4C45B6D2EA12FC99185805A7E77527899B25C5 L_25 = { reinterpret_cast<intptr_t> (U3CPrivateImplementationDetailsU3E_t0F5473E849A5A5185A9F4C5246F0C32816C49FCA____7FCA397EF25DB53B2C58A05F9BBFA4E8E0685FDBC8AAF39536123447056895C0_2_FieldInfo_var) };
		RuntimeHelpers_InitializeArray_m751372AA3F24FBF6DA9B9D687CBFA2DE436CAB9B((RuntimeArray*)L_24, L_25, NULL);
		JsonReader_TableAddCol_mC7A131F8C9F735843F03721B124116C59B9D2843(L_22, ((int32_t)65549), ((int32_t)65537), L_24, NULL);
		// TableAddCol (parse_table, ParserToken.ArrayPrime, (int) ParserToken.True,
		//                 (int) ParserToken.Value,
		//                 (int) ParserToken.ValueRest,
		//                 ']');
		RuntimeObject* L_26 = V_0;
		Int32U5BU5D_t19C97395396A72ECAF310612F0760F165060314C* L_27 = (Int32U5BU5D_t19C97395396A72ECAF310612F0760F165060314C*)(Int32U5BU5D_t19C97395396A72ECAF310612F0760F165060314C*)SZArrayNew(Int32U5BU5D_t19C97395396A72ECAF310612F0760F165060314C_il2cpp_TypeInfo_var, (uint32_t)3);
		Int32U5BU5D_t19C97395396A72ECAF310612F0760F165060314C* L_28 = L_27;
		RuntimeFieldHandle_t6E4C45B6D2EA12FC99185805A7E77527899B25C5 L_29 = { reinterpret_cast<intptr_t> (U3CPrivateImplementationDetailsU3E_t0F5473E849A5A5185A9F4C5246F0C32816C49FCA____7FCA397EF25DB53B2C58A05F9BBFA4E8E0685FDBC8AAF39536123447056895C0_2_FieldInfo_var) };
		RuntimeHelpers_InitializeArray_m751372AA3F24FBF6DA9B9D687CBFA2DE436CAB9B((RuntimeArray*)L_28, L_29, NULL);
		JsonReader_TableAddCol_mC7A131F8C9F735843F03721B124116C59B9D2843(L_26, ((int32_t)65549), ((int32_t)65538), L_28, NULL);
		// TableAddCol (parse_table, ParserToken.ArrayPrime, (int) ParserToken.False,
		//                 (int) ParserToken.Value,
		//                 (int) ParserToken.ValueRest,
		//                 ']');
		RuntimeObject* L_30 = V_0;
		Int32U5BU5D_t19C97395396A72ECAF310612F0760F165060314C* L_31 = (Int32U5BU5D_t19C97395396A72ECAF310612F0760F165060314C*)(Int32U5BU5D_t19C97395396A72ECAF310612F0760F165060314C*)SZArrayNew(Int32U5BU5D_t19C97395396A72ECAF310612F0760F165060314C_il2cpp_TypeInfo_var, (uint32_t)3);
		Int32U5BU5D_t19C97395396A72ECAF310612F0760F165060314C* L_32 = L_31;
		RuntimeFieldHandle_t6E4C45B6D2EA12FC99185805A7E77527899B25C5 L_33 = { reinterpret_cast<intptr_t> (U3CPrivateImplementationDetailsU3E_t0F5473E849A5A5185A9F4C5246F0C32816C49FCA____7FCA397EF25DB53B2C58A05F9BBFA4E8E0685FDBC8AAF39536123447056895C0_2_FieldInfo_var) };
		RuntimeHelpers_InitializeArray_m751372AA3F24FBF6DA9B9D687CBFA2DE436CAB9B((RuntimeArray*)L_32, L_33, NULL);
		JsonReader_TableAddCol_mC7A131F8C9F735843F03721B124116C59B9D2843(L_30, ((int32_t)65549), ((int32_t)65539), L_32, NULL);
		// TableAddCol (parse_table, ParserToken.ArrayPrime, (int) ParserToken.Null,
		//                 (int) ParserToken.Value,
		//                 (int) ParserToken.ValueRest,
		//                 ']');
		RuntimeObject* L_34 = V_0;
		Int32U5BU5D_t19C97395396A72ECAF310612F0760F165060314C* L_35 = (Int32U5BU5D_t19C97395396A72ECAF310612F0760F165060314C*)(Int32U5BU5D_t19C97395396A72ECAF310612F0760F165060314C*)SZArrayNew(Int32U5BU5D_t19C97395396A72ECAF310612F0760F165060314C_il2cpp_TypeInfo_var, (uint32_t)3);
		Int32U5BU5D_t19C97395396A72ECAF310612F0760F165060314C* L_36 = L_35;
		RuntimeFieldHandle_t6E4C45B6D2EA12FC99185805A7E77527899B25C5 L_37 = { reinterpret_cast<intptr_t> (U3CPrivateImplementationDetailsU3E_t0F5473E849A5A5185A9F4C5246F0C32816C49FCA____7FCA397EF25DB53B2C58A05F9BBFA4E8E0685FDBC8AAF39536123447056895C0_2_FieldInfo_var) };
		RuntimeHelpers_InitializeArray_m751372AA3F24FBF6DA9B9D687CBFA2DE436CAB9B((RuntimeArray*)L_36, L_37, NULL);
		JsonReader_TableAddCol_mC7A131F8C9F735843F03721B124116C59B9D2843(L_34, ((int32_t)65549), ((int32_t)65540), L_36, NULL);
		// TableAddRow (parse_table, ParserToken.Object);
		RuntimeObject* L_38 = V_0;
		JsonReader_TableAddRow_mD4C19201516D293B36F4BC52B1BC41F2A837230B(L_38, ((int32_t)65544), NULL);
		// TableAddCol (parse_table, ParserToken.Object, '{',
		//                 '{',
		//                 (int) ParserToken.ObjectPrime);
		RuntimeObject* L_39 = V_0;
		Int32U5BU5D_t19C97395396A72ECAF310612F0760F165060314C* L_40 = (Int32U5BU5D_t19C97395396A72ECAF310612F0760F165060314C*)(Int32U5BU5D_t19C97395396A72ECAF310612F0760F165060314C*)SZArrayNew(Int32U5BU5D_t19C97395396A72ECAF310612F0760F165060314C_il2cpp_TypeInfo_var, (uint32_t)2);
		Int32U5BU5D_t19C97395396A72ECAF310612F0760F165060314C* L_41 = L_40;
		NullCheck(L_41);
		(L_41)->SetAt(static_cast<il2cpp_array_size_t>(0), (int32_t)((int32_t)123));
		Int32U5BU5D_t19C97395396A72ECAF310612F0760F165060314C* L_42 = L_41;
		NullCheck(L_42);
		(L_42)->SetAt(static_cast<il2cpp_array_size_t>(1), (int32_t)((int32_t)65545));
		JsonReader_TableAddCol_mC7A131F8C9F735843F03721B124116C59B9D2843(L_39, ((int32_t)65544), ((int32_t)123), L_42, NULL);
		// TableAddRow (parse_table, ParserToken.ObjectPrime);
		RuntimeObject* L_43 = V_0;
		JsonReader_TableAddRow_mD4C19201516D293B36F4BC52B1BC41F2A837230B(L_43, ((int32_t)65545), NULL);
		// TableAddCol (parse_table, ParserToken.ObjectPrime, '"',
		//                 (int) ParserToken.Pair,
		//                 (int) ParserToken.PairRest,
		//                 '}');
		RuntimeObject* L_44 = V_0;
		Int32U5BU5D_t19C97395396A72ECAF310612F0760F165060314C* L_45 = (Int32U5BU5D_t19C97395396A72ECAF310612F0760F165060314C*)(Int32U5BU5D_t19C97395396A72ECAF310612F0760F165060314C*)SZArrayNew(Int32U5BU5D_t19C97395396A72ECAF310612F0760F165060314C_il2cpp_TypeInfo_var, (uint32_t)3);
		Int32U5BU5D_t19C97395396A72ECAF310612F0760F165060314C* L_46 = L_45;
		RuntimeFieldHandle_t6E4C45B6D2EA12FC99185805A7E77527899B25C5 L_47 = { reinterpret_cast<intptr_t> (U3CPrivateImplementationDetailsU3E_t0F5473E849A5A5185A9F4C5246F0C32816C49FCA____59B7E757844D3BF9299877BD1C17451611BFBAB493374D6B18D973FDE534151A_0_FieldInfo_var) };
		RuntimeHelpers_InitializeArray_m751372AA3F24FBF6DA9B9D687CBFA2DE436CAB9B((RuntimeArray*)L_46, L_47, NULL);
		JsonReader_TableAddCol_mC7A131F8C9F735843F03721B124116C59B9D2843(L_44, ((int32_t)65545), ((int32_t)34), L_46, NULL);
		// TableAddCol (parse_table, ParserToken.ObjectPrime, '}',
		//                 '}');
		RuntimeObject* L_48 = V_0;
		Int32U5BU5D_t19C97395396A72ECAF310612F0760F165060314C* L_49 = (Int32U5BU5D_t19C97395396A72ECAF310612F0760F165060314C*)(Int32U5BU5D_t19C97395396A72ECAF310612F0760F165060314C*)SZArrayNew(Int32U5BU5D_t19C97395396A72ECAF310612F0760F165060314C_il2cpp_TypeInfo_var, (uint32_t)1);
		Int32U5BU5D_t19C97395396A72ECAF310612F0760F165060314C* L_50 = L_49;
		NullCheck(L_50);
		(L_50)->SetAt(static_cast<il2cpp_array_size_t>(0), (int32_t)((int32_t)125));
		JsonReader_TableAddCol_mC7A131F8C9F735843F03721B124116C59B9D2843(L_48, ((int32_t)65545), ((int32_t)125), L_50, NULL);
		// TableAddRow (parse_table, ParserToken.Pair);
		RuntimeObject* L_51 = V_0;
		JsonReader_TableAddRow_mD4C19201516D293B36F4BC52B1BC41F2A837230B(L_51, ((int32_t)65546), NULL);
		// TableAddCol (parse_table, ParserToken.Pair, '"',
		//                 (int) ParserToken.String,
		//                 ':',
		//                 (int) ParserToken.Value);
		RuntimeObject* L_52 = V_0;
		Int32U5BU5D_t19C97395396A72ECAF310612F0760F165060314C* L_53 = (Int32U5BU5D_t19C97395396A72ECAF310612F0760F165060314C*)(Int32U5BU5D_t19C97395396A72ECAF310612F0760F165060314C*)SZArrayNew(Int32U5BU5D_t19C97395396A72ECAF310612F0760F165060314C_il2cpp_TypeInfo_var, (uint32_t)3);
		Int32U5BU5D_t19C97395396A72ECAF310612F0760F165060314C* L_54 = L_53;
		RuntimeFieldHandle_t6E4C45B6D2EA12FC99185805A7E77527899B25C5 L_55 = { reinterpret_cast<intptr_t> (U3CPrivateImplementationDetailsU3E_t0F5473E849A5A5185A9F4C5246F0C32816C49FCA____B7A918F6F138CA8137025633559198B529D28CCEC5A51B005376CC69A5B83D85_4_FieldInfo_var) };
		RuntimeHelpers_InitializeArray_m751372AA3F24FBF6DA9B9D687CBFA2DE436CAB9B((RuntimeArray*)L_54, L_55, NULL);
		JsonReader_TableAddCol_mC7A131F8C9F735843F03721B124116C59B9D2843(L_52, ((int32_t)65546), ((int32_t)34), L_54, NULL);
		// TableAddRow (parse_table, ParserToken.PairRest);
		RuntimeObject* L_56 = V_0;
		JsonReader_TableAddRow_mD4C19201516D293B36F4BC52B1BC41F2A837230B(L_56, ((int32_t)65547), NULL);
		// TableAddCol (parse_table, ParserToken.PairRest, ',',
		//                 ',',
		//                 (int) ParserToken.Pair,
		//                 (int) ParserToken.PairRest);
		RuntimeObject* L_57 = V_0;
		Int32U5BU5D_t19C97395396A72ECAF310612F0760F165060314C* L_58 = (Int32U5BU5D_t19C97395396A72ECAF310612F0760F165060314C*)(Int32U5BU5D_t19C97395396A72ECAF310612F0760F165060314C*)SZArrayNew(Int32U5BU5D_t19C97395396A72ECAF310612F0760F165060314C_il2cpp_TypeInfo_var, (uint32_t)3);
		Int32U5BU5D_t19C97395396A72ECAF310612F0760F165060314C* L_59 = L_58;
		RuntimeFieldHandle_t6E4C45B6D2EA12FC99185805A7E77527899B25C5 L_60 = { reinterpret_cast<intptr_t> (U3CPrivateImplementationDetailsU3E_t0F5473E849A5A5185A9F4C5246F0C32816C49FCA____FC03ECB1D62767A5B31230F548FA4D4C02F01E3DA8CA1FC66C7C332EA16BF206_6_FieldInfo_var) };
		RuntimeHelpers_InitializeArray_m751372AA3F24FBF6DA9B9D687CBFA2DE436CAB9B((RuntimeArray*)L_59, L_60, NULL);
		JsonReader_TableAddCol_mC7A131F8C9F735843F03721B124116C59B9D2843(L_57, ((int32_t)65547), ((int32_t)44), L_59, NULL);
		// TableAddCol (parse_table, ParserToken.PairRest, '}',
		//                 (int) ParserToken.Epsilon);
		RuntimeObject* L_61 = V_0;
		Int32U5BU5D_t19C97395396A72ECAF310612F0760F165060314C* L_62 = (Int32U5BU5D_t19C97395396A72ECAF310612F0760F165060314C*)(Int32U5BU5D_t19C97395396A72ECAF310612F0760F165060314C*)SZArrayNew(Int32U5BU5D_t19C97395396A72ECAF310612F0760F165060314C_il2cpp_TypeInfo_var, (uint32_t)1);
		Int32U5BU5D_t19C97395396A72ECAF310612F0760F165060314C* L_63 = L_62;
		NullCheck(L_63);
		(L_63)->SetAt(static_cast<il2cpp_array_size_t>(0), (int32_t)((int32_t)65554));
		JsonReader_TableAddCol_mC7A131F8C9F735843F03721B124116C59B9D2843(L_61, ((int32_t)65547), ((int32_t)125), L_63, NULL);
		// TableAddRow (parse_table, ParserToken.String);
		RuntimeObject* L_64 = V_0;
		JsonReader_TableAddRow_mD4C19201516D293B36F4BC52B1BC41F2A837230B(L_64, ((int32_t)65552), NULL);
		// TableAddCol (parse_table, ParserToken.String, '"',
		//                 '"',
		//                 (int) ParserToken.CharSeq,
		//                 '"');
		RuntimeObject* L_65 = V_0;
		Int32U5BU5D_t19C97395396A72ECAF310612F0760F165060314C* L_66 = (Int32U5BU5D_t19C97395396A72ECAF310612F0760F165060314C*)(Int32U5BU5D_t19C97395396A72ECAF310612F0760F165060314C*)SZArrayNew(Int32U5BU5D_t19C97395396A72ECAF310612F0760F165060314C_il2cpp_TypeInfo_var, (uint32_t)3);
		Int32U5BU5D_t19C97395396A72ECAF310612F0760F165060314C* L_67 = L_66;
		RuntimeFieldHandle_t6E4C45B6D2EA12FC99185805A7E77527899B25C5 L_68 = { reinterpret_cast<intptr_t> (U3CPrivateImplementationDetailsU3E_t0F5473E849A5A5185A9F4C5246F0C32816C49FCA____B257E85A5D3CAB5E738D5A0FD1A7AE96624BFE92CB7915726CBBE1518C3225CF_3_FieldInfo_var) };
		RuntimeHelpers_InitializeArray_m751372AA3F24FBF6DA9B9D687CBFA2DE436CAB9B((RuntimeArray*)L_67, L_68, NULL);
		JsonReader_TableAddCol_mC7A131F8C9F735843F03721B124116C59B9D2843(L_65, ((int32_t)65552), ((int32_t)34), L_67, NULL);
		// TableAddRow (parse_table, ParserToken.Text);
		RuntimeObject* L_69 = V_0;
		JsonReader_TableAddRow_mD4C19201516D293B36F4BC52B1BC41F2A837230B(L_69, ((int32_t)65543), NULL);
		// TableAddCol (parse_table, ParserToken.Text, '[',
		//                 (int) ParserToken.Array);
		RuntimeObject* L_70 = V_0;
		Int32U5BU5D_t19C97395396A72ECAF310612F0760F165060314C* L_71 = (Int32U5BU5D_t19C97395396A72ECAF310612F0760F165060314C*)(Int32U5BU5D_t19C97395396A72ECAF310612F0760F165060314C*)SZArrayNew(Int32U5BU5D_t19C97395396A72ECAF310612F0760F165060314C_il2cpp_TypeInfo_var, (uint32_t)1);
		Int32U5BU5D_t19C97395396A72ECAF310612F0760F165060314C* L_72 = L_71;
		NullCheck(L_72);
		(L_72)->SetAt(static_cast<il2cpp_array_size_t>(0), (int32_t)((int32_t)65548));
		JsonReader_TableAddCol_mC7A131F8C9F735843F03721B124116C59B9D2843(L_70, ((int32_t)65543), ((int32_t)91), L_72, NULL);
		// TableAddCol (parse_table, ParserToken.Text, '{',
		//                 (int) ParserToken.Object);
		RuntimeObject* L_73 = V_0;
		Int32U5BU5D_t19C97395396A72ECAF310612F0760F165060314C* L_74 = (Int32U5BU5D_t19C97395396A72ECAF310612F0760F165060314C*)(Int32U5BU5D_t19C97395396A72ECAF310612F0760F165060314C*)SZArrayNew(Int32U5BU5D_t19C97395396A72ECAF310612F0760F165060314C_il2cpp_TypeInfo_var, (uint32_t)1);
		Int32U5BU5D_t19C97395396A72ECAF310612F0760F165060314C* L_75 = L_74;
		NullCheck(L_75);
		(L_75)->SetAt(static_cast<il2cpp_array_size_t>(0), (int32_t)((int32_t)65544));
		JsonReader_TableAddCol_mC7A131F8C9F735843F03721B124116C59B9D2843(L_73, ((int32_t)65543), ((int32_t)123), L_75, NULL);
		// TableAddRow (parse_table, ParserToken.Value);
		RuntimeObject* L_76 = V_0;
		JsonReader_TableAddRow_mD4C19201516D293B36F4BC52B1BC41F2A837230B(L_76, ((int32_t)65550), NULL);
		// TableAddCol (parse_table, ParserToken.Value, '"',
		//                 (int) ParserToken.String);
		RuntimeObject* L_77 = V_0;
		Int32U5BU5D_t19C97395396A72ECAF310612F0760F165060314C* L_78 = (Int32U5BU5D_t19C97395396A72ECAF310612F0760F165060314C*)(Int32U5BU5D_t19C97395396A72ECAF310612F0760F165060314C*)SZArrayNew(Int32U5BU5D_t19C97395396A72ECAF310612F0760F165060314C_il2cpp_TypeInfo_var, (uint32_t)1);
		Int32U5BU5D_t19C97395396A72ECAF310612F0760F165060314C* L_79 = L_78;
		NullCheck(L_79);
		(L_79)->SetAt(static_cast<il2cpp_array_size_t>(0), (int32_t)((int32_t)65552));
		JsonReader_TableAddCol_mC7A131F8C9F735843F03721B124116C59B9D2843(L_77, ((int32_t)65550), ((int32_t)34), L_79, NULL);
		// TableAddCol (parse_table, ParserToken.Value, '[',
		//                 (int) ParserToken.Array);
		RuntimeObject* L_80 = V_0;
		Int32U5BU5D_t19C97395396A72ECAF310612F0760F165060314C* L_81 = (Int32U5BU5D_t19C97395396A72ECAF310612F0760F165060314C*)(Int32U5BU5D_t19C97395396A72ECAF310612F0760F165060314C*)SZArrayNew(Int32U5BU5D_t19C97395396A72ECAF310612F0760F165060314C_il2cpp_TypeInfo_var, (uint32_t)1);
		Int32U5BU5D_t19C97395396A72ECAF310612F0760F165060314C* L_82 = L_81;
		NullCheck(L_82);
		(L_82)->SetAt(static_cast<il2cpp_array_size_t>(0), (int32_t)((int32_t)65548));
		JsonReader_TableAddCol_mC7A131F8C9F735843F03721B124116C59B9D2843(L_80, ((int32_t)65550), ((int32_t)91), L_82, NULL);
		// TableAddCol (parse_table, ParserToken.Value, '{',
		//                 (int) ParserToken.Object);
		RuntimeObject* L_83 = V_0;
		Int32U5BU5D_t19C97395396A72ECAF310612F0760F165060314C* L_84 = (Int32U5BU5D_t19C97395396A72ECAF310612F0760F165060314C*)(Int32U5BU5D_t19C97395396A72ECAF310612F0760F165060314C*)SZArrayNew(Int32U5BU5D_t19C97395396A72ECAF310612F0760F165060314C_il2cpp_TypeInfo_var, (uint32_t)1);
		Int32U5BU5D_t19C97395396A72ECAF310612F0760F165060314C* L_85 = L_84;
		NullCheck(L_85);
		(L_85)->SetAt(static_cast<il2cpp_array_size_t>(0), (int32_t)((int32_t)65544));
		JsonReader_TableAddCol_mC7A131F8C9F735843F03721B124116C59B9D2843(L_83, ((int32_t)65550), ((int32_t)123), L_85, NULL);
		// TableAddCol (parse_table, ParserToken.Value, (int) ParserToken.Number,
		//                 (int) ParserToken.Number);
		RuntimeObject* L_86 = V_0;
		Int32U5BU5D_t19C97395396A72ECAF310612F0760F165060314C* L_87 = (Int32U5BU5D_t19C97395396A72ECAF310612F0760F165060314C*)(Int32U5BU5D_t19C97395396A72ECAF310612F0760F165060314C*)SZArrayNew(Int32U5BU5D_t19C97395396A72ECAF310612F0760F165060314C_il2cpp_TypeInfo_var, (uint32_t)1);
		Int32U5BU5D_t19C97395396A72ECAF310612F0760F165060314C* L_88 = L_87;
		NullCheck(L_88);
		(L_88)->SetAt(static_cast<il2cpp_array_size_t>(0), (int32_t)((int32_t)65537));
		JsonReader_TableAddCol_mC7A131F8C9F735843F03721B124116C59B9D2843(L_86, ((int32_t)65550), ((int32_t)65537), L_88, NULL);
		// TableAddCol (parse_table, ParserToken.Value, (int) ParserToken.True,
		//                 (int) ParserToken.True);
		RuntimeObject* L_89 = V_0;
		Int32U5BU5D_t19C97395396A72ECAF310612F0760F165060314C* L_90 = (Int32U5BU5D_t19C97395396A72ECAF310612F0760F165060314C*)(Int32U5BU5D_t19C97395396A72ECAF310612F0760F165060314C*)SZArrayNew(Int32U5BU5D_t19C97395396A72ECAF310612F0760F165060314C_il2cpp_TypeInfo_var, (uint32_t)1);
		Int32U5BU5D_t19C97395396A72ECAF310612F0760F165060314C* L_91 = L_90;
		NullCheck(L_91);
		(L_91)->SetAt(static_cast<il2cpp_array_size_t>(0), (int32_t)((int32_t)65538));
		JsonReader_TableAddCol_mC7A131F8C9F735843F03721B124116C59B9D2843(L_89, ((int32_t)65550), ((int32_t)65538), L_91, NULL);
		// TableAddCol (parse_table, ParserToken.Value, (int) ParserToken.False,
		//                 (int) ParserToken.False);
		RuntimeObject* L_92 = V_0;
		Int32U5BU5D_t19C97395396A72ECAF310612F0760F165060314C* L_93 = (Int32U5BU5D_t19C97395396A72ECAF310612F0760F165060314C*)(Int32U5BU5D_t19C97395396A72ECAF310612F0760F165060314C*)SZArrayNew(Int32U5BU5D_t19C97395396A72ECAF310612F0760F165060314C_il2cpp_TypeInfo_var, (uint32_t)1);
		Int32U5BU5D_t19C97395396A72ECAF310612F0760F165060314C* L_94 = L_93;
		NullCheck(L_94);
		(L_94)->SetAt(static_cast<il2cpp_array_size_t>(0), (int32_t)((int32_t)65539));
		JsonReader_TableAddCol_mC7A131F8C9F735843F03721B124116C59B9D2843(L_92, ((int32_t)65550), ((int32_t)65539), L_94, NULL);
		// TableAddCol (parse_table, ParserToken.Value, (int) ParserToken.Null,
		//                 (int) ParserToken.Null);
		RuntimeObject* L_95 = V_0;
		Int32U5BU5D_t19C97395396A72ECAF310612F0760F165060314C* L_96 = (Int32U5BU5D_t19C97395396A72ECAF310612F0760F165060314C*)(Int32U5BU5D_t19C97395396A72ECAF310612F0760F165060314C*)SZArrayNew(Int32U5BU5D_t19C97395396A72ECAF310612F0760F165060314C_il2cpp_TypeInfo_var, (uint32_t)1);
		Int32U5BU5D_t19C97395396A72ECAF310612F0760F165060314C* L_97 = L_96;
		NullCheck(L_97);
		(L_97)->SetAt(static_cast<il2cpp_array_size_t>(0), (int32_t)((int32_t)65540));
		JsonReader_TableAddCol_mC7A131F8C9F735843F03721B124116C59B9D2843(L_95, ((int32_t)65550), ((int32_t)65540), L_97, NULL);
		// TableAddRow (parse_table, ParserToken.ValueRest);
		RuntimeObject* L_98 = V_0;
		JsonReader_TableAddRow_mD4C19201516D293B36F4BC52B1BC41F2A837230B(L_98, ((int32_t)65551), NULL);
		// TableAddCol (parse_table, ParserToken.ValueRest, ',',
		//                 ',',
		//                 (int) ParserToken.Value,
		//                 (int) ParserToken.ValueRest);
		RuntimeObject* L_99 = V_0;
		Int32U5BU5D_t19C97395396A72ECAF310612F0760F165060314C* L_100 = (Int32U5BU5D_t19C97395396A72ECAF310612F0760F165060314C*)(Int32U5BU5D_t19C97395396A72ECAF310612F0760F165060314C*)SZArrayNew(Int32U5BU5D_t19C97395396A72ECAF310612F0760F165060314C_il2cpp_TypeInfo_var, (uint32_t)3);
		Int32U5BU5D_t19C97395396A72ECAF310612F0760F165060314C* L_101 = L_100;
		RuntimeFieldHandle_t6E4C45B6D2EA12FC99185805A7E77527899B25C5 L_102 = { reinterpret_cast<intptr_t> (U3CPrivateImplementationDetailsU3E_t0F5473E849A5A5185A9F4C5246F0C32816C49FCA____5B979F69B96A61586A09DD4ED26F20534C629B08732AE32FA34B6F8A0049ACDD_1_FieldInfo_var) };
		RuntimeHelpers_InitializeArray_m751372AA3F24FBF6DA9B9D687CBFA2DE436CAB9B((RuntimeArray*)L_101, L_102, NULL);
		JsonReader_TableAddCol_mC7A131F8C9F735843F03721B124116C59B9D2843(L_99, ((int32_t)65551), ((int32_t)44), L_101, NULL);
		// TableAddCol (parse_table, ParserToken.ValueRest, ']',
		//                 (int) ParserToken.Epsilon);
		RuntimeObject* L_103 = V_0;
		Int32U5BU5D_t19C97395396A72ECAF310612F0760F165060314C* L_104 = (Int32U5BU5D_t19C97395396A72ECAF310612F0760F165060314C*)(Int32U5BU5D_t19C97395396A72ECAF310612F0760F165060314C*)SZArrayNew(Int32U5BU5D_t19C97395396A72ECAF310612F0760F165060314C_il2cpp_TypeInfo_var, (uint32_t)1);
		Int32U5BU5D_t19C97395396A72ECAF310612F0760F165060314C* L_105 = L_104;
		NullCheck(L_105);
		(L_105)->SetAt(static_cast<il2cpp_array_size_t>(0), (int32_t)((int32_t)65554));
		JsonReader_TableAddCol_mC7A131F8C9F735843F03721B124116C59B9D2843(L_103, ((int32_t)65551), ((int32_t)93), L_105, NULL);
		// return parse_table;
		RuntimeObject* L_106 = V_0;
		return L_106;
	}
}
// System.Void Agora.Rtc.LitJson.JsonReader::TableAddCol(System.Collections.Generic.IDictionary`2<System.Int32,System.Collections.Generic.IDictionary`2<System.Int32,System.Int32[]>>,Agora.Rtc.LitJson.ParserToken,System.Int32,System.Int32[])
IL2CPP_EXTERN_C IL2CPP_METHOD_ATTR void JsonReader_TableAddCol_mC7A131F8C9F735843F03721B124116C59B9D2843 (RuntimeObject* ___parse_table0, int32_t ___row1, int32_t ___col2, Int32U5BU5D_t19C97395396A72ECAF310612F0760F165060314C* ___symbols3, const RuntimeMethod* method) 
{
	static bool s_Il2CppMethodInitialized;
	if (!s_Il2CppMethodInitialized)
	{
		il2cpp_codegen_initialize_runtime_metadata((uintptr_t*)&IDictionary_2_t9503DE0744217071D554CC415B2890C454070024_il2cpp_TypeInfo_var);
		il2cpp_codegen_initialize_runtime_metadata((uintptr_t*)&IDictionary_2_tAD4D3CC9C1631510439F3806F67FAA90CE4C4313_il2cpp_TypeInfo_var);
		s_Il2CppMethodInitialized = true;
	}
	{
		// parse_table[(int) row].Add (col, symbols);
		RuntimeObject* L_0 = ___parse_table0;
		int32_t L_1 = ___row1;
		NullCheck(L_0);
		RuntimeObject* L_2;
		L_2 = InterfaceFuncInvoker1< RuntimeObject*, int32_t >::Invoke(0 /* TValue System.Collections.Generic.IDictionary`2<System.Int32,System.Collections.Generic.IDictionary`2<System.Int32,System.Int32[]>>::get_Item(TKey) */, IDictionary_2_t9503DE0744217071D554CC415B2890C454070024_il2cpp_TypeInfo_var, L_0, L_1);
		int32_t L_3 = ___col2;
		Int32U5BU5D_t19C97395396A72ECAF310612F0760F165060314C* L_4 = ___symbols3;
		NullCheck(L_2);
		InterfaceActionInvoker2< int32_t, Int32U5BU5D_t19C97395396A72ECAF310612F0760F165060314C* >::Invoke(5 /* System.Void System.Collections.Generic.IDictionary`2<System.Int32,System.Int32[]>::Add(TKey,TValue) */, IDictionary_2_tAD4D3CC9C1631510439F3806F67FAA90CE4C4313_il2cpp_TypeInfo_var, L_2, L_3, L_4);
		// }
		return;
	}
}
// System.Void Agora.Rtc.LitJson.JsonReader::TableAddRow(System.Collections.Generic.IDictionary`2<System.Int32,System.Collections.Generic.IDictionary`2<System.Int32,System.Int32[]>>,Agora.Rtc.LitJson.ParserToken)
IL2CPP_EXTERN_C IL2CPP_METHOD_ATTR void JsonReader_TableAddRow_mD4C19201516D293B36F4BC52B1BC41F2A837230B (RuntimeObject* ___parse_table0, int32_t ___rule1, const RuntimeMethod* method) 
{
	static bool s_Il2CppMethodInitialized;
	if (!s_Il2CppMethodInitialized)
	{
		il2cpp_codegen_initialize_runtime_metadata((uintptr_t*)&Dictionary_2__ctor_m3F530E7CD9CC3EB97DCC6E1669EAB9FCE984FA9A_RuntimeMethod_var);
		il2cpp_codegen_initialize_runtime_metadata((uintptr_t*)&Dictionary_2_t029F6A37F043A1B571A7DB746955ECB8DC548AD9_il2cpp_TypeInfo_var);
		il2cpp_codegen_initialize_runtime_metadata((uintptr_t*)&IDictionary_2_t9503DE0744217071D554CC415B2890C454070024_il2cpp_TypeInfo_var);
		s_Il2CppMethodInitialized = true;
	}
	{
		// parse_table.Add ((int) rule, new Dictionary<int, int[]> ());
		RuntimeObject* L_0 = ___parse_table0;
		int32_t L_1 = ___rule1;
		Dictionary_2_t029F6A37F043A1B571A7DB746955ECB8DC548AD9* L_2 = (Dictionary_2_t029F6A37F043A1B571A7DB746955ECB8DC548AD9*)il2cpp_codegen_object_new(Dictionary_2_t029F6A37F043A1B571A7DB746955ECB8DC548AD9_il2cpp_TypeInfo_var);
		NullCheck(L_2);
		Dictionary_2__ctor_m3F530E7CD9CC3EB97DCC6E1669EAB9FCE984FA9A(L_2, Dictionary_2__ctor_m3F530E7CD9CC3EB97DCC6E1669EAB9FCE984FA9A_RuntimeMethod_var);
		NullCheck(L_0);
		InterfaceActionInvoker2< int32_t, RuntimeObject* >::Invoke(5 /* System.Void System.Collections.Generic.IDictionary`2<System.Int32,System.Collections.Generic.IDictionary`2<System.Int32,System.Int32[]>>::Add(TKey,TValue) */, IDictionary_2_t9503DE0744217071D554CC415B2890C454070024_il2cpp_TypeInfo_var, L_0, L_1, L_2);
		// }
		return;
	}
}
// System.Void Agora.Rtc.LitJson.JsonReader::ProcessNumber(System.String)
IL2CPP_EXTERN_C IL2CPP_METHOD_ATTR void JsonReader_ProcessNumber_m5E57D4151FE833AF991EA77CE4D9AADEC5E20D3D (JsonReader_tE72AF24875A229A65356715AAFF4C23E38105A3F* __this, String_t* ___number0, const RuntimeMethod* method) 
{
	static bool s_Il2CppMethodInitialized;
	if (!s_Il2CppMethodInitialized)
	{
		il2cpp_codegen_initialize_runtime_metadata((uintptr_t*)&CultureInfo_t9BA817D41AD55AC8BD07480DD8AC22F8FFA378E0_il2cpp_TypeInfo_var);
		il2cpp_codegen_initialize_runtime_metadata((uintptr_t*)&Double_tE150EF3D1D43DEE85D533810AB4C742307EEDE5F_il2cpp_TypeInfo_var);
		il2cpp_codegen_initialize_runtime_metadata((uintptr_t*)&Int32_t680FF22E76F6EFAD4375103CBBFFA0421349384C_il2cpp_TypeInfo_var);
		il2cpp_codegen_initialize_runtime_metadata((uintptr_t*)&Int64_t092CFB123BE63C28ACDAF65C68F21A526050DBA3_il2cpp_TypeInfo_var);
		il2cpp_codegen_initialize_runtime_metadata((uintptr_t*)&UInt32_t1833D51FFA667B18A5AA4B8D34DE284F8495D29B_il2cpp_TypeInfo_var);
		il2cpp_codegen_initialize_runtime_metadata((uintptr_t*)&UInt64_t8F12534CC8FC4B5860F2A2CD1EE79D322E7A41AF_il2cpp_TypeInfo_var);
		s_Il2CppMethodInitialized = true;
	}
	int32_t V_0 = 0;
	uint32_t V_1 = 0;
	int64_t V_2 = 0;
	uint64_t V_3 = 0;
	double V_4 = 0.0;
	{
		// if (number.IndexOf ('.') != -1 ||
		//     number.IndexOf ('e') != -1 ||
		//     number.IndexOf ('E') != -1) {
		String_t* L_0 = ___number0;
		NullCheck(L_0);
		int32_t L_1;
		L_1 = String_IndexOf_mE21E78F35EF4A7768E385A72814C88D22B689966(L_0, ((int32_t)46), NULL);
		if ((!(((uint32_t)L_1) == ((uint32_t)(-1)))))
		{
			goto IL_0021;
		}
	}
	{
		String_t* L_2 = ___number0;
		NullCheck(L_2);
		int32_t L_3;
		L_3 = String_IndexOf_mE21E78F35EF4A7768E385A72814C88D22B689966(L_2, ((int32_t)101), NULL);
		if ((!(((uint32_t)L_3) == ((uint32_t)(-1)))))
		{
			goto IL_0021;
		}
	}
	{
		String_t* L_4 = ___number0;
		NullCheck(L_4);
		int32_t L_5;
		L_5 = String_IndexOf_mE21E78F35EF4A7768E385A72814C88D22B689966(L_4, ((int32_t)69), NULL);
		if ((((int32_t)L_5) == ((int32_t)(-1))))
		{
			goto IL_004b;
		}
	}

IL_0021:
	{
		// if (double.TryParse (number, NumberStyles.Any, CultureInfo.InvariantCulture, out n_double)) {
		String_t* L_6 = ___number0;
		il2cpp_codegen_runtime_class_init_inline(CultureInfo_t9BA817D41AD55AC8BD07480DD8AC22F8FFA378E0_il2cpp_TypeInfo_var);
		CultureInfo_t9BA817D41AD55AC8BD07480DD8AC22F8FFA378E0* L_7;
		L_7 = CultureInfo_get_InvariantCulture_mD1E96DC845E34B10F78CB744B0CB5D7D63CEB1E6(NULL);
		bool L_8;
		L_8 = Double_TryParse_m1D39DC22A45BC9A576B9D9130600BFD3CB6DA382(L_6, ((int32_t)511), L_7, (&V_4), NULL);
		if (!L_8)
		{
			goto IL_004b;
		}
	}
	{
		// token = JsonToken.Double;
		__this->___token_14 = ((int32_t)10);
		// token_value = n_double;
		double L_9 = V_4;
		double L_10 = L_9;
		RuntimeObject* L_11 = Box(Double_tE150EF3D1D43DEE85D533810AB4C742307EEDE5F_il2cpp_TypeInfo_var, &L_10);
		__this->___token_value_13 = L_11;
		Il2CppCodeGenWriteBarrier((void**)(&__this->___token_value_13), (void*)L_11);
		// return;
		return;
	}

IL_004b:
	{
		// if (int.TryParse (number, NumberStyles.Integer, CultureInfo.InvariantCulture, out n_int32)) {
		String_t* L_12 = ___number0;
		il2cpp_codegen_runtime_class_init_inline(CultureInfo_t9BA817D41AD55AC8BD07480DD8AC22F8FFA378E0_il2cpp_TypeInfo_var);
		CultureInfo_t9BA817D41AD55AC8BD07480DD8AC22F8FFA378E0* L_13;
		L_13 = CultureInfo_get_InvariantCulture_mD1E96DC845E34B10F78CB744B0CB5D7D63CEB1E6(NULL);
		bool L_14;
		L_14 = Int32_TryParse_mB8E246A7D6D6308EF36DE3473643BDE4CF8F71FF(L_12, 7, L_13, (&V_0), NULL);
		if (!L_14)
		{
			goto IL_006f;
		}
	}
	{
		// token = JsonToken.Int;
		__this->___token_14 = 6;
		// token_value = n_int32;
		int32_t L_15 = V_0;
		int32_t L_16 = L_15;
		RuntimeObject* L_17 = Box(Int32_t680FF22E76F6EFAD4375103CBBFFA0421349384C_il2cpp_TypeInfo_var, &L_16);
		__this->___token_value_13 = L_17;
		Il2CppCodeGenWriteBarrier((void**)(&__this->___token_value_13), (void*)L_17);
		// return;
		return;
	}

IL_006f:
	{
		// if(uint.TryParse(number, NumberStyles.Integer, CultureInfo.InvariantCulture, out n_uint32)){
		String_t* L_18 = ___number0;
		il2cpp_codegen_runtime_class_init_inline(CultureInfo_t9BA817D41AD55AC8BD07480DD8AC22F8FFA378E0_il2cpp_TypeInfo_var);
		CultureInfo_t9BA817D41AD55AC8BD07480DD8AC22F8FFA378E0* L_19;
		L_19 = CultureInfo_get_InvariantCulture_mD1E96DC845E34B10F78CB744B0CB5D7D63CEB1E6(NULL);
		bool L_20;
		L_20 = UInt32_TryParse_m5F53514F97B4CF90C9F1D49D3794B52F6E07BBF3(L_18, 7, L_19, (&V_1), NULL);
		if (!L_20)
		{
			goto IL_0093;
		}
	}
	{
		// token = JsonToken.UInt;
		__this->___token_14 = 7;
		// token_value = n_uint32;
		uint32_t L_21 = V_1;
		uint32_t L_22 = L_21;
		RuntimeObject* L_23 = Box(UInt32_t1833D51FFA667B18A5AA4B8D34DE284F8495D29B_il2cpp_TypeInfo_var, &L_22);
		__this->___token_value_13 = L_23;
		Il2CppCodeGenWriteBarrier((void**)(&__this->___token_value_13), (void*)L_23);
		// return;
		return;
	}

IL_0093:
	{
		// if (long.TryParse (number, NumberStyles.Integer, CultureInfo.InvariantCulture, out n_int64)) {
		String_t* L_24 = ___number0;
		il2cpp_codegen_runtime_class_init_inline(CultureInfo_t9BA817D41AD55AC8BD07480DD8AC22F8FFA378E0_il2cpp_TypeInfo_var);
		CultureInfo_t9BA817D41AD55AC8BD07480DD8AC22F8FFA378E0* L_25;
		L_25 = CultureInfo_get_InvariantCulture_mD1E96DC845E34B10F78CB744B0CB5D7D63CEB1E6(NULL);
		bool L_26;
		L_26 = Int64_TryParse_m64CEDECE4C3F16B715CA1057801018B2957AE0E3(L_24, 7, L_25, (&V_2), NULL);
		if (!L_26)
		{
			goto IL_00b7;
		}
	}
	{
		// token = JsonToken.Long;
		__this->___token_14 = 8;
		// token_value = n_int64;
		int64_t L_27 = V_2;
		int64_t L_28 = L_27;
		RuntimeObject* L_29 = Box(Int64_t092CFB123BE63C28ACDAF65C68F21A526050DBA3_il2cpp_TypeInfo_var, &L_28);
		__this->___token_value_13 = L_29;
		Il2CppCodeGenWriteBarrier((void**)(&__this->___token_value_13), (void*)L_29);
		// return;
		return;
	}

IL_00b7:
	{
		// if (ulong.TryParse(number, NumberStyles.Integer, CultureInfo.InvariantCulture, out n_uint64))
		String_t* L_30 = ___number0;
		il2cpp_codegen_runtime_class_init_inline(CultureInfo_t9BA817D41AD55AC8BD07480DD8AC22F8FFA378E0_il2cpp_TypeInfo_var);
		CultureInfo_t9BA817D41AD55AC8BD07480DD8AC22F8FFA378E0* L_31;
		L_31 = CultureInfo_get_InvariantCulture_mD1E96DC845E34B10F78CB744B0CB5D7D63CEB1E6(NULL);
		bool L_32;
		L_32 = UInt64_TryParse_m33051106D55D2FDFB53461FF5DDB59F8C35B2388(L_30, 7, L_31, (&V_3), NULL);
		if (!L_32)
		{
			goto IL_00dc;
		}
	}
	{
		// token = JsonToken.ULong;
		__this->___token_14 = ((int32_t)9);
		// token_value = n_uint64;
		uint64_t L_33 = V_3;
		uint64_t L_34 = L_33;
		RuntimeObject* L_35 = Box(UInt64_t8F12534CC8FC4B5860F2A2CD1EE79D322E7A41AF_il2cpp_TypeInfo_var, &L_34);
		__this->___token_value_13 = L_35;
		Il2CppCodeGenWriteBarrier((void**)(&__this->___token_value_13), (void*)L_35);
		// return;
		return;
	}

IL_00dc:
	{
		// token = JsonToken.Int;
		__this->___token_14 = 6;
		// token_value = 0;
		int32_t L_36 = 0;
		RuntimeObject* L_37 = Box(Int32_t680FF22E76F6EFAD4375103CBBFFA0421349384C_il2cpp_TypeInfo_var, &L_36);
		__this->___token_value_13 = L_37;
		Il2CppCodeGenWriteBarrier((void**)(&__this->___token_value_13), (void*)L_37);
		// }
		return;
	}
}
// System.Void Agora.Rtc.LitJson.JsonReader::ProcessSymbol()
IL2CPP_EXTERN_C IL2CPP_METHOD_ATTR void JsonReader_ProcessSymbol_m509DBD82CC0B635458155A8CF04E5FE56217D787 (JsonReader_tE72AF24875A229A65356715AAFF4C23E38105A3F* __this, const RuntimeMethod* method) 
{
	static bool s_Il2CppMethodInitialized;
	if (!s_Il2CppMethodInitialized)
	{
		il2cpp_codegen_initialize_runtime_metadata((uintptr_t*)&Boolean_t09A6377A54BE2F9E6985A8149F19234FD7DDFE22_il2cpp_TypeInfo_var);
		s_Il2CppMethodInitialized = true;
	}
	{
		// if (current_symbol == '[')  {
		int32_t L_0 = __this->___current_symbol_3;
		if ((!(((uint32_t)L_0) == ((uint32_t)((int32_t)91)))))
		{
			goto IL_0019;
		}
	}
	{
		// token = JsonToken.ArrayStart;
		__this->___token_14 = 4;
		// parser_return = true;
		__this->___parser_return_8 = (bool)1;
		return;
	}

IL_0019:
	{
		// } else if (current_symbol == ']')  {
		int32_t L_1 = __this->___current_symbol_3;
		if ((!(((uint32_t)L_1) == ((uint32_t)((int32_t)93)))))
		{
			goto IL_0032;
		}
	}
	{
		// token = JsonToken.ArrayEnd;
		__this->___token_14 = 5;
		// parser_return = true;
		__this->___parser_return_8 = (bool)1;
		return;
	}

IL_0032:
	{
		// } else if (current_symbol == '{')  {
		int32_t L_2 = __this->___current_symbol_3;
		if ((!(((uint32_t)L_2) == ((uint32_t)((int32_t)123)))))
		{
			goto IL_004b;
		}
	}
	{
		// token = JsonToken.ObjectStart;
		__this->___token_14 = 1;
		// parser_return = true;
		__this->___parser_return_8 = (bool)1;
		return;
	}

IL_004b:
	{
		// } else if (current_symbol == '}')  {
		int32_t L_3 = __this->___current_symbol_3;
		if ((!(((uint32_t)L_3) == ((uint32_t)((int32_t)125)))))
		{
			goto IL_0064;
		}
	}
	{
		// token = JsonToken.ObjectEnd;
		__this->___token_14 = 3;
		// parser_return = true;
		__this->___parser_return_8 = (bool)1;
		return;
	}

IL_0064:
	{
		// } else if (current_symbol == '"')  {
		int32_t L_4 = __this->___current_symbol_3;
		if ((!(((uint32_t)L_4) == ((uint32_t)((int32_t)34)))))
		{
			goto IL_009d;
		}
	}
	{
		// if (parser_in_string) {
		bool L_5 = __this->___parser_in_string_7;
		if (!L_5)
		{
			goto IL_0085;
		}
	}
	{
		// parser_in_string = false;
		__this->___parser_in_string_7 = (bool)0;
		// parser_return = true;
		__this->___parser_return_8 = (bool)1;
		return;
	}

IL_0085:
	{
		// if (token == JsonToken.None)
		int32_t L_6 = __this->___token_14;
		if (L_6)
		{
			goto IL_0095;
		}
	}
	{
		// token = JsonToken.String;
		__this->___token_14 = ((int32_t)11);
	}

IL_0095:
	{
		// parser_in_string = true;
		__this->___parser_in_string_7 = (bool)1;
		return;
	}

IL_009d:
	{
		// } else if (current_symbol == (int) ParserToken.CharSeq) {
		int32_t L_7 = __this->___current_symbol_3;
		if ((!(((uint32_t)L_7) == ((uint32_t)((int32_t)65541)))))
		{
			goto IL_00bc;
		}
	}
	{
		// token_value = lexer.StringValue;
		Lexer_tDC14CFA7B390E884510F554D9D1E03188A185E27* L_8 = __this->___lexer_6;
		NullCheck(L_8);
		String_t* L_9;
		L_9 = Lexer_get_StringValue_mFCF7CD0EBB22B34F500B25C26360DFF643FE6132_inline(L_8, NULL);
		__this->___token_value_13 = L_9;
		Il2CppCodeGenWriteBarrier((void**)(&__this->___token_value_13), (void*)L_9);
		return;
	}

IL_00bc:
	{
		// } else if (current_symbol == (int) ParserToken.False)  {
		int32_t L_10 = __this->___current_symbol_3;
		if ((!(((uint32_t)L_10) == ((uint32_t)((int32_t)65539)))))
		{
			goto IL_00e5;
		}
	}
	{
		// token = JsonToken.Boolean;
		__this->___token_14 = ((int32_t)12);
		// token_value = false;
		bool L_11 = ((bool)0);
		RuntimeObject* L_12 = Box(Boolean_t09A6377A54BE2F9E6985A8149F19234FD7DDFE22_il2cpp_TypeInfo_var, &L_11);
		__this->___token_value_13 = L_12;
		Il2CppCodeGenWriteBarrier((void**)(&__this->___token_value_13), (void*)L_12);
		// parser_return = true;
		__this->___parser_return_8 = (bool)1;
		return;
	}

IL_00e5:
	{
		// } else if (current_symbol == (int) ParserToken.Null)  {
		int32_t L_13 = __this->___current_symbol_3;
		if ((!(((uint32_t)L_13) == ((uint32_t)((int32_t)65540)))))
		{
			goto IL_0102;
		}
	}
	{
		// token = JsonToken.Null;
		__this->___token_14 = ((int32_t)13);
		// parser_return = true;
		__this->___parser_return_8 = (bool)1;
		return;
	}

IL_0102:
	{
		// } else if (current_symbol == (int) ParserToken.Number)  {
		int32_t L_14 = __this->___current_symbol_3;
		if ((!(((uint32_t)L_14) == ((uint32_t)((int32_t)65537)))))
		{
			goto IL_0128;
		}
	}
	{
		// ProcessNumber (lexer.StringValue);
		Lexer_tDC14CFA7B390E884510F554D9D1E03188A185E27* L_15 = __this->___lexer_6;
		NullCheck(L_15);
		String_t* L_16;
		L_16 = Lexer_get_StringValue_mFCF7CD0EBB22B34F500B25C26360DFF643FE6132_inline(L_15, NULL);
		JsonReader_ProcessNumber_m5E57D4151FE833AF991EA77CE4D9AADEC5E20D3D(__this, L_16, NULL);
		// parser_return = true;
		__this->___parser_return_8 = (bool)1;
		return;
	}

IL_0128:
	{
		// } else if (current_symbol == (int) ParserToken.Pair)  {
		int32_t L_17 = __this->___current_symbol_3;
		if ((!(((uint32_t)L_17) == ((uint32_t)((int32_t)65546)))))
		{
			goto IL_013d;
		}
	}
	{
		// token = JsonToken.PropertyName;
		__this->___token_14 = 2;
		return;
	}

IL_013d:
	{
		// } else if (current_symbol == (int) ParserToken.True)  {
		int32_t L_18 = __this->___current_symbol_3;
		if ((!(((uint32_t)L_18) == ((uint32_t)((int32_t)65538)))))
		{
			goto IL_0165;
		}
	}
	{
		// token = JsonToken.Boolean;
		__this->___token_14 = ((int32_t)12);
		// token_value = true;
		bool L_19 = ((bool)1);
		RuntimeObject* L_20 = Box(Boolean_t09A6377A54BE2F9E6985A8149F19234FD7DDFE22_il2cpp_TypeInfo_var, &L_19);
		__this->___token_value_13 = L_20;
		Il2CppCodeGenWriteBarrier((void**)(&__this->___token_value_13), (void*)L_20);
		// parser_return = true;
		__this->___parser_return_8 = (bool)1;
	}

IL_0165:
	{
		// }
		return;
	}
}
// System.Boolean Agora.Rtc.LitJson.JsonReader::ReadToken()
IL2CPP_EXTERN_C IL2CPP_METHOD_ATTR bool JsonReader_ReadToken_mEFA7D889C078F842BBF80886EA5BC51897E2B83A (JsonReader_tE72AF24875A229A65356715AAFF4C23E38105A3F* __this, const RuntimeMethod* method) 
{
	{
		// if (end_of_input)
		bool L_0 = __this->___end_of_input_5;
		if (!L_0)
		{
			goto IL_000a;
		}
	}
	{
		// return false;
		return (bool)0;
	}

IL_000a:
	{
		// lexer.NextToken ();
		Lexer_tDC14CFA7B390E884510F554D9D1E03188A185E27* L_1 = __this->___lexer_6;
		NullCheck(L_1);
		bool L_2;
		L_2 = Lexer_NextToken_mE34A5B2E9932497D86F3BCD0B7732A1454A2760E(L_1, NULL);
		// if (lexer.EndOfInput) {
		Lexer_tDC14CFA7B390E884510F554D9D1E03188A185E27* L_3 = __this->___lexer_6;
		NullCheck(L_3);
		bool L_4;
		L_4 = Lexer_get_EndOfInput_mB1C09B97ED8A1B7141AB706DCA74D9EE4A6C423D_inline(L_3, NULL);
		if (!L_4)
		{
			goto IL_002b;
		}
	}
	{
		// Close ();
		JsonReader_Close_mACAF3ABE0D50A8EF37CDB7CE77CC1FB3AA552C10(__this, NULL);
		// return false;
		return (bool)0;
	}

IL_002b:
	{
		// current_input = lexer.Token;
		Lexer_tDC14CFA7B390E884510F554D9D1E03188A185E27* L_5 = __this->___lexer_6;
		NullCheck(L_5);
		int32_t L_6;
		L_6 = Lexer_get_Token_m2A2C0BFC698B6DCE0F1C347A70A47449F9035FBF_inline(L_5, NULL);
		__this->___current_input_2 = L_6;
		// return true;
		return (bool)1;
	}
}
// System.Void Agora.Rtc.LitJson.JsonReader::Close()
IL2CPP_EXTERN_C IL2CPP_METHOD_ATTR void JsonReader_Close_mACAF3ABE0D50A8EF37CDB7CE77CC1FB3AA552C10 (JsonReader_tE72AF24875A229A65356715AAFF4C23E38105A3F* __this, const RuntimeMethod* method) 
{
	static bool s_Il2CppMethodInitialized;
	if (!s_Il2CppMethodInitialized)
	{
		il2cpp_codegen_initialize_runtime_metadata((uintptr_t*)&IDisposable_t030E0496B4E0E4E4F086825007979AF51F7248C5_il2cpp_TypeInfo_var);
		s_Il2CppMethodInitialized = true;
	}
	TextReader_tB8D43017CB6BE1633E5A86D64E7757366507C1F7* V_0 = NULL;
	{
		// if (end_of_input)
		bool L_0 = __this->___end_of_input_5;
		if (!L_0)
		{
			goto IL_0009;
		}
	}
	{
		// return;
		return;
	}

IL_0009:
	{
		// end_of_input = true;
		__this->___end_of_input_5 = (bool)1;
		// end_of_json  = true;
		__this->___end_of_json_4 = (bool)1;
		// if (reader_is_owned)
		bool L_1 = __this->___reader_is_owned_11;
		if (!L_1)
		{
			goto IL_0032;
		}
	}
	{
		// using(reader){}
		TextReader_tB8D43017CB6BE1633E5A86D64E7757366507C1F7* L_2 = __this->___reader_10;
		V_0 = L_2;
	}
	{
		auto __finallyBlock = il2cpp::utils::Finally([&]
		{

FINALLY_0028:
			{// begin finally (depth: 1)
				{
					TextReader_tB8D43017CB6BE1633E5A86D64E7757366507C1F7* L_3 = V_0;
					if (!L_3)
					{
						goto IL_0031;
					}
				}
				{
					TextReader_tB8D43017CB6BE1633E5A86D64E7757366507C1F7* L_4 = V_0;
					NullCheck(L_4);
					InterfaceActionInvoker0::Invoke(0 /* System.Void System.IDisposable::Dispose() */, IDisposable_t030E0496B4E0E4E4F086825007979AF51F7248C5_il2cpp_TypeInfo_var, L_4);
				}

IL_0031:
				{
					return;
				}
			}// end finally (depth: 1)
		});
		try
		{// begin try (depth: 1)
			// using(reader){}
			goto IL_0032;
		}// end try (depth: 1)
		catch(Il2CppExceptionWrapper& e)
		{
			__finallyBlock.StoreException(e.ex);
		}
	}

IL_0032:
	{
		// reader = null;
		__this->___reader_10 = (TextReader_tB8D43017CB6BE1633E5A86D64E7757366507C1F7*)NULL;
		Il2CppCodeGenWriteBarrier((void**)(&__this->___reader_10), (void*)(TextReader_tB8D43017CB6BE1633E5A86D64E7757366507C1F7*)NULL);
		// }
		return;
	}
}
// System.Boolean Agora.Rtc.LitJson.JsonReader::Read()
IL2CPP_EXTERN_C IL2CPP_METHOD_ATTR bool JsonReader_Read_mD49C2B0A28DE9C640B1B812B85DE7D5B9B7158D2 (JsonReader_tE72AF24875A229A65356715AAFF4C23E38105A3F* __this, const RuntimeMethod* method) 
{
	static bool s_Il2CppMethodInitialized;
	if (!s_Il2CppMethodInitialized)
	{
		il2cpp_codegen_initialize_runtime_metadata((uintptr_t*)&IDictionary_2_t9503DE0744217071D554CC415B2890C454070024_il2cpp_TypeInfo_var);
		il2cpp_codegen_initialize_runtime_metadata((uintptr_t*)&IDictionary_2_tAD4D3CC9C1631510439F3806F67FAA90CE4C4313_il2cpp_TypeInfo_var);
		il2cpp_codegen_initialize_runtime_metadata((uintptr_t*)&JsonReader_tE72AF24875A229A65356715AAFF4C23E38105A3F_il2cpp_TypeInfo_var);
		il2cpp_codegen_initialize_runtime_metadata((uintptr_t*)&Stack_1_Clear_mEE1C6E0AF654AE01D41D12DAF62217D4FE3930E0_RuntimeMethod_var);
		il2cpp_codegen_initialize_runtime_metadata((uintptr_t*)&Stack_1_Peek_m919AA48BFC239B260BB6A0639B8E027B60CB8B66_RuntimeMethod_var);
		il2cpp_codegen_initialize_runtime_metadata((uintptr_t*)&Stack_1_Pop_m59DFD2B5EC8D9044532E0AD0BDB20DB33BA76748_RuntimeMethod_var);
		il2cpp_codegen_initialize_runtime_metadata((uintptr_t*)&Stack_1_Push_mF7CC12CF73D9D4B66FFA2E2D264270212CAB3EDA_RuntimeMethod_var);
		s_Il2CppMethodInitialized = true;
	}
	Int32U5BU5D_t19C97395396A72ECAF310612F0760F165060314C* V_0 = NULL;
	KeyNotFoundException_tCE416EC9BCA9F396A3DFFF86D1B5209BA876079E* V_1 = NULL;
	int32_t V_2 = 0;
	il2cpp::utils::ExceptionSupportStack<RuntimeObject*, 1> __active_exceptions;
	{
		// if (end_of_input)
		bool L_0 = __this->___end_of_input_5;
		if (!L_0)
		{
			goto IL_000a;
		}
	}
	{
		// return false;
		return (bool)0;
	}

IL_000a:
	{
		// if (end_of_json) {
		bool L_1 = __this->___end_of_json_4;
		if (!L_1)
		{
			goto IL_0044;
		}
	}
	{
		// end_of_json = false;
		__this->___end_of_json_4 = (bool)0;
		// automaton_stack.Clear ();
		Stack_1_t3197E0F5EA36E611B259A88751D31FC2396FE4B6* L_2 = __this->___automaton_stack_1;
		NullCheck(L_2);
		Stack_1_Clear_mEE1C6E0AF654AE01D41D12DAF62217D4FE3930E0(L_2, Stack_1_Clear_mEE1C6E0AF654AE01D41D12DAF62217D4FE3930E0_RuntimeMethod_var);
		// automaton_stack.Push ((int) ParserToken.End);
		Stack_1_t3197E0F5EA36E611B259A88751D31FC2396FE4B6* L_3 = __this->___automaton_stack_1;
		NullCheck(L_3);
		Stack_1_Push_mF7CC12CF73D9D4B66FFA2E2D264270212CAB3EDA(L_3, ((int32_t)65553), Stack_1_Push_mF7CC12CF73D9D4B66FFA2E2D264270212CAB3EDA_RuntimeMethod_var);
		// automaton_stack.Push ((int) ParserToken.Text);
		Stack_1_t3197E0F5EA36E611B259A88751D31FC2396FE4B6* L_4 = __this->___automaton_stack_1;
		NullCheck(L_4);
		Stack_1_Push_mF7CC12CF73D9D4B66FFA2E2D264270212CAB3EDA(L_4, ((int32_t)65543), Stack_1_Push_mF7CC12CF73D9D4B66FFA2E2D264270212CAB3EDA_RuntimeMethod_var);
	}

IL_0044:
	{
		// parser_in_string = false;
		__this->___parser_in_string_7 = (bool)0;
		// parser_return    = false;
		__this->___parser_return_8 = (bool)0;
		// token       = JsonToken.None;
		__this->___token_14 = 0;
		// token_value = null;
		__this->___token_value_13 = NULL;
		Il2CppCodeGenWriteBarrier((void**)(&__this->___token_value_13), (void*)NULL);
		// if (! read_started) {
		bool L_5 = __this->___read_started_9;
		if (L_5)
		{
			goto IL_0079;
		}
	}
	{
		// read_started = true;
		__this->___read_started_9 = (bool)1;
		// if (! ReadToken ())
		bool L_6;
		L_6 = JsonReader_ReadToken_mEFA7D889C078F842BBF80886EA5BC51897E2B83A(__this, NULL);
		if (L_6)
		{
			goto IL_0079;
		}
	}
	{
		// return false;
		return (bool)0;
	}

IL_0079:
	{
		// if (parser_return) {
		bool L_7 = __this->___parser_return_8;
		if (!L_7)
		{
			goto IL_009c;
		}
	}
	{
		// if (automaton_stack.Peek () == (int) ParserToken.End)
		Stack_1_t3197E0F5EA36E611B259A88751D31FC2396FE4B6* L_8 = __this->___automaton_stack_1;
		NullCheck(L_8);
		int32_t L_9;
		L_9 = Stack_1_Peek_m919AA48BFC239B260BB6A0639B8E027B60CB8B66(L_8, Stack_1_Peek_m919AA48BFC239B260BB6A0639B8E027B60CB8B66_RuntimeMethod_var);
		if ((!(((uint32_t)L_9) == ((uint32_t)((int32_t)65553)))))
		{
			goto IL_009a;
		}
	}
	{
		// end_of_json = true;
		__this->___end_of_json_4 = (bool)1;
	}

IL_009a:
	{
		// return true;
		return (bool)1;
	}

IL_009c:
	{
		// current_symbol = automaton_stack.Pop ();
		Stack_1_t3197E0F5EA36E611B259A88751D31FC2396FE4B6* L_10 = __this->___automaton_stack_1;
		NullCheck(L_10);
		int32_t L_11;
		L_11 = Stack_1_Pop_m59DFD2B5EC8D9044532E0AD0BDB20DB33BA76748(L_10, Stack_1_Pop_m59DFD2B5EC8D9044532E0AD0BDB20DB33BA76748_RuntimeMethod_var);
		__this->___current_symbol_3 = L_11;
		// ProcessSymbol ();
		JsonReader_ProcessSymbol_m509DBD82CC0B635458155A8CF04E5FE56217D787(__this, NULL);
		// if (current_symbol == current_input) {
		int32_t L_12 = __this->___current_symbol_3;
		int32_t L_13 = __this->___current_input_2;
		if ((!(((uint32_t)L_12) == ((uint32_t)L_13))))
		{
			goto IL_00f2;
		}
	}
	{
		// if (! ReadToken ()) {
		bool L_14;
		L_14 = JsonReader_ReadToken_mEFA7D889C078F842BBF80886EA5BC51897E2B83A(__this, NULL);
		if (L_14)
		{
			goto IL_0079;
		}
	}
	{
		// if (automaton_stack.Peek () != (int) ParserToken.End)
		Stack_1_t3197E0F5EA36E611B259A88751D31FC2396FE4B6* L_15 = __this->___automaton_stack_1;
		NullCheck(L_15);
		int32_t L_16;
		L_16 = Stack_1_Peek_m919AA48BFC239B260BB6A0639B8E027B60CB8B66(L_15, Stack_1_Peek_m919AA48BFC239B260BB6A0639B8E027B60CB8B66_RuntimeMethod_var);
		if ((((int32_t)L_16) == ((int32_t)((int32_t)65553))))
		{
			goto IL_00e6;
		}
	}
	{
		// throw new JsonException (
		//     "Input doesn't evaluate to proper JSON text");
		JsonException_t3B214813E48AA5E19793F9026831120B5B2254A1* L_17 = (JsonException_t3B214813E48AA5E19793F9026831120B5B2254A1*)il2cpp_codegen_object_new(((RuntimeClass*)il2cpp_codegen_initialize_runtime_metadata_inline((uintptr_t*)&JsonException_t3B214813E48AA5E19793F9026831120B5B2254A1_il2cpp_TypeInfo_var)));
		NullCheck(L_17);
		JsonException__ctor_m8DBB1F40704DD3E03412DABF55AEE93485DCCBBF(L_17, ((String_t*)il2cpp_codegen_initialize_runtime_metadata_inline((uintptr_t*)&_stringLiteral7B6EE056E549534162451A09C7F0AFAC372DBD06)), NULL);
		IL2CPP_RAISE_MANAGED_EXCEPTION(L_17, ((RuntimeMethod*)il2cpp_codegen_initialize_runtime_metadata_inline((uintptr_t*)&JsonReader_Read_mD49C2B0A28DE9C640B1B812B85DE7D5B9B7158D2_RuntimeMethod_var)));
	}

IL_00e6:
	{
		// if (parser_return)
		bool L_18 = __this->___parser_return_8;
		if (!L_18)
		{
			goto IL_00f0;
		}
	}
	{
		// return true;
		return (bool)1;
	}

IL_00f0:
	{
		// return false;
		return (bool)0;
	}

IL_00f2:
	{
	}
	try
	{// begin try (depth: 1)
		// entry_symbols =
		//     parse_table[current_symbol][current_input];
		il2cpp_codegen_runtime_class_init_inline(JsonReader_tE72AF24875A229A65356715AAFF4C23E38105A3F_il2cpp_TypeInfo_var);
		RuntimeObject* L_19 = ((JsonReader_tE72AF24875A229A65356715AAFF4C23E38105A3F_StaticFields*)il2cpp_codegen_static_fields_for(JsonReader_tE72AF24875A229A65356715AAFF4C23E38105A3F_il2cpp_TypeInfo_var))->___parse_table_0;
		int32_t L_20 = __this->___current_symbol_3;
		NullCheck(L_19);
		RuntimeObject* L_21;
		L_21 = InterfaceFuncInvoker1< RuntimeObject*, int32_t >::Invoke(0 /* TValue System.Collections.Generic.IDictionary`2<System.Int32,System.Collections.Generic.IDictionary`2<System.Int32,System.Int32[]>>::get_Item(TKey) */, IDictionary_2_t9503DE0744217071D554CC415B2890C454070024_il2cpp_TypeInfo_var, L_19, L_20);
		int32_t L_22 = __this->___current_input_2;
		NullCheck(L_21);
		Int32U5BU5D_t19C97395396A72ECAF310612F0760F165060314C* L_23;
		L_23 = InterfaceFuncInvoker1< Int32U5BU5D_t19C97395396A72ECAF310612F0760F165060314C*, int32_t >::Invoke(0 /* TValue System.Collections.Generic.IDictionary`2<System.Int32,System.Int32[]>::get_Item(TKey) */, IDictionary_2_tAD4D3CC9C1631510439F3806F67FAA90CE4C4313_il2cpp_TypeInfo_var, L_21, L_22);
		V_0 = L_23;
		// } catch (KeyNotFoundException e) {
		goto IL_011f;
	}// end try (depth: 1)
	catch(Il2CppExceptionWrapper& e)
	{
		if(il2cpp_codegen_class_is_assignable_from (((RuntimeClass*)il2cpp_codegen_initialize_runtime_metadata_inline((uintptr_t*)&KeyNotFoundException_tCE416EC9BCA9F396A3DFFF86D1B5209BA876079E_il2cpp_TypeInfo_var)), il2cpp_codegen_object_class(e.ex)))
		{
			IL2CPP_PUSH_ACTIVE_EXCEPTION(e.ex);
			goto CATCH_0111;
		}
		throw e;
	}

CATCH_0111:
	{// begin catch(System.Collections.Generic.KeyNotFoundException)
		// } catch (KeyNotFoundException e) {
		V_1 = ((KeyNotFoundException_tCE416EC9BCA9F396A3DFFF86D1B5209BA876079E*)IL2CPP_GET_ACTIVE_EXCEPTION(KeyNotFoundException_tCE416EC9BCA9F396A3DFFF86D1B5209BA876079E*));
		// throw new JsonException ((ParserToken) current_input, e);
		int32_t L_24 = __this->___current_input_2;
		KeyNotFoundException_tCE416EC9BCA9F396A3DFFF86D1B5209BA876079E* L_25 = V_1;
		JsonException_t3B214813E48AA5E19793F9026831120B5B2254A1* L_26 = (JsonException_t3B214813E48AA5E19793F9026831120B5B2254A1*)il2cpp_codegen_object_new(((RuntimeClass*)il2cpp_codegen_initialize_runtime_metadata_inline((uintptr_t*)&JsonException_t3B214813E48AA5E19793F9026831120B5B2254A1_il2cpp_TypeInfo_var)));
		NullCheck(L_26);
		JsonException__ctor_mF7D218AE06BCCB8D56BE8BB7ABCEFE81360CC353(L_26, L_24, L_25, NULL);
		IL2CPP_RAISE_MANAGED_EXCEPTION(L_26, ((RuntimeMethod*)il2cpp_codegen_initialize_runtime_metadata_inline((uintptr_t*)&JsonReader_Read_mD49C2B0A28DE9C640B1B812B85DE7D5B9B7158D2_RuntimeMethod_var)));
	}// end catch (depth: 1)

IL_011f:
	{
		// if (entry_symbols[0] == (int) ParserToken.Epsilon)
		Int32U5BU5D_t19C97395396A72ECAF310612F0760F165060314C* L_27 = V_0;
		NullCheck(L_27);
		int32_t L_28 = 0;
		int32_t L_29 = (L_27)->GetAt(static_cast<il2cpp_array_size_t>(L_28));
		if ((((int32_t)L_29) == ((int32_t)((int32_t)65554))))
		{
			goto IL_0079;
		}
	}
	{
		// for (int i = entry_symbols.Length - 1; i >= 0; i--)
		Int32U5BU5D_t19C97395396A72ECAF310612F0760F165060314C* L_30 = V_0;
		NullCheck(L_30);
		V_2 = ((int32_t)il2cpp_codegen_subtract(((int32_t)(((RuntimeArray*)L_30)->max_length)), 1));
		goto IL_0146;
	}

IL_0134:
	{
		// automaton_stack.Push (entry_symbols[i]);
		Stack_1_t3197E0F5EA36E611B259A88751D31FC2396FE4B6* L_31 = __this->___automaton_stack_1;
		Int32U5BU5D_t19C97395396A72ECAF310612F0760F165060314C* L_32 = V_0;
		int32_t L_33 = V_2;
		NullCheck(L_32);
		int32_t L_34 = L_33;
		int32_t L_35 = (L_32)->GetAt(static_cast<il2cpp_array_size_t>(L_34));
		NullCheck(L_31);
		Stack_1_Push_mF7CC12CF73D9D4B66FFA2E2D264270212CAB3EDA(L_31, L_35, Stack_1_Push_mF7CC12CF73D9D4B66FFA2E2D264270212CAB3EDA_RuntimeMethod_var);
		// for (int i = entry_symbols.Length - 1; i >= 0; i--)
		int32_t L_36 = V_2;
		V_2 = ((int32_t)il2cpp_codegen_subtract(L_36, 1));
	}

IL_0146:
	{
		// for (int i = entry_symbols.Length - 1; i >= 0; i--)
		int32_t L_37 = V_2;
		if ((((int32_t)L_37) >= ((int32_t)0)))
		{
			goto IL_0134;
		}
	}
	{
		// while (true) {
		goto IL_0079;
	}
}
#ifdef __clang__
#pragma clang diagnostic pop
#endif
#ifdef __clang__
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Winvalid-offsetof"
#pragma clang diagnostic ignored "-Wunused-variable"
#endif
// System.Void Agora.Rtc.LitJson.WriterContext::.ctor()
IL2CPP_EXTERN_C IL2CPP_METHOD_ATTR void WriterContext__ctor_m91AF1613E06FA2DC16EBC0B70A80FB80F2AF22C3 (WriterContext_tAA13A82DA53BA6A99795422A71F6D19F331F30BA* __this, const RuntimeMethod* method) 
{
	{
		Object__ctor_mE837C6B9FA8C6D5D109F4B2EC885D79919AC0EA2(__this, NULL);
		return;
	}
}
#ifdef __clang__
#pragma clang diagnostic pop
#endif
#ifdef __clang__
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Winvalid-offsetof"
#pragma clang diagnostic ignored "-Wunused-variable"
#endif
// System.Int32 Agora.Rtc.LitJson.JsonWriter::get_IndentValue()
IL2CPP_EXTERN_C IL2CPP_METHOD_ATTR int32_t JsonWriter_get_IndentValue_m3CF0619F7B1E14C165D4F7451270ECAF9BE3DA48 (JsonWriter_tC9B032D35ED4E85319A227892A43EB8627661732* __this, const RuntimeMethod* method) 
{
	{
		// get { return indent_value; }
		int32_t L_0 = __this->___indent_value_6;
		return L_0;
	}
}
// System.Void Agora.Rtc.LitJson.JsonWriter::set_IndentValue(System.Int32)
IL2CPP_EXTERN_C IL2CPP_METHOD_ATTR void JsonWriter_set_IndentValue_m93B964959A404D1F565D12AFD4E645BF6A209813 (JsonWriter_tC9B032D35ED4E85319A227892A43EB8627661732* __this, int32_t ___value0, const RuntimeMethod* method) 
{
	{
		// indentation = (indentation / indent_value) * value;
		int32_t L_0 = __this->___indentation_5;
		int32_t L_1 = __this->___indent_value_6;
		int32_t L_2 = ___value0;
		__this->___indentation_5 = ((int32_t)il2cpp_codegen_multiply(((int32_t)(L_0/L_1)), L_2));
		// indent_value = value;
		int32_t L_3 = ___value0;
		__this->___indent_value_6 = L_3;
		// }
		return;
	}
}
// System.Boolean Agora.Rtc.LitJson.JsonWriter::get_PrettyPrint()
IL2CPP_EXTERN_C IL2CPP_METHOD_ATTR bool JsonWriter_get_PrettyPrint_m8901DA5A3902F9CF567873AFDAE26973C496574D (JsonWriter_tC9B032D35ED4E85319A227892A43EB8627661732* __this, const RuntimeMethod* method) 
{
	{
		// get { return pretty_print; }
		bool L_0 = __this->___pretty_print_8;
		return L_0;
	}
}
// System.Void Agora.Rtc.LitJson.JsonWriter::set_PrettyPrint(System.Boolean)
IL2CPP_EXTERN_C IL2CPP_METHOD_ATTR void JsonWriter_set_PrettyPrint_m55B2CD9C0E70CB0991BEEF7A3F0C1E7E27C516A9 (JsonWriter_tC9B032D35ED4E85319A227892A43EB8627661732* __this, bool ___value0, const RuntimeMethod* method) 
{
	{
		// set { pretty_print = value; }
		bool L_0 = ___value0;
		__this->___pretty_print_8 = L_0;
		// set { pretty_print = value; }
		return;
	}
}
// System.IO.TextWriter Agora.Rtc.LitJson.JsonWriter::get_TextWriter()
IL2CPP_EXTERN_C IL2CPP_METHOD_ATTR TextWriter_tA9E5461506CF806E17B6BBBF2119359DEDA3F0F3* JsonWriter_get_TextWriter_m216AB070A6AB54500F01C980DDC04D9B1414776B (JsonWriter_tC9B032D35ED4E85319A227892A43EB8627661732* __this, const RuntimeMethod* method) 
{
	{
		// get { return writer; }
		TextWriter_tA9E5461506CF806E17B6BBBF2119359DEDA3F0F3* L_0 = __this->___writer_11;
		return L_0;
	}
}
// System.Boolean Agora.Rtc.LitJson.JsonWriter::get_Validate()
IL2CPP_EXTERN_C IL2CPP_METHOD_ATTR bool JsonWriter_get_Validate_m051C7ABCB333703D118C7871DC98ABCB1C98925C (JsonWriter_tC9B032D35ED4E85319A227892A43EB8627661732* __this, const RuntimeMethod* method) 
{
	{
		// get { return validate; }
		bool L_0 = __this->___validate_9;
		return L_0;
	}
}
// System.Void Agora.Rtc.LitJson.JsonWriter::set_Validate(System.Boolean)
IL2CPP_EXTERN_C IL2CPP_METHOD_ATTR void JsonWriter_set_Validate_m80789D7B405EA8E6012E6E951FDA9D7B3F454C27 (JsonWriter_tC9B032D35ED4E85319A227892A43EB8627661732* __this, bool ___value0, const RuntimeMethod* method) 
{
	{
		// set { validate = value; }
		bool L_0 = ___value0;
		__this->___validate_9 = L_0;
		// set { validate = value; }
		return;
	}
}
// System.Boolean Agora.Rtc.LitJson.JsonWriter::get_LowerCaseProperties()
IL2CPP_EXTERN_C IL2CPP_METHOD_ATTR bool JsonWriter_get_LowerCaseProperties_mADDFFEA3A5AD98726AA19AB75E9203C7A5B1A20A (JsonWriter_tC9B032D35ED4E85319A227892A43EB8627661732* __this, const RuntimeMethod* method) 
{
	{
		// get { return lower_case_properties; }
		bool L_0 = __this->___lower_case_properties_10;
		return L_0;
	}
}
// System.Void Agora.Rtc.LitJson.JsonWriter::set_LowerCaseProperties(System.Boolean)
IL2CPP_EXTERN_C IL2CPP_METHOD_ATTR void JsonWriter_set_LowerCaseProperties_m59CEF067899BE5ACCB749D4B5CD48C05FFEC2BCC (JsonWriter_tC9B032D35ED4E85319A227892A43EB8627661732* __this, bool ___value0, const RuntimeMethod* method) 
{
	{
		// set { lower_case_properties = value; }
		bool L_0 = ___value0;
		__this->___lower_case_properties_10 = L_0;
		// set { lower_case_properties = value; }
		return;
	}
}
// System.Void Agora.Rtc.LitJson.JsonWriter::.cctor()
IL2CPP_EXTERN_C IL2CPP_METHOD_ATTR void JsonWriter__cctor_m9BD24708E327D0D274F6C5C6BCB651825EE98A17 (const RuntimeMethod* method) 
{
	static bool s_Il2CppMethodInitialized;
	if (!s_Il2CppMethodInitialized)
	{
		il2cpp_codegen_initialize_runtime_metadata((uintptr_t*)&JsonWriter_tC9B032D35ED4E85319A227892A43EB8627661732_il2cpp_TypeInfo_var);
		s_Il2CppMethodInitialized = true;
	}
	{
		// number_format = NumberFormatInfo.InvariantInfo;
		NumberFormatInfo_t8E26808B202927FEBF9064FCFEEA4D6E076E6472* L_0;
		L_0 = NumberFormatInfo_get_InvariantInfo_m4689F466D2607C7369BCE394E3FB3681A6E644FA(NULL);
		((JsonWriter_tC9B032D35ED4E85319A227892A43EB8627661732_StaticFields*)il2cpp_codegen_static_fields_for(JsonWriter_tC9B032D35ED4E85319A227892A43EB8627661732_il2cpp_TypeInfo_var))->___number_format_0 = L_0;
		Il2CppCodeGenWriteBarrier((void**)(&((JsonWriter_tC9B032D35ED4E85319A227892A43EB8627661732_StaticFields*)il2cpp_codegen_static_fields_for(JsonWriter_tC9B032D35ED4E85319A227892A43EB8627661732_il2cpp_TypeInfo_var))->___number_format_0), (void*)L_0);
		// }
		return;
	}
}
// System.Void Agora.Rtc.LitJson.JsonWriter::.ctor()
IL2CPP_EXTERN_C IL2CPP_METHOD_ATTR void JsonWriter__ctor_mD558CAAAEA34F9B9BCE3C7AC39CCF7424491F55C (JsonWriter_tC9B032D35ED4E85319A227892A43EB8627661732* __this, const RuntimeMethod* method) 
{
	static bool s_Il2CppMethodInitialized;
	if (!s_Il2CppMethodInitialized)
	{
		il2cpp_codegen_initialize_runtime_metadata((uintptr_t*)&StringBuilder_t_il2cpp_TypeInfo_var);
		il2cpp_codegen_initialize_runtime_metadata((uintptr_t*)&StringWriter_tF48052BE4F980E5C85403221E835768E4156267D_il2cpp_TypeInfo_var);
		s_Il2CppMethodInitialized = true;
	}
	{
		// public JsonWriter ()
		Object__ctor_mE837C6B9FA8C6D5D109F4B2EC885D79919AC0EA2(__this, NULL);
		// inst_string_builder = new StringBuilder ();
		StringBuilder_t* L_0 = (StringBuilder_t*)il2cpp_codegen_object_new(StringBuilder_t_il2cpp_TypeInfo_var);
		NullCheck(L_0);
		StringBuilder__ctor_m1D99713357DE05DAFA296633639DB55F8C30587D(L_0, NULL);
		__this->___inst_string_builder_7 = L_0;
		Il2CppCodeGenWriteBarrier((void**)(&__this->___inst_string_builder_7), (void*)L_0);
		// writer = new StringWriter (inst_string_builder);
		StringBuilder_t* L_1 = __this->___inst_string_builder_7;
		StringWriter_tF48052BE4F980E5C85403221E835768E4156267D* L_2 = (StringWriter_tF48052BE4F980E5C85403221E835768E4156267D*)il2cpp_codegen_object_new(StringWriter_tF48052BE4F980E5C85403221E835768E4156267D_il2cpp_TypeInfo_var);
		NullCheck(L_2);
		StringWriter__ctor_mF38CB8046B79DEF523E427B7F41CA3135671D0C8(L_2, L_1, NULL);
		__this->___writer_11 = L_2;
		Il2CppCodeGenWriteBarrier((void**)(&__this->___writer_11), (void*)L_2);
		// Init ();
		JsonWriter_Init_m1219982C70E6D0B90AB8552218D25C164613DCEF(__this, NULL);
		// }
		return;
	}
}
// System.Void Agora.Rtc.LitJson.JsonWriter::.ctor(System.Text.StringBuilder)
IL2CPP_EXTERN_C IL2CPP_METHOD_ATTR void JsonWriter__ctor_mE43DCF19B6787096CB03168EE1CC9C7ED537A45F (JsonWriter_tC9B032D35ED4E85319A227892A43EB8627661732* __this, StringBuilder_t* ___sb0, const RuntimeMethod* method) 
{
	static bool s_Il2CppMethodInitialized;
	if (!s_Il2CppMethodInitialized)
	{
		il2cpp_codegen_initialize_runtime_metadata((uintptr_t*)&StringWriter_tF48052BE4F980E5C85403221E835768E4156267D_il2cpp_TypeInfo_var);
		s_Il2CppMethodInitialized = true;
	}
	{
		// this (new StringWriter (sb))
		StringBuilder_t* L_0 = ___sb0;
		StringWriter_tF48052BE4F980E5C85403221E835768E4156267D* L_1 = (StringWriter_tF48052BE4F980E5C85403221E835768E4156267D*)il2cpp_codegen_object_new(StringWriter_tF48052BE4F980E5C85403221E835768E4156267D_il2cpp_TypeInfo_var);
		NullCheck(L_1);
		StringWriter__ctor_mF38CB8046B79DEF523E427B7F41CA3135671D0C8(L_1, L_0, NULL);
		JsonWriter__ctor_mDFC33F09AE54B24B0930A2B55C43B3B4EABD168D(__this, L_1, NULL);
		// }
		return;
	}
}
// System.Void Agora.Rtc.LitJson.JsonWriter::.ctor(System.IO.TextWriter)
IL2CPP_EXTERN_C IL2CPP_METHOD_ATTR void JsonWriter__ctor_mDFC33F09AE54B24B0930A2B55C43B3B4EABD168D (JsonWriter_tC9B032D35ED4E85319A227892A43EB8627661732* __this, TextWriter_tA9E5461506CF806E17B6BBBF2119359DEDA3F0F3* ___writer0, const RuntimeMethod* method) 
{
	{
		// public JsonWriter (TextWriter writer)
		Object__ctor_mE837C6B9FA8C6D5D109F4B2EC885D79919AC0EA2(__this, NULL);
		// if (writer == null)
		TextWriter_tA9E5461506CF806E17B6BBBF2119359DEDA3F0F3* L_0 = ___writer0;
		if (L_0)
		{
			goto IL_0014;
		}
	}
	{
		// throw new ArgumentNullException ("writer");
		ArgumentNullException_t327031E412FAB2351B0022DD5DAD47E67E597129* L_1 = (ArgumentNullException_t327031E412FAB2351B0022DD5DAD47E67E597129*)il2cpp_codegen_object_new(((RuntimeClass*)il2cpp_codegen_initialize_runtime_metadata_inline((uintptr_t*)&ArgumentNullException_t327031E412FAB2351B0022DD5DAD47E67E597129_il2cpp_TypeInfo_var)));
		NullCheck(L_1);
		ArgumentNullException__ctor_m444AE141157E333844FC1A9500224C2F9FD24F4B(L_1, ((String_t*)il2cpp_codegen_initialize_runtime_metadata_inline((uintptr_t*)&_stringLiteral638C5441E8427B2B9D2C941DDBF958579B5FE3F0)), NULL);
		IL2CPP_RAISE_MANAGED_EXCEPTION(L_1, ((RuntimeMethod*)il2cpp_codegen_initialize_runtime_metadata_inline((uintptr_t*)&JsonWriter__ctor_mDFC33F09AE54B24B0930A2B55C43B3B4EABD168D_RuntimeMethod_var)));
	}

IL_0014:
	{
		// this.writer = writer;
		TextWriter_tA9E5461506CF806E17B6BBBF2119359DEDA3F0F3* L_2 = ___writer0;
		__this->___writer_11 = L_2;
		Il2CppCodeGenWriteBarrier((void**)(&__this->___writer_11), (void*)L_2);
		// Init ();
		JsonWriter_Init_m1219982C70E6D0B90AB8552218D25C164613DCEF(__this, NULL);
		// }
		return;
	}
}
// System.Void Agora.Rtc.LitJson.JsonWriter::DoValidation(Agora.Rtc.LitJson.Condition)
IL2CPP_EXTERN_C IL2CPP_METHOD_ATTR void JsonWriter_DoValidation_mE5807100853E142A9F37794C4C13B30619720445 (JsonWriter_tC9B032D35ED4E85319A227892A43EB8627661732* __this, int32_t ___cond0, const RuntimeMethod* method) 
{
	{
		// if (! context.ExpectingValue)
		WriterContext_tAA13A82DA53BA6A99795422A71F6D19F331F30BA* L_0 = __this->___context_1;
		NullCheck(L_0);
		bool L_1 = L_0->___ExpectingValue_3;
		if (L_1)
		{
			goto IL_0020;
		}
	}
	{
		// context.Count++;
		WriterContext_tAA13A82DA53BA6A99795422A71F6D19F331F30BA* L_2 = __this->___context_1;
		WriterContext_tAA13A82DA53BA6A99795422A71F6D19F331F30BA* L_3 = L_2;
		NullCheck(L_3);
		int32_t L_4 = L_3->___Count_0;
		NullCheck(L_3);
		L_3->___Count_0 = ((int32_t)il2cpp_codegen_add(L_4, 1));
	}

IL_0020:
	{
		// if (! validate)
		bool L_5 = __this->___validate_9;
		if (L_5)
		{
			goto IL_0029;
		}
	}
	{
		// return;
		return;
	}

IL_0029:
	{
		// if (has_reached_end)
		bool L_6 = __this->___has_reached_end_3;
		if (!L_6)
		{
			goto IL_003c;
		}
	}
	{
		// throw new JsonException (
		//     "A complete JSON symbol has already been written");
		JsonException_t3B214813E48AA5E19793F9026831120B5B2254A1* L_7 = (JsonException_t3B214813E48AA5E19793F9026831120B5B2254A1*)il2cpp_codegen_object_new(((RuntimeClass*)il2cpp_codegen_initialize_runtime_metadata_inline((uintptr_t*)&JsonException_t3B214813E48AA5E19793F9026831120B5B2254A1_il2cpp_TypeInfo_var)));
		NullCheck(L_7);
		JsonException__ctor_m8DBB1F40704DD3E03412DABF55AEE93485DCCBBF(L_7, ((String_t*)il2cpp_codegen_initialize_runtime_metadata_inline((uintptr_t*)&_stringLiteral8E284AA45C643AAA8D3553AA7AB6A1C3BC3E32D1)), NULL);
		IL2CPP_RAISE_MANAGED_EXCEPTION(L_7, ((RuntimeMethod*)il2cpp_codegen_initialize_runtime_metadata_inline((uintptr_t*)&JsonWriter_DoValidation_mE5807100853E142A9F37794C4C13B30619720445_RuntimeMethod_var)));
	}

IL_003c:
	{
		int32_t L_8 = ___cond0;
		switch (L_8)
		{
			case 0:
			{
				goto IL_0057;
			}
			case 1:
			{
				goto IL_0072;
			}
			case 2:
			{
				goto IL_009a;
			}
			case 3:
			{
				goto IL_00bf;
			}
			case 4:
			{
				goto IL_00e4;
			}
		}
	}
	{
		return;
	}

IL_0057:
	{
		// if (! context.InArray)
		WriterContext_tAA13A82DA53BA6A99795422A71F6D19F331F30BA* L_9 = __this->___context_1;
		NullCheck(L_9);
		bool L_10 = L_9->___InArray_1;
		if (L_10)
		{
			goto IL_0116;
		}
	}
	{
		// throw new JsonException (
		//     "Can't close an array here");
		JsonException_t3B214813E48AA5E19793F9026831120B5B2254A1* L_11 = (JsonException_t3B214813E48AA5E19793F9026831120B5B2254A1*)il2cpp_codegen_object_new(((RuntimeClass*)il2cpp_codegen_initialize_runtime_metadata_inline((uintptr_t*)&JsonException_t3B214813E48AA5E19793F9026831120B5B2254A1_il2cpp_TypeInfo_var)));
		NullCheck(L_11);
		JsonException__ctor_m8DBB1F40704DD3E03412DABF55AEE93485DCCBBF(L_11, ((String_t*)il2cpp_codegen_initialize_runtime_metadata_inline((uintptr_t*)&_stringLiteral057118C49B28F31FA4955B194753088DDCD94999)), NULL);
		IL2CPP_RAISE_MANAGED_EXCEPTION(L_11, ((RuntimeMethod*)il2cpp_codegen_initialize_runtime_metadata_inline((uintptr_t*)&JsonWriter_DoValidation_mE5807100853E142A9F37794C4C13B30619720445_RuntimeMethod_var)));
	}

IL_0072:
	{
		// if (! context.InObject || context.ExpectingValue)
		WriterContext_tAA13A82DA53BA6A99795422A71F6D19F331F30BA* L_12 = __this->___context_1;
		NullCheck(L_12);
		bool L_13 = L_12->___InObject_2;
		if (!L_13)
		{
			goto IL_008f;
		}
	}
	{
		WriterContext_tAA13A82DA53BA6A99795422A71F6D19F331F30BA* L_14 = __this->___context_1;
		NullCheck(L_14);
		bool L_15 = L_14->___ExpectingValue_3;
		if (!L_15)
		{
			goto IL_0116;
		}
	}

IL_008f:
	{
		// throw new JsonException (
		//     "Can't close an object here");
		JsonException_t3B214813E48AA5E19793F9026831120B5B2254A1* L_16 = (JsonException_t3B214813E48AA5E19793F9026831120B5B2254A1*)il2cpp_codegen_object_new(((RuntimeClass*)il2cpp_codegen_initialize_runtime_metadata_inline((uintptr_t*)&JsonException_t3B214813E48AA5E19793F9026831120B5B2254A1_il2cpp_TypeInfo_var)));
		NullCheck(L_16);
		JsonException__ctor_m8DBB1F40704DD3E03412DABF55AEE93485DCCBBF(L_16, ((String_t*)il2cpp_codegen_initialize_runtime_metadata_inline((uintptr_t*)&_stringLiteralCEE7535349ADB76DD55B08451D311FC3CF06A19C)), NULL);
		IL2CPP_RAISE_MANAGED_EXCEPTION(L_16, ((RuntimeMethod*)il2cpp_codegen_initialize_runtime_metadata_inline((uintptr_t*)&JsonWriter_DoValidation_mE5807100853E142A9F37794C4C13B30619720445_RuntimeMethod_var)));
	}

IL_009a:
	{
		// if (context.InObject && ! context.ExpectingValue)
		WriterContext_tAA13A82DA53BA6A99795422A71F6D19F331F30BA* L_17 = __this->___context_1;
		NullCheck(L_17);
		bool L_18 = L_17->___InObject_2;
		if (!L_18)
		{
			goto IL_0116;
		}
	}
	{
		WriterContext_tAA13A82DA53BA6A99795422A71F6D19F331F30BA* L_19 = __this->___context_1;
		NullCheck(L_19);
		bool L_20 = L_19->___ExpectingValue_3;
		if (L_20)
		{
			goto IL_0116;
		}
	}
	{
		// throw new JsonException (
		//     "Expected a property");
		JsonException_t3B214813E48AA5E19793F9026831120B5B2254A1* L_21 = (JsonException_t3B214813E48AA5E19793F9026831120B5B2254A1*)il2cpp_codegen_object_new(((RuntimeClass*)il2cpp_codegen_initialize_runtime_metadata_inline((uintptr_t*)&JsonException_t3B214813E48AA5E19793F9026831120B5B2254A1_il2cpp_TypeInfo_var)));
		NullCheck(L_21);
		JsonException__ctor_m8DBB1F40704DD3E03412DABF55AEE93485DCCBBF(L_21, ((String_t*)il2cpp_codegen_initialize_runtime_metadata_inline((uintptr_t*)&_stringLiteralCDA723AA4DBB226A906416AA9BF1C2D4CEC53C89)), NULL);
		IL2CPP_RAISE_MANAGED_EXCEPTION(L_21, ((RuntimeMethod*)il2cpp_codegen_initialize_runtime_metadata_inline((uintptr_t*)&JsonWriter_DoValidation_mE5807100853E142A9F37794C4C13B30619720445_RuntimeMethod_var)));
	}

IL_00bf:
	{
		// if (! context.InObject || context.ExpectingValue)
		WriterContext_tAA13A82DA53BA6A99795422A71F6D19F331F30BA* L_22 = __this->___context_1;
		NullCheck(L_22);
		bool L_23 = L_22->___InObject_2;
		if (!L_23)
		{
			goto IL_00d9;
		}
	}
	{
		WriterContext_tAA13A82DA53BA6A99795422A71F6D19F331F30BA* L_24 = __this->___context_1;
		NullCheck(L_24);
		bool L_25 = L_24->___ExpectingValue_3;
		if (!L_25)
		{
			goto IL_0116;
		}
	}

IL_00d9:
	{
		// throw new JsonException (
		//     "Can't add a property here");
		JsonException_t3B214813E48AA5E19793F9026831120B5B2254A1* L_26 = (JsonException_t3B214813E48AA5E19793F9026831120B5B2254A1*)il2cpp_codegen_object_new(((RuntimeClass*)il2cpp_codegen_initialize_runtime_metadata_inline((uintptr_t*)&JsonException_t3B214813E48AA5E19793F9026831120B5B2254A1_il2cpp_TypeInfo_var)));
		NullCheck(L_26);
		JsonException__ctor_m8DBB1F40704DD3E03412DABF55AEE93485DCCBBF(L_26, ((String_t*)il2cpp_codegen_initialize_runtime_metadata_inline((uintptr_t*)&_stringLiteral84BE6DF7F5E86A94476E7ED44C8A9ACA10E6236A)), NULL);
		IL2CPP_RAISE_MANAGED_EXCEPTION(L_26, ((RuntimeMethod*)il2cpp_codegen_initialize_runtime_metadata_inline((uintptr_t*)&JsonWriter_DoValidation_mE5807100853E142A9F37794C4C13B30619720445_RuntimeMethod_var)));
	}

IL_00e4:
	{
		// if (! context.InArray &&
		//     (! context.InObject || ! context.ExpectingValue))
		WriterContext_tAA13A82DA53BA6A99795422A71F6D19F331F30BA* L_27 = __this->___context_1;
		NullCheck(L_27);
		bool L_28 = L_27->___InArray_1;
		if (L_28)
		{
			goto IL_0116;
		}
	}
	{
		WriterContext_tAA13A82DA53BA6A99795422A71F6D19F331F30BA* L_29 = __this->___context_1;
		NullCheck(L_29);
		bool L_30 = L_29->___InObject_2;
		if (!L_30)
		{
			goto IL_010b;
		}
	}
	{
		WriterContext_tAA13A82DA53BA6A99795422A71F6D19F331F30BA* L_31 = __this->___context_1;
		NullCheck(L_31);
		bool L_32 = L_31->___ExpectingValue_3;
		if (L_32)
		{
			goto IL_0116;
		}
	}

IL_010b:
	{
		// throw new JsonException (
		//     "Can't add a value here");
		JsonException_t3B214813E48AA5E19793F9026831120B5B2254A1* L_33 = (JsonException_t3B214813E48AA5E19793F9026831120B5B2254A1*)il2cpp_codegen_object_new(((RuntimeClass*)il2cpp_codegen_initialize_runtime_metadata_inline((uintptr_t*)&JsonException_t3B214813E48AA5E19793F9026831120B5B2254A1_il2cpp_TypeInfo_var)));
		NullCheck(L_33);
		JsonException__ctor_m8DBB1F40704DD3E03412DABF55AEE93485DCCBBF(L_33, ((String_t*)il2cpp_codegen_initialize_runtime_metadata_inline((uintptr_t*)&_stringLiteralC63496F78F80F09E4841EF5CD0DA8DAF7028FB4B)), NULL);
		IL2CPP_RAISE_MANAGED_EXCEPTION(L_33, ((RuntimeMethod*)il2cpp_codegen_initialize_runtime_metadata_inline((uintptr_t*)&JsonWriter_DoValidation_mE5807100853E142A9F37794C4C13B30619720445_RuntimeMethod_var)));
	}

IL_0116:
	{
		// }
		return;
	}
}
// System.Void Agora.Rtc.LitJson.JsonWriter::Init()
IL2CPP_EXTERN_C IL2CPP_METHOD_ATTR void JsonWriter_Init_m1219982C70E6D0B90AB8552218D25C164613DCEF (JsonWriter_tC9B032D35ED4E85319A227892A43EB8627661732* __this, const RuntimeMethod* method) 
{
	static bool s_Il2CppMethodInitialized;
	if (!s_Il2CppMethodInitialized)
	{
		il2cpp_codegen_initialize_runtime_metadata((uintptr_t*)&CharU5BU5D_t799905CF001DD5F13F7DBB310181FC4D8B7D0AAB_il2cpp_TypeInfo_var);
		il2cpp_codegen_initialize_runtime_metadata((uintptr_t*)&Stack_1_Push_m55AF25BEEA08E56F5C74631BB98562B8461303E9_RuntimeMethod_var);
		il2cpp_codegen_initialize_runtime_metadata((uintptr_t*)&Stack_1__ctor_m6F4B606D290A80B5EA37E96C0DE8A1C9C9C88769_RuntimeMethod_var);
		il2cpp_codegen_initialize_runtime_metadata((uintptr_t*)&Stack_1_t7D2C4DA3105E485DD5491FB8B36FC2D66DA84336_il2cpp_TypeInfo_var);
		il2cpp_codegen_initialize_runtime_metadata((uintptr_t*)&WriterContext_tAA13A82DA53BA6A99795422A71F6D19F331F30BA_il2cpp_TypeInfo_var);
		s_Il2CppMethodInitialized = true;
	}
	{
		// has_reached_end = false;
		__this->___has_reached_end_3 = (bool)0;
		// hex_seq = new char[4];
		CharU5BU5D_t799905CF001DD5F13F7DBB310181FC4D8B7D0AAB* L_0 = (CharU5BU5D_t799905CF001DD5F13F7DBB310181FC4D8B7D0AAB*)(CharU5BU5D_t799905CF001DD5F13F7DBB310181FC4D8B7D0AAB*)SZArrayNew(CharU5BU5D_t799905CF001DD5F13F7DBB310181FC4D8B7D0AAB_il2cpp_TypeInfo_var, (uint32_t)4);
		__this->___hex_seq_4 = L_0;
		Il2CppCodeGenWriteBarrier((void**)(&__this->___hex_seq_4), (void*)L_0);
		// indentation = 0;
		__this->___indentation_5 = 0;
		// indent_value = 4;
		__this->___indent_value_6 = 4;
		// pretty_print = false;
		__this->___pretty_print_8 = (bool)0;
		// validate = true;
		__this->___validate_9 = (bool)1;
		// lower_case_properties = false;
		__this->___lower_case_properties_10 = (bool)0;
		// ctx_stack = new Stack<WriterContext> ();
		Stack_1_t7D2C4DA3105E485DD5491FB8B36FC2D66DA84336* L_1 = (Stack_1_t7D2C4DA3105E485DD5491FB8B36FC2D66DA84336*)il2cpp_codegen_object_new(Stack_1_t7D2C4DA3105E485DD5491FB8B36FC2D66DA84336_il2cpp_TypeInfo_var);
		NullCheck(L_1);
		Stack_1__ctor_m6F4B606D290A80B5EA37E96C0DE8A1C9C9C88769(L_1, Stack_1__ctor_m6F4B606D290A80B5EA37E96C0DE8A1C9C9C88769_RuntimeMethod_var);
		__this->___ctx_stack_2 = L_1;
		Il2CppCodeGenWriteBarrier((void**)(&__this->___ctx_stack_2), (void*)L_1);
		// context = new WriterContext ();
		WriterContext_tAA13A82DA53BA6A99795422A71F6D19F331F30BA* L_2 = (WriterContext_tAA13A82DA53BA6A99795422A71F6D19F331F30BA*)il2cpp_codegen_object_new(WriterContext_tAA13A82DA53BA6A99795422A71F6D19F331F30BA_il2cpp_TypeInfo_var);
		NullCheck(L_2);
		WriterContext__ctor_m91AF1613E06FA2DC16EBC0B70A80FB80F2AF22C3(L_2, NULL);
		__this->___context_1 = L_2;
		Il2CppCodeGenWriteBarrier((void**)(&__this->___context_1), (void*)L_2);
		// ctx_stack.Push (context);
		Stack_1_t7D2C4DA3105E485DD5491FB8B36FC2D66DA84336* L_3 = __this->___ctx_stack_2;
		WriterContext_tAA13A82DA53BA6A99795422A71F6D19F331F30BA* L_4 = __this->___context_1;
		NullCheck(L_3);
		Stack_1_Push_m55AF25BEEA08E56F5C74631BB98562B8461303E9(L_3, L_4, Stack_1_Push_m55AF25BEEA08E56F5C74631BB98562B8461303E9_RuntimeMethod_var);
		// }
		return;
	}
}
// System.Void Agora.Rtc.LitJson.JsonWriter::IntToHex(System.Int32,System.Char[])
IL2CPP_EXTERN_C IL2CPP_METHOD_ATTR void JsonWriter_IntToHex_mA83EFCC9493DC333D63E162215313A6E245018E3 (int32_t ___n0, CharU5BU5D_t799905CF001DD5F13F7DBB310181FC4D8B7D0AAB* ___hex1, const RuntimeMethod* method) 
{
	int32_t V_0 = 0;
	int32_t V_1 = 0;
	{
		// for (int i = 0; i < 4; i++) {
		V_1 = 0;
		goto IL_0030;
	}

IL_0004:
	{
		// num = n % 16;
		int32_t L_0 = ___n0;
		V_0 = ((int32_t)(L_0%((int32_t)16)));
		// if (num < 10)
		int32_t L_1 = V_0;
		if ((((int32_t)L_1) >= ((int32_t)((int32_t)10))))
		{
			goto IL_001a;
		}
	}
	{
		// hex[3 - i] = (char) ('0' + num);
		CharU5BU5D_t799905CF001DD5F13F7DBB310181FC4D8B7D0AAB* L_2 = ___hex1;
		int32_t L_3 = V_1;
		int32_t L_4 = V_0;
		NullCheck(L_2);
		(L_2)->SetAt(static_cast<il2cpp_array_size_t>(((int32_t)il2cpp_codegen_subtract(3, L_3))), (Il2CppChar)((int32_t)(uint16_t)((int32_t)il2cpp_codegen_add(((int32_t)48), L_4))));
		goto IL_0027;
	}

IL_001a:
	{
		// hex[3 - i] = (char) ('A' + (num - 10));
		CharU5BU5D_t799905CF001DD5F13F7DBB310181FC4D8B7D0AAB* L_5 = ___hex1;
		int32_t L_6 = V_1;
		int32_t L_7 = V_0;
		NullCheck(L_5);
		(L_5)->SetAt(static_cast<il2cpp_array_size_t>(((int32_t)il2cpp_codegen_subtract(3, L_6))), (Il2CppChar)((int32_t)(uint16_t)((int32_t)il2cpp_codegen_add(((int32_t)65), ((int32_t)il2cpp_codegen_subtract(L_7, ((int32_t)10)))))));
	}

IL_0027:
	{
		// n >>= 4;
		int32_t L_8 = ___n0;
		___n0 = ((int32_t)(L_8>>4));
		// for (int i = 0; i < 4; i++) {
		int32_t L_9 = V_1;
		V_1 = ((int32_t)il2cpp_codegen_add(L_9, 1));
	}

IL_0030:
	{
		// for (int i = 0; i < 4; i++) {
		int32_t L_10 = V_1;
		if ((((int32_t)L_10) < ((int32_t)4)))
		{
			goto IL_0004;
		}
	}
	{
		// }
		return;
	}
}
// System.Void Agora.Rtc.LitJson.JsonWriter::Indent()
IL2CPP_EXTERN_C IL2CPP_METHOD_ATTR void JsonWriter_Indent_mC750E7984828750E95FCB795B0D3D6BA3A0D74DA (JsonWriter_tC9B032D35ED4E85319A227892A43EB8627661732* __this, const RuntimeMethod* method) 
{
	{
		// if (pretty_print)
		bool L_0 = __this->___pretty_print_8;
		if (!L_0)
		{
			goto IL_001b;
		}
	}
	{
		// indentation += indent_value;
		int32_t L_1 = __this->___indentation_5;
		int32_t L_2 = __this->___indent_value_6;
		__this->___indentation_5 = ((int32_t)il2cpp_codegen_add(L_1, L_2));
	}

IL_001b:
	{
		// }
		return;
	}
}
// System.Void Agora.Rtc.LitJson.JsonWriter::Put(System.String)
IL2CPP_EXTERN_C IL2CPP_METHOD_ATTR void JsonWriter_Put_m727B8E7799FDDF22D93C62522E33ABE198FC78E3 (JsonWriter_tC9B032D35ED4E85319A227892A43EB8627661732* __this, String_t* ___str0, const RuntimeMethod* method) 
{
	int32_t V_0 = 0;
	{
		// if (pretty_print && ! context.ExpectingValue)
		bool L_0 = __this->___pretty_print_8;
		if (!L_0)
		{
			goto IL_0033;
		}
	}
	{
		WriterContext_tAA13A82DA53BA6A99795422A71F6D19F331F30BA* L_1 = __this->___context_1;
		NullCheck(L_1);
		bool L_2 = L_1->___ExpectingValue_3;
		if (L_2)
		{
			goto IL_0033;
		}
	}
	{
		// for (int i = 0; i < indentation; i++)
		V_0 = 0;
		goto IL_002a;
	}

IL_0019:
	{
		// writer.Write (' ');
		TextWriter_tA9E5461506CF806E17B6BBBF2119359DEDA3F0F3* L_3 = __this->___writer_11;
		NullCheck(L_3);
		VirtualActionInvoker1< Il2CppChar >::Invoke(13 /* System.Void System.IO.TextWriter::Write(System.Char) */, L_3, ((int32_t)32));
		// for (int i = 0; i < indentation; i++)
		int32_t L_4 = V_0;
		V_0 = ((int32_t)il2cpp_codegen_add(L_4, 1));
	}

IL_002a:
	{
		// for (int i = 0; i < indentation; i++)
		int32_t L_5 = V_0;
		int32_t L_6 = __this->___indentation_5;
		if ((((int32_t)L_5) < ((int32_t)L_6)))
		{
			goto IL_0019;
		}
	}

IL_0033:
	{
		// writer.Write (str);
		TextWriter_tA9E5461506CF806E17B6BBBF2119359DEDA3F0F3* L_7 = __this->___writer_11;
		String_t* L_8 = ___str0;
		NullCheck(L_7);
		VirtualActionInvoker1< String_t* >::Invoke(16 /* System.Void System.IO.TextWriter::Write(System.String) */, L_7, L_8);
		// }
		return;
	}
}
// System.Void Agora.Rtc.LitJson.JsonWriter::PutNewline()
IL2CPP_EXTERN_C IL2CPP_METHOD_ATTR void JsonWriter_PutNewline_m75776BA10443F6494A562FEF05BF65291B861D1F (JsonWriter_tC9B032D35ED4E85319A227892A43EB8627661732* __this, const RuntimeMethod* method) 
{
	{
		// PutNewline (true);
		JsonWriter_PutNewline_mCA284D695C145383C730CE1A87C87C5C5A6AA7C5(__this, (bool)1, NULL);
		// }
		return;
	}
}
// System.Void Agora.Rtc.LitJson.JsonWriter::PutNewline(System.Boolean)
IL2CPP_EXTERN_C IL2CPP_METHOD_ATTR void JsonWriter_PutNewline_mCA284D695C145383C730CE1A87C87C5C5A6AA7C5 (JsonWriter_tC9B032D35ED4E85319A227892A43EB8627661732* __this, bool ___add_comma0, const RuntimeMethod* method) 
{
	{
		// if (add_comma && ! context.ExpectingValue &&
		//     context.Count > 1)
		bool L_0 = ___add_comma0;
		if (!L_0)
		{
			goto IL_002b;
		}
	}
	{
		WriterContext_tAA13A82DA53BA6A99795422A71F6D19F331F30BA* L_1 = __this->___context_1;
		NullCheck(L_1);
		bool L_2 = L_1->___ExpectingValue_3;
		if (L_2)
		{
			goto IL_002b;
		}
	}
	{
		WriterContext_tAA13A82DA53BA6A99795422A71F6D19F331F30BA* L_3 = __this->___context_1;
		NullCheck(L_3);
		int32_t L_4 = L_3->___Count_0;
		if ((((int32_t)L_4) <= ((int32_t)1)))
		{
			goto IL_002b;
		}
	}
	{
		// writer.Write (',');
		TextWriter_tA9E5461506CF806E17B6BBBF2119359DEDA3F0F3* L_5 = __this->___writer_11;
		NullCheck(L_5);
		VirtualActionInvoker1< Il2CppChar >::Invoke(13 /* System.Void System.IO.TextWriter::Write(System.Char) */, L_5, ((int32_t)44));
	}

IL_002b:
	{
		// if (pretty_print && ! context.ExpectingValue)
		bool L_6 = __this->___pretty_print_8;
		if (!L_6)
		{
			goto IL_0050;
		}
	}
	{
		WriterContext_tAA13A82DA53BA6A99795422A71F6D19F331F30BA* L_7 = __this->___context_1;
		NullCheck(L_7);
		bool L_8 = L_7->___ExpectingValue_3;
		if (L_8)
		{
			goto IL_0050;
		}
	}
	{
		// writer.Write (Environment.NewLine);
		TextWriter_tA9E5461506CF806E17B6BBBF2119359DEDA3F0F3* L_9 = __this->___writer_11;
		String_t* L_10;
		L_10 = Environment_get_NewLine_m8BF68A4EFDAFFB66500984CE779629811BA98FFF(NULL);
		NullCheck(L_9);
		VirtualActionInvoker1< String_t* >::Invoke(16 /* System.Void System.IO.TextWriter::Write(System.String) */, L_9, L_10);
	}

IL_0050:
	{
		// }
		return;
	}
}
// System.Void Agora.Rtc.LitJson.JsonWriter::PutString(System.String)
IL2CPP_EXTERN_C IL2CPP_METHOD_ATTR void JsonWriter_PutString_m1727A993A1F47158048BC2E3F6B150B3773E2716 (JsonWriter_tC9B032D35ED4E85319A227892A43EB8627661732* __this, String_t* ___str0, const RuntimeMethod* method) 
{
	static bool s_Il2CppMethodInitialized;
	if (!s_Il2CppMethodInitialized)
	{
		il2cpp_codegen_initialize_runtime_metadata((uintptr_t*)&JsonWriter_tC9B032D35ED4E85319A227892A43EB8627661732_il2cpp_TypeInfo_var);
		il2cpp_codegen_initialize_runtime_metadata((uintptr_t*)&String_t_il2cpp_TypeInfo_var);
		il2cpp_codegen_initialize_runtime_metadata((uintptr_t*)&_stringLiteral5962E944D7340CE47999BF097B4AFD70C1501FB9);
		il2cpp_codegen_initialize_runtime_metadata((uintptr_t*)&_stringLiteral785F17F45C331C415D0A7458E6AAC36966399C51);
		il2cpp_codegen_initialize_runtime_metadata((uintptr_t*)&_stringLiteral7F3238CD8C342B06FB9AB185C610175C84625462);
		il2cpp_codegen_initialize_runtime_metadata((uintptr_t*)&_stringLiteralA7C3FCA8C63E127B542B38A5CA5E3FEEDDD1B122);
		il2cpp_codegen_initialize_runtime_metadata((uintptr_t*)&_stringLiteralB78F235D4291950A7D101307609C259F3E1F033F);
		il2cpp_codegen_initialize_runtime_metadata((uintptr_t*)&_stringLiteralDA666908BB15F4E1D2649752EC5DCBD0D5C64699);
		s_Il2CppMethodInitialized = true;
	}
	int32_t V_0 = 0;
	int32_t V_1 = 0;
	Il2CppChar V_2 = 0x0;
	{
		// Put (String.Empty);
		String_t* L_0 = ((String_t_StaticFields*)il2cpp_codegen_static_fields_for(String_t_il2cpp_TypeInfo_var))->___Empty_6;
		JsonWriter_Put_m727B8E7799FDDF22D93C62522E33ABE198FC78E3(__this, L_0, NULL);
		// writer.Write ('"');
		TextWriter_tA9E5461506CF806E17B6BBBF2119359DEDA3F0F3* L_1 = __this->___writer_11;
		NullCheck(L_1);
		VirtualActionInvoker1< Il2CppChar >::Invoke(13 /* System.Void System.IO.TextWriter::Write(System.Char) */, L_1, ((int32_t)34));
		// int n = str.Length;
		String_t* L_2 = ___str0;
		NullCheck(L_2);
		int32_t L_3;
		L_3 = String_get_Length_m42625D67623FA5CC7A44D47425CE86FB946542D2_inline(L_2, NULL);
		V_0 = L_3;
		// for (int i = 0; i < n; i++) {
		V_1 = 0;
		goto IL_0145;
	}

IL_0026:
	{
		// switch (str[i]) {
		String_t* L_4 = ___str0;
		int32_t L_5 = V_1;
		NullCheck(L_4);
		Il2CppChar L_6;
		L_6 = String_get_Chars_mC49DF0CD2D3BE7BE97B3AD9C995BE3094F8E36D3(L_4, L_5, NULL);
		V_2 = L_6;
		Il2CppChar L_7 = V_2;
		switch (((int32_t)il2cpp_codegen_subtract((int32_t)L_7, 8)))
		{
			case 0:
			{
				goto IL_00d2;
			}
			case 1:
			{
				goto IL_0087;
			}
			case 2:
			{
				goto IL_005d;
			}
			case 3:
			{
				goto IL_00e4;
			}
			case 4:
			{
				goto IL_00c0;
			}
			case 5:
			{
				goto IL_0072;
			}
		}
	}
	{
		Il2CppChar L_8 = V_2;
		if ((((int32_t)L_8) == ((int32_t)((int32_t)34))))
		{
			goto IL_009c;
		}
	}
	{
		Il2CppChar L_9 = V_2;
		if ((((int32_t)L_9) == ((int32_t)((int32_t)92))))
		{
			goto IL_009c;
		}
	}
	{
		goto IL_00e4;
	}

IL_005d:
	{
		// writer.Write ("\\n");
		TextWriter_tA9E5461506CF806E17B6BBBF2119359DEDA3F0F3* L_10 = __this->___writer_11;
		NullCheck(L_10);
		VirtualActionInvoker1< String_t* >::Invoke(16 /* System.Void System.IO.TextWriter::Write(System.String) */, L_10, _stringLiteral785F17F45C331C415D0A7458E6AAC36966399C51);
		// continue;
		goto IL_0141;
	}

IL_0072:
	{
		// writer.Write ("\\r");
		TextWriter_tA9E5461506CF806E17B6BBBF2119359DEDA3F0F3* L_11 = __this->___writer_11;
		NullCheck(L_11);
		VirtualActionInvoker1< String_t* >::Invoke(16 /* System.Void System.IO.TextWriter::Write(System.String) */, L_11, _stringLiteralB78F235D4291950A7D101307609C259F3E1F033F);
		// continue;
		goto IL_0141;
	}

IL_0087:
	{
		// writer.Write ("\\t");
		TextWriter_tA9E5461506CF806E17B6BBBF2119359DEDA3F0F3* L_12 = __this->___writer_11;
		NullCheck(L_12);
		VirtualActionInvoker1< String_t* >::Invoke(16 /* System.Void System.IO.TextWriter::Write(System.String) */, L_12, _stringLiteral7F3238CD8C342B06FB9AB185C610175C84625462);
		// continue;
		goto IL_0141;
	}

IL_009c:
	{
		// writer.Write ('\\');
		TextWriter_tA9E5461506CF806E17B6BBBF2119359DEDA3F0F3* L_13 = __this->___writer_11;
		NullCheck(L_13);
		VirtualActionInvoker1< Il2CppChar >::Invoke(13 /* System.Void System.IO.TextWriter::Write(System.Char) */, L_13, ((int32_t)92));
		// writer.Write (str[i]);
		TextWriter_tA9E5461506CF806E17B6BBBF2119359DEDA3F0F3* L_14 = __this->___writer_11;
		String_t* L_15 = ___str0;
		int32_t L_16 = V_1;
		NullCheck(L_15);
		Il2CppChar L_17;
		L_17 = String_get_Chars_mC49DF0CD2D3BE7BE97B3AD9C995BE3094F8E36D3(L_15, L_16, NULL);
		NullCheck(L_14);
		VirtualActionInvoker1< Il2CppChar >::Invoke(13 /* System.Void System.IO.TextWriter::Write(System.Char) */, L_14, L_17);
		// continue;
		goto IL_0141;
	}

IL_00c0:
	{
		// writer.Write ("\\f");
		TextWriter_tA9E5461506CF806E17B6BBBF2119359DEDA3F0F3* L_18 = __this->___writer_11;
		NullCheck(L_18);
		VirtualActionInvoker1< String_t* >::Invoke(16 /* System.Void System.IO.TextWriter::Write(System.String) */, L_18, _stringLiteralA7C3FCA8C63E127B542B38A5CA5E3FEEDDD1B122);
		// continue;
		goto IL_0141;
	}

IL_00d2:
	{
		// writer.Write ("\\b");
		TextWriter_tA9E5461506CF806E17B6BBBF2119359DEDA3F0F3* L_19 = __this->___writer_11;
		NullCheck(L_19);
		VirtualActionInvoker1< String_t* >::Invoke(16 /* System.Void System.IO.TextWriter::Write(System.String) */, L_19, _stringLiteral5962E944D7340CE47999BF097B4AFD70C1501FB9);
		// continue;
		goto IL_0141;
	}

IL_00e4:
	{
		// if ((int) str[i] >= 32 && (int) str[i] <= 126) {
		String_t* L_20 = ___str0;
		int32_t L_21 = V_1;
		NullCheck(L_20);
		Il2CppChar L_22;
		L_22 = String_get_Chars_mC49DF0CD2D3BE7BE97B3AD9C995BE3094F8E36D3(L_20, L_21, NULL);
		if ((((int32_t)L_22) < ((int32_t)((int32_t)32))))
		{
			goto IL_010e;
		}
	}
	{
		String_t* L_23 = ___str0;
		int32_t L_24 = V_1;
		NullCheck(L_23);
		Il2CppChar L_25;
		L_25 = String_get_Chars_mC49DF0CD2D3BE7BE97B3AD9C995BE3094F8E36D3(L_23, L_24, NULL);
		if ((((int32_t)L_25) > ((int32_t)((int32_t)126))))
		{
			goto IL_010e;
		}
	}
	{
		// writer.Write (str[i]);
		TextWriter_tA9E5461506CF806E17B6BBBF2119359DEDA3F0F3* L_26 = __this->___writer_11;
		String_t* L_27 = ___str0;
		int32_t L_28 = V_1;
		NullCheck(L_27);
		Il2CppChar L_29;
		L_29 = String_get_Chars_mC49DF0CD2D3BE7BE97B3AD9C995BE3094F8E36D3(L_27, L_28, NULL);
		NullCheck(L_26);
		VirtualActionInvoker1< Il2CppChar >::Invoke(13 /* System.Void System.IO.TextWriter::Write(System.Char) */, L_26, L_29);
		// continue;
		goto IL_0141;
	}

IL_010e:
	{
		// IntToHex ((int) str[i], hex_seq);
		String_t* L_30 = ___str0;
		int32_t L_31 = V_1;
		NullCheck(L_30);
		Il2CppChar L_32;
		L_32 = String_get_Chars_mC49DF0CD2D3BE7BE97B3AD9C995BE3094F8E36D3(L_30, L_31, NULL);
		CharU5BU5D_t799905CF001DD5F13F7DBB310181FC4D8B7D0AAB* L_33 = __this->___hex_seq_4;
		il2cpp_codegen_runtime_class_init_inline(JsonWriter_tC9B032D35ED4E85319A227892A43EB8627661732_il2cpp_TypeInfo_var);
		JsonWriter_IntToHex_mA83EFCC9493DC333D63E162215313A6E245018E3(L_32, L_33, NULL);
		// writer.Write ("\\u");
		TextWriter_tA9E5461506CF806E17B6BBBF2119359DEDA3F0F3* L_34 = __this->___writer_11;
		NullCheck(L_34);
		VirtualActionInvoker1< String_t* >::Invoke(16 /* System.Void System.IO.TextWriter::Write(System.String) */, L_34, _stringLiteralDA666908BB15F4E1D2649752EC5DCBD0D5C64699);
		// writer.Write (hex_seq);
		TextWriter_tA9E5461506CF806E17B6BBBF2119359DEDA3F0F3* L_35 = __this->___writer_11;
		CharU5BU5D_t799905CF001DD5F13F7DBB310181FC4D8B7D0AAB* L_36 = __this->___hex_seq_4;
		NullCheck(L_35);
		VirtualActionInvoker1< CharU5BU5D_t799905CF001DD5F13F7DBB310181FC4D8B7D0AAB* >::Invoke(14 /* System.Void System.IO.TextWriter::Write(System.Char[]) */, L_35, L_36);
	}

IL_0141:
	{
		// for (int i = 0; i < n; i++) {
		int32_t L_37 = V_1;
		V_1 = ((int32_t)il2cpp_codegen_add(L_37, 1));
	}

IL_0145:
	{
		// for (int i = 0; i < n; i++) {
		int32_t L_38 = V_1;
		int32_t L_39 = V_0;
		if ((((int32_t)L_38) < ((int32_t)L_39)))
		{
			goto IL_0026;
		}
	}
	{
		// writer.Write ('"');
		TextWriter_tA9E5461506CF806E17B6BBBF2119359DEDA3F0F3* L_40 = __this->___writer_11;
		NullCheck(L_40);
		VirtualActionInvoker1< Il2CppChar >::Invoke(13 /* System.Void System.IO.TextWriter::Write(System.Char) */, L_40, ((int32_t)34));
		// }
		return;
	}
}
// System.Void Agora.Rtc.LitJson.JsonWriter::Unindent()
IL2CPP_EXTERN_C IL2CPP_METHOD_ATTR void JsonWriter_Unindent_mCE6B680D58C2112946014AE15C9E7AF4D3D047B0 (JsonWriter_tC9B032D35ED4E85319A227892A43EB8627661732* __this, const RuntimeMethod* method) 
{
	{
		// if (pretty_print)
		bool L_0 = __this->___pretty_print_8;
		if (!L_0)
		{
			goto IL_001b;
		}
	}
	{
		// indentation -= indent_value;
		int32_t L_1 = __this->___indentation_5;
		int32_t L_2 = __this->___indent_value_6;
		__this->___indentation_5 = ((int32_t)il2cpp_codegen_subtract(L_1, L_2));
	}

IL_001b:
	{
		// }
		return;
	}
}
// System.String Agora.Rtc.LitJson.JsonWriter::ToString()
IL2CPP_EXTERN_C IL2CPP_METHOD_ATTR String_t* JsonWriter_ToString_mBB38D9E8B446E63A3FDE43B73E25E851CE4A7816 (JsonWriter_tC9B032D35ED4E85319A227892A43EB8627661732* __this, const RuntimeMethod* method) 
{
	static bool s_Il2CppMethodInitialized;
	if (!s_Il2CppMethodInitialized)
	{
		il2cpp_codegen_initialize_runtime_metadata((uintptr_t*)&String_t_il2cpp_TypeInfo_var);
		s_Il2CppMethodInitialized = true;
	}
	{
		// if (inst_string_builder == null)
		StringBuilder_t* L_0 = __this->___inst_string_builder_7;
		if (L_0)
		{
			goto IL_000e;
		}
	}
	{
		// return String.Empty;
		String_t* L_1 = ((String_t_StaticFields*)il2cpp_codegen_static_fields_for(String_t_il2cpp_TypeInfo_var))->___Empty_6;
		return L_1;
	}

IL_000e:
	{
		// return inst_string_builder.ToString ();
		StringBuilder_t* L_2 = __this->___inst_string_builder_7;
		NullCheck(L_2);
		String_t* L_3;
		L_3 = VirtualFuncInvoker0< String_t* >::Invoke(3 /* System.String System.Object::ToString() */, L_2);
		return L_3;
	}
}
// System.Void Agora.Rtc.LitJson.JsonWriter::Reset()
IL2CPP_EXTERN_C IL2CPP_METHOD_ATTR void JsonWriter_Reset_mD406298E6ABF01CFA5532778FFC719E7CDABABE8 (JsonWriter_tC9B032D35ED4E85319A227892A43EB8627661732* __this, const RuntimeMethod* method) 
{
	static bool s_Il2CppMethodInitialized;
	if (!s_Il2CppMethodInitialized)
	{
		il2cpp_codegen_initialize_runtime_metadata((uintptr_t*)&Stack_1_Clear_m6A6BD959A75D18D594176D96A28F64A48E06FF42_RuntimeMethod_var);
		il2cpp_codegen_initialize_runtime_metadata((uintptr_t*)&Stack_1_Push_m55AF25BEEA08E56F5C74631BB98562B8461303E9_RuntimeMethod_var);
		il2cpp_codegen_initialize_runtime_metadata((uintptr_t*)&WriterContext_tAA13A82DA53BA6A99795422A71F6D19F331F30BA_il2cpp_TypeInfo_var);
		s_Il2CppMethodInitialized = true;
	}
	{
		// has_reached_end = false;
		__this->___has_reached_end_3 = (bool)0;
		// ctx_stack.Clear ();
		Stack_1_t7D2C4DA3105E485DD5491FB8B36FC2D66DA84336* L_0 = __this->___ctx_stack_2;
		NullCheck(L_0);
		Stack_1_Clear_m6A6BD959A75D18D594176D96A28F64A48E06FF42(L_0, Stack_1_Clear_m6A6BD959A75D18D594176D96A28F64A48E06FF42_RuntimeMethod_var);
		// context = new WriterContext ();
		WriterContext_tAA13A82DA53BA6A99795422A71F6D19F331F30BA* L_1 = (WriterContext_tAA13A82DA53BA6A99795422A71F6D19F331F30BA*)il2cpp_codegen_object_new(WriterContext_tAA13A82DA53BA6A99795422A71F6D19F331F30BA_il2cpp_TypeInfo_var);
		NullCheck(L_1);
		WriterContext__ctor_m91AF1613E06FA2DC16EBC0B70A80FB80F2AF22C3(L_1, NULL);
		__this->___context_1 = L_1;
		Il2CppCodeGenWriteBarrier((void**)(&__this->___context_1), (void*)L_1);
		// ctx_stack.Push (context);
		Stack_1_t7D2C4DA3105E485DD5491FB8B36FC2D66DA84336* L_2 = __this->___ctx_stack_2;
		WriterContext_tAA13A82DA53BA6A99795422A71F6D19F331F30BA* L_3 = __this->___context_1;
		NullCheck(L_2);
		Stack_1_Push_m55AF25BEEA08E56F5C74631BB98562B8461303E9(L_2, L_3, Stack_1_Push_m55AF25BEEA08E56F5C74631BB98562B8461303E9_RuntimeMethod_var);
		// if (inst_string_builder != null)
		StringBuilder_t* L_4 = __this->___inst_string_builder_7;
		if (!L_4)
		{
			goto IL_004e;
		}
	}
	{
		// inst_string_builder.Remove (0, inst_string_builder.Length);
		StringBuilder_t* L_5 = __this->___inst_string_builder_7;
		StringBuilder_t* L_6 = __this->___inst_string_builder_7;
		NullCheck(L_6);
		int32_t L_7;
		L_7 = StringBuilder_get_Length_mDEA041E7357C68CC3B5885276BB403676DAAE0D8(L_6, NULL);
		NullCheck(L_5);
		StringBuilder_t* L_8;
		L_8 = StringBuilder_Remove_m0D93692674D1C09795C7D6542420A3B6C5F81E90(L_5, 0, L_7, NULL);
	}

IL_004e:
	{
		// }
		return;
	}
}
// System.Void Agora.Rtc.LitJson.JsonWriter::Write(System.Boolean)
IL2CPP_EXTERN_C IL2CPP_METHOD_ATTR void JsonWriter_Write_m9BD6510420B13A0C0F33A6D28906F4E8CDB82EAB (JsonWriter_tC9B032D35ED4E85319A227892A43EB8627661732* __this, bool ___boolean0, const RuntimeMethod* method) 
{
	static bool s_Il2CppMethodInitialized;
	if (!s_Il2CppMethodInitialized)
	{
		il2cpp_codegen_initialize_runtime_metadata((uintptr_t*)&_stringLiteral77D38C0623F92B292B925F6E72CF5CF99A20D4EB);
		il2cpp_codegen_initialize_runtime_metadata((uintptr_t*)&_stringLiteralB7C45DD316C68ABF3429C20058C2981C652192F2);
		s_Il2CppMethodInitialized = true;
	}
	JsonWriter_tC9B032D35ED4E85319A227892A43EB8627661732* G_B2_0 = NULL;
	JsonWriter_tC9B032D35ED4E85319A227892A43EB8627661732* G_B1_0 = NULL;
	String_t* G_B3_0 = NULL;
	JsonWriter_tC9B032D35ED4E85319A227892A43EB8627661732* G_B3_1 = NULL;
	{
		// DoValidation (Condition.Value);
		JsonWriter_DoValidation_mE5807100853E142A9F37794C4C13B30619720445(__this, 4, NULL);
		// PutNewline ();
		JsonWriter_PutNewline_m75776BA10443F6494A562FEF05BF65291B861D1F(__this, NULL);
		// Put (boolean ? "true" : "false");
		bool L_0 = ___boolean0;
		G_B1_0 = __this;
		if (L_0)
		{
			G_B2_0 = __this;
			goto IL_0018;
		}
	}
	{
		G_B3_0 = _stringLiteral77D38C0623F92B292B925F6E72CF5CF99A20D4EB;
		G_B3_1 = G_B1_0;
		goto IL_001d;
	}

IL_0018:
	{
		G_B3_0 = _stringLiteralB7C45DD316C68ABF3429C20058C2981C652192F2;
		G_B3_1 = G_B2_0;
	}

IL_001d:
	{
		NullCheck(G_B3_1);
		JsonWriter_Put_m727B8E7799FDDF22D93C62522E33ABE198FC78E3(G_B3_1, G_B3_0, NULL);
		// context.ExpectingValue = false;
		WriterContext_tAA13A82DA53BA6A99795422A71F6D19F331F30BA* L_1 = __this->___context_1;
		NullCheck(L_1);
		L_1->___ExpectingValue_3 = (bool)0;
		// }
		return;
	}
}
// System.Void Agora.Rtc.LitJson.JsonWriter::Write(System.Decimal)
IL2CPP_EXTERN_C IL2CPP_METHOD_ATTR void JsonWriter_Write_m890E86088FDAB9171E16DEDD20FE3DA90C7339C9 (JsonWriter_tC9B032D35ED4E85319A227892A43EB8627661732* __this, Decimal_tDA6C877282B2D789CF97C0949661CC11D643969F ___number0, const RuntimeMethod* method) 
{
	static bool s_Il2CppMethodInitialized;
	if (!s_Il2CppMethodInitialized)
	{
		il2cpp_codegen_initialize_runtime_metadata((uintptr_t*)&Convert_t7097FF336D592F7C06D88A98349A44646F91EFFC_il2cpp_TypeInfo_var);
		il2cpp_codegen_initialize_runtime_metadata((uintptr_t*)&JsonWriter_tC9B032D35ED4E85319A227892A43EB8627661732_il2cpp_TypeInfo_var);
		s_Il2CppMethodInitialized = true;
	}
	{
		// DoValidation (Condition.Value);
		JsonWriter_DoValidation_mE5807100853E142A9F37794C4C13B30619720445(__this, 4, NULL);
		// PutNewline ();
		JsonWriter_PutNewline_m75776BA10443F6494A562FEF05BF65291B861D1F(__this, NULL);
		// Put (Convert.ToString (number, number_format));
		Decimal_tDA6C877282B2D789CF97C0949661CC11D643969F L_0 = ___number0;
		il2cpp_codegen_runtime_class_init_inline(JsonWriter_tC9B032D35ED4E85319A227892A43EB8627661732_il2cpp_TypeInfo_var);
		NumberFormatInfo_t8E26808B202927FEBF9064FCFEEA4D6E076E6472* L_1 = ((JsonWriter_tC9B032D35ED4E85319A227892A43EB8627661732_StaticFields*)il2cpp_codegen_static_fields_for(JsonWriter_tC9B032D35ED4E85319A227892A43EB8627661732_il2cpp_TypeInfo_var))->___number_format_0;
		il2cpp_codegen_runtime_class_init_inline(Convert_t7097FF336D592F7C06D88A98349A44646F91EFFC_il2cpp_TypeInfo_var);
		String_t* L_2;
		L_2 = Convert_ToString_mF6A8BB10515230B099A7EDA9D28C2F8991F758CA(L_0, L_1, NULL);
		JsonWriter_Put_m727B8E7799FDDF22D93C62522E33ABE198FC78E3(__this, L_2, NULL);
		// context.ExpectingValue = false;
		WriterContext_tAA13A82DA53BA6A99795422A71F6D19F331F30BA* L_3 = __this->___context_1;
		NullCheck(L_3);
		L_3->___ExpectingValue_3 = (bool)0;
		// }
		return;
	}
}
// System.Void Agora.Rtc.LitJson.JsonWriter::Write(System.Double)
IL2CPP_EXTERN_C IL2CPP_METHOD_ATTR void JsonWriter_Write_mED0E50A291A9F97AC7BF9E63C16767093ED4AF13 (JsonWriter_tC9B032D35ED4E85319A227892A43EB8627661732* __this, double ___number0, const RuntimeMethod* method) 
{
	static bool s_Il2CppMethodInitialized;
	if (!s_Il2CppMethodInitialized)
	{
		il2cpp_codegen_initialize_runtime_metadata((uintptr_t*)&Convert_t7097FF336D592F7C06D88A98349A44646F91EFFC_il2cpp_TypeInfo_var);
		il2cpp_codegen_initialize_runtime_metadata((uintptr_t*)&JsonWriter_tC9B032D35ED4E85319A227892A43EB8627661732_il2cpp_TypeInfo_var);
		il2cpp_codegen_initialize_runtime_metadata((uintptr_t*)&_stringLiteralC31E66F919D06AD2730738EF7F884271E99BB7DA);
		s_Il2CppMethodInitialized = true;
	}
	String_t* V_0 = NULL;
	{
		// DoValidation (Condition.Value);
		JsonWriter_DoValidation_mE5807100853E142A9F37794C4C13B30619720445(__this, 4, NULL);
		// PutNewline ();
		JsonWriter_PutNewline_m75776BA10443F6494A562FEF05BF65291B861D1F(__this, NULL);
		// string str = Convert.ToString (number, number_format);
		double L_0 = ___number0;
		il2cpp_codegen_runtime_class_init_inline(JsonWriter_tC9B032D35ED4E85319A227892A43EB8627661732_il2cpp_TypeInfo_var);
		NumberFormatInfo_t8E26808B202927FEBF9064FCFEEA4D6E076E6472* L_1 = ((JsonWriter_tC9B032D35ED4E85319A227892A43EB8627661732_StaticFields*)il2cpp_codegen_static_fields_for(JsonWriter_tC9B032D35ED4E85319A227892A43EB8627661732_il2cpp_TypeInfo_var))->___number_format_0;
		il2cpp_codegen_runtime_class_init_inline(Convert_t7097FF336D592F7C06D88A98349A44646F91EFFC_il2cpp_TypeInfo_var);
		String_t* L_2;
		L_2 = Convert_ToString_m7EBE84B1D453D12C9514AD3EF4F6B3F55A5E5C9B(L_0, L_1, NULL);
		V_0 = L_2;
		// Put (str);
		String_t* L_3 = V_0;
		JsonWriter_Put_m727B8E7799FDDF22D93C62522E33ABE198FC78E3(__this, L_3, NULL);
		// if (str.IndexOf ('.') == -1 &&
		//     str.IndexOf ('E') == -1)
		String_t* L_4 = V_0;
		NullCheck(L_4);
		int32_t L_5;
		L_5 = String_IndexOf_mE21E78F35EF4A7768E385A72814C88D22B689966(L_4, ((int32_t)46), NULL);
		if ((!(((uint32_t)L_5) == ((uint32_t)(-1)))))
		{
			goto IL_0046;
		}
	}
	{
		String_t* L_6 = V_0;
		NullCheck(L_6);
		int32_t L_7;
		L_7 = String_IndexOf_mE21E78F35EF4A7768E385A72814C88D22B689966(L_6, ((int32_t)69), NULL);
		if ((!(((uint32_t)L_7) == ((uint32_t)(-1)))))
		{
			goto IL_0046;
		}
	}
	{
		// writer.Write (".0");
		TextWriter_tA9E5461506CF806E17B6BBBF2119359DEDA3F0F3* L_8 = __this->___writer_11;
		NullCheck(L_8);
		VirtualActionInvoker1< String_t* >::Invoke(16 /* System.Void System.IO.TextWriter::Write(System.String) */, L_8, _stringLiteralC31E66F919D06AD2730738EF7F884271E99BB7DA);
	}

IL_0046:
	{
		// context.ExpectingValue = false;
		WriterContext_tAA13A82DA53BA6A99795422A71F6D19F331F30BA* L_9 = __this->___context_1;
		NullCheck(L_9);
		L_9->___ExpectingValue_3 = (bool)0;
		// }
		return;
	}
}
// System.Void Agora.Rtc.LitJson.JsonWriter::Write(System.Single)
IL2CPP_EXTERN_C IL2CPP_METHOD_ATTR void JsonWriter_Write_mC6413EFB2419DA11FC5F5C778CFD105E54EDBB57 (JsonWriter_tC9B032D35ED4E85319A227892A43EB8627661732* __this, float ___number0, const RuntimeMethod* method) 
{
	static bool s_Il2CppMethodInitialized;
	if (!s_Il2CppMethodInitialized)
	{
		il2cpp_codegen_initialize_runtime_metadata((uintptr_t*)&Convert_t7097FF336D592F7C06D88A98349A44646F91EFFC_il2cpp_TypeInfo_var);
		il2cpp_codegen_initialize_runtime_metadata((uintptr_t*)&JsonWriter_tC9B032D35ED4E85319A227892A43EB8627661732_il2cpp_TypeInfo_var);
		s_Il2CppMethodInitialized = true;
	}
	String_t* V_0 = NULL;
	{
		// DoValidation(Condition.Value);
		JsonWriter_DoValidation_mE5807100853E142A9F37794C4C13B30619720445(__this, 4, NULL);
		// PutNewline();
		JsonWriter_PutNewline_m75776BA10443F6494A562FEF05BF65291B861D1F(__this, NULL);
		// string str = Convert.ToString(number, number_format);
		float L_0 = ___number0;
		il2cpp_codegen_runtime_class_init_inline(JsonWriter_tC9B032D35ED4E85319A227892A43EB8627661732_il2cpp_TypeInfo_var);
		NumberFormatInfo_t8E26808B202927FEBF9064FCFEEA4D6E076E6472* L_1 = ((JsonWriter_tC9B032D35ED4E85319A227892A43EB8627661732_StaticFields*)il2cpp_codegen_static_fields_for(JsonWriter_tC9B032D35ED4E85319A227892A43EB8627661732_il2cpp_TypeInfo_var))->___number_format_0;
		il2cpp_codegen_runtime_class_init_inline(Convert_t7097FF336D592F7C06D88A98349A44646F91EFFC_il2cpp_TypeInfo_var);
		String_t* L_2;
		L_2 = Convert_ToString_mBFBBE2F36FF6B3235848801940FD15A17028AC70(L_0, L_1, NULL);
		V_0 = L_2;
		// Put(str);
		String_t* L_3 = V_0;
		JsonWriter_Put_m727B8E7799FDDF22D93C62522E33ABE198FC78E3(__this, L_3, NULL);
		// context.ExpectingValue = false;
		WriterContext_tAA13A82DA53BA6A99795422A71F6D19F331F30BA* L_4 = __this->___context_1;
		NullCheck(L_4);
		L_4->___ExpectingValue_3 = (bool)0;
		// }
		return;
	}
}
// System.Void Agora.Rtc.LitJson.JsonWriter::Write(System.Int32)
IL2CPP_EXTERN_C IL2CPP_METHOD_ATTR void JsonWriter_Write_mCC3A77C46777F4FF87E8CD21ED0E8608CD06BD30 (JsonWriter_tC9B032D35ED4E85319A227892A43EB8627661732* __this, int32_t ___number0, const RuntimeMethod* method) 
{
	static bool s_Il2CppMethodInitialized;
	if (!s_Il2CppMethodInitialized)
	{
		il2cpp_codegen_initialize_runtime_metadata((uintptr_t*)&Convert_t7097FF336D592F7C06D88A98349A44646F91EFFC_il2cpp_TypeInfo_var);
		il2cpp_codegen_initialize_runtime_metadata((uintptr_t*)&JsonWriter_tC9B032D35ED4E85319A227892A43EB8627661732_il2cpp_TypeInfo_var);
		s_Il2CppMethodInitialized = true;
	}
	{
		// DoValidation (Condition.Value);
		JsonWriter_DoValidation_mE5807100853E142A9F37794C4C13B30619720445(__this, 4, NULL);
		// PutNewline ();
		JsonWriter_PutNewline_m75776BA10443F6494A562FEF05BF65291B861D1F(__this, NULL);
		// Put (Convert.ToString (number, number_format));
		int32_t L_0 = ___number0;
		il2cpp_codegen_runtime_class_init_inline(JsonWriter_tC9B032D35ED4E85319A227892A43EB8627661732_il2cpp_TypeInfo_var);
		NumberFormatInfo_t8E26808B202927FEBF9064FCFEEA4D6E076E6472* L_1 = ((JsonWriter_tC9B032D35ED4E85319A227892A43EB8627661732_StaticFields*)il2cpp_codegen_static_fields_for(JsonWriter_tC9B032D35ED4E85319A227892A43EB8627661732_il2cpp_TypeInfo_var))->___number_format_0;
		il2cpp_codegen_runtime_class_init_inline(Convert_t7097FF336D592F7C06D88A98349A44646F91EFFC_il2cpp_TypeInfo_var);
		String_t* L_2;
		L_2 = Convert_ToString_mC65AC3BEDED3049732E8A67B496AAAEF4C732871(L_0, L_1, NULL);
		JsonWriter_Put_m727B8E7799FDDF22D93C62522E33ABE198FC78E3(__this, L_2, NULL);
		// context.ExpectingValue = false;
		WriterContext_tAA13A82DA53BA6A99795422A71F6D19F331F30BA* L_3 = __this->___context_1;
		NullCheck(L_3);
		L_3->___ExpectingValue_3 = (bool)0;
		// }
		return;
	}
}
// System.Void Agora.Rtc.LitJson.JsonWriter::Write(System.Int64)
IL2CPP_EXTERN_C IL2CPP_METHOD_ATTR void JsonWriter_Write_m5D775E08DAC4A2BA4659C173ECC36F1C072DD7ED (JsonWriter_tC9B032D35ED4E85319A227892A43EB8627661732* __this, int64_t ___number0, const RuntimeMethod* method) 
{
	static bool s_Il2CppMethodInitialized;
	if (!s_Il2CppMethodInitialized)
	{
		il2cpp_codegen_initialize_runtime_metadata((uintptr_t*)&Convert_t7097FF336D592F7C06D88A98349A44646F91EFFC_il2cpp_TypeInfo_var);
		il2cpp_codegen_initialize_runtime_metadata((uintptr_t*)&JsonWriter_tC9B032D35ED4E85319A227892A43EB8627661732_il2cpp_TypeInfo_var);
		s_Il2CppMethodInitialized = true;
	}
	{
		// DoValidation (Condition.Value);
		JsonWriter_DoValidation_mE5807100853E142A9F37794C4C13B30619720445(__this, 4, NULL);
		// PutNewline ();
		JsonWriter_PutNewline_m75776BA10443F6494A562FEF05BF65291B861D1F(__this, NULL);
		// Put (Convert.ToString (number, number_format));
		int64_t L_0 = ___number0;
		il2cpp_codegen_runtime_class_init_inline(JsonWriter_tC9B032D35ED4E85319A227892A43EB8627661732_il2cpp_TypeInfo_var);
		NumberFormatInfo_t8E26808B202927FEBF9064FCFEEA4D6E076E6472* L_1 = ((JsonWriter_tC9B032D35ED4E85319A227892A43EB8627661732_StaticFields*)il2cpp_codegen_static_fields_for(JsonWriter_tC9B032D35ED4E85319A227892A43EB8627661732_il2cpp_TypeInfo_var))->___number_format_0;
		il2cpp_codegen_runtime_class_init_inline(Convert_t7097FF336D592F7C06D88A98349A44646F91EFFC_il2cpp_TypeInfo_var);
		String_t* L_2;
		L_2 = Convert_ToString_m03FCA4B41451E9A04705485B1C2FFC3D826B63E1(L_0, L_1, NULL);
		JsonWriter_Put_m727B8E7799FDDF22D93C62522E33ABE198FC78E3(__this, L_2, NULL);
		// context.ExpectingValue = false;
		WriterContext_tAA13A82DA53BA6A99795422A71F6D19F331F30BA* L_3 = __this->___context_1;
		NullCheck(L_3);
		L_3->___ExpectingValue_3 = (bool)0;
		// }
		return;
	}
}
// System.Void Agora.Rtc.LitJson.JsonWriter::Write(System.String)
IL2CPP_EXTERN_C IL2CPP_METHOD_ATTR void JsonWriter_Write_mF5B2C30D93DE321FCBBEE50EB4D68895D210201A (JsonWriter_tC9B032D35ED4E85319A227892A43EB8627661732* __this, String_t* ___str0, const RuntimeMethod* method) 
{
	static bool s_Il2CppMethodInitialized;
	if (!s_Il2CppMethodInitialized)
	{
		il2cpp_codegen_initialize_runtime_metadata((uintptr_t*)&_stringLiteral5BEFD8CC60A79699B5BB00E37BAC5B62D371E174);
		s_Il2CppMethodInitialized = true;
	}
	{
		// DoValidation (Condition.Value);
		JsonWriter_DoValidation_mE5807100853E142A9F37794C4C13B30619720445(__this, 4, NULL);
		// PutNewline ();
		JsonWriter_PutNewline_m75776BA10443F6494A562FEF05BF65291B861D1F(__this, NULL);
		// if (str == null)
		String_t* L_0 = ___str0;
		if (L_0)
		{
			goto IL_001d;
		}
	}
	{
		// Put ("null");
		JsonWriter_Put_m727B8E7799FDDF22D93C62522E33ABE198FC78E3(__this, _stringLiteral5BEFD8CC60A79699B5BB00E37BAC5B62D371E174, NULL);
		goto IL_0024;
	}

IL_001d:
	{
		// PutString (str);
		String_t* L_1 = ___str0;
		JsonWriter_PutString_m1727A993A1F47158048BC2E3F6B150B3773E2716(__this, L_1, NULL);
	}

IL_0024:
	{
		// context.ExpectingValue = false;
		WriterContext_tAA13A82DA53BA6A99795422A71F6D19F331F30BA* L_2 = __this->___context_1;
		NullCheck(L_2);
		L_2->___ExpectingValue_3 = (bool)0;
		// }
		return;
	}
}
// System.Void Agora.Rtc.LitJson.JsonWriter::Write(System.UInt64)
IL2CPP_EXTERN_C IL2CPP_METHOD_ATTR void JsonWriter_Write_mAE20584AB1461EFA3BB71203CC1A65BAC8C650AE (JsonWriter_tC9B032D35ED4E85319A227892A43EB8627661732* __this, uint64_t ___number0, const RuntimeMethod* method) 
{
	static bool s_Il2CppMethodInitialized;
	if (!s_Il2CppMethodInitialized)
	{
		il2cpp_codegen_initialize_runtime_metadata((uintptr_t*)&Convert_t7097FF336D592F7C06D88A98349A44646F91EFFC_il2cpp_TypeInfo_var);
		il2cpp_codegen_initialize_runtime_metadata((uintptr_t*)&JsonWriter_tC9B032D35ED4E85319A227892A43EB8627661732_il2cpp_TypeInfo_var);
		s_Il2CppMethodInitialized = true;
	}
	{
		// DoValidation (Condition.Value);
		JsonWriter_DoValidation_mE5807100853E142A9F37794C4C13B30619720445(__this, 4, NULL);
		// PutNewline ();
		JsonWriter_PutNewline_m75776BA10443F6494A562FEF05BF65291B861D1F(__this, NULL);
		// Put (Convert.ToString (number, number_format));
		uint64_t L_0 = ___number0;
		il2cpp_codegen_runtime_class_init_inline(JsonWriter_tC9B032D35ED4E85319A227892A43EB8627661732_il2cpp_TypeInfo_var);
		NumberFormatInfo_t8E26808B202927FEBF9064FCFEEA4D6E076E6472* L_1 = ((JsonWriter_tC9B032D35ED4E85319A227892A43EB8627661732_StaticFields*)il2cpp_codegen_static_fields_for(JsonWriter_tC9B032D35ED4E85319A227892A43EB8627661732_il2cpp_TypeInfo_var))->___number_format_0;
		il2cpp_codegen_runtime_class_init_inline(Convert_t7097FF336D592F7C06D88A98349A44646F91EFFC_il2cpp_TypeInfo_var);
		String_t* L_2;
		L_2 = Convert_ToString_mB35C9B82D948EFB22F235F65AC3996B9F44C6D38(L_0, L_1, NULL);
		JsonWriter_Put_m727B8E7799FDDF22D93C62522E33ABE198FC78E3(__this, L_2, NULL);
		// context.ExpectingValue = false;
		WriterContext_tAA13A82DA53BA6A99795422A71F6D19F331F30BA* L_3 = __this->___context_1;
		NullCheck(L_3);
		L_3->___ExpectingValue_3 = (bool)0;
		// }
		return;
	}
}
// System.Void Agora.Rtc.LitJson.JsonWriter::WriteArrayEnd()
IL2CPP_EXTERN_C IL2CPP_METHOD_ATTR void JsonWriter_WriteArrayEnd_m1432FCD43A4F4846EB3F9CF45751CA1BBDD74D4B (JsonWriter_tC9B032D35ED4E85319A227892A43EB8627661732* __this, const RuntimeMethod* method) 
{
	static bool s_Il2CppMethodInitialized;
	if (!s_Il2CppMethodInitialized)
	{
		il2cpp_codegen_initialize_runtime_metadata((uintptr_t*)&Stack_1_Peek_m0FEDB97EFD290B417A1782460FB52FDA59229146_RuntimeMethod_var);
		il2cpp_codegen_initialize_runtime_metadata((uintptr_t*)&Stack_1_Pop_mCA172CFAE834614F947860C76631CFF9A995BBE3_RuntimeMethod_var);
		il2cpp_codegen_initialize_runtime_metadata((uintptr_t*)&Stack_1_get_Count_mDE5E5A58BFA286D4526261A83956911D0C00D06E_RuntimeMethod_var);
		il2cpp_codegen_initialize_runtime_metadata((uintptr_t*)&_stringLiteralE166C9564FBDE461738077E3B1B506525EB6ACCC);
		s_Il2CppMethodInitialized = true;
	}
	{
		// DoValidation (Condition.InArray);
		JsonWriter_DoValidation_mE5807100853E142A9F37794C4C13B30619720445(__this, 0, NULL);
		// PutNewline (false);
		JsonWriter_PutNewline_mCA284D695C145383C730CE1A87C87C5C5A6AA7C5(__this, (bool)0, NULL);
		// ctx_stack.Pop ();
		Stack_1_t7D2C4DA3105E485DD5491FB8B36FC2D66DA84336* L_0 = __this->___ctx_stack_2;
		NullCheck(L_0);
		WriterContext_tAA13A82DA53BA6A99795422A71F6D19F331F30BA* L_1;
		L_1 = Stack_1_Pop_mCA172CFAE834614F947860C76631CFF9A995BBE3(L_0, Stack_1_Pop_mCA172CFAE834614F947860C76631CFF9A995BBE3_RuntimeMethod_var);
		// if (ctx_stack.Count == 1)
		Stack_1_t7D2C4DA3105E485DD5491FB8B36FC2D66DA84336* L_2 = __this->___ctx_stack_2;
		NullCheck(L_2);
		int32_t L_3;
		L_3 = Stack_1_get_Count_mDE5E5A58BFA286D4526261A83956911D0C00D06E_inline(L_2, Stack_1_get_Count_mDE5E5A58BFA286D4526261A83956911D0C00D06E_RuntimeMethod_var);
		if ((!(((uint32_t)L_3) == ((uint32_t)1))))
		{
			goto IL_0031;
		}
	}
	{
		// has_reached_end = true;
		__this->___has_reached_end_3 = (bool)1;
		goto IL_004e;
	}

IL_0031:
	{
		// context = ctx_stack.Peek ();
		Stack_1_t7D2C4DA3105E485DD5491FB8B36FC2D66DA84336* L_4 = __this->___ctx_stack_2;
		NullCheck(L_4);
		WriterContext_tAA13A82DA53BA6A99795422A71F6D19F331F30BA* L_5;
		L_5 = Stack_1_Peek_m0FEDB97EFD290B417A1782460FB52FDA59229146(L_4, Stack_1_Peek_m0FEDB97EFD290B417A1782460FB52FDA59229146_RuntimeMethod_var);
		__this->___context_1 = L_5;
		Il2CppCodeGenWriteBarrier((void**)(&__this->___context_1), (void*)L_5);
		// context.ExpectingValue = false;
		WriterContext_tAA13A82DA53BA6A99795422A71F6D19F331F30BA* L_6 = __this->___context_1;
		NullCheck(L_6);
		L_6->___ExpectingValue_3 = (bool)0;
	}

IL_004e:
	{
		// Unindent ();
		JsonWriter_Unindent_mCE6B680D58C2112946014AE15C9E7AF4D3D047B0(__this, NULL);
		// Put ("]");
		JsonWriter_Put_m727B8E7799FDDF22D93C62522E33ABE198FC78E3(__this, _stringLiteralE166C9564FBDE461738077E3B1B506525EB6ACCC, NULL);
		// }
		return;
	}
}
// System.Void Agora.Rtc.LitJson.JsonWriter::WriteArrayStart()
IL2CPP_EXTERN_C IL2CPP_METHOD_ATTR void JsonWriter_WriteArrayStart_m14095C4FE0CC5BE513D039DCFF0065203250D8CB (JsonWriter_tC9B032D35ED4E85319A227892A43EB8627661732* __this, const RuntimeMethod* method) 
{
	static bool s_Il2CppMethodInitialized;
	if (!s_Il2CppMethodInitialized)
	{
		il2cpp_codegen_initialize_runtime_metadata((uintptr_t*)&Stack_1_Push_m55AF25BEEA08E56F5C74631BB98562B8461303E9_RuntimeMethod_var);
		il2cpp_codegen_initialize_runtime_metadata((uintptr_t*)&WriterContext_tAA13A82DA53BA6A99795422A71F6D19F331F30BA_il2cpp_TypeInfo_var);
		il2cpp_codegen_initialize_runtime_metadata((uintptr_t*)&_stringLiteralD9691C4FD8A1F6B09DB1147CA32B442772FB46A1);
		s_Il2CppMethodInitialized = true;
	}
	{
		// DoValidation (Condition.NotAProperty);
		JsonWriter_DoValidation_mE5807100853E142A9F37794C4C13B30619720445(__this, 2, NULL);
		// PutNewline ();
		JsonWriter_PutNewline_m75776BA10443F6494A562FEF05BF65291B861D1F(__this, NULL);
		// Put ("[");
		JsonWriter_Put_m727B8E7799FDDF22D93C62522E33ABE198FC78E3(__this, _stringLiteralD9691C4FD8A1F6B09DB1147CA32B442772FB46A1, NULL);
		// context = new WriterContext ();
		WriterContext_tAA13A82DA53BA6A99795422A71F6D19F331F30BA* L_0 = (WriterContext_tAA13A82DA53BA6A99795422A71F6D19F331F30BA*)il2cpp_codegen_object_new(WriterContext_tAA13A82DA53BA6A99795422A71F6D19F331F30BA_il2cpp_TypeInfo_var);
		NullCheck(L_0);
		WriterContext__ctor_m91AF1613E06FA2DC16EBC0B70A80FB80F2AF22C3(L_0, NULL);
		__this->___context_1 = L_0;
		Il2CppCodeGenWriteBarrier((void**)(&__this->___context_1), (void*)L_0);
		// context.InArray = true;
		WriterContext_tAA13A82DA53BA6A99795422A71F6D19F331F30BA* L_1 = __this->___context_1;
		NullCheck(L_1);
		L_1->___InArray_1 = (bool)1;
		// ctx_stack.Push (context);
		Stack_1_t7D2C4DA3105E485DD5491FB8B36FC2D66DA84336* L_2 = __this->___ctx_stack_2;
		WriterContext_tAA13A82DA53BA6A99795422A71F6D19F331F30BA* L_3 = __this->___context_1;
		NullCheck(L_2);
		Stack_1_Push_m55AF25BEEA08E56F5C74631BB98562B8461303E9(L_2, L_3, Stack_1_Push_m55AF25BEEA08E56F5C74631BB98562B8461303E9_RuntimeMethod_var);
		// Indent ();
		JsonWriter_Indent_mC750E7984828750E95FCB795B0D3D6BA3A0D74DA(__this, NULL);
		// }
		return;
	}
}
// System.Void Agora.Rtc.LitJson.JsonWriter::WriteObjectEnd()
IL2CPP_EXTERN_C IL2CPP_METHOD_ATTR void JsonWriter_WriteObjectEnd_m42E8AF87C6333B7A8A63004C370309BD21389906 (JsonWriter_tC9B032D35ED4E85319A227892A43EB8627661732* __this, const RuntimeMethod* method) 
{
	static bool s_Il2CppMethodInitialized;
	if (!s_Il2CppMethodInitialized)
	{
		il2cpp_codegen_initialize_runtime_metadata((uintptr_t*)&Stack_1_Peek_m0FEDB97EFD290B417A1782460FB52FDA59229146_RuntimeMethod_var);
		il2cpp_codegen_initialize_runtime_metadata((uintptr_t*)&Stack_1_Pop_mCA172CFAE834614F947860C76631CFF9A995BBE3_RuntimeMethod_var);
		il2cpp_codegen_initialize_runtime_metadata((uintptr_t*)&Stack_1_get_Count_mDE5E5A58BFA286D4526261A83956911D0C00D06E_RuntimeMethod_var);
		il2cpp_codegen_initialize_runtime_metadata((uintptr_t*)&_stringLiteral4D8D9C94AC5DA5FCED2EC8A64E10E714A2515C30);
		s_Il2CppMethodInitialized = true;
	}
	{
		// DoValidation (Condition.InObject);
		JsonWriter_DoValidation_mE5807100853E142A9F37794C4C13B30619720445(__this, 1, NULL);
		// PutNewline (false);
		JsonWriter_PutNewline_mCA284D695C145383C730CE1A87C87C5C5A6AA7C5(__this, (bool)0, NULL);
		// ctx_stack.Pop ();
		Stack_1_t7D2C4DA3105E485DD5491FB8B36FC2D66DA84336* L_0 = __this->___ctx_stack_2;
		NullCheck(L_0);
		WriterContext_tAA13A82DA53BA6A99795422A71F6D19F331F30BA* L_1;
		L_1 = Stack_1_Pop_mCA172CFAE834614F947860C76631CFF9A995BBE3(L_0, Stack_1_Pop_mCA172CFAE834614F947860C76631CFF9A995BBE3_RuntimeMethod_var);
		// if (ctx_stack.Count == 1)
		Stack_1_t7D2C4DA3105E485DD5491FB8B36FC2D66DA84336* L_2 = __this->___ctx_stack_2;
		NullCheck(L_2);
		int32_t L_3;
		L_3 = Stack_1_get_Count_mDE5E5A58BFA286D4526261A83956911D0C00D06E_inline(L_2, Stack_1_get_Count_mDE5E5A58BFA286D4526261A83956911D0C00D06E_RuntimeMethod_var);
		if ((!(((uint32_t)L_3) == ((uint32_t)1))))
		{
			goto IL_0031;
		}
	}
	{
		// has_reached_end = true;
		__this->___has_reached_end_3 = (bool)1;
		goto IL_004e;
	}

IL_0031:
	{
		// context = ctx_stack.Peek ();
		Stack_1_t7D2C4DA3105E485DD5491FB8B36FC2D66DA84336* L_4 = __this->___ctx_stack_2;
		NullCheck(L_4);
		WriterContext_tAA13A82DA53BA6A99795422A71F6D19F331F30BA* L_5;
		L_5 = Stack_1_Peek_m0FEDB97EFD290B417A1782460FB52FDA59229146(L_4, Stack_1_Peek_m0FEDB97EFD290B417A1782460FB52FDA59229146_RuntimeMethod_var);
		__this->___context_1 = L_5;
		Il2CppCodeGenWriteBarrier((void**)(&__this->___context_1), (void*)L_5);
		// context.ExpectingValue = false;
		WriterContext_tAA13A82DA53BA6A99795422A71F6D19F331F30BA* L_6 = __this->___context_1;
		NullCheck(L_6);
		L_6->___ExpectingValue_3 = (bool)0;
	}

IL_004e:
	{
		// Unindent ();
		JsonWriter_Unindent_mCE6B680D58C2112946014AE15C9E7AF4D3D047B0(__this, NULL);
		// Put ("}");
		JsonWriter_Put_m727B8E7799FDDF22D93C62522E33ABE198FC78E3(__this, _stringLiteral4D8D9C94AC5DA5FCED2EC8A64E10E714A2515C30, NULL);
		// }
		return;
	}
}
// System.Void Agora.Rtc.LitJson.JsonWriter::WriteObjectStart()
IL2CPP_EXTERN_C IL2CPP_METHOD_ATTR void JsonWriter_WriteObjectStart_m7FEAF649E953EA882B08F681B1D53DE9F7415107 (JsonWriter_tC9B032D35ED4E85319A227892A43EB8627661732* __this, const RuntimeMethod* method) 
{
	static bool s_Il2CppMethodInitialized;
	if (!s_Il2CppMethodInitialized)
	{
		il2cpp_codegen_initialize_runtime_metadata((uintptr_t*)&Stack_1_Push_m55AF25BEEA08E56F5C74631BB98562B8461303E9_RuntimeMethod_var);
		il2cpp_codegen_initialize_runtime_metadata((uintptr_t*)&WriterContext_tAA13A82DA53BA6A99795422A71F6D19F331F30BA_il2cpp_TypeInfo_var);
		il2cpp_codegen_initialize_runtime_metadata((uintptr_t*)&_stringLiteral0C3C6829C3CCF8020C6AC45B87963ADC095CD44A);
		s_Il2CppMethodInitialized = true;
	}
	{
		// DoValidation (Condition.NotAProperty);
		JsonWriter_DoValidation_mE5807100853E142A9F37794C4C13B30619720445(__this, 2, NULL);
		// PutNewline ();
		JsonWriter_PutNewline_m75776BA10443F6494A562FEF05BF65291B861D1F(__this, NULL);
		// Put ("{");
		JsonWriter_Put_m727B8E7799FDDF22D93C62522E33ABE198FC78E3(__this, _stringLiteral0C3C6829C3CCF8020C6AC45B87963ADC095CD44A, NULL);
		// context = new WriterContext ();
		WriterContext_tAA13A82DA53BA6A99795422A71F6D19F331F30BA* L_0 = (WriterContext_tAA13A82DA53BA6A99795422A71F6D19F331F30BA*)il2cpp_codegen_object_new(WriterContext_tAA13A82DA53BA6A99795422A71F6D19F331F30BA_il2cpp_TypeInfo_var);
		NullCheck(L_0);
		WriterContext__ctor_m91AF1613E06FA2DC16EBC0B70A80FB80F2AF22C3(L_0, NULL);
		__this->___context_1 = L_0;
		Il2CppCodeGenWriteBarrier((void**)(&__this->___context_1), (void*)L_0);
		// context.InObject = true;
		WriterContext_tAA13A82DA53BA6A99795422A71F6D19F331F30BA* L_1 = __this->___context_1;
		NullCheck(L_1);
		L_1->___InObject_2 = (bool)1;
		// ctx_stack.Push (context);
		Stack_1_t7D2C4DA3105E485DD5491FB8B36FC2D66DA84336* L_2 = __this->___ctx_stack_2;
		WriterContext_tAA13A82DA53BA6A99795422A71F6D19F331F30BA* L_3 = __this->___context_1;
		NullCheck(L_2);
		Stack_1_Push_m55AF25BEEA08E56F5C74631BB98562B8461303E9(L_2, L_3, Stack_1_Push_m55AF25BEEA08E56F5C74631BB98562B8461303E9_RuntimeMethod_var);
		// Indent ();
		JsonWriter_Indent_mC750E7984828750E95FCB795B0D3D6BA3A0D74DA(__this, NULL);
		// }
		return;
	}
}
// System.Void Agora.Rtc.LitJson.JsonWriter::WritePropertyName(System.String)
IL2CPP_EXTERN_C IL2CPP_METHOD_ATTR void JsonWriter_WritePropertyName_m574FC2B6D604FB521302C6A92D56C9FCD5A152A0 (JsonWriter_tC9B032D35ED4E85319A227892A43EB8627661732* __this, String_t* ___property_name0, const RuntimeMethod* method) 
{
	static bool s_Il2CppMethodInitialized;
	if (!s_Il2CppMethodInitialized)
	{
		il2cpp_codegen_initialize_runtime_metadata((uintptr_t*)&_stringLiteral1168E92C164109D6220480DEDA987085B2A21155);
		s_Il2CppMethodInitialized = true;
	}
	String_t* V_0 = NULL;
	int32_t V_1 = 0;
	String_t* G_B4_0 = NULL;
	{
		// DoValidation (Condition.Property);
		JsonWriter_DoValidation_mE5807100853E142A9F37794C4C13B30619720445(__this, 3, NULL);
		// PutNewline ();
		JsonWriter_PutNewline_m75776BA10443F6494A562FEF05BF65291B861D1F(__this, NULL);
		// string propertyName = (property_name == null || !lower_case_properties)
		//     ? property_name
		//     : property_name.ToLowerInvariant();
		String_t* L_0 = ___property_name0;
		if (!L_0)
		{
			goto IL_0020;
		}
	}
	{
		bool L_1 = __this->___lower_case_properties_10;
		if (!L_1)
		{
			goto IL_0020;
		}
	}
	{
		String_t* L_2 = ___property_name0;
		NullCheck(L_2);
		String_t* L_3;
		L_3 = String_ToLowerInvariant_mBE32C93DE27C5353FEA3FA654FC1DDBE3D0EB0F2(L_2, NULL);
		G_B4_0 = L_3;
		goto IL_0021;
	}

IL_0020:
	{
		String_t* L_4 = ___property_name0;
		G_B4_0 = L_4;
	}

IL_0021:
	{
		V_0 = G_B4_0;
		// PutString (propertyName);
		String_t* L_5 = V_0;
		JsonWriter_PutString_m1727A993A1F47158048BC2E3F6B150B3773E2716(__this, L_5, NULL);
		// if (pretty_print) {
		bool L_6 = __this->___pretty_print_8;
		if (!L_6)
		{
			goto IL_0091;
		}
	}
	{
		// if (propertyName.Length > context.Padding)
		String_t* L_7 = V_0;
		NullCheck(L_7);
		int32_t L_8;
		L_8 = String_get_Length_m42625D67623FA5CC7A44D47425CE86FB946542D2_inline(L_7, NULL);
		WriterContext_tAA13A82DA53BA6A99795422A71F6D19F331F30BA* L_9 = __this->___context_1;
		NullCheck(L_9);
		int32_t L_10 = L_9->___Padding_4;
		if ((((int32_t)L_8) <= ((int32_t)L_10)))
		{
			goto IL_0055;
		}
	}
	{
		// context.Padding = propertyName.Length;
		WriterContext_tAA13A82DA53BA6A99795422A71F6D19F331F30BA* L_11 = __this->___context_1;
		String_t* L_12 = V_0;
		NullCheck(L_12);
		int32_t L_13;
		L_13 = String_get_Length_m42625D67623FA5CC7A44D47425CE86FB946542D2_inline(L_12, NULL);
		NullCheck(L_11);
		L_11->___Padding_4 = L_13;
	}

IL_0055:
	{
		// for (int i = context.Padding - propertyName.Length;
		WriterContext_tAA13A82DA53BA6A99795422A71F6D19F331F30BA* L_14 = __this->___context_1;
		NullCheck(L_14);
		int32_t L_15 = L_14->___Padding_4;
		String_t* L_16 = V_0;
		NullCheck(L_16);
		int32_t L_17;
		L_17 = String_get_Length_m42625D67623FA5CC7A44D47425CE86FB946542D2_inline(L_16, NULL);
		V_1 = ((int32_t)il2cpp_codegen_subtract(L_15, L_17));
		goto IL_007b;
	}

IL_006a:
	{
		// writer.Write (' ');
		TextWriter_tA9E5461506CF806E17B6BBBF2119359DEDA3F0F3* L_18 = __this->___writer_11;
		NullCheck(L_18);
		VirtualActionInvoker1< Il2CppChar >::Invoke(13 /* System.Void System.IO.TextWriter::Write(System.Char) */, L_18, ((int32_t)32));
		// i >= 0; i--)
		int32_t L_19 = V_1;
		V_1 = ((int32_t)il2cpp_codegen_subtract(L_19, 1));
	}

IL_007b:
	{
		// i >= 0; i--)
		int32_t L_20 = V_1;
		if ((((int32_t)L_20) >= ((int32_t)0)))
		{
			goto IL_006a;
		}
	}
	{
		// writer.Write (": ");
		TextWriter_tA9E5461506CF806E17B6BBBF2119359DEDA3F0F3* L_21 = __this->___writer_11;
		NullCheck(L_21);
		VirtualActionInvoker1< String_t* >::Invoke(16 /* System.Void System.IO.TextWriter::Write(System.String) */, L_21, _stringLiteral1168E92C164109D6220480DEDA987085B2A21155);
		goto IL_009e;
	}

IL_0091:
	{
		// writer.Write (':');
		TextWriter_tA9E5461506CF806E17B6BBBF2119359DEDA3F0F3* L_22 = __this->___writer_11;
		NullCheck(L_22);
		VirtualActionInvoker1< Il2CppChar >::Invoke(13 /* System.Void System.IO.TextWriter::Write(System.Char) */, L_22, ((int32_t)58));
	}

IL_009e:
	{
		// context.ExpectingValue = true;
		WriterContext_tAA13A82DA53BA6A99795422A71F6D19F331F30BA* L_23 = __this->___context_1;
		NullCheck(L_23);
		L_23->___ExpectingValue_3 = (bool)1;
		// }
		return;
	}
}
#ifdef __clang__
#pragma clang diagnostic pop
#endif
#ifdef __clang__
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Winvalid-offsetof"
#pragma clang diagnostic ignored "-Wunused-variable"
#endif
// System.Void Agora.Rtc.LitJson.FsmContext::.ctor()
IL2CPP_EXTERN_C IL2CPP_METHOD_ATTR void FsmContext__ctor_mB83D75833878362DB092C21B06599CA0D363CBFD (FsmContext_tC11B461D4D90680FC71416881106E6AF48CAE21F* __this, const RuntimeMethod* method) 
{
	{
		Object__ctor_mE837C6B9FA8C6D5D109F4B2EC885D79919AC0EA2(__this, NULL);
		return;
	}
}
#ifdef __clang__
#pragma clang diagnostic pop
#endif
#ifdef __clang__
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Winvalid-offsetof"
#pragma clang diagnostic ignored "-Wunused-variable"
#endif
// System.Boolean Agora.Rtc.LitJson.Lexer::get_AllowComments()
IL2CPP_EXTERN_C IL2CPP_METHOD_ATTR bool Lexer_get_AllowComments_mBD7811B449819997218E5052F2763E267EFF277B (Lexer_tDC14CFA7B390E884510F554D9D1E03188A185E27* __this, const RuntimeMethod* method) 
{
	{
		// get { return allow_comments; }
		bool L_0 = __this->___allow_comments_2;
		return L_0;
	}
}
// System.Void Agora.Rtc.LitJson.Lexer::set_AllowComments(System.Boolean)
IL2CPP_EXTERN_C IL2CPP_METHOD_ATTR void Lexer_set_AllowComments_mA16354319A472743B6F147EAFD3175C774878914 (Lexer_tDC14CFA7B390E884510F554D9D1E03188A185E27* __this, bool ___value0, const RuntimeMethod* method) 
{
	{
		// set { allow_comments = value; }
		bool L_0 = ___value0;
		__this->___allow_comments_2 = L_0;
		// set { allow_comments = value; }
		return;
	}
}
// System.Boolean Agora.Rtc.LitJson.Lexer::get_AllowSingleQuotedStrings()
IL2CPP_EXTERN_C IL2CPP_METHOD_ATTR bool Lexer_get_AllowSingleQuotedStrings_mA6F77A0052FA0515743F21C5DA754BE68EF3C7AD (Lexer_tDC14CFA7B390E884510F554D9D1E03188A185E27* __this, const RuntimeMethod* method) 
{
	{
		// get { return allow_single_quoted_strings; }
		bool L_0 = __this->___allow_single_quoted_strings_3;
		return L_0;
	}
}
// System.Void Agora.Rtc.LitJson.Lexer::set_AllowSingleQuotedStrings(System.Boolean)
IL2CPP_EXTERN_C IL2CPP_METHOD_ATTR void Lexer_set_AllowSingleQuotedStrings_mA3CBFDE99EF4FF5DCC41B861A2CE6E6271B7382D (Lexer_tDC14CFA7B390E884510F554D9D1E03188A185E27* __this, bool ___value0, const RuntimeMethod* method) 
{
	{
		// set { allow_single_quoted_strings = value; }
		bool L_0 = ___value0;
		__this->___allow_single_quoted_strings_3 = L_0;
		// set { allow_single_quoted_strings = value; }
		return;
	}
}
// System.Boolean Agora.Rtc.LitJson.Lexer::get_EndOfInput()
IL2CPP_EXTERN_C IL2CPP_METHOD_ATTR bool Lexer_get_EndOfInput_mB1C09B97ED8A1B7141AB706DCA74D9EE4A6C423D (Lexer_tDC14CFA7B390E884510F554D9D1E03188A185E27* __this, const RuntimeMethod* method) 
{
	{
		// get { return end_of_input; }
		bool L_0 = __this->___end_of_input_4;
		return L_0;
	}
}
// System.Int32 Agora.Rtc.LitJson.Lexer::get_Token()
IL2CPP_EXTERN_C IL2CPP_METHOD_ATTR int32_t Lexer_get_Token_m2A2C0BFC698B6DCE0F1C347A70A47449F9035FBF (Lexer_tDC14CFA7B390E884510F554D9D1E03188A185E27* __this, const RuntimeMethod* method) 
{
	{
		// get { return token; }
		int32_t L_0 = __this->___token_12;
		return L_0;
	}
}
// System.String Agora.Rtc.LitJson.Lexer::get_StringValue()
IL2CPP_EXTERN_C IL2CPP_METHOD_ATTR String_t* Lexer_get_StringValue_mFCF7CD0EBB22B34F500B25C26360DFF643FE6132 (Lexer_tDC14CFA7B390E884510F554D9D1E03188A185E27* __this, const RuntimeMethod* method) 
{
	{
		// get { return string_value; }
		String_t* L_0 = __this->___string_value_11;
		return L_0;
	}
}
// System.Void Agora.Rtc.LitJson.Lexer::.cctor()
IL2CPP_EXTERN_C IL2CPP_METHOD_ATTR void Lexer__cctor_m417D954600B446E227599AB10DE5E0EBB2EEDADE (const RuntimeMethod* method) 
{
	static bool s_Il2CppMethodInitialized;
	if (!s_Il2CppMethodInitialized)
	{
		il2cpp_codegen_initialize_runtime_metadata((uintptr_t*)&Lexer_tDC14CFA7B390E884510F554D9D1E03188A185E27_il2cpp_TypeInfo_var);
		s_Il2CppMethodInitialized = true;
	}
	{
		// PopulateFsmTables (out fsm_handler_table, out fsm_return_table);
		Lexer_PopulateFsmTables_m1D8CE22E3CB0D1384720CC855AF92D86BEE2B68E((&((Lexer_tDC14CFA7B390E884510F554D9D1E03188A185E27_StaticFields*)il2cpp_codegen_static_fields_for(Lexer_tDC14CFA7B390E884510F554D9D1E03188A185E27_il2cpp_TypeInfo_var))->___fsm_handler_table_1), (&((Lexer_tDC14CFA7B390E884510F554D9D1E03188A185E27_StaticFields*)il2cpp_codegen_static_fields_for(Lexer_tDC14CFA7B390E884510F554D9D1E03188A185E27_il2cpp_TypeInfo_var))->___fsm_return_table_0), NULL);
		// }
		return;
	}
}
// System.Void Agora.Rtc.LitJson.Lexer::.ctor(System.IO.TextReader)
IL2CPP_EXTERN_C IL2CPP_METHOD_ATTR void Lexer__ctor_mC0FA8A9D9BF9E529309C24F013B2A4F555F1727A (Lexer_tDC14CFA7B390E884510F554D9D1E03188A185E27* __this, TextReader_tB8D43017CB6BE1633E5A86D64E7757366507C1F7* ___reader0, const RuntimeMethod* method) 
{
	static bool s_Il2CppMethodInitialized;
	if (!s_Il2CppMethodInitialized)
	{
		il2cpp_codegen_initialize_runtime_metadata((uintptr_t*)&FsmContext_tC11B461D4D90680FC71416881106E6AF48CAE21F_il2cpp_TypeInfo_var);
		il2cpp_codegen_initialize_runtime_metadata((uintptr_t*)&StringBuilder_t_il2cpp_TypeInfo_var);
		s_Il2CppMethodInitialized = true;
	}
	{
		// public Lexer (TextReader reader)
		Object__ctor_mE837C6B9FA8C6D5D109F4B2EC885D79919AC0EA2(__this, NULL);
		// allow_comments = true;
		__this->___allow_comments_2 = (bool)1;
		// allow_single_quoted_strings = true;
		__this->___allow_single_quoted_strings_3 = (bool)1;
		// input_buffer = 0;
		__this->___input_buffer_6 = 0;
		// string_buffer = new StringBuilder (128);
		StringBuilder_t* L_0 = (StringBuilder_t*)il2cpp_codegen_object_new(StringBuilder_t_il2cpp_TypeInfo_var);
		NullCheck(L_0);
		StringBuilder__ctor_m2619CA8D2C3476DF1A302D9D941498BB1C6164C5(L_0, ((int32_t)128), NULL);
		__this->___string_buffer_10 = L_0;
		Il2CppCodeGenWriteBarrier((void**)(&__this->___string_buffer_10), (void*)L_0);
		// state = 1;
		__this->___state_9 = 1;
		// end_of_input = false;
		__this->___end_of_input_4 = (bool)0;
		// this.reader = reader;
		TextReader_tB8D43017CB6BE1633E5A86D64E7757366507C1F7* L_1 = ___reader0;
		__this->___reader_8 = L_1;
		Il2CppCodeGenWriteBarrier((void**)(&__this->___reader_8), (void*)L_1);
		// fsm_context = new FsmContext ();
		FsmContext_tC11B461D4D90680FC71416881106E6AF48CAE21F* L_2 = (FsmContext_tC11B461D4D90680FC71416881106E6AF48CAE21F*)il2cpp_codegen_object_new(FsmContext_tC11B461D4D90680FC71416881106E6AF48CAE21F_il2cpp_TypeInfo_var);
		NullCheck(L_2);
		FsmContext__ctor_mB83D75833878362DB092C21B06599CA0D363CBFD(L_2, NULL);
		__this->___fsm_context_5 = L_2;
		Il2CppCodeGenWriteBarrier((void**)(&__this->___fsm_context_5), (void*)L_2);
		// fsm_context.L = this;
		FsmContext_tC11B461D4D90680FC71416881106E6AF48CAE21F* L_3 = __this->___fsm_context_5;
		NullCheck(L_3);
		L_3->___L_2 = __this;
		Il2CppCodeGenWriteBarrier((void**)(&L_3->___L_2), (void*)__this);
		// }
		return;
	}
}
// System.Int32 Agora.Rtc.LitJson.Lexer::HexValue(System.Int32)
IL2CPP_EXTERN_C IL2CPP_METHOD_ATTR int32_t Lexer_HexValue_mEC657936A38EA8E89F28359F9F244E906F637D1B (int32_t ___digit0, const RuntimeMethod* method) 
{
	{
		int32_t L_0 = ___digit0;
		switch (((int32_t)il2cpp_codegen_subtract(L_0, ((int32_t)65))))
		{
			case 0:
			{
				goto IL_0044;
			}
			case 1:
			{
				goto IL_0047;
			}
			case 2:
			{
				goto IL_004a;
			}
			case 3:
			{
				goto IL_004d;
			}
			case 4:
			{
				goto IL_0050;
			}
			case 5:
			{
				goto IL_0053;
			}
		}
	}
	{
		int32_t L_1 = ___digit0;
		switch (((int32_t)il2cpp_codegen_subtract(L_1, ((int32_t)97))))
		{
			case 0:
			{
				goto IL_0044;
			}
			case 1:
			{
				goto IL_0047;
			}
			case 2:
			{
				goto IL_004a;
			}
			case 3:
			{
				goto IL_004d;
			}
			case 4:
			{
				goto IL_0050;
			}
			case 5:
			{
				goto IL_0053;
			}
		}
	}
	{
		goto IL_0056;
	}

IL_0044:
	{
		// return 10;
		return ((int32_t)10);
	}

IL_0047:
	{
		// return 11;
		return ((int32_t)11);
	}

IL_004a:
	{
		// return 12;
		return ((int32_t)12);
	}

IL_004d:
	{
		// return 13;
		return ((int32_t)13);
	}

IL_0050:
	{
		// return 14;
		return ((int32_t)14);
	}

IL_0053:
	{
		// return 15;
		return ((int32_t)15);
	}

IL_0056:
	{
		// return digit - '0';
		int32_t L_2 = ___digit0;
		return ((int32_t)il2cpp_codegen_subtract(L_2, ((int32_t)48)));
	}
}
// System.Void Agora.Rtc.LitJson.Lexer::PopulateFsmTables(Agora.Rtc.LitJson.Lexer/StateHandler[]&,System.Int32[]&)
IL2CPP_EXTERN_C IL2CPP_METHOD_ATTR void Lexer_PopulateFsmTables_m1D8CE22E3CB0D1384720CC855AF92D86BEE2B68E (StateHandlerU5BU5D_t766A22C9C454D383614ED21CB99EAD5F5F15438B** ___fsm_handler_table0, Int32U5BU5D_t19C97395396A72ECAF310612F0760F165060314C** ___fsm_return_table1, const RuntimeMethod* method) 
{
	static bool s_Il2CppMethodInitialized;
	if (!s_Il2CppMethodInitialized)
	{
		il2cpp_codegen_initialize_runtime_metadata((uintptr_t*)&Int32U5BU5D_t19C97395396A72ECAF310612F0760F165060314C_il2cpp_TypeInfo_var);
		il2cpp_codegen_initialize_runtime_metadata((uintptr_t*)&Lexer_State10_m09FDA0FCE8DC10439C3F0230FE49C2479EA2CF9F_RuntimeMethod_var);
		il2cpp_codegen_initialize_runtime_metadata((uintptr_t*)&Lexer_State11_m10B21AA8B5F120F37CA9A6BA3FCE91093028E921_RuntimeMethod_var);
		il2cpp_codegen_initialize_runtime_metadata((uintptr_t*)&Lexer_State12_mA3309CA31EA7DF35795793EC1625BD7BB8F0DE31_RuntimeMethod_var);
		il2cpp_codegen_initialize_runtime_metadata((uintptr_t*)&Lexer_State13_mA36CE192CAB3A980421944E2E748C60C36F5C46D_RuntimeMethod_var);
		il2cpp_codegen_initialize_runtime_metadata((uintptr_t*)&Lexer_State14_mE16EEB2471742849851399A944FEAEFA52627434_RuntimeMethod_var);
		il2cpp_codegen_initialize_runtime_metadata((uintptr_t*)&Lexer_State15_m31270A40FAFFF8A0360B89A4BCBEE77B9CDA16B6_RuntimeMethod_var);
		il2cpp_codegen_initialize_runtime_metadata((uintptr_t*)&Lexer_State16_m180FD3FBA0BCDCB7CD31DF8066CFB0D95A8E5899_RuntimeMethod_var);
		il2cpp_codegen_initialize_runtime_metadata((uintptr_t*)&Lexer_State17_mBCA9C4F0E50F372C89018A235BD28A351CD066BF_RuntimeMethod_var);
		il2cpp_codegen_initialize_runtime_metadata((uintptr_t*)&Lexer_State18_m08C6ABD65DA0E9E71E22F625E7767F5FDA5E527B_RuntimeMethod_var);
		il2cpp_codegen_initialize_runtime_metadata((uintptr_t*)&Lexer_State19_m72717A35567FDD6CB2B2D17F405D9A8A62D5A7D7_RuntimeMethod_var);
		il2cpp_codegen_initialize_runtime_metadata((uintptr_t*)&Lexer_State1_m354DEC7337AB8F388456A52C690558DA2667A78A_RuntimeMethod_var);
		il2cpp_codegen_initialize_runtime_metadata((uintptr_t*)&Lexer_State20_m7AB439035107082B949A2E84806B0234056451CF_RuntimeMethod_var);
		il2cpp_codegen_initialize_runtime_metadata((uintptr_t*)&Lexer_State21_mAF43928E6128B3D414351408BEC48D9D8A13FE1F_RuntimeMethod_var);
		il2cpp_codegen_initialize_runtime_metadata((uintptr_t*)&Lexer_State22_mA8F75DBBADDA9897FF5A4FC0618085644BC527F9_RuntimeMethod_var);
		il2cpp_codegen_initialize_runtime_metadata((uintptr_t*)&Lexer_State23_m40E6D1E13EEAE247AA7A182A25CDB3251ED54DC4_RuntimeMethod_var);
		il2cpp_codegen_initialize_runtime_metadata((uintptr_t*)&Lexer_State24_mF032D4CC3EC466A9348FAD9C1054FD29C7214A44_RuntimeMethod_var);
		il2cpp_codegen_initialize_runtime_metadata((uintptr_t*)&Lexer_State25_mFF34556A9AC7D3134B061F186784E9D14D749CB2_RuntimeMethod_var);
		il2cpp_codegen_initialize_runtime_metadata((uintptr_t*)&Lexer_State26_mD4B202B505D9D18BB02A00E78A066B94C3FF041A_RuntimeMethod_var);
		il2cpp_codegen_initialize_runtime_metadata((uintptr_t*)&Lexer_State27_m7A8DB0C14046DC8E864B145D58075823088F7DCC_RuntimeMethod_var);
		il2cpp_codegen_initialize_runtime_metadata((uintptr_t*)&Lexer_State28_mE35361243292AE3F746EA665EE51E35AD2F71D58_RuntimeMethod_var);
		il2cpp_codegen_initialize_runtime_metadata((uintptr_t*)&Lexer_State2_m17C42E885DC482058990D1CBB0A22E1A61275E61_RuntimeMethod_var);
		il2cpp_codegen_initialize_runtime_metadata((uintptr_t*)&Lexer_State3_mD790267EE8D2875ECF01971BB71AB85D34F7F164_RuntimeMethod_var);
		il2cpp_codegen_initialize_runtime_metadata((uintptr_t*)&Lexer_State4_m5A6397940610B555715FF84A98B939A20F3222DD_RuntimeMethod_var);
		il2cpp_codegen_initialize_runtime_metadata((uintptr_t*)&Lexer_State5_m66419555D44A07340F468202EB1623F64E07D057_RuntimeMethod_var);
		il2cpp_codegen_initialize_runtime_metadata((uintptr_t*)&Lexer_State6_m2FA1AC1A3BB7D134A4070EAA04B4B8F7578082F9_RuntimeMethod_var);
		il2cpp_codegen_initialize_runtime_metadata((uintptr_t*)&Lexer_State7_mD7D75CE8EE1228FA4F834D0A5B9D70366738FA78_RuntimeMethod_var);
		il2cpp_codegen_initialize_runtime_metadata((uintptr_t*)&Lexer_State8_m6E43322CC449B219D8B91721D69CB1BC06D49D67_RuntimeMethod_var);
		il2cpp_codegen_initialize_runtime_metadata((uintptr_t*)&Lexer_State9_m7801BC5CF8DBDCFD46091BF2BFAF300D2108FA62_RuntimeMethod_var);
		il2cpp_codegen_initialize_runtime_metadata((uintptr_t*)&StateHandlerU5BU5D_t766A22C9C454D383614ED21CB99EAD5F5F15438B_il2cpp_TypeInfo_var);
		il2cpp_codegen_initialize_runtime_metadata((uintptr_t*)&StateHandler_t8EA5CD11BFA1A958F305A2A0134A0BBB631FAFCB_il2cpp_TypeInfo_var);
		il2cpp_codegen_initialize_runtime_metadata((uintptr_t*)&U3CPrivateImplementationDetailsU3E_t0F5473E849A5A5185A9F4C5246F0C32816C49FCA____C84227140A8A7787B30DFF8BD5693C19AA5A430C4E89FFD0256D7F77B3FEAD82_5_FieldInfo_var);
		s_Il2CppMethodInitialized = true;
	}
	{
		// fsm_handler_table = new StateHandler[28] {
		//     State1,
		//     State2,
		//     State3,
		//     State4,
		//     State5,
		//     State6,
		//     State7,
		//     State8,
		//     State9,
		//     State10,
		//     State11,
		//     State12,
		//     State13,
		//     State14,
		//     State15,
		//     State16,
		//     State17,
		//     State18,
		//     State19,
		//     State20,
		//     State21,
		//     State22,
		//     State23,
		//     State24,
		//     State25,
		//     State26,
		//     State27,
		//     State28
		// };
		StateHandlerU5BU5D_t766A22C9C454D383614ED21CB99EAD5F5F15438B** L_0 = ___fsm_handler_table0;
		StateHandlerU5BU5D_t766A22C9C454D383614ED21CB99EAD5F5F15438B* L_1 = (StateHandlerU5BU5D_t766A22C9C454D383614ED21CB99EAD5F5F15438B*)(StateHandlerU5BU5D_t766A22C9C454D383614ED21CB99EAD5F5F15438B*)SZArrayNew(StateHandlerU5BU5D_t766A22C9C454D383614ED21CB99EAD5F5F15438B_il2cpp_TypeInfo_var, (uint32_t)((int32_t)28));
		StateHandlerU5BU5D_t766A22C9C454D383614ED21CB99EAD5F5F15438B* L_2 = L_1;
		StateHandler_t8EA5CD11BFA1A958F305A2A0134A0BBB631FAFCB* L_3 = (StateHandler_t8EA5CD11BFA1A958F305A2A0134A0BBB631FAFCB*)il2cpp_codegen_object_new(StateHandler_t8EA5CD11BFA1A958F305A2A0134A0BBB631FAFCB_il2cpp_TypeInfo_var);
		NullCheck(L_3);
		StateHandler__ctor_m7B636AFF08A3049222D6F82BF87AFF9012CE69D2(L_3, NULL, (intptr_t)((void*)Lexer_State1_m354DEC7337AB8F388456A52C690558DA2667A78A_RuntimeMethod_var), NULL);
		NullCheck(L_2);
		ArrayElementTypeCheck (L_2, L_3);
		(L_2)->SetAt(static_cast<il2cpp_array_size_t>(0), (StateHandler_t8EA5CD11BFA1A958F305A2A0134A0BBB631FAFCB*)L_3);
		StateHandlerU5BU5D_t766A22C9C454D383614ED21CB99EAD5F5F15438B* L_4 = L_2;
		StateHandler_t8EA5CD11BFA1A958F305A2A0134A0BBB631FAFCB* L_5 = (StateHandler_t8EA5CD11BFA1A958F305A2A0134A0BBB631FAFCB*)il2cpp_codegen_object_new(StateHandler_t8EA5CD11BFA1A958F305A2A0134A0BBB631FAFCB_il2cpp_TypeInfo_var);
		NullCheck(L_5);
		StateHandler__ctor_m7B636AFF08A3049222D6F82BF87AFF9012CE69D2(L_5, NULL, (intptr_t)((void*)Lexer_State2_m17C42E885DC482058990D1CBB0A22E1A61275E61_RuntimeMethod_var), NULL);
		NullCheck(L_4);
		ArrayElementTypeCheck (L_4, L_5);
		(L_4)->SetAt(static_cast<il2cpp_array_size_t>(1), (StateHandler_t8EA5CD11BFA1A958F305A2A0134A0BBB631FAFCB*)L_5);
		StateHandlerU5BU5D_t766A22C9C454D383614ED21CB99EAD5F5F15438B* L_6 = L_4;
		StateHandler_t8EA5CD11BFA1A958F305A2A0134A0BBB631FAFCB* L_7 = (StateHandler_t8EA5CD11BFA1A958F305A2A0134A0BBB631FAFCB*)il2cpp_codegen_object_new(StateHandler_t8EA5CD11BFA1A958F305A2A0134A0BBB631FAFCB_il2cpp_TypeInfo_var);
		NullCheck(L_7);
		StateHandler__ctor_m7B636AFF08A3049222D6F82BF87AFF9012CE69D2(L_7, NULL, (intptr_t)((void*)Lexer_State3_mD790267EE8D2875ECF01971BB71AB85D34F7F164_RuntimeMethod_var), NULL);
		NullCheck(L_6);
		ArrayElementTypeCheck (L_6, L_7);
		(L_6)->SetAt(static_cast<il2cpp_array_size_t>(2), (StateHandler_t8EA5CD11BFA1A958F305A2A0134A0BBB631FAFCB*)L_7);
		StateHandlerU5BU5D_t766A22C9C454D383614ED21CB99EAD5F5F15438B* L_8 = L_6;
		StateHandler_t8EA5CD11BFA1A958F305A2A0134A0BBB631FAFCB* L_9 = (StateHandler_t8EA5CD11BFA1A958F305A2A0134A0BBB631FAFCB*)il2cpp_codegen_object_new(StateHandler_t8EA5CD11BFA1A958F305A2A0134A0BBB631FAFCB_il2cpp_TypeInfo_var);
		NullCheck(L_9);
		StateHandler__ctor_m7B636AFF08A3049222D6F82BF87AFF9012CE69D2(L_9, NULL, (intptr_t)((void*)Lexer_State4_m5A6397940610B555715FF84A98B939A20F3222DD_RuntimeMethod_var), NULL);
		NullCheck(L_8);
		ArrayElementTypeCheck (L_8, L_9);
		(L_8)->SetAt(static_cast<il2cpp_array_size_t>(3), (StateHandler_t8EA5CD11BFA1A958F305A2A0134A0BBB631FAFCB*)L_9);
		StateHandlerU5BU5D_t766A22C9C454D383614ED21CB99EAD5F5F15438B* L_10 = L_8;
		StateHandler_t8EA5CD11BFA1A958F305A2A0134A0BBB631FAFCB* L_11 = (StateHandler_t8EA5CD11BFA1A958F305A2A0134A0BBB631FAFCB*)il2cpp_codegen_object_new(StateHandler_t8EA5CD11BFA1A958F305A2A0134A0BBB631FAFCB_il2cpp_TypeInfo_var);
		NullCheck(L_11);
		StateHandler__ctor_m7B636AFF08A3049222D6F82BF87AFF9012CE69D2(L_11, NULL, (intptr_t)((void*)Lexer_State5_m66419555D44A07340F468202EB1623F64E07D057_RuntimeMethod_var), NULL);
		NullCheck(L_10);
		ArrayElementTypeCheck (L_10, L_11);
		(L_10)->SetAt(static_cast<il2cpp_array_size_t>(4), (StateHandler_t8EA5CD11BFA1A958F305A2A0134A0BBB631FAFCB*)L_11);
		StateHandlerU5BU5D_t766A22C9C454D383614ED21CB99EAD5F5F15438B* L_12 = L_10;
		StateHandler_t8EA5CD11BFA1A958F305A2A0134A0BBB631FAFCB* L_13 = (StateHandler_t8EA5CD11BFA1A958F305A2A0134A0BBB631FAFCB*)il2cpp_codegen_object_new(StateHandler_t8EA5CD11BFA1A958F305A2A0134A0BBB631FAFCB_il2cpp_TypeInfo_var);
		NullCheck(L_13);
		StateHandler__ctor_m7B636AFF08A3049222D6F82BF87AFF9012CE69D2(L_13, NULL, (intptr_t)((void*)Lexer_State6_m2FA1AC1A3BB7D134A4070EAA04B4B8F7578082F9_RuntimeMethod_var), NULL);
		NullCheck(L_12);
		ArrayElementTypeCheck (L_12, L_13);
		(L_12)->SetAt(static_cast<il2cpp_array_size_t>(5), (StateHandler_t8EA5CD11BFA1A958F305A2A0134A0BBB631FAFCB*)L_13);
		StateHandlerU5BU5D_t766A22C9C454D383614ED21CB99EAD5F5F15438B* L_14 = L_12;
		StateHandler_t8EA5CD11BFA1A958F305A2A0134A0BBB631FAFCB* L_15 = (StateHandler_t8EA5CD11BFA1A958F305A2A0134A0BBB631FAFCB*)il2cpp_codegen_object_new(StateHandler_t8EA5CD11BFA1A958F305A2A0134A0BBB631FAFCB_il2cpp_TypeInfo_var);
		NullCheck(L_15);
		StateHandler__ctor_m7B636AFF08A3049222D6F82BF87AFF9012CE69D2(L_15, NULL, (intptr_t)((void*)Lexer_State7_mD7D75CE8EE1228FA4F834D0A5B9D70366738FA78_RuntimeMethod_var), NULL);
		NullCheck(L_14);
		ArrayElementTypeCheck (L_14, L_15);
		(L_14)->SetAt(static_cast<il2cpp_array_size_t>(6), (StateHandler_t8EA5CD11BFA1A958F305A2A0134A0BBB631FAFCB*)L_15);
		StateHandlerU5BU5D_t766A22C9C454D383614ED21CB99EAD5F5F15438B* L_16 = L_14;
		StateHandler_t8EA5CD11BFA1A958F305A2A0134A0BBB631FAFCB* L_17 = (StateHandler_t8EA5CD11BFA1A958F305A2A0134A0BBB631FAFCB*)il2cpp_codegen_object_new(StateHandler_t8EA5CD11BFA1A958F305A2A0134A0BBB631FAFCB_il2cpp_TypeInfo_var);
		NullCheck(L_17);
		StateHandler__ctor_m7B636AFF08A3049222D6F82BF87AFF9012CE69D2(L_17, NULL, (intptr_t)((void*)Lexer_State8_m6E43322CC449B219D8B91721D69CB1BC06D49D67_RuntimeMethod_var), NULL);
		NullCheck(L_16);
		ArrayElementTypeCheck (L_16, L_17);
		(L_16)->SetAt(static_cast<il2cpp_array_size_t>(7), (StateHandler_t8EA5CD11BFA1A958F305A2A0134A0BBB631FAFCB*)L_17);
		StateHandlerU5BU5D_t766A22C9C454D383614ED21CB99EAD5F5F15438B* L_18 = L_16;
		StateHandler_t8EA5CD11BFA1A958F305A2A0134A0BBB631FAFCB* L_19 = (StateHandler_t8EA5CD11BFA1A958F305A2A0134A0BBB631FAFCB*)il2cpp_codegen_object_new(StateHandler_t8EA5CD11BFA1A958F305A2A0134A0BBB631FAFCB_il2cpp_TypeInfo_var);
		NullCheck(L_19);
		StateHandler__ctor_m7B636AFF08A3049222D6F82BF87AFF9012CE69D2(L_19, NULL, (intptr_t)((void*)Lexer_State9_m7801BC5CF8DBDCFD46091BF2BFAF300D2108FA62_RuntimeMethod_var), NULL);
		NullCheck(L_18);
		ArrayElementTypeCheck (L_18, L_19);
		(L_18)->SetAt(static_cast<il2cpp_array_size_t>(8), (StateHandler_t8EA5CD11BFA1A958F305A2A0134A0BBB631FAFCB*)L_19);
		StateHandlerU5BU5D_t766A22C9C454D383614ED21CB99EAD5F5F15438B* L_20 = L_18;
		StateHandler_t8EA5CD11BFA1A958F305A2A0134A0BBB631FAFCB* L_21 = (StateHandler_t8EA5CD11BFA1A958F305A2A0134A0BBB631FAFCB*)il2cpp_codegen_object_new(StateHandler_t8EA5CD11BFA1A958F305A2A0134A0BBB631FAFCB_il2cpp_TypeInfo_var);
		NullCheck(L_21);
		StateHandler__ctor_m7B636AFF08A3049222D6F82BF87AFF9012CE69D2(L_21, NULL, (intptr_t)((void*)Lexer_State10_m09FDA0FCE8DC10439C3F0230FE49C2479EA2CF9F_RuntimeMethod_var), NULL);
		NullCheck(L_20);
		ArrayElementTypeCheck (L_20, L_21);
		(L_20)->SetAt(static_cast<il2cpp_array_size_t>(((int32_t)9)), (StateHandler_t8EA5CD11BFA1A958F305A2A0134A0BBB631FAFCB*)L_21);
		StateHandlerU5BU5D_t766A22C9C454D383614ED21CB99EAD5F5F15438B* L_22 = L_20;
		StateHandler_t8EA5CD11BFA1A958F305A2A0134A0BBB631FAFCB* L_23 = (StateHandler_t8EA5CD11BFA1A958F305A2A0134A0BBB631FAFCB*)il2cpp_codegen_object_new(StateHandler_t8EA5CD11BFA1A958F305A2A0134A0BBB631FAFCB_il2cpp_TypeInfo_var);
		NullCheck(L_23);
		StateHandler__ctor_m7B636AFF08A3049222D6F82BF87AFF9012CE69D2(L_23, NULL, (intptr_t)((void*)Lexer_State11_m10B21AA8B5F120F37CA9A6BA3FCE91093028E921_RuntimeMethod_var), NULL);
		NullCheck(L_22);
		ArrayElementTypeCheck (L_22, L_23);
		(L_22)->SetAt(static_cast<il2cpp_array_size_t>(((int32_t)10)), (StateHandler_t8EA5CD11BFA1A958F305A2A0134A0BBB631FAFCB*)L_23);
		StateHandlerU5BU5D_t766A22C9C454D383614ED21CB99EAD5F5F15438B* L_24 = L_22;
		StateHandler_t8EA5CD11BFA1A958F305A2A0134A0BBB631FAFCB* L_25 = (StateHandler_t8EA5CD11BFA1A958F305A2A0134A0BBB631FAFCB*)il2cpp_codegen_object_new(StateHandler_t8EA5CD11BFA1A958F305A2A0134A0BBB631FAFCB_il2cpp_TypeInfo_var);
		NullCheck(L_25);
		StateHandler__ctor_m7B636AFF08A3049222D6F82BF87AFF9012CE69D2(L_25, NULL, (intptr_t)((void*)Lexer_State12_mA3309CA31EA7DF35795793EC1625BD7BB8F0DE31_RuntimeMethod_var), NULL);
		NullCheck(L_24);
		ArrayElementTypeCheck (L_24, L_25);
		(L_24)->SetAt(static_cast<il2cpp_array_size_t>(((int32_t)11)), (StateHandler_t8EA5CD11BFA1A958F305A2A0134A0BBB631FAFCB*)L_25);
		StateHandlerU5BU5D_t766A22C9C454D383614ED21CB99EAD5F5F15438B* L_26 = L_24;
		StateHandler_t8EA5CD11BFA1A958F305A2A0134A0BBB631FAFCB* L_27 = (StateHandler_t8EA5CD11BFA1A958F305A2A0134A0BBB631FAFCB*)il2cpp_codegen_object_new(StateHandler_t8EA5CD11BFA1A958F305A2A0134A0BBB631FAFCB_il2cpp_TypeInfo_var);
		NullCheck(L_27);
		StateHandler__ctor_m7B636AFF08A3049222D6F82BF87AFF9012CE69D2(L_27, NULL, (intptr_t)((void*)Lexer_State13_mA36CE192CAB3A980421944E2E748C60C36F5C46D_RuntimeMethod_var), NULL);
		NullCheck(L_26);
		ArrayElementTypeCheck (L_26, L_27);
		(L_26)->SetAt(static_cast<il2cpp_array_size_t>(((int32_t)12)), (StateHandler_t8EA5CD11BFA1A958F305A2A0134A0BBB631FAFCB*)L_27);
		StateHandlerU5BU5D_t766A22C9C454D383614ED21CB99EAD5F5F15438B* L_28 = L_26;
		StateHandler_t8EA5CD11BFA1A958F305A2A0134A0BBB631FAFCB* L_29 = (StateHandler_t8EA5CD11BFA1A958F305A2A0134A0BBB631FAFCB*)il2cpp_codegen_object_new(StateHandler_t8EA5CD11BFA1A958F305A2A0134A0BBB631FAFCB_il2cpp_TypeInfo_var);
		NullCheck(L_29);
		StateHandler__ctor_m7B636AFF08A3049222D6F82BF87AFF9012CE69D2(L_29, NULL, (intptr_t)((void*)Lexer_State14_mE16EEB2471742849851399A944FEAEFA52627434_RuntimeMethod_var), NULL);
		NullCheck(L_28);
		ArrayElementTypeCheck (L_28, L_29);
		(L_28)->SetAt(static_cast<il2cpp_array_size_t>(((int32_t)13)), (StateHandler_t8EA5CD11BFA1A958F305A2A0134A0BBB631FAFCB*)L_29);
		StateHandlerU5BU5D_t766A22C9C454D383614ED21CB99EAD5F5F15438B* L_30 = L_28;
		StateHandler_t8EA5CD11BFA1A958F305A2A0134A0BBB631FAFCB* L_31 = (StateHandler_t8EA5CD11BFA1A958F305A2A0134A0BBB631FAFCB*)il2cpp_codegen_object_new(StateHandler_t8EA5CD11BFA1A958F305A2A0134A0BBB631FAFCB_il2cpp_TypeInfo_var);
		NullCheck(L_31);
		StateHandler__ctor_m7B636AFF08A3049222D6F82BF87AFF9012CE69D2(L_31, NULL, (intptr_t)((void*)Lexer_State15_m31270A40FAFFF8A0360B89A4BCBEE77B9CDA16B6_RuntimeMethod_var), NULL);
		NullCheck(L_30);
		ArrayElementTypeCheck (L_30, L_31);
		(L_30)->SetAt(static_cast<il2cpp_array_size_t>(((int32_t)14)), (StateHandler_t8EA5CD11BFA1A958F305A2A0134A0BBB631FAFCB*)L_31);
		StateHandlerU5BU5D_t766A22C9C454D383614ED21CB99EAD5F5F15438B* L_32 = L_30;
		StateHandler_t8EA5CD11BFA1A958F305A2A0134A0BBB631FAFCB* L_33 = (StateHandler_t8EA5CD11BFA1A958F305A2A0134A0BBB631FAFCB*)il2cpp_codegen_object_new(StateHandler_t8EA5CD11BFA1A958F305A2A0134A0BBB631FAFCB_il2cpp_TypeInfo_var);
		NullCheck(L_33);
		StateHandler__ctor_m7B636AFF08A3049222D6F82BF87AFF9012CE69D2(L_33, NULL, (intptr_t)((void*)Lexer_State16_m180FD3FBA0BCDCB7CD31DF8066CFB0D95A8E5899_RuntimeMethod_var), NULL);
		NullCheck(L_32);
		ArrayElementTypeCheck (L_32, L_33);
		(L_32)->SetAt(static_cast<il2cpp_array_size_t>(((int32_t)15)), (StateHandler_t8EA5CD11BFA1A958F305A2A0134A0BBB631FAFCB*)L_33);
		StateHandlerU5BU5D_t766A22C9C454D383614ED21CB99EAD5F5F15438B* L_34 = L_32;
		StateHandler_t8EA5CD11BFA1A958F305A2A0134A0BBB631FAFCB* L_35 = (StateHandler_t8EA5CD11BFA1A958F305A2A0134A0BBB631FAFCB*)il2cpp_codegen_object_new(StateHandler_t8EA5CD11BFA1A958F305A2A0134A0BBB631FAFCB_il2cpp_TypeInfo_var);
		NullCheck(L_35);
		StateHandler__ctor_m7B636AFF08A3049222D6F82BF87AFF9012CE69D2(L_35, NULL, (intptr_t)((void*)Lexer_State17_mBCA9C4F0E50F372C89018A235BD28A351CD066BF_RuntimeMethod_var), NULL);
		NullCheck(L_34);
		ArrayElementTypeCheck (L_34, L_35);
		(L_34)->SetAt(static_cast<il2cpp_array_size_t>(((int32_t)16)), (StateHandler_t8EA5CD11BFA1A958F305A2A0134A0BBB631FAFCB*)L_35);
		StateHandlerU5BU5D_t766A22C9C454D383614ED21CB99EAD5F5F15438B* L_36 = L_34;
		StateHandler_t8EA5CD11BFA1A958F305A2A0134A0BBB631FAFCB* L_37 = (StateHandler_t8EA5CD11BFA1A958F305A2A0134A0BBB631FAFCB*)il2cpp_codegen_object_new(StateHandler_t8EA5CD11BFA1A958F305A2A0134A0BBB631FAFCB_il2cpp_TypeInfo_var);
		NullCheck(L_37);
		StateHandler__ctor_m7B636AFF08A3049222D6F82BF87AFF9012CE69D2(L_37, NULL, (intptr_t)((void*)Lexer_State18_m08C6ABD65DA0E9E71E22F625E7767F5FDA5E527B_RuntimeMethod_var), NULL);
		NullCheck(L_36);
		ArrayElementTypeCheck (L_36, L_37);
		(L_36)->SetAt(static_cast<il2cpp_array_size_t>(((int32_t)17)), (StateHandler_t8EA5CD11BFA1A958F305A2A0134A0BBB631FAFCB*)L_37);
		StateHandlerU5BU5D_t766A22C9C454D383614ED21CB99EAD5F5F15438B* L_38 = L_36;
		StateHandler_t8EA5CD11BFA1A958F305A2A0134A0BBB631FAFCB* L_39 = (StateHandler_t8EA5CD11BFA1A958F305A2A0134A0BBB631FAFCB*)il2cpp_codegen_object_new(StateHandler_t8EA5CD11BFA1A958F305A2A0134A0BBB631FAFCB_il2cpp_TypeInfo_var);
		NullCheck(L_39);
		StateHandler__ctor_m7B636AFF08A3049222D6F82BF87AFF9012CE69D2(L_39, NULL, (intptr_t)((void*)Lexer_State19_m72717A35567FDD6CB2B2D17F405D9A8A62D5A7D7_RuntimeMethod_var), NULL);
		NullCheck(L_38);
		ArrayElementTypeCheck (L_38, L_39);
		(L_38)->SetAt(static_cast<il2cpp_array_size_t>(((int32_t)18)), (StateHandler_t8EA5CD11BFA1A958F305A2A0134A0BBB631FAFCB*)L_39);
		StateHandlerU5BU5D_t766A22C9C454D383614ED21CB99EAD5F5F15438B* L_40 = L_38;
		StateHandler_t8EA5CD11BFA1A958F305A2A0134A0BBB631FAFCB* L_41 = (StateHandler_t8EA5CD11BFA1A958F305A2A0134A0BBB631FAFCB*)il2cpp_codegen_object_new(StateHandler_t8EA5CD11BFA1A958F305A2A0134A0BBB631FAFCB_il2cpp_TypeInfo_var);
		NullCheck(L_41);
		StateHandler__ctor_m7B636AFF08A3049222D6F82BF87AFF9012CE69D2(L_41, NULL, (intptr_t)((void*)Lexer_State20_m7AB439035107082B949A2E84806B0234056451CF_RuntimeMethod_var), NULL);
		NullCheck(L_40);
		ArrayElementTypeCheck (L_40, L_41);
		(L_40)->SetAt(static_cast<il2cpp_array_size_t>(((int32_t)19)), (StateHandler_t8EA5CD11BFA1A958F305A2A0134A0BBB631FAFCB*)L_41);
		StateHandlerU5BU5D_t766A22C9C454D383614ED21CB99EAD5F5F15438B* L_42 = L_40;
		StateHandler_t8EA5CD11BFA1A958F305A2A0134A0BBB631FAFCB* L_43 = (StateHandler_t8EA5CD11BFA1A958F305A2A0134A0BBB631FAFCB*)il2cpp_codegen_object_new(StateHandler_t8EA5CD11BFA1A958F305A2A0134A0BBB631FAFCB_il2cpp_TypeInfo_var);
		NullCheck(L_43);
		StateHandler__ctor_m7B636AFF08A3049222D6F82BF87AFF9012CE69D2(L_43, NULL, (intptr_t)((void*)Lexer_State21_mAF43928E6128B3D414351408BEC48D9D8A13FE1F_RuntimeMethod_var), NULL);
		NullCheck(L_42);
		ArrayElementTypeCheck (L_42, L_43);
		(L_42)->SetAt(static_cast<il2cpp_array_size_t>(((int32_t)20)), (StateHandler_t8EA5CD11BFA1A958F305A2A0134A0BBB631FAFCB*)L_43);
		StateHandlerU5BU5D_t766A22C9C454D383614ED21CB99EAD5F5F15438B* L_44 = L_42;
		StateHandler_t8EA5CD11BFA1A958F305A2A0134A0BBB631FAFCB* L_45 = (StateHandler_t8EA5CD11BFA1A958F305A2A0134A0BBB631FAFCB*)il2cpp_codegen_object_new(StateHandler_t8EA5CD11BFA1A958F305A2A0134A0BBB631FAFCB_il2cpp_TypeInfo_var);
		NullCheck(L_45);
		StateHandler__ctor_m7B636AFF08A3049222D6F82BF87AFF9012CE69D2(L_45, NULL, (intptr_t)((void*)Lexer_State22_mA8F75DBBADDA9897FF5A4FC0618085644BC527F9_RuntimeMethod_var), NULL);
		NullCheck(L_44);
		ArrayElementTypeCheck (L_44, L_45);
		(L_44)->SetAt(static_cast<il2cpp_array_size_t>(((int32_t)21)), (StateHandler_t8EA5CD11BFA1A958F305A2A0134A0BBB631FAFCB*)L_45);
		StateHandlerU5BU5D_t766A22C9C454D383614ED21CB99EAD5F5F15438B* L_46 = L_44;
		StateHandler_t8EA5CD11BFA1A958F305A2A0134A0BBB631FAFCB* L_47 = (StateHandler_t8EA5CD11BFA1A958F305A2A0134A0BBB631FAFCB*)il2cpp_codegen_object_new(StateHandler_t8EA5CD11BFA1A958F305A2A0134A0BBB631FAFCB_il2cpp_TypeInfo_var);
		NullCheck(L_47);
		StateHandler__ctor_m7B636AFF08A3049222D6F82BF87AFF9012CE69D2(L_47, NULL, (intptr_t)((void*)Lexer_State23_m40E6D1E13EEAE247AA7A182A25CDB3251ED54DC4_RuntimeMethod_var), NULL);
		NullCheck(L_46);
		ArrayElementTypeCheck (L_46, L_47);
		(L_46)->SetAt(static_cast<il2cpp_array_size_t>(((int32_t)22)), (StateHandler_t8EA5CD11BFA1A958F305A2A0134A0BBB631FAFCB*)L_47);
		StateHandlerU5BU5D_t766A22C9C454D383614ED21CB99EAD5F5F15438B* L_48 = L_46;
		StateHandler_t8EA5CD11BFA1A958F305A2A0134A0BBB631FAFCB* L_49 = (StateHandler_t8EA5CD11BFA1A958F305A2A0134A0BBB631FAFCB*)il2cpp_codegen_object_new(StateHandler_t8EA5CD11BFA1A958F305A2A0134A0BBB631FAFCB_il2cpp_TypeInfo_var);
		NullCheck(L_49);
		StateHandler__ctor_m7B636AFF08A3049222D6F82BF87AFF9012CE69D2(L_49, NULL, (intptr_t)((void*)Lexer_State24_mF032D4CC3EC466A9348FAD9C1054FD29C7214A44_RuntimeMethod_var), NULL);
		NullCheck(L_48);
		ArrayElementTypeCheck (L_48, L_49);
		(L_48)->SetAt(static_cast<il2cpp_array_size_t>(((int32_t)23)), (StateHandler_t8EA5CD11BFA1A958F305A2A0134A0BBB631FAFCB*)L_49);
		StateHandlerU5BU5D_t766A22C9C454D383614ED21CB99EAD5F5F15438B* L_50 = L_48;
		StateHandler_t8EA5CD11BFA1A958F305A2A0134A0BBB631FAFCB* L_51 = (StateHandler_t8EA5CD11BFA1A958F305A2A0134A0BBB631FAFCB*)il2cpp_codegen_object_new(StateHandler_t8EA5CD11BFA1A958F305A2A0134A0BBB631FAFCB_il2cpp_TypeInfo_var);
		NullCheck(L_51);
		StateHandler__ctor_m7B636AFF08A3049222D6F82BF87AFF9012CE69D2(L_51, NULL, (intptr_t)((void*)Lexer_State25_mFF34556A9AC7D3134B061F186784E9D14D749CB2_RuntimeMethod_var), NULL);
		NullCheck(L_50);
		ArrayElementTypeCheck (L_50, L_51);
		(L_50)->SetAt(static_cast<il2cpp_array_size_t>(((int32_t)24)), (StateHandler_t8EA5CD11BFA1A958F305A2A0134A0BBB631FAFCB*)L_51);
		StateHandlerU5BU5D_t766A22C9C454D383614ED21CB99EAD5F5F15438B* L_52 = L_50;
		StateHandler_t8EA5CD11BFA1A958F305A2A0134A0BBB631FAFCB* L_53 = (StateHandler_t8EA5CD11BFA1A958F305A2A0134A0BBB631FAFCB*)il2cpp_codegen_object_new(StateHandler_t8EA5CD11BFA1A958F305A2A0134A0BBB631FAFCB_il2cpp_TypeInfo_var);
		NullCheck(L_53);
		StateHandler__ctor_m7B636AFF08A3049222D6F82BF87AFF9012CE69D2(L_53, NULL, (intptr_t)((void*)Lexer_State26_mD4B202B505D9D18BB02A00E78A066B94C3FF041A_RuntimeMethod_var), NULL);
		NullCheck(L_52);
		ArrayElementTypeCheck (L_52, L_53);
		(L_52)->SetAt(static_cast<il2cpp_array_size_t>(((int32_t)25)), (StateHandler_t8EA5CD11BFA1A958F305A2A0134A0BBB631FAFCB*)L_53);
		StateHandlerU5BU5D_t766A22C9C454D383614ED21CB99EAD5F5F15438B* L_54 = L_52;
		StateHandler_t8EA5CD11BFA1A958F305A2A0134A0BBB631FAFCB* L_55 = (StateHandler_t8EA5CD11BFA1A958F305A2A0134A0BBB631FAFCB*)il2cpp_codegen_object_new(StateHandler_t8EA5CD11BFA1A958F305A2A0134A0BBB631FAFCB_il2cpp_TypeInfo_var);
		NullCheck(L_55);
		StateHandler__ctor_m7B636AFF08A3049222D6F82BF87AFF9012CE69D2(L_55, NULL, (intptr_t)((void*)Lexer_State27_m7A8DB0C14046DC8E864B145D58075823088F7DCC_RuntimeMethod_var), NULL);
		NullCheck(L_54);
		ArrayElementTypeCheck (L_54, L_55);
		(L_54)->SetAt(static_cast<il2cpp_array_size_t>(((int32_t)26)), (StateHandler_t8EA5CD11BFA1A958F305A2A0134A0BBB631FAFCB*)L_55);
		StateHandlerU5BU5D_t766A22C9C454D383614ED21CB99EAD5F5F15438B* L_56 = L_54;
		StateHandler_t8EA5CD11BFA1A958F305A2A0134A0BBB631FAFCB* L_57 = (StateHandler_t8EA5CD11BFA1A958F305A2A0134A0BBB631FAFCB*)il2cpp_codegen_object_new(StateHandler_t8EA5CD11BFA1A958F305A2A0134A0BBB631FAFCB_il2cpp_TypeInfo_var);
		NullCheck(L_57);
		StateHandler__ctor_m7B636AFF08A3049222D6F82BF87AFF9012CE69D2(L_57, NULL, (intptr_t)((void*)Lexer_State28_mE35361243292AE3F746EA665EE51E35AD2F71D58_RuntimeMethod_var), NULL);
		NullCheck(L_56);
		ArrayElementTypeCheck (L_56, L_57);
		(L_56)->SetAt(static_cast<il2cpp_array_size_t>(((int32_t)27)), (StateHandler_t8EA5CD11BFA1A958F305A2A0134A0BBB631FAFCB*)L_57);
		*((RuntimeObject**)L_0) = (RuntimeObject*)L_56;
		Il2CppCodeGenWriteBarrier((void**)(RuntimeObject**)L_0, (void*)(RuntimeObject*)L_56);
		// fsm_return_table = new int[28] {
		//     (int) ParserToken.Char,
		//     0,
		//     (int) ParserToken.Number,
		//     (int) ParserToken.Number,
		//     0,
		//     (int) ParserToken.Number,
		//     0,
		//     (int) ParserToken.Number,
		//     0,
		//     0,
		//     (int) ParserToken.True,
		//     0,
		//     0,
		//     0,
		//     (int) ParserToken.False,
		//     0,
		//     0,
		//     (int) ParserToken.Null,
		//     (int) ParserToken.CharSeq,
		//     (int) ParserToken.Char,
		//     0,
		//     0,
		//     (int) ParserToken.CharSeq,
		//     (int) ParserToken.Char,
		//     0,
		//     0,
		//     0,
		//     0
		// };
		Int32U5BU5D_t19C97395396A72ECAF310612F0760F165060314C** L_58 = ___fsm_return_table1;
		Int32U5BU5D_t19C97395396A72ECAF310612F0760F165060314C* L_59 = (Int32U5BU5D_t19C97395396A72ECAF310612F0760F165060314C*)(Int32U5BU5D_t19C97395396A72ECAF310612F0760F165060314C*)SZArrayNew(Int32U5BU5D_t19C97395396A72ECAF310612F0760F165060314C_il2cpp_TypeInfo_var, (uint32_t)((int32_t)28));
		Int32U5BU5D_t19C97395396A72ECAF310612F0760F165060314C* L_60 = L_59;
		RuntimeFieldHandle_t6E4C45B6D2EA12FC99185805A7E77527899B25C5 L_61 = { reinterpret_cast<intptr_t> (U3CPrivateImplementationDetailsU3E_t0F5473E849A5A5185A9F4C5246F0C32816C49FCA____C84227140A8A7787B30DFF8BD5693C19AA5A430C4E89FFD0256D7F77B3FEAD82_5_FieldInfo_var) };
		RuntimeHelpers_InitializeArray_m751372AA3F24FBF6DA9B9D687CBFA2DE436CAB9B((RuntimeArray*)L_60, L_61, NULL);
		*((RuntimeObject**)L_58) = (RuntimeObject*)L_60;
		Il2CppCodeGenWriteBarrier((void**)(RuntimeObject**)L_58, (void*)(RuntimeObject*)L_60);
		// }
		return;
	}
}
// System.Char Agora.Rtc.LitJson.Lexer::ProcessEscChar(System.Int32)
IL2CPP_EXTERN_C IL2CPP_METHOD_ATTR Il2CppChar Lexer_ProcessEscChar_m0E97C7D9F98BBEF906B17B4EDB0B93CA2B0BC11D (int32_t ___esc_char0, const RuntimeMethod* method) 
{
	static bool s_Il2CppMethodInitialized;
	if (!s_Il2CppMethodInitialized)
	{
		il2cpp_codegen_initialize_runtime_metadata((uintptr_t*)&Convert_t7097FF336D592F7C06D88A98349A44646F91EFFC_il2cpp_TypeInfo_var);
		s_Il2CppMethodInitialized = true;
	}
	{
		int32_t L_0 = ___esc_char0;
		if ((((int32_t)L_0) > ((int32_t)((int32_t)92))))
		{
			goto IL_0022;
		}
	}
	{
		int32_t L_1 = ___esc_char0;
		if ((((int32_t)L_1) > ((int32_t)((int32_t)39))))
		{
			goto IL_0016;
		}
	}
	{
		int32_t L_2 = ___esc_char0;
		if ((((int32_t)L_2) == ((int32_t)((int32_t)34))))
		{
			goto IL_0044;
		}
	}
	{
		int32_t L_3 = ___esc_char0;
		if ((((int32_t)L_3) == ((int32_t)((int32_t)39))))
		{
			goto IL_0044;
		}
	}
	{
		goto IL_0059;
	}

IL_0016:
	{
		int32_t L_4 = ___esc_char0;
		if ((((int32_t)L_4) == ((int32_t)((int32_t)47))))
		{
			goto IL_0044;
		}
	}
	{
		int32_t L_5 = ___esc_char0;
		if ((((int32_t)L_5) == ((int32_t)((int32_t)92))))
		{
			goto IL_0044;
		}
	}
	{
		goto IL_0059;
	}

IL_0022:
	{
		int32_t L_6 = ___esc_char0;
		if ((((int32_t)L_6) > ((int32_t)((int32_t)102))))
		{
			goto IL_0033;
		}
	}
	{
		int32_t L_7 = ___esc_char0;
		if ((((int32_t)L_7) == ((int32_t)((int32_t)98))))
		{
			goto IL_0054;
		}
	}
	{
		int32_t L_8 = ___esc_char0;
		if ((((int32_t)L_8) == ((int32_t)((int32_t)102))))
		{
			goto IL_0056;
		}
	}
	{
		goto IL_0059;
	}

IL_0033:
	{
		int32_t L_9 = ___esc_char0;
		if ((((int32_t)L_9) == ((int32_t)((int32_t)110))))
		{
			goto IL_004b;
		}
	}
	{
		int32_t L_10 = ___esc_char0;
		if ((((int32_t)L_10) == ((int32_t)((int32_t)114))))
		{
			goto IL_0051;
		}
	}
	{
		int32_t L_11 = ___esc_char0;
		if ((((int32_t)L_11) == ((int32_t)((int32_t)116))))
		{
			goto IL_004e;
		}
	}
	{
		goto IL_0059;
	}

IL_0044:
	{
		// return Convert.ToChar (esc_char);
		int32_t L_12 = ___esc_char0;
		il2cpp_codegen_runtime_class_init_inline(Convert_t7097FF336D592F7C06D88A98349A44646F91EFFC_il2cpp_TypeInfo_var);
		Il2CppChar L_13;
		L_13 = Convert_ToChar_mF1B1B205DDEFDE52251235514E7DAFCAB37D1F24(L_12, NULL);
		return L_13;
	}

IL_004b:
	{
		// return '\n';
		return ((int32_t)10);
	}

IL_004e:
	{
		// return '\t';
		return ((int32_t)9);
	}

IL_0051:
	{
		// return '\r';
		return ((int32_t)13);
	}

IL_0054:
	{
		// return '\b';
		return 8;
	}

IL_0056:
	{
		// return '\f';
		return ((int32_t)12);
	}

IL_0059:
	{
		// return '?';
		return ((int32_t)63);
	}
}
// System.Boolean Agora.Rtc.LitJson.Lexer::State1(Agora.Rtc.LitJson.FsmContext)
IL2CPP_EXTERN_C IL2CPP_METHOD_ATTR bool Lexer_State1_m354DEC7337AB8F388456A52C690558DA2667A78A (FsmContext_tC11B461D4D90680FC71416881106E6AF48CAE21F* ___ctx0, const RuntimeMethod* method) 
{
	int32_t V_0 = 0;
	{
		goto IL_01d9;
	}

IL_0005:
	{
		// if (ctx.L.input_char == ' ' ||
		//     ctx.L.input_char >= '\t' && ctx.L.input_char <= '\r')
		FsmContext_tC11B461D4D90680FC71416881106E6AF48CAE21F* L_0 = ___ctx0;
		NullCheck(L_0);
		Lexer_tDC14CFA7B390E884510F554D9D1E03188A185E27* L_1 = L_0->___L_2;
		NullCheck(L_1);
		int32_t L_2 = L_1->___input_char_7;
		if ((((int32_t)L_2) == ((int32_t)((int32_t)32))))
		{
			goto IL_01d9;
		}
	}
	{
		FsmContext_tC11B461D4D90680FC71416881106E6AF48CAE21F* L_3 = ___ctx0;
		NullCheck(L_3);
		Lexer_tDC14CFA7B390E884510F554D9D1E03188A185E27* L_4 = L_3->___L_2;
		NullCheck(L_4);
		int32_t L_5 = L_4->___input_char_7;
		if ((((int32_t)L_5) < ((int32_t)((int32_t)9))))
		{
			goto IL_0038;
		}
	}
	{
		FsmContext_tC11B461D4D90680FC71416881106E6AF48CAE21F* L_6 = ___ctx0;
		NullCheck(L_6);
		Lexer_tDC14CFA7B390E884510F554D9D1E03188A185E27* L_7 = L_6->___L_2;
		NullCheck(L_7);
		int32_t L_8 = L_7->___input_char_7;
		if ((((int32_t)L_8) <= ((int32_t)((int32_t)13))))
		{
			goto IL_01d9;
		}
	}

IL_0038:
	{
		// if (ctx.L.input_char >= '1' && ctx.L.input_char <= '9') {
		FsmContext_tC11B461D4D90680FC71416881106E6AF48CAE21F* L_9 = ___ctx0;
		NullCheck(L_9);
		Lexer_tDC14CFA7B390E884510F554D9D1E03188A185E27* L_10 = L_9->___L_2;
		NullCheck(L_10);
		int32_t L_11 = L_10->___input_char_7;
		if ((((int32_t)L_11) < ((int32_t)((int32_t)49))))
		{
			goto IL_007c;
		}
	}
	{
		FsmContext_tC11B461D4D90680FC71416881106E6AF48CAE21F* L_12 = ___ctx0;
		NullCheck(L_12);
		Lexer_tDC14CFA7B390E884510F554D9D1E03188A185E27* L_13 = L_12->___L_2;
		NullCheck(L_13);
		int32_t L_14 = L_13->___input_char_7;
		if ((((int32_t)L_14) > ((int32_t)((int32_t)57))))
		{
			goto IL_007c;
		}
	}
	{
		// ctx.L.string_buffer.Append ((char) ctx.L.input_char);
		FsmContext_tC11B461D4D90680FC71416881106E6AF48CAE21F* L_15 = ___ctx0;
		NullCheck(L_15);
		Lexer_tDC14CFA7B390E884510F554D9D1E03188A185E27* L_16 = L_15->___L_2;
		NullCheck(L_16);
		StringBuilder_t* L_17 = L_16->___string_buffer_10;
		FsmContext_tC11B461D4D90680FC71416881106E6AF48CAE21F* L_18 = ___ctx0;
		NullCheck(L_18);
		Lexer_tDC14CFA7B390E884510F554D9D1E03188A185E27* L_19 = L_18->___L_2;
		NullCheck(L_19);
		int32_t L_20 = L_19->___input_char_7;
		NullCheck(L_17);
		StringBuilder_t* L_21;
		L_21 = StringBuilder_Append_m71228B30F05724CD2CD96D9611DCD61BFB96A6E1(L_17, ((int32_t)(uint16_t)L_20), NULL);
		// ctx.NextState = 3;
		FsmContext_tC11B461D4D90680FC71416881106E6AF48CAE21F* L_22 = ___ctx0;
		NullCheck(L_22);
		L_22->___NextState_1 = 3;
		// return true;
		return (bool)1;
	}

IL_007c:
	{
		// switch (ctx.L.input_char) {
		FsmContext_tC11B461D4D90680FC71416881106E6AF48CAE21F* L_23 = ___ctx0;
		NullCheck(L_23);
		Lexer_tDC14CFA7B390E884510F554D9D1E03188A185E27* L_24 = L_23->___L_2;
		NullCheck(L_24);
		int32_t L_25 = L_24->___input_char_7;
		V_0 = L_25;
		int32_t L_26 = V_0;
		if ((((int32_t)L_26) > ((int32_t)((int32_t)91))))
		{
			goto IL_00d0;
		}
	}
	{
		int32_t L_27 = V_0;
		if ((((int32_t)L_27) > ((int32_t)((int32_t)39))))
		{
			goto IL_00a4;
		}
	}
	{
		int32_t L_28 = V_0;
		if ((((int32_t)L_28) == ((int32_t)((int32_t)34))))
		{
			goto IL_0106;
		}
	}
	{
		int32_t L_29 = V_0;
		if ((((int32_t)L_29) == ((int32_t)((int32_t)39))))
		{
			goto IL_0191;
		}
	}
	{
		goto IL_01d7;
	}

IL_00a4:
	{
		int32_t L_30 = V_0;
		switch (((int32_t)il2cpp_codegen_subtract(L_30, ((int32_t)44))))
		{
			case 0:
			{
				goto IL_0117;
			}
			case 1:
			{
				goto IL_0127;
			}
			case 2:
			{
				goto IL_01d7;
			}
			case 3:
			{
				goto IL_01be;
			}
			case 4:
			{
				goto IL_014d;
			}
		}
	}
	{
		int32_t L_31 = V_0;
		if ((((int32_t)L_31) == ((int32_t)((int32_t)58))))
		{
			goto IL_0117;
		}
	}
	{
		int32_t L_32 = V_0;
		if ((((int32_t)L_32) == ((int32_t)((int32_t)91))))
		{
			goto IL_0117;
		}
	}
	{
		goto IL_01d7;
	}

IL_00d0:
	{
		int32_t L_33 = V_0;
		if ((((int32_t)L_33) > ((int32_t)((int32_t)110))))
		{
			goto IL_00ef;
		}
	}
	{
		int32_t L_34 = V_0;
		if ((((int32_t)L_34) == ((int32_t)((int32_t)93))))
		{
			goto IL_0117;
		}
	}
	{
		int32_t L_35 = V_0;
		if ((((int32_t)L_35) == ((int32_t)((int32_t)102))))
		{
			goto IL_0173;
		}
	}
	{
		int32_t L_36 = V_0;
		if ((((int32_t)L_36) == ((int32_t)((int32_t)110))))
		{
			goto IL_017d;
		}
	}
	{
		goto IL_01d7;
	}

IL_00ef:
	{
		int32_t L_37 = V_0;
		if ((((int32_t)L_37) == ((int32_t)((int32_t)116))))
		{
			goto IL_0187;
		}
	}
	{
		int32_t L_38 = V_0;
		if ((((int32_t)L_38) == ((int32_t)((int32_t)123))))
		{
			goto IL_0117;
		}
	}
	{
		int32_t L_39 = V_0;
		if ((((int32_t)L_39) == ((int32_t)((int32_t)125))))
		{
			goto IL_0117;
		}
	}
	{
		goto IL_01d7;
	}

IL_0106:
	{
		// ctx.NextState = 19;
		FsmContext_tC11B461D4D90680FC71416881106E6AF48CAE21F* L_40 = ___ctx0;
		NullCheck(L_40);
		L_40->___NextState_1 = ((int32_t)19);
		// ctx.Return = true;
		FsmContext_tC11B461D4D90680FC71416881106E6AF48CAE21F* L_41 = ___ctx0;
		NullCheck(L_41);
		L_41->___Return_0 = (bool)1;
		// return true;
		return (bool)1;
	}

IL_0117:
	{
		// ctx.NextState = 1;
		FsmContext_tC11B461D4D90680FC71416881106E6AF48CAE21F* L_42 = ___ctx0;
		NullCheck(L_42);
		L_42->___NextState_1 = 1;
		// ctx.Return = true;
		FsmContext_tC11B461D4D90680FC71416881106E6AF48CAE21F* L_43 = ___ctx0;
		NullCheck(L_43);
		L_43->___Return_0 = (bool)1;
		// return true;
		return (bool)1;
	}

IL_0127:
	{
		// ctx.L.string_buffer.Append ((char) ctx.L.input_char);
		FsmContext_tC11B461D4D90680FC71416881106E6AF48CAE21F* L_44 = ___ctx0;
		NullCheck(L_44);
		Lexer_tDC14CFA7B390E884510F554D9D1E03188A185E27* L_45 = L_44->___L_2;
		NullCheck(L_45);
		StringBuilder_t* L_46 = L_45->___string_buffer_10;
		FsmContext_tC11B461D4D90680FC71416881106E6AF48CAE21F* L_47 = ___ctx0;
		NullCheck(L_47);
		Lexer_tDC14CFA7B390E884510F554D9D1E03188A185E27* L_48 = L_47->___L_2;
		NullCheck(L_48);
		int32_t L_49 = L_48->___input_char_7;
		NullCheck(L_46);
		StringBuilder_t* L_50;
		L_50 = StringBuilder_Append_m71228B30F05724CD2CD96D9611DCD61BFB96A6E1(L_46, ((int32_t)(uint16_t)L_49), NULL);
		// ctx.NextState = 2;
		FsmContext_tC11B461D4D90680FC71416881106E6AF48CAE21F* L_51 = ___ctx0;
		NullCheck(L_51);
		L_51->___NextState_1 = 2;
		// return true;
		return (bool)1;
	}

IL_014d:
	{
		// ctx.L.string_buffer.Append ((char) ctx.L.input_char);
		FsmContext_tC11B461D4D90680FC71416881106E6AF48CAE21F* L_52 = ___ctx0;
		NullCheck(L_52);
		Lexer_tDC14CFA7B390E884510F554D9D1E03188A185E27* L_53 = L_52->___L_2;
		NullCheck(L_53);
		StringBuilder_t* L_54 = L_53->___string_buffer_10;
		FsmContext_tC11B461D4D90680FC71416881106E6AF48CAE21F* L_55 = ___ctx0;
		NullCheck(L_55);
		Lexer_tDC14CFA7B390E884510F554D9D1E03188A185E27* L_56 = L_55->___L_2;
		NullCheck(L_56);
		int32_t L_57 = L_56->___input_char_7;
		NullCheck(L_54);
		StringBuilder_t* L_58;
		L_58 = StringBuilder_Append_m71228B30F05724CD2CD96D9611DCD61BFB96A6E1(L_54, ((int32_t)(uint16_t)L_57), NULL);
		// ctx.NextState = 4;
		FsmContext_tC11B461D4D90680FC71416881106E6AF48CAE21F* L_59 = ___ctx0;
		NullCheck(L_59);
		L_59->___NextState_1 = 4;
		// return true;
		return (bool)1;
	}

IL_0173:
	{
		// ctx.NextState = 12;
		FsmContext_tC11B461D4D90680FC71416881106E6AF48CAE21F* L_60 = ___ctx0;
		NullCheck(L_60);
		L_60->___NextState_1 = ((int32_t)12);
		// return true;
		return (bool)1;
	}

IL_017d:
	{
		// ctx.NextState = 16;
		FsmContext_tC11B461D4D90680FC71416881106E6AF48CAE21F* L_61 = ___ctx0;
		NullCheck(L_61);
		L_61->___NextState_1 = ((int32_t)16);
		// return true;
		return (bool)1;
	}

IL_0187:
	{
		// ctx.NextState = 9;
		FsmContext_tC11B461D4D90680FC71416881106E6AF48CAE21F* L_62 = ___ctx0;
		NullCheck(L_62);
		L_62->___NextState_1 = ((int32_t)9);
		// return true;
		return (bool)1;
	}

IL_0191:
	{
		// if (! ctx.L.allow_single_quoted_strings)
		FsmContext_tC11B461D4D90680FC71416881106E6AF48CAE21F* L_63 = ___ctx0;
		NullCheck(L_63);
		Lexer_tDC14CFA7B390E884510F554D9D1E03188A185E27* L_64 = L_63->___L_2;
		NullCheck(L_64);
		bool L_65 = L_64->___allow_single_quoted_strings_3;
		if (L_65)
		{
			goto IL_01a0;
		}
	}
	{
		// return false;
		return (bool)0;
	}

IL_01a0:
	{
		// ctx.L.input_char = '"';
		FsmContext_tC11B461D4D90680FC71416881106E6AF48CAE21F* L_66 = ___ctx0;
		NullCheck(L_66);
		Lexer_tDC14CFA7B390E884510F554D9D1E03188A185E27* L_67 = L_66->___L_2;
		NullCheck(L_67);
		L_67->___input_char_7 = ((int32_t)34);
		// ctx.NextState = 23;
		FsmContext_tC11B461D4D90680FC71416881106E6AF48CAE21F* L_68 = ___ctx0;
		NullCheck(L_68);
		L_68->___NextState_1 = ((int32_t)23);
		// ctx.Return = true;
		FsmContext_tC11B461D4D90680FC71416881106E6AF48CAE21F* L_69 = ___ctx0;
		NullCheck(L_69);
		L_69->___Return_0 = (bool)1;
		// return true;
		return (bool)1;
	}

IL_01be:
	{
		// if (! ctx.L.allow_comments)
		FsmContext_tC11B461D4D90680FC71416881106E6AF48CAE21F* L_70 = ___ctx0;
		NullCheck(L_70);
		Lexer_tDC14CFA7B390E884510F554D9D1E03188A185E27* L_71 = L_70->___L_2;
		NullCheck(L_71);
		bool L_72 = L_71->___allow_comments_2;
		if (L_72)
		{
			goto IL_01cd;
		}
	}
	{
		// return false;
		return (bool)0;
	}

IL_01cd:
	{
		// ctx.NextState = 25;
		FsmContext_tC11B461D4D90680FC71416881106E6AF48CAE21F* L_73 = ___ctx0;
		NullCheck(L_73);
		L_73->___NextState_1 = ((int32_t)25);
		// return true;
		return (bool)1;
	}

IL_01d7:
	{
		// return false;
		return (bool)0;
	}

IL_01d9:
	{
		// while (ctx.L.GetChar ()) {
		FsmContext_tC11B461D4D90680FC71416881106E6AF48CAE21F* L_74 = ___ctx0;
		NullCheck(L_74);
		Lexer_tDC14CFA7B390E884510F554D9D1E03188A185E27* L_75 = L_74->___L_2;
		NullCheck(L_75);
		bool L_76;
		L_76 = Lexer_GetChar_mB847D68CA0D5B450930406D4FBC986DA5C066FAA(L_75, NULL);
		if (L_76)
		{
			goto IL_0005;
		}
	}
	{
		// return true;
		return (bool)1;
	}
}
// System.Boolean Agora.Rtc.LitJson.Lexer::State2(Agora.Rtc.LitJson.FsmContext)
IL2CPP_EXTERN_C IL2CPP_METHOD_ATTR bool Lexer_State2_m17C42E885DC482058990D1CBB0A22E1A61275E61 (FsmContext_tC11B461D4D90680FC71416881106E6AF48CAE21F* ___ctx0, const RuntimeMethod* method) 
{
	{
		// ctx.L.GetChar ();
		FsmContext_tC11B461D4D90680FC71416881106E6AF48CAE21F* L_0 = ___ctx0;
		NullCheck(L_0);
		Lexer_tDC14CFA7B390E884510F554D9D1E03188A185E27* L_1 = L_0->___L_2;
		NullCheck(L_1);
		bool L_2;
		L_2 = Lexer_GetChar_mB847D68CA0D5B450930406D4FBC986DA5C066FAA(L_1, NULL);
		// if (ctx.L.input_char >= '1' && ctx.L.input_char<= '9') {
		FsmContext_tC11B461D4D90680FC71416881106E6AF48CAE21F* L_3 = ___ctx0;
		NullCheck(L_3);
		Lexer_tDC14CFA7B390E884510F554D9D1E03188A185E27* L_4 = L_3->___L_2;
		NullCheck(L_4);
		int32_t L_5 = L_4->___input_char_7;
		if ((((int32_t)L_5) < ((int32_t)((int32_t)49))))
		{
			goto IL_0050;
		}
	}
	{
		FsmContext_tC11B461D4D90680FC71416881106E6AF48CAE21F* L_6 = ___ctx0;
		NullCheck(L_6);
		Lexer_tDC14CFA7B390E884510F554D9D1E03188A185E27* L_7 = L_6->___L_2;
		NullCheck(L_7);
		int32_t L_8 = L_7->___input_char_7;
		if ((((int32_t)L_8) > ((int32_t)((int32_t)57))))
		{
			goto IL_0050;
		}
	}
	{
		// ctx.L.string_buffer.Append ((char) ctx.L.input_char);
		FsmContext_tC11B461D4D90680FC71416881106E6AF48CAE21F* L_9 = ___ctx0;
		NullCheck(L_9);
		Lexer_tDC14CFA7B390E884510F554D9D1E03188A185E27* L_10 = L_9->___L_2;
		NullCheck(L_10);
		StringBuilder_t* L_11 = L_10->___string_buffer_10;
		FsmContext_tC11B461D4D90680FC71416881106E6AF48CAE21F* L_12 = ___ctx0;
		NullCheck(L_12);
		Lexer_tDC14CFA7B390E884510F554D9D1E03188A185E27* L_13 = L_12->___L_2;
		NullCheck(L_13);
		int32_t L_14 = L_13->___input_char_7;
		NullCheck(L_11);
		StringBuilder_t* L_15;
		L_15 = StringBuilder_Append_m71228B30F05724CD2CD96D9611DCD61BFB96A6E1(L_11, ((int32_t)(uint16_t)L_14), NULL);
		// ctx.NextState = 3;
		FsmContext_tC11B461D4D90680FC71416881106E6AF48CAE21F* L_16 = ___ctx0;
		NullCheck(L_16);
		L_16->___NextState_1 = 3;
		// return true;
		return (bool)1;
	}

IL_0050:
	{
		// switch (ctx.L.input_char) {
		FsmContext_tC11B461D4D90680FC71416881106E6AF48CAE21F* L_17 = ___ctx0;
		NullCheck(L_17);
		Lexer_tDC14CFA7B390E884510F554D9D1E03188A185E27* L_18 = L_17->___L_2;
		NullCheck(L_18);
		int32_t L_19 = L_18->___input_char_7;
		if ((!(((uint32_t)L_19) == ((uint32_t)((int32_t)48)))))
		{
			goto IL_0085;
		}
	}
	{
		// ctx.L.string_buffer.Append ((char) ctx.L.input_char);
		FsmContext_tC11B461D4D90680FC71416881106E6AF48CAE21F* L_20 = ___ctx0;
		NullCheck(L_20);
		Lexer_tDC14CFA7B390E884510F554D9D1E03188A185E27* L_21 = L_20->___L_2;
		NullCheck(L_21);
		StringBuilder_t* L_22 = L_21->___string_buffer_10;
		FsmContext_tC11B461D4D90680FC71416881106E6AF48CAE21F* L_23 = ___ctx0;
		NullCheck(L_23);
		Lexer_tDC14CFA7B390E884510F554D9D1E03188A185E27* L_24 = L_23->___L_2;
		NullCheck(L_24);
		int32_t L_25 = L_24->___input_char_7;
		NullCheck(L_22);
		StringBuilder_t* L_26;
		L_26 = StringBuilder_Append_m71228B30F05724CD2CD96D9611DCD61BFB96A6E1(L_22, ((int32_t)(uint16_t)L_25), NULL);
		// ctx.NextState = 4;
		FsmContext_tC11B461D4D90680FC71416881106E6AF48CAE21F* L_27 = ___ctx0;
		NullCheck(L_27);
		L_27->___NextState_1 = 4;
		// return true;
		return (bool)1;
	}

IL_0085:
	{
		// return false;
		return (bool)0;
	}
}
// System.Boolean Agora.Rtc.LitJson.Lexer::State3(Agora.Rtc.LitJson.FsmContext)
IL2CPP_EXTERN_C IL2CPP_METHOD_ATTR bool Lexer_State3_mD790267EE8D2875ECF01971BB71AB85D34F7F164 (FsmContext_tC11B461D4D90680FC71416881106E6AF48CAE21F* ___ctx0, const RuntimeMethod* method) 
{
	int32_t V_0 = 0;
	{
		goto IL_011c;
	}

IL_0005:
	{
		// if (ctx.L.input_char >= '0' && ctx.L.input_char <= '9') {
		FsmContext_tC11B461D4D90680FC71416881106E6AF48CAE21F* L_0 = ___ctx0;
		NullCheck(L_0);
		Lexer_tDC14CFA7B390E884510F554D9D1E03188A185E27* L_1 = L_0->___L_2;
		NullCheck(L_1);
		int32_t L_2 = L_1->___input_char_7;
		if ((((int32_t)L_2) < ((int32_t)((int32_t)48))))
		{
			goto IL_0045;
		}
	}
	{
		FsmContext_tC11B461D4D90680FC71416881106E6AF48CAE21F* L_3 = ___ctx0;
		NullCheck(L_3);
		Lexer_tDC14CFA7B390E884510F554D9D1E03188A185E27* L_4 = L_3->___L_2;
		NullCheck(L_4);
		int32_t L_5 = L_4->___input_char_7;
		if ((((int32_t)L_5) > ((int32_t)((int32_t)57))))
		{
			goto IL_0045;
		}
	}
	{
		// ctx.L.string_buffer.Append ((char) ctx.L.input_char);
		FsmContext_tC11B461D4D90680FC71416881106E6AF48CAE21F* L_6 = ___ctx0;
		NullCheck(L_6);
		Lexer_tDC14CFA7B390E884510F554D9D1E03188A185E27* L_7 = L_6->___L_2;
		NullCheck(L_7);
		StringBuilder_t* L_8 = L_7->___string_buffer_10;
		FsmContext_tC11B461D4D90680FC71416881106E6AF48CAE21F* L_9 = ___ctx0;
		NullCheck(L_9);
		Lexer_tDC14CFA7B390E884510F554D9D1E03188A185E27* L_10 = L_9->___L_2;
		NullCheck(L_10);
		int32_t L_11 = L_10->___input_char_7;
		NullCheck(L_8);
		StringBuilder_t* L_12;
		L_12 = StringBuilder_Append_m71228B30F05724CD2CD96D9611DCD61BFB96A6E1(L_8, ((int32_t)(uint16_t)L_11), NULL);
		// continue;
		goto IL_011c;
	}

IL_0045:
	{
		// if (ctx.L.input_char == ' ' ||
		//     ctx.L.input_char >= '\t' && ctx.L.input_char <= '\r') {
		FsmContext_tC11B461D4D90680FC71416881106E6AF48CAE21F* L_13 = ___ctx0;
		NullCheck(L_13);
		Lexer_tDC14CFA7B390E884510F554D9D1E03188A185E27* L_14 = L_13->___L_2;
		NullCheck(L_14);
		int32_t L_15 = L_14->___input_char_7;
		if ((((int32_t)L_15) == ((int32_t)((int32_t)32))))
		{
			goto IL_0072;
		}
	}
	{
		FsmContext_tC11B461D4D90680FC71416881106E6AF48CAE21F* L_16 = ___ctx0;
		NullCheck(L_16);
		Lexer_tDC14CFA7B390E884510F554D9D1E03188A185E27* L_17 = L_16->___L_2;
		NullCheck(L_17);
		int32_t L_18 = L_17->___input_char_7;
		if ((((int32_t)L_18) < ((int32_t)((int32_t)9))))
		{
			goto IL_0082;
		}
	}
	{
		FsmContext_tC11B461D4D90680FC71416881106E6AF48CAE21F* L_19 = ___ctx0;
		NullCheck(L_19);
		Lexer_tDC14CFA7B390E884510F554D9D1E03188A185E27* L_20 = L_19->___L_2;
		NullCheck(L_20);
		int32_t L_21 = L_20->___input_char_7;
		if ((((int32_t)L_21) > ((int32_t)((int32_t)13))))
		{
			goto IL_0082;
		}
	}

IL_0072:
	{
		// ctx.Return = true;
		FsmContext_tC11B461D4D90680FC71416881106E6AF48CAE21F* L_22 = ___ctx0;
		NullCheck(L_22);
		L_22->___Return_0 = (bool)1;
		// ctx.NextState = 1;
		FsmContext_tC11B461D4D90680FC71416881106E6AF48CAE21F* L_23 = ___ctx0;
		NullCheck(L_23);
		L_23->___NextState_1 = 1;
		// return true;
		return (bool)1;
	}

IL_0082:
	{
		// switch (ctx.L.input_char) {
		FsmContext_tC11B461D4D90680FC71416881106E6AF48CAE21F* L_24 = ___ctx0;
		NullCheck(L_24);
		Lexer_tDC14CFA7B390E884510F554D9D1E03188A185E27* L_25 = L_24->___L_2;
		NullCheck(L_25);
		int32_t L_26 = L_25->___input_char_7;
		V_0 = L_26;
		int32_t L_27 = V_0;
		if ((((int32_t)L_27) > ((int32_t)((int32_t)69))))
		{
			goto IL_00a4;
		}
	}
	{
		int32_t L_28 = V_0;
		if ((((int32_t)L_28) == ((int32_t)((int32_t)44))))
		{
			goto IL_00b3;
		}
	}
	{
		int32_t L_29 = V_0;
		if ((((int32_t)L_29) == ((int32_t)((int32_t)46))))
		{
			goto IL_00ce;
		}
	}
	{
		int32_t L_30 = V_0;
		if ((((int32_t)L_30) == ((int32_t)((int32_t)69))))
		{
			goto IL_00f4;
		}
	}
	{
		goto IL_011a;
	}

IL_00a4:
	{
		int32_t L_31 = V_0;
		if ((((int32_t)L_31) == ((int32_t)((int32_t)93))))
		{
			goto IL_00b3;
		}
	}
	{
		int32_t L_32 = V_0;
		if ((((int32_t)L_32) == ((int32_t)((int32_t)101))))
		{
			goto IL_00f4;
		}
	}
	{
		int32_t L_33 = V_0;
		if ((!(((uint32_t)L_33) == ((uint32_t)((int32_t)125)))))
		{
			goto IL_011a;
		}
	}

IL_00b3:
	{
		// ctx.L.UngetChar ();
		FsmContext_tC11B461D4D90680FC71416881106E6AF48CAE21F* L_34 = ___ctx0;
		NullCheck(L_34);
		Lexer_tDC14CFA7B390E884510F554D9D1E03188A185E27* L_35 = L_34->___L_2;
		NullCheck(L_35);
		Lexer_UngetChar_m46FD110F88E00E60F9E296833913BC84AD8C7BA7(L_35, NULL);
		// ctx.Return = true;
		FsmContext_tC11B461D4D90680FC71416881106E6AF48CAE21F* L_36 = ___ctx0;
		NullCheck(L_36);
		L_36->___Return_0 = (bool)1;
		// ctx.NextState = 1;
		FsmContext_tC11B461D4D90680FC71416881106E6AF48CAE21F* L_37 = ___ctx0;
		NullCheck(L_37);
		L_37->___NextState_1 = 1;
		// return true;
		return (bool)1;
	}

IL_00ce:
	{
		// ctx.L.string_buffer.Append ((char) ctx.L.input_char);
		FsmContext_tC11B461D4D90680FC71416881106E6AF48CAE21F* L_38 = ___ctx0;
		NullCheck(L_38);
		Lexer_tDC14CFA7B390E884510F554D9D1E03188A185E27* L_39 = L_38->___L_2;
		NullCheck(L_39);
		StringBuilder_t* L_40 = L_39->___string_buffer_10;
		FsmContext_tC11B461D4D90680FC71416881106E6AF48CAE21F* L_41 = ___ctx0;
		NullCheck(L_41);
		Lexer_tDC14CFA7B390E884510F554D9D1E03188A185E27* L_42 = L_41->___L_2;
		NullCheck(L_42);
		int32_t L_43 = L_42->___input_char_7;
		NullCheck(L_40);
		StringBuilder_t* L_44;
		L_44 = StringBuilder_Append_m71228B30F05724CD2CD96D9611DCD61BFB96A6E1(L_40, ((int32_t)(uint16_t)L_43), NULL);
		// ctx.NextState = 5;
		FsmContext_tC11B461D4D90680FC71416881106E6AF48CAE21F* L_45 = ___ctx0;
		NullCheck(L_45);
		L_45->___NextState_1 = 5;
		// return true;
		return (bool)1;
	}

IL_00f4:
	{
		// ctx.L.string_buffer.Append ((char) ctx.L.input_char);
		FsmContext_tC11B461D4D90680FC71416881106E6AF48CAE21F* L_46 = ___ctx0;
		NullCheck(L_46);
		Lexer_tDC14CFA7B390E884510F554D9D1E03188A185E27* L_47 = L_46->___L_2;
		NullCheck(L_47);
		StringBuilder_t* L_48 = L_47->___string_buffer_10;
		FsmContext_tC11B461D4D90680FC71416881106E6AF48CAE21F* L_49 = ___ctx0;
		NullCheck(L_49);
		Lexer_tDC14CFA7B390E884510F554D9D1E03188A185E27* L_50 = L_49->___L_2;
		NullCheck(L_50);
		int32_t L_51 = L_50->___input_char_7;
		NullCheck(L_48);
		StringBuilder_t* L_52;
		L_52 = StringBuilder_Append_m71228B30F05724CD2CD96D9611DCD61BFB96A6E1(L_48, ((int32_t)(uint16_t)L_51), NULL);
		// ctx.NextState = 7;
		FsmContext_tC11B461D4D90680FC71416881106E6AF48CAE21F* L_53 = ___ctx0;
		NullCheck(L_53);
		L_53->___NextState_1 = 7;
		// return true;
		return (bool)1;
	}

IL_011a:
	{
		// return false;
		return (bool)0;
	}

IL_011c:
	{
		// while (ctx.L.GetChar ()) {
		FsmContext_tC11B461D4D90680FC71416881106E6AF48CAE21F* L_54 = ___ctx0;
		NullCheck(L_54);
		Lexer_tDC14CFA7B390E884510F554D9D1E03188A185E27* L_55 = L_54->___L_2;
		NullCheck(L_55);
		bool L_56;
		L_56 = Lexer_GetChar_mB847D68CA0D5B450930406D4FBC986DA5C066FAA(L_55, NULL);
		if (L_56)
		{
			goto IL_0005;
		}
	}
	{
		// return true;
		return (bool)1;
	}
}
// System.Boolean Agora.Rtc.LitJson.Lexer::State4(Agora.Rtc.LitJson.FsmContext)
IL2CPP_EXTERN_C IL2CPP_METHOD_ATTR bool Lexer_State4_m5A6397940610B555715FF84A98B939A20F3222DD (FsmContext_tC11B461D4D90680FC71416881106E6AF48CAE21F* ___ctx0, const RuntimeMethod* method) 
{
	int32_t V_0 = 0;
	{
		// ctx.L.GetChar ();
		FsmContext_tC11B461D4D90680FC71416881106E6AF48CAE21F* L_0 = ___ctx0;
		NullCheck(L_0);
		Lexer_tDC14CFA7B390E884510F554D9D1E03188A185E27* L_1 = L_0->___L_2;
		NullCheck(L_1);
		bool L_2;
		L_2 = Lexer_GetChar_mB847D68CA0D5B450930406D4FBC986DA5C066FAA(L_1, NULL);
		// if (ctx.L.input_char == ' ' ||
		//     ctx.L.input_char >= '\t' && ctx.L.input_char <= '\r') {
		FsmContext_tC11B461D4D90680FC71416881106E6AF48CAE21F* L_3 = ___ctx0;
		NullCheck(L_3);
		Lexer_tDC14CFA7B390E884510F554D9D1E03188A185E27* L_4 = L_3->___L_2;
		NullCheck(L_4);
		int32_t L_5 = L_4->___input_char_7;
		if ((((int32_t)L_5) == ((int32_t)((int32_t)32))))
		{
			goto IL_0039;
		}
	}
	{
		FsmContext_tC11B461D4D90680FC71416881106E6AF48CAE21F* L_6 = ___ctx0;
		NullCheck(L_6);
		Lexer_tDC14CFA7B390E884510F554D9D1E03188A185E27* L_7 = L_6->___L_2;
		NullCheck(L_7);
		int32_t L_8 = L_7->___input_char_7;
		if ((((int32_t)L_8) < ((int32_t)((int32_t)9))))
		{
			goto IL_0049;
		}
	}
	{
		FsmContext_tC11B461D4D90680FC71416881106E6AF48CAE21F* L_9 = ___ctx0;
		NullCheck(L_9);
		Lexer_tDC14CFA7B390E884510F554D9D1E03188A185E27* L_10 = L_9->___L_2;
		NullCheck(L_10);
		int32_t L_11 = L_10->___input_char_7;
		if ((((int32_t)L_11) > ((int32_t)((int32_t)13))))
		{
			goto IL_0049;
		}
	}

IL_0039:
	{
		// ctx.Return = true;
		FsmContext_tC11B461D4D90680FC71416881106E6AF48CAE21F* L_12 = ___ctx0;
		NullCheck(L_12);
		L_12->___Return_0 = (bool)1;
		// ctx.NextState = 1;
		FsmContext_tC11B461D4D90680FC71416881106E6AF48CAE21F* L_13 = ___ctx0;
		NullCheck(L_13);
		L_13->___NextState_1 = 1;
		// return true;
		return (bool)1;
	}

IL_0049:
	{
		// switch (ctx.L.input_char) {
		FsmContext_tC11B461D4D90680FC71416881106E6AF48CAE21F* L_14 = ___ctx0;
		NullCheck(L_14);
		Lexer_tDC14CFA7B390E884510F554D9D1E03188A185E27* L_15 = L_14->___L_2;
		NullCheck(L_15);
		int32_t L_16 = L_15->___input_char_7;
		V_0 = L_16;
		int32_t L_17 = V_0;
		if ((((int32_t)L_17) > ((int32_t)((int32_t)69))))
		{
			goto IL_006b;
		}
	}
	{
		int32_t L_18 = V_0;
		if ((((int32_t)L_18) == ((int32_t)((int32_t)44))))
		{
			goto IL_007a;
		}
	}
	{
		int32_t L_19 = V_0;
		if ((((int32_t)L_19) == ((int32_t)((int32_t)46))))
		{
			goto IL_0095;
		}
	}
	{
		int32_t L_20 = V_0;
		if ((((int32_t)L_20) == ((int32_t)((int32_t)69))))
		{
			goto IL_00bb;
		}
	}
	{
		goto IL_00e1;
	}

IL_006b:
	{
		int32_t L_21 = V_0;
		if ((((int32_t)L_21) == ((int32_t)((int32_t)93))))
		{
			goto IL_007a;
		}
	}
	{
		int32_t L_22 = V_0;
		if ((((int32_t)L_22) == ((int32_t)((int32_t)101))))
		{
			goto IL_00bb;
		}
	}
	{
		int32_t L_23 = V_0;
		if ((!(((uint32_t)L_23) == ((uint32_t)((int32_t)125)))))
		{
			goto IL_00e1;
		}
	}

IL_007a:
	{
		// ctx.L.UngetChar ();
		FsmContext_tC11B461D4D90680FC71416881106E6AF48CAE21F* L_24 = ___ctx0;
		NullCheck(L_24);
		Lexer_tDC14CFA7B390E884510F554D9D1E03188A185E27* L_25 = L_24->___L_2;
		NullCheck(L_25);
		Lexer_UngetChar_m46FD110F88E00E60F9E296833913BC84AD8C7BA7(L_25, NULL);
		// ctx.Return = true;
		FsmContext_tC11B461D4D90680FC71416881106E6AF48CAE21F* L_26 = ___ctx0;
		NullCheck(L_26);
		L_26->___Return_0 = (bool)1;
		// ctx.NextState = 1;
		FsmContext_tC11B461D4D90680FC71416881106E6AF48CAE21F* L_27 = ___ctx0;
		NullCheck(L_27);
		L_27->___NextState_1 = 1;
		// return true;
		return (bool)1;
	}

IL_0095:
	{
		// ctx.L.string_buffer.Append ((char) ctx.L.input_char);
		FsmContext_tC11B461D4D90680FC71416881106E6AF48CAE21F* L_28 = ___ctx0;
		NullCheck(L_28);
		Lexer_tDC14CFA7B390E884510F554D9D1E03188A185E27* L_29 = L_28->___L_2;
		NullCheck(L_29);
		StringBuilder_t* L_30 = L_29->___string_buffer_10;
		FsmContext_tC11B461D4D90680FC71416881106E6AF48CAE21F* L_31 = ___ctx0;
		NullCheck(L_31);
		Lexer_tDC14CFA7B390E884510F554D9D1E03188A185E27* L_32 = L_31->___L_2;
		NullCheck(L_32);
		int32_t L_33 = L_32->___input_char_7;
		NullCheck(L_30);
		StringBuilder_t* L_34;
		L_34 = StringBuilder_Append_m71228B30F05724CD2CD96D9611DCD61BFB96A6E1(L_30, ((int32_t)(uint16_t)L_33), NULL);
		// ctx.NextState = 5;
		FsmContext_tC11B461D4D90680FC71416881106E6AF48CAE21F* L_35 = ___ctx0;
		NullCheck(L_35);
		L_35->___NextState_1 = 5;
		// return true;
		return (bool)1;
	}

IL_00bb:
	{
		// ctx.L.string_buffer.Append ((char) ctx.L.input_char);
		FsmContext_tC11B461D4D90680FC71416881106E6AF48CAE21F* L_36 = ___ctx0;
		NullCheck(L_36);
		Lexer_tDC14CFA7B390E884510F554D9D1E03188A185E27* L_37 = L_36->___L_2;
		NullCheck(L_37);
		StringBuilder_t* L_38 = L_37->___string_buffer_10;
		FsmContext_tC11B461D4D90680FC71416881106E6AF48CAE21F* L_39 = ___ctx0;
		NullCheck(L_39);
		Lexer_tDC14CFA7B390E884510F554D9D1E03188A185E27* L_40 = L_39->___L_2;
		NullCheck(L_40);
		int32_t L_41 = L_40->___input_char_7;
		NullCheck(L_38);
		StringBuilder_t* L_42;
		L_42 = StringBuilder_Append_m71228B30F05724CD2CD96D9611DCD61BFB96A6E1(L_38, ((int32_t)(uint16_t)L_41), NULL);
		// ctx.NextState = 7;
		FsmContext_tC11B461D4D90680FC71416881106E6AF48CAE21F* L_43 = ___ctx0;
		NullCheck(L_43);
		L_43->___NextState_1 = 7;
		// return true;
		return (bool)1;
	}

IL_00e1:
	{
		// return false;
		return (bool)0;
	}
}
// System.Boolean Agora.Rtc.LitJson.Lexer::State5(Agora.Rtc.LitJson.FsmContext)
IL2CPP_EXTERN_C IL2CPP_METHOD_ATTR bool Lexer_State5_m66419555D44A07340F468202EB1623F64E07D057 (FsmContext_tC11B461D4D90680FC71416881106E6AF48CAE21F* ___ctx0, const RuntimeMethod* method) 
{
	{
		// ctx.L.GetChar ();
		FsmContext_tC11B461D4D90680FC71416881106E6AF48CAE21F* L_0 = ___ctx0;
		NullCheck(L_0);
		Lexer_tDC14CFA7B390E884510F554D9D1E03188A185E27* L_1 = L_0->___L_2;
		NullCheck(L_1);
		bool L_2;
		L_2 = Lexer_GetChar_mB847D68CA0D5B450930406D4FBC986DA5C066FAA(L_1, NULL);
		// if (ctx.L.input_char >= '0' && ctx.L.input_char <= '9') {
		FsmContext_tC11B461D4D90680FC71416881106E6AF48CAE21F* L_3 = ___ctx0;
		NullCheck(L_3);
		Lexer_tDC14CFA7B390E884510F554D9D1E03188A185E27* L_4 = L_3->___L_2;
		NullCheck(L_4);
		int32_t L_5 = L_4->___input_char_7;
		if ((((int32_t)L_5) < ((int32_t)((int32_t)48))))
		{
			goto IL_0050;
		}
	}
	{
		FsmContext_tC11B461D4D90680FC71416881106E6AF48CAE21F* L_6 = ___ctx0;
		NullCheck(L_6);
		Lexer_tDC14CFA7B390E884510F554D9D1E03188A185E27* L_7 = L_6->___L_2;
		NullCheck(L_7);
		int32_t L_8 = L_7->___input_char_7;
		if ((((int32_t)L_8) > ((int32_t)((int32_t)57))))
		{
			goto IL_0050;
		}
	}
	{
		// ctx.L.string_buffer.Append ((char) ctx.L.input_char);
		FsmContext_tC11B461D4D90680FC71416881106E6AF48CAE21F* L_9 = ___ctx0;
		NullCheck(L_9);
		Lexer_tDC14CFA7B390E884510F554D9D1E03188A185E27* L_10 = L_9->___L_2;
		NullCheck(L_10);
		StringBuilder_t* L_11 = L_10->___string_buffer_10;
		FsmContext_tC11B461D4D90680FC71416881106E6AF48CAE21F* L_12 = ___ctx0;
		NullCheck(L_12);
		Lexer_tDC14CFA7B390E884510F554D9D1E03188A185E27* L_13 = L_12->___L_2;
		NullCheck(L_13);
		int32_t L_14 = L_13->___input_char_7;
		NullCheck(L_11);
		StringBuilder_t* L_15;
		L_15 = StringBuilder_Append_m71228B30F05724CD2CD96D9611DCD61BFB96A6E1(L_11, ((int32_t)(uint16_t)L_14), NULL);
		// ctx.NextState = 6;
		FsmContext_tC11B461D4D90680FC71416881106E6AF48CAE21F* L_16 = ___ctx0;
		NullCheck(L_16);
		L_16->___NextState_1 = 6;
		// return true;
		return (bool)1;
	}

IL_0050:
	{
		// return false;
		return (bool)0;
	}
}
// System.Boolean Agora.Rtc.LitJson.Lexer::State6(Agora.Rtc.LitJson.FsmContext)
IL2CPP_EXTERN_C IL2CPP_METHOD_ATTR bool Lexer_State6_m2FA1AC1A3BB7D134A4070EAA04B4B8F7578082F9 (FsmContext_tC11B461D4D90680FC71416881106E6AF48CAE21F* ___ctx0, const RuntimeMethod* method) 
{
	int32_t V_0 = 0;
	{
		goto IL_00f1;
	}

IL_0005:
	{
		// if (ctx.L.input_char >= '0' && ctx.L.input_char <= '9') {
		FsmContext_tC11B461D4D90680FC71416881106E6AF48CAE21F* L_0 = ___ctx0;
		NullCheck(L_0);
		Lexer_tDC14CFA7B390E884510F554D9D1E03188A185E27* L_1 = L_0->___L_2;
		NullCheck(L_1);
		int32_t L_2 = L_1->___input_char_7;
		if ((((int32_t)L_2) < ((int32_t)((int32_t)48))))
		{
			goto IL_0045;
		}
	}
	{
		FsmContext_tC11B461D4D90680FC71416881106E6AF48CAE21F* L_3 = ___ctx0;
		NullCheck(L_3);
		Lexer_tDC14CFA7B390E884510F554D9D1E03188A185E27* L_4 = L_3->___L_2;
		NullCheck(L_4);
		int32_t L_5 = L_4->___input_char_7;
		if ((((int32_t)L_5) > ((int32_t)((int32_t)57))))
		{
			goto IL_0045;
		}
	}
	{
		// ctx.L.string_buffer.Append ((char) ctx.L.input_char);
		FsmContext_tC11B461D4D90680FC71416881106E6AF48CAE21F* L_6 = ___ctx0;
		NullCheck(L_6);
		Lexer_tDC14CFA7B390E884510F554D9D1E03188A185E27* L_7 = L_6->___L_2;
		NullCheck(L_7);
		StringBuilder_t* L_8 = L_7->___string_buffer_10;
		FsmContext_tC11B461D4D90680FC71416881106E6AF48CAE21F* L_9 = ___ctx0;
		NullCheck(L_9);
		Lexer_tDC14CFA7B390E884510F554D9D1E03188A185E27* L_10 = L_9->___L_2;
		NullCheck(L_10);
		int32_t L_11 = L_10->___input_char_7;
		NullCheck(L_8);
		StringBuilder_t* L_12;
		L_12 = StringBuilder_Append_m71228B30F05724CD2CD96D9611DCD61BFB96A6E1(L_8, ((int32_t)(uint16_t)L_11), NULL);
		// continue;
		goto IL_00f1;
	}

IL_0045:
	{
		// if (ctx.L.input_char == ' ' ||
		//     ctx.L.input_char >= '\t' && ctx.L.input_char <= '\r') {
		FsmContext_tC11B461D4D90680FC71416881106E6AF48CAE21F* L_13 = ___ctx0;
		NullCheck(L_13);
		Lexer_tDC14CFA7B390E884510F554D9D1E03188A185E27* L_14 = L_13->___L_2;
		NullCheck(L_14);
		int32_t L_15 = L_14->___input_char_7;
		if ((((int32_t)L_15) == ((int32_t)((int32_t)32))))
		{
			goto IL_0072;
		}
	}
	{
		FsmContext_tC11B461D4D90680FC71416881106E6AF48CAE21F* L_16 = ___ctx0;
		NullCheck(L_16);
		Lexer_tDC14CFA7B390E884510F554D9D1E03188A185E27* L_17 = L_16->___L_2;
		NullCheck(L_17);
		int32_t L_18 = L_17->___input_char_7;
		if ((((int32_t)L_18) < ((int32_t)((int32_t)9))))
		{
			goto IL_0082;
		}
	}
	{
		FsmContext_tC11B461D4D90680FC71416881106E6AF48CAE21F* L_19 = ___ctx0;
		NullCheck(L_19);
		Lexer_tDC14CFA7B390E884510F554D9D1E03188A185E27* L_20 = L_19->___L_2;
		NullCheck(L_20);
		int32_t L_21 = L_20->___input_char_7;
		if ((((int32_t)L_21) > ((int32_t)((int32_t)13))))
		{
			goto IL_0082;
		}
	}

IL_0072:
	{
		// ctx.Return = true;
		FsmContext_tC11B461D4D90680FC71416881106E6AF48CAE21F* L_22 = ___ctx0;
		NullCheck(L_22);
		L_22->___Return_0 = (bool)1;
		// ctx.NextState = 1;
		FsmContext_tC11B461D4D90680FC71416881106E6AF48CAE21F* L_23 = ___ctx0;
		NullCheck(L_23);
		L_23->___NextState_1 = 1;
		// return true;
		return (bool)1;
	}

IL_0082:
	{
		// switch (ctx.L.input_char) {
		FsmContext_tC11B461D4D90680FC71416881106E6AF48CAE21F* L_24 = ___ctx0;
		NullCheck(L_24);
		Lexer_tDC14CFA7B390E884510F554D9D1E03188A185E27* L_25 = L_24->___L_2;
		NullCheck(L_25);
		int32_t L_26 = L_25->___input_char_7;
		V_0 = L_26;
		int32_t L_27 = V_0;
		if ((((int32_t)L_27) > ((int32_t)((int32_t)69))))
		{
			goto IL_009f;
		}
	}
	{
		int32_t L_28 = V_0;
		if ((((int32_t)L_28) == ((int32_t)((int32_t)44))))
		{
			goto IL_00ae;
		}
	}
	{
		int32_t L_29 = V_0;
		if ((((int32_t)L_29) == ((int32_t)((int32_t)69))))
		{
			goto IL_00c9;
		}
	}
	{
		goto IL_00ef;
	}

IL_009f:
	{
		int32_t L_30 = V_0;
		if ((((int32_t)L_30) == ((int32_t)((int32_t)93))))
		{
			goto IL_00ae;
		}
	}
	{
		int32_t L_31 = V_0;
		if ((((int32_t)L_31) == ((int32_t)((int32_t)101))))
		{
			goto IL_00c9;
		}
	}
	{
		int32_t L_32 = V_0;
		if ((!(((uint32_t)L_32) == ((uint32_t)((int32_t)125)))))
		{
			goto IL_00ef;
		}
	}

IL_00ae:
	{
		// ctx.L.UngetChar ();
		FsmContext_tC11B461D4D90680FC71416881106E6AF48CAE21F* L_33 = ___ctx0;
		NullCheck(L_33);
		Lexer_tDC14CFA7B390E884510F554D9D1E03188A185E27* L_34 = L_33->___L_2;
		NullCheck(L_34);
		Lexer_UngetChar_m46FD110F88E00E60F9E296833913BC84AD8C7BA7(L_34, NULL);
		// ctx.Return = true;
		FsmContext_tC11B461D4D90680FC71416881106E6AF48CAE21F* L_35 = ___ctx0;
		NullCheck(L_35);
		L_35->___Return_0 = (bool)1;
		// ctx.NextState = 1;
		FsmContext_tC11B461D4D90680FC71416881106E6AF48CAE21F* L_36 = ___ctx0;
		NullCheck(L_36);
		L_36->___NextState_1 = 1;
		// return true;
		return (bool)1;
	}

IL_00c9:
	{
		// ctx.L.string_buffer.Append ((char) ctx.L.input_char);
		FsmContext_tC11B461D4D90680FC71416881106E6AF48CAE21F* L_37 = ___ctx0;
		NullCheck(L_37);
		Lexer_tDC14CFA7B390E884510F554D9D1E03188A185E27* L_38 = L_37->___L_2;
		NullCheck(L_38);
		StringBuilder_t* L_39 = L_38->___string_buffer_10;
		FsmContext_tC11B461D4D90680FC71416881106E6AF48CAE21F* L_40 = ___ctx0;
		NullCheck(L_40);
		Lexer_tDC14CFA7B390E884510F554D9D1E03188A185E27* L_41 = L_40->___L_2;
		NullCheck(L_41);
		int32_t L_42 = L_41->___input_char_7;
		NullCheck(L_39);
		StringBuilder_t* L_43;
		L_43 = StringBuilder_Append_m71228B30F05724CD2CD96D9611DCD61BFB96A6E1(L_39, ((int32_t)(uint16_t)L_42), NULL);
		// ctx.NextState = 7;
		FsmContext_tC11B461D4D90680FC71416881106E6AF48CAE21F* L_44 = ___ctx0;
		NullCheck(L_44);
		L_44->___NextState_1 = 7;
		// return true;
		return (bool)1;
	}

IL_00ef:
	{
		// return false;
		return (bool)0;
	}

IL_00f1:
	{
		// while (ctx.L.GetChar ()) {
		FsmContext_tC11B461D4D90680FC71416881106E6AF48CAE21F* L_45 = ___ctx0;
		NullCheck(L_45);
		Lexer_tDC14CFA7B390E884510F554D9D1E03188A185E27* L_46 = L_45->___L_2;
		NullCheck(L_46);
		bool L_47;
		L_47 = Lexer_GetChar_mB847D68CA0D5B450930406D4FBC986DA5C066FAA(L_46, NULL);
		if (L_47)
		{
			goto IL_0005;
		}
	}
	{
		// return true;
		return (bool)1;
	}
}
// System.Boolean Agora.Rtc.LitJson.Lexer::State7(Agora.Rtc.LitJson.FsmContext)
IL2CPP_EXTERN_C IL2CPP_METHOD_ATTR bool Lexer_State7_mD7D75CE8EE1228FA4F834D0A5B9D70366738FA78 (FsmContext_tC11B461D4D90680FC71416881106E6AF48CAE21F* ___ctx0, const RuntimeMethod* method) 
{
	int32_t V_0 = 0;
	{
		// ctx.L.GetChar ();
		FsmContext_tC11B461D4D90680FC71416881106E6AF48CAE21F* L_0 = ___ctx0;
		NullCheck(L_0);
		Lexer_tDC14CFA7B390E884510F554D9D1E03188A185E27* L_1 = L_0->___L_2;
		NullCheck(L_1);
		bool L_2;
		L_2 = Lexer_GetChar_mB847D68CA0D5B450930406D4FBC986DA5C066FAA(L_1, NULL);
		// if (ctx.L.input_char >= '0' && ctx.L.input_char<= '9') {
		FsmContext_tC11B461D4D90680FC71416881106E6AF48CAE21F* L_3 = ___ctx0;
		NullCheck(L_3);
		Lexer_tDC14CFA7B390E884510F554D9D1E03188A185E27* L_4 = L_3->___L_2;
		NullCheck(L_4);
		int32_t L_5 = L_4->___input_char_7;
		if ((((int32_t)L_5) < ((int32_t)((int32_t)48))))
		{
			goto IL_0050;
		}
	}
	{
		FsmContext_tC11B461D4D90680FC71416881106E6AF48CAE21F* L_6 = ___ctx0;
		NullCheck(L_6);
		Lexer_tDC14CFA7B390E884510F554D9D1E03188A185E27* L_7 = L_6->___L_2;
		NullCheck(L_7);
		int32_t L_8 = L_7->___input_char_7;
		if ((((int32_t)L_8) > ((int32_t)((int32_t)57))))
		{
			goto IL_0050;
		}
	}
	{
		// ctx.L.string_buffer.Append ((char) ctx.L.input_char);
		FsmContext_tC11B461D4D90680FC71416881106E6AF48CAE21F* L_9 = ___ctx0;
		NullCheck(L_9);
		Lexer_tDC14CFA7B390E884510F554D9D1E03188A185E27* L_10 = L_9->___L_2;
		NullCheck(L_10);
		StringBuilder_t* L_11 = L_10->___string_buffer_10;
		FsmContext_tC11B461D4D90680FC71416881106E6AF48CAE21F* L_12 = ___ctx0;
		NullCheck(L_12);
		Lexer_tDC14CFA7B390E884510F554D9D1E03188A185E27* L_13 = L_12->___L_2;
		NullCheck(L_13);
		int32_t L_14 = L_13->___input_char_7;
		NullCheck(L_11);
		StringBuilder_t* L_15;
		L_15 = StringBuilder_Append_m71228B30F05724CD2CD96D9611DCD61BFB96A6E1(L_11, ((int32_t)(uint16_t)L_14), NULL);
		// ctx.NextState = 8;
		FsmContext_tC11B461D4D90680FC71416881106E6AF48CAE21F* L_16 = ___ctx0;
		NullCheck(L_16);
		L_16->___NextState_1 = 8;
		// return true;
		return (bool)1;
	}

IL_0050:
	{
		// switch (ctx.L.input_char) {
		FsmContext_tC11B461D4D90680FC71416881106E6AF48CAE21F* L_17 = ___ctx0;
		NullCheck(L_17);
		Lexer_tDC14CFA7B390E884510F554D9D1E03188A185E27* L_18 = L_17->___L_2;
		NullCheck(L_18);
		int32_t L_19 = L_18->___input_char_7;
		V_0 = L_19;
		int32_t L_20 = V_0;
		if ((((int32_t)L_20) == ((int32_t)((int32_t)43))))
		{
			goto IL_0066;
		}
	}
	{
		int32_t L_21 = V_0;
		if ((!(((uint32_t)L_21) == ((uint32_t)((int32_t)45)))))
		{
			goto IL_008c;
		}
	}

IL_0066:
	{
		// ctx.L.string_buffer.Append ((char) ctx.L.input_char);
		FsmContext_tC11B461D4D90680FC71416881106E6AF48CAE21F* L_22 = ___ctx0;
		NullCheck(L_22);
		Lexer_tDC14CFA7B390E884510F554D9D1E03188A185E27* L_23 = L_22->___L_2;
		NullCheck(L_23);
		StringBuilder_t* L_24 = L_23->___string_buffer_10;
		FsmContext_tC11B461D4D90680FC71416881106E6AF48CAE21F* L_25 = ___ctx0;
		NullCheck(L_25);
		Lexer_tDC14CFA7B390E884510F554D9D1E03188A185E27* L_26 = L_25->___L_2;
		NullCheck(L_26);
		int32_t L_27 = L_26->___input_char_7;
		NullCheck(L_24);
		StringBuilder_t* L_28;
		L_28 = StringBuilder_Append_m71228B30F05724CD2CD96D9611DCD61BFB96A6E1(L_24, ((int32_t)(uint16_t)L_27), NULL);
		// ctx.NextState = 8;
		FsmContext_tC11B461D4D90680FC71416881106E6AF48CAE21F* L_29 = ___ctx0;
		NullCheck(L_29);
		L_29->___NextState_1 = 8;
		// return true;
		return (bool)1;
	}

IL_008c:
	{
		// return false;
		return (bool)0;
	}
}
// System.Boolean Agora.Rtc.LitJson.Lexer::State8(Agora.Rtc.LitJson.FsmContext)
IL2CPP_EXTERN_C IL2CPP_METHOD_ATTR bool Lexer_State8_m6E43322CC449B219D8B91721D69CB1BC06D49D67 (FsmContext_tC11B461D4D90680FC71416881106E6AF48CAE21F* ___ctx0, const RuntimeMethod* method) 
{
	int32_t V_0 = 0;
	{
		goto IL_00b7;
	}

IL_0005:
	{
		// if (ctx.L.input_char >= '0' && ctx.L.input_char<= '9') {
		FsmContext_tC11B461D4D90680FC71416881106E6AF48CAE21F* L_0 = ___ctx0;
		NullCheck(L_0);
		Lexer_tDC14CFA7B390E884510F554D9D1E03188A185E27* L_1 = L_0->___L_2;
		NullCheck(L_1);
		int32_t L_2 = L_1->___input_char_7;
		if ((((int32_t)L_2) < ((int32_t)((int32_t)48))))
		{
			goto IL_0042;
		}
	}
	{
		FsmContext_tC11B461D4D90680FC71416881106E6AF48CAE21F* L_3 = ___ctx0;
		NullCheck(L_3);
		Lexer_tDC14CFA7B390E884510F554D9D1E03188A185E27* L_4 = L_3->___L_2;
		NullCheck(L_4);
		int32_t L_5 = L_4->___input_char_7;
		if ((((int32_t)L_5) > ((int32_t)((int32_t)57))))
		{
			goto IL_0042;
		}
	}
	{
		// ctx.L.string_buffer.Append ((char) ctx.L.input_char);
		FsmContext_tC11B461D4D90680FC71416881106E6AF48CAE21F* L_6 = ___ctx0;
		NullCheck(L_6);
		Lexer_tDC14CFA7B390E884510F554D9D1E03188A185E27* L_7 = L_6->___L_2;
		NullCheck(L_7);
		StringBuilder_t* L_8 = L_7->___string_buffer_10;
		FsmContext_tC11B461D4D90680FC71416881106E6AF48CAE21F* L_9 = ___ctx0;
		NullCheck(L_9);
		Lexer_tDC14CFA7B390E884510F554D9D1E03188A185E27* L_10 = L_9->___L_2;
		NullCheck(L_10);
		int32_t L_11 = L_10->___input_char_7;
		NullCheck(L_8);
		StringBuilder_t* L_12;
		L_12 = StringBuilder_Append_m71228B30F05724CD2CD96D9611DCD61BFB96A6E1(L_8, ((int32_t)(uint16_t)L_11), NULL);
		// continue;
		goto IL_00b7;
	}

IL_0042:
	{
		// if (ctx.L.input_char == ' ' ||
		//     ctx.L.input_char >= '\t' && ctx.L.input_char<= '\r') {
		FsmContext_tC11B461D4D90680FC71416881106E6AF48CAE21F* L_13 = ___ctx0;
		NullCheck(L_13);
		Lexer_tDC14CFA7B390E884510F554D9D1E03188A185E27* L_14 = L_13->___L_2;
		NullCheck(L_14);
		int32_t L_15 = L_14->___input_char_7;
		if ((((int32_t)L_15) == ((int32_t)((int32_t)32))))
		{
			goto IL_006f;
		}
	}
	{
		FsmContext_tC11B461D4D90680FC71416881106E6AF48CAE21F* L_16 = ___ctx0;
		NullCheck(L_16);
		Lexer_tDC14CFA7B390E884510F554D9D1E03188A185E27* L_17 = L_16->___L_2;
		NullCheck(L_17);
		int32_t L_18 = L_17->___input_char_7;
		if ((((int32_t)L_18) < ((int32_t)((int32_t)9))))
		{
			goto IL_007f;
		}
	}
	{
		FsmContext_tC11B461D4D90680FC71416881106E6AF48CAE21F* L_19 = ___ctx0;
		NullCheck(L_19);
		Lexer_tDC14CFA7B390E884510F554D9D1E03188A185E27* L_20 = L_19->___L_2;
		NullCheck(L_20);
		int32_t L_21 = L_20->___input_char_7;
		if ((((int32_t)L_21) > ((int32_t)((int32_t)13))))
		{
			goto IL_007f;
		}
	}

IL_006f:
	{
		// ctx.Return = true;
		FsmContext_tC11B461D4D90680FC71416881106E6AF48CAE21F* L_22 = ___ctx0;
		NullCheck(L_22);
		L_22->___Return_0 = (bool)1;
		// ctx.NextState = 1;
		FsmContext_tC11B461D4D90680FC71416881106E6AF48CAE21F* L_23 = ___ctx0;
		NullCheck(L_23);
		L_23->___NextState_1 = 1;
		// return true;
		return (bool)1;
	}

IL_007f:
	{
		// switch (ctx.L.input_char) {
		FsmContext_tC11B461D4D90680FC71416881106E6AF48CAE21F* L_24 = ___ctx0;
		NullCheck(L_24);
		Lexer_tDC14CFA7B390E884510F554D9D1E03188A185E27* L_25 = L_24->___L_2;
		NullCheck(L_25);
		int32_t L_26 = L_25->___input_char_7;
		V_0 = L_26;
		int32_t L_27 = V_0;
		if ((((int32_t)L_27) == ((int32_t)((int32_t)44))))
		{
			goto IL_009a;
		}
	}
	{
		int32_t L_28 = V_0;
		if ((((int32_t)L_28) == ((int32_t)((int32_t)93))))
		{
			goto IL_009a;
		}
	}
	{
		int32_t L_29 = V_0;
		if ((!(((uint32_t)L_29) == ((uint32_t)((int32_t)125)))))
		{
			goto IL_00b5;
		}
	}

IL_009a:
	{
		// ctx.L.UngetChar ();
		FsmContext_tC11B461D4D90680FC71416881106E6AF48CAE21F* L_30 = ___ctx0;
		NullCheck(L_30);
		Lexer_tDC14CFA7B390E884510F554D9D1E03188A185E27* L_31 = L_30->___L_2;
		NullCheck(L_31);
		Lexer_UngetChar_m46FD110F88E00E60F9E296833913BC84AD8C7BA7(L_31, NULL);
		// ctx.Return = true;
		FsmContext_tC11B461D4D90680FC71416881106E6AF48CAE21F* L_32 = ___ctx0;
		NullCheck(L_32);
		L_32->___Return_0 = (bool)1;
		// ctx.NextState = 1;
		FsmContext_tC11B461D4D90680FC71416881106E6AF48CAE21F* L_33 = ___ctx0;
		NullCheck(L_33);
		L_33->___NextState_1 = 1;
		// return true;
		return (bool)1;
	}

IL_00b5:
	{
		// return false;
		return (bool)0;
	}

IL_00b7:
	{
		// while (ctx.L.GetChar ()) {
		FsmContext_tC11B461D4D90680FC71416881106E6AF48CAE21F* L_34 = ___ctx0;
		NullCheck(L_34);
		Lexer_tDC14CFA7B390E884510F554D9D1E03188A185E27* L_35 = L_34->___L_2;
		NullCheck(L_35);
		bool L_36;
		L_36 = Lexer_GetChar_mB847D68CA0D5B450930406D4FBC986DA5C066FAA(L_35, NULL);
		if (L_36)
		{
			goto IL_0005;
		}
	}
	{
		// return true;
		return (bool)1;
	}
}
// System.Boolean Agora.Rtc.LitJson.Lexer::State9(Agora.Rtc.LitJson.FsmContext)
IL2CPP_EXTERN_C IL2CPP_METHOD_ATTR bool Lexer_State9_m7801BC5CF8DBDCFD46091BF2BFAF300D2108FA62 (FsmContext_tC11B461D4D90680FC71416881106E6AF48CAE21F* ___ctx0, const RuntimeMethod* method) 
{
	{
		// ctx.L.GetChar ();
		FsmContext_tC11B461D4D90680FC71416881106E6AF48CAE21F* L_0 = ___ctx0;
		NullCheck(L_0);
		Lexer_tDC14CFA7B390E884510F554D9D1E03188A185E27* L_1 = L_0->___L_2;
		NullCheck(L_1);
		bool L_2;
		L_2 = Lexer_GetChar_mB847D68CA0D5B450930406D4FBC986DA5C066FAA(L_1, NULL);
		// switch (ctx.L.input_char) {
		FsmContext_tC11B461D4D90680FC71416881106E6AF48CAE21F* L_3 = ___ctx0;
		NullCheck(L_3);
		Lexer_tDC14CFA7B390E884510F554D9D1E03188A185E27* L_4 = L_3->___L_2;
		NullCheck(L_4);
		int32_t L_5 = L_4->___input_char_7;
		if ((!(((uint32_t)L_5) == ((uint32_t)((int32_t)114)))))
		{
			goto IL_0025;
		}
	}
	{
		// ctx.NextState = 10;
		FsmContext_tC11B461D4D90680FC71416881106E6AF48CAE21F* L_6 = ___ctx0;
		NullCheck(L_6);
		L_6->___NextState_1 = ((int32_t)10);
		// return true;
		return (bool)1;
	}

IL_0025:
	{
		// return false;
		return (bool)0;
	}
}
// System.Boolean Agora.Rtc.LitJson.Lexer::State10(Agora.Rtc.LitJson.FsmContext)
IL2CPP_EXTERN_C IL2CPP_METHOD_ATTR bool Lexer_State10_m09FDA0FCE8DC10439C3F0230FE49C2479EA2CF9F (FsmContext_tC11B461D4D90680FC71416881106E6AF48CAE21F* ___ctx0, const RuntimeMethod* method) 
{
	{
		// ctx.L.GetChar ();
		FsmContext_tC11B461D4D90680FC71416881106E6AF48CAE21F* L_0 = ___ctx0;
		NullCheck(L_0);
		Lexer_tDC14CFA7B390E884510F554D9D1E03188A185E27* L_1 = L_0->___L_2;
		NullCheck(L_1);
		bool L_2;
		L_2 = Lexer_GetChar_mB847D68CA0D5B450930406D4FBC986DA5C066FAA(L_1, NULL);
		// switch (ctx.L.input_char) {
		FsmContext_tC11B461D4D90680FC71416881106E6AF48CAE21F* L_3 = ___ctx0;
		NullCheck(L_3);
		Lexer_tDC14CFA7B390E884510F554D9D1E03188A185E27* L_4 = L_3->___L_2;
		NullCheck(L_4);
		int32_t L_5 = L_4->___input_char_7;
		if ((!(((uint32_t)L_5) == ((uint32_t)((int32_t)117)))))
		{
			goto IL_0025;
		}
	}
	{
		// ctx.NextState = 11;
		FsmContext_tC11B461D4D90680FC71416881106E6AF48CAE21F* L_6 = ___ctx0;
		NullCheck(L_6);
		L_6->___NextState_1 = ((int32_t)11);
		// return true;
		return (bool)1;
	}

IL_0025:
	{
		// return false;
		return (bool)0;
	}
}
// System.Boolean Agora.Rtc.LitJson.Lexer::State11(Agora.Rtc.LitJson.FsmContext)
IL2CPP_EXTERN_C IL2CPP_METHOD_ATTR bool Lexer_State11_m10B21AA8B5F120F37CA9A6BA3FCE91093028E921 (FsmContext_tC11B461D4D90680FC71416881106E6AF48CAE21F* ___ctx0, const RuntimeMethod* method) 
{
	{
		// ctx.L.GetChar ();
		FsmContext_tC11B461D4D90680FC71416881106E6AF48CAE21F* L_0 = ___ctx0;
		NullCheck(L_0);
		Lexer_tDC14CFA7B390E884510F554D9D1E03188A185E27* L_1 = L_0->___L_2;
		NullCheck(L_1);
		bool L_2;
		L_2 = Lexer_GetChar_mB847D68CA0D5B450930406D4FBC986DA5C066FAA(L_1, NULL);
		// switch (ctx.L.input_char) {
		FsmContext_tC11B461D4D90680FC71416881106E6AF48CAE21F* L_3 = ___ctx0;
		NullCheck(L_3);
		Lexer_tDC14CFA7B390E884510F554D9D1E03188A185E27* L_4 = L_3->___L_2;
		NullCheck(L_4);
		int32_t L_5 = L_4->___input_char_7;
		if ((!(((uint32_t)L_5) == ((uint32_t)((int32_t)101)))))
		{
			goto IL_002b;
		}
	}
	{
		// ctx.Return = true;
		FsmContext_tC11B461D4D90680FC71416881106E6AF48CAE21F* L_6 = ___ctx0;
		NullCheck(L_6);
		L_6->___Return_0 = (bool)1;
		// ctx.NextState = 1;
		FsmContext_tC11B461D4D90680FC71416881106E6AF48CAE21F* L_7 = ___ctx0;
		NullCheck(L_7);
		L_7->___NextState_1 = 1;
		// return true;
		return (bool)1;
	}

IL_002b:
	{
		// return false;
		return (bool)0;
	}
}
// System.Boolean Agora.Rtc.LitJson.Lexer::State12(Agora.Rtc.LitJson.FsmContext)
IL2CPP_EXTERN_C IL2CPP_METHOD_ATTR bool Lexer_State12_mA3309CA31EA7DF35795793EC1625BD7BB8F0DE31 (FsmContext_tC11B461D4D90680FC71416881106E6AF48CAE21F* ___ctx0, const RuntimeMethod* method) 
{
	{
		// ctx.L.GetChar ();
		FsmContext_tC11B461D4D90680FC71416881106E6AF48CAE21F* L_0 = ___ctx0;
		NullCheck(L_0);
		Lexer_tDC14CFA7B390E884510F554D9D1E03188A185E27* L_1 = L_0->___L_2;
		NullCheck(L_1);
		bool L_2;
		L_2 = Lexer_GetChar_mB847D68CA0D5B450930406D4FBC986DA5C066FAA(L_1, NULL);
		// switch (ctx.L.input_char) {
		FsmContext_tC11B461D4D90680FC71416881106E6AF48CAE21F* L_3 = ___ctx0;
		NullCheck(L_3);
		Lexer_tDC14CFA7B390E884510F554D9D1E03188A185E27* L_4 = L_3->___L_2;
		NullCheck(L_4);
		int32_t L_5 = L_4->___input_char_7;
		if ((!(((uint32_t)L_5) == ((uint32_t)((int32_t)97)))))
		{
			goto IL_0025;
		}
	}
	{
		// ctx.NextState = 13;
		FsmContext_tC11B461D4D90680FC71416881106E6AF48CAE21F* L_6 = ___ctx0;
		NullCheck(L_6);
		L_6->___NextState_1 = ((int32_t)13);
		// return true;
		return (bool)1;
	}

IL_0025:
	{
		// return false;
		return (bool)0;
	}
}
// System.Boolean Agora.Rtc.LitJson.Lexer::State13(Agora.Rtc.LitJson.FsmContext)
IL2CPP_EXTERN_C IL2CPP_METHOD_ATTR bool Lexer_State13_mA36CE192CAB3A980421944E2E748C60C36F5C46D (FsmContext_tC11B461D4D90680FC71416881106E6AF48CAE21F* ___ctx0, const RuntimeMethod* method) 
{
	{
		// ctx.L.GetChar ();
		FsmContext_tC11B461D4D90680FC71416881106E6AF48CAE21F* L_0 = ___ctx0;
		NullCheck(L_0);
		Lexer_tDC14CFA7B390E884510F554D9D1E03188A185E27* L_1 = L_0->___L_2;
		NullCheck(L_1);
		bool L_2;
		L_2 = Lexer_GetChar_mB847D68CA0D5B450930406D4FBC986DA5C066FAA(L_1, NULL);
		// switch (ctx.L.input_char) {
		FsmContext_tC11B461D4D90680FC71416881106E6AF48CAE21F* L_3 = ___ctx0;
		NullCheck(L_3);
		Lexer_tDC14CFA7B390E884510F554D9D1E03188A185E27* L_4 = L_3->___L_2;
		NullCheck(L_4);
		int32_t L_5 = L_4->___input_char_7;
		if ((!(((uint32_t)L_5) == ((uint32_t)((int32_t)108)))))
		{
			goto IL_0025;
		}
	}
	{
		// ctx.NextState = 14;
		FsmContext_tC11B461D4D90680FC71416881106E6AF48CAE21F* L_6 = ___ctx0;
		NullCheck(L_6);
		L_6->___NextState_1 = ((int32_t)14);
		// return true;
		return (bool)1;
	}

IL_0025:
	{
		// return false;
		return (bool)0;
	}
}
// System.Boolean Agora.Rtc.LitJson.Lexer::State14(Agora.Rtc.LitJson.FsmContext)
IL2CPP_EXTERN_C IL2CPP_METHOD_ATTR bool Lexer_State14_mE16EEB2471742849851399A944FEAEFA52627434 (FsmContext_tC11B461D4D90680FC71416881106E6AF48CAE21F* ___ctx0, const RuntimeMethod* method) 
{
	{
		// ctx.L.GetChar ();
		FsmContext_tC11B461D4D90680FC71416881106E6AF48CAE21F* L_0 = ___ctx0;
		NullCheck(L_0);
		Lexer_tDC14CFA7B390E884510F554D9D1E03188A185E27* L_1 = L_0->___L_2;
		NullCheck(L_1);
		bool L_2;
		L_2 = Lexer_GetChar_mB847D68CA0D5B450930406D4FBC986DA5C066FAA(L_1, NULL);
		// switch (ctx.L.input_char) {
		FsmContext_tC11B461D4D90680FC71416881106E6AF48CAE21F* L_3 = ___ctx0;
		NullCheck(L_3);
		Lexer_tDC14CFA7B390E884510F554D9D1E03188A185E27* L_4 = L_3->___L_2;
		NullCheck(L_4);
		int32_t L_5 = L_4->___input_char_7;
		if ((!(((uint32_t)L_5) == ((uint32_t)((int32_t)115)))))
		{
			goto IL_0025;
		}
	}
	{
		// ctx.NextState = 15;
		FsmContext_tC11B461D4D90680FC71416881106E6AF48CAE21F* L_6 = ___ctx0;
		NullCheck(L_6);
		L_6->___NextState_1 = ((int32_t)15);
		// return true;
		return (bool)1;
	}

IL_0025:
	{
		// return false;
		return (bool)0;
	}
}
// System.Boolean Agora.Rtc.LitJson.Lexer::State15(Agora.Rtc.LitJson.FsmContext)
IL2CPP_EXTERN_C IL2CPP_METHOD_ATTR bool Lexer_State15_m31270A40FAFFF8A0360B89A4BCBEE77B9CDA16B6 (FsmContext_tC11B461D4D90680FC71416881106E6AF48CAE21F* ___ctx0, const RuntimeMethod* method) 
{
	{
		// ctx.L.GetChar ();
		FsmContext_tC11B461D4D90680FC71416881106E6AF48CAE21F* L_0 = ___ctx0;
		NullCheck(L_0);
		Lexer_tDC14CFA7B390E884510F554D9D1E03188A185E27* L_1 = L_0->___L_2;
		NullCheck(L_1);
		bool L_2;
		L_2 = Lexer_GetChar_mB847D68CA0D5B450930406D4FBC986DA5C066FAA(L_1, NULL);
		// switch (ctx.L.input_char) {
		FsmContext_tC11B461D4D90680FC71416881106E6AF48CAE21F* L_3 = ___ctx0;
		NullCheck(L_3);
		Lexer_tDC14CFA7B390E884510F554D9D1E03188A185E27* L_4 = L_3->___L_2;
		NullCheck(L_4);
		int32_t L_5 = L_4->___input_char_7;
		if ((!(((uint32_t)L_5) == ((uint32_t)((int32_t)101)))))
		{
			goto IL_002b;
		}
	}
	{
		// ctx.Return = true;
		FsmContext_tC11B461D4D90680FC71416881106E6AF48CAE21F* L_6 = ___ctx0;
		NullCheck(L_6);
		L_6->___Return_0 = (bool)1;
		// ctx.NextState = 1;
		FsmContext_tC11B461D4D90680FC71416881106E6AF48CAE21F* L_7 = ___ctx0;
		NullCheck(L_7);
		L_7->___NextState_1 = 1;
		// return true;
		return (bool)1;
	}

IL_002b:
	{
		// return false;
		return (bool)0;
	}
}
// System.Boolean Agora.Rtc.LitJson.Lexer::State16(Agora.Rtc.LitJson.FsmContext)
IL2CPP_EXTERN_C IL2CPP_METHOD_ATTR bool Lexer_State16_m180FD3FBA0BCDCB7CD31DF8066CFB0D95A8E5899 (FsmContext_tC11B461D4D90680FC71416881106E6AF48CAE21F* ___ctx0, const RuntimeMethod* method) 
{
	{
		// ctx.L.GetChar ();
		FsmContext_tC11B461D4D90680FC71416881106E6AF48CAE21F* L_0 = ___ctx0;
		NullCheck(L_0);
		Lexer_tDC14CFA7B390E884510F554D9D1E03188A185E27* L_1 = L_0->___L_2;
		NullCheck(L_1);
		bool L_2;
		L_2 = Lexer_GetChar_mB847D68CA0D5B450930406D4FBC986DA5C066FAA(L_1, NULL);
		// switch (ctx.L.input_char) {
		FsmContext_tC11B461D4D90680FC71416881106E6AF48CAE21F* L_3 = ___ctx0;
		NullCheck(L_3);
		Lexer_tDC14CFA7B390E884510F554D9D1E03188A185E27* L_4 = L_3->___L_2;
		NullCheck(L_4);
		int32_t L_5 = L_4->___input_char_7;
		if ((!(((uint32_t)L_5) == ((uint32_t)((int32_t)117)))))
		{
			goto IL_0025;
		}
	}
	{
		// ctx.NextState = 17;
		FsmContext_tC11B461D4D90680FC71416881106E6AF48CAE21F* L_6 = ___ctx0;
		NullCheck(L_6);
		L_6->___NextState_1 = ((int32_t)17);
		// return true;
		return (bool)1;
	}

IL_0025:
	{
		// return false;
		return (bool)0;
	}
}
// System.Boolean Agora.Rtc.LitJson.Lexer::State17(Agora.Rtc.LitJson.FsmContext)
IL2CPP_EXTERN_C IL2CPP_METHOD_ATTR bool Lexer_State17_mBCA9C4F0E50F372C89018A235BD28A351CD066BF (FsmContext_tC11B461D4D90680FC71416881106E6AF48CAE21F* ___ctx0, const RuntimeMethod* method) 
{
	{
		// ctx.L.GetChar ();
		FsmContext_tC11B461D4D90680FC71416881106E6AF48CAE21F* L_0 = ___ctx0;
		NullCheck(L_0);
		Lexer_tDC14CFA7B390E884510F554D9D1E03188A185E27* L_1 = L_0->___L_2;
		NullCheck(L_1);
		bool L_2;
		L_2 = Lexer_GetChar_mB847D68CA0D5B450930406D4FBC986DA5C066FAA(L_1, NULL);
		// switch (ctx.L.input_char) {
		FsmContext_tC11B461D4D90680FC71416881106E6AF48CAE21F* L_3 = ___ctx0;
		NullCheck(L_3);
		Lexer_tDC14CFA7B390E884510F554D9D1E03188A185E27* L_4 = L_3->___L_2;
		NullCheck(L_4);
		int32_t L_5 = L_4->___input_char_7;
		if ((!(((uint32_t)L_5) == ((uint32_t)((int32_t)108)))))
		{
			goto IL_0025;
		}
	}
	{
		// ctx.NextState = 18;
		FsmContext_tC11B461D4D90680FC71416881106E6AF48CAE21F* L_6 = ___ctx0;
		NullCheck(L_6);
		L_6->___NextState_1 = ((int32_t)18);
		// return true;
		return (bool)1;
	}

IL_0025:
	{
		// return false;
		return (bool)0;
	}
}
// System.Boolean Agora.Rtc.LitJson.Lexer::State18(Agora.Rtc.LitJson.FsmContext)
IL2CPP_EXTERN_C IL2CPP_METHOD_ATTR bool Lexer_State18_m08C6ABD65DA0E9E71E22F625E7767F5FDA5E527B (FsmContext_tC11B461D4D90680FC71416881106E6AF48CAE21F* ___ctx0, const RuntimeMethod* method) 
{
	{
		// ctx.L.GetChar ();
		FsmContext_tC11B461D4D90680FC71416881106E6AF48CAE21F* L_0 = ___ctx0;
		NullCheck(L_0);
		Lexer_tDC14CFA7B390E884510F554D9D1E03188A185E27* L_1 = L_0->___L_2;
		NullCheck(L_1);
		bool L_2;
		L_2 = Lexer_GetChar_mB847D68CA0D5B450930406D4FBC986DA5C066FAA(L_1, NULL);
		// switch (ctx.L.input_char) {
		FsmContext_tC11B461D4D90680FC71416881106E6AF48CAE21F* L_3 = ___ctx0;
		NullCheck(L_3);
		Lexer_tDC14CFA7B390E884510F554D9D1E03188A185E27* L_4 = L_3->___L_2;
		NullCheck(L_4);
		int32_t L_5 = L_4->___input_char_7;
		if ((!(((uint32_t)L_5) == ((uint32_t)((int32_t)108)))))
		{
			goto IL_002b;
		}
	}
	{
		// ctx.Return = true;
		FsmContext_tC11B461D4D90680FC71416881106E6AF48CAE21F* L_6 = ___ctx0;
		NullCheck(L_6);
		L_6->___Return_0 = (bool)1;
		// ctx.NextState = 1;
		FsmContext_tC11B461D4D90680FC71416881106E6AF48CAE21F* L_7 = ___ctx0;
		NullCheck(L_7);
		L_7->___NextState_1 = 1;
		// return true;
		return (bool)1;
	}

IL_002b:
	{
		// return false;
		return (bool)0;
	}
}
// System.Boolean Agora.Rtc.LitJson.Lexer::State19(Agora.Rtc.LitJson.FsmContext)
IL2CPP_EXTERN_C IL2CPP_METHOD_ATTR bool Lexer_State19_m72717A35567FDD6CB2B2D17F405D9A8A62D5A7D7 (FsmContext_tC11B461D4D90680FC71416881106E6AF48CAE21F* ___ctx0, const RuntimeMethod* method) 
{
	int32_t V_0 = 0;
	{
		goto IL_0065;
	}

IL_0002:
	{
		// switch (ctx.L.input_char) {
		FsmContext_tC11B461D4D90680FC71416881106E6AF48CAE21F* L_0 = ___ctx0;
		NullCheck(L_0);
		Lexer_tDC14CFA7B390E884510F554D9D1E03188A185E27* L_1 = L_0->___L_2;
		NullCheck(L_1);
		int32_t L_2 = L_1->___input_char_7;
		V_0 = L_2;
		int32_t L_3 = V_0;
		if ((((int32_t)L_3) == ((int32_t)((int32_t)34))))
		{
			goto IL_001a;
		}
	}
	{
		int32_t L_4 = V_0;
		if ((((int32_t)L_4) == ((int32_t)((int32_t)92))))
		{
			goto IL_0036;
		}
	}
	{
		goto IL_0048;
	}

IL_001a:
	{
		// ctx.L.UngetChar ();
		FsmContext_tC11B461D4D90680FC71416881106E6AF48CAE21F* L_5 = ___ctx0;
		NullCheck(L_5);
		Lexer_tDC14CFA7B390E884510F554D9D1E03188A185E27* L_6 = L_5->___L_2;
		NullCheck(L_6);
		Lexer_UngetChar_m46FD110F88E00E60F9E296833913BC84AD8C7BA7(L_6, NULL);
		// ctx.Return = true;
		FsmContext_tC11B461D4D90680FC71416881106E6AF48CAE21F* L_7 = ___ctx0;
		NullCheck(L_7);
		L_7->___Return_0 = (bool)1;
		// ctx.NextState = 20;
		FsmContext_tC11B461D4D90680FC71416881106E6AF48CAE21F* L_8 = ___ctx0;
		NullCheck(L_8);
		L_8->___NextState_1 = ((int32_t)20);
		// return true;
		return (bool)1;
	}

IL_0036:
	{
		// ctx.StateStack = 19;
		FsmContext_tC11B461D4D90680FC71416881106E6AF48CAE21F* L_9 = ___ctx0;
		NullCheck(L_9);
		L_9->___StateStack_3 = ((int32_t)19);
		// ctx.NextState = 21;
		FsmContext_tC11B461D4D90680FC71416881106E6AF48CAE21F* L_10 = ___ctx0;
		NullCheck(L_10);
		L_10->___NextState_1 = ((int32_t)21);
		// return true;
		return (bool)1;
	}

IL_0048:
	{
		// ctx.L.string_buffer.Append ((char) ctx.L.input_char);
		FsmContext_tC11B461D4D90680FC71416881106E6AF48CAE21F* L_11 = ___ctx0;
		NullCheck(L_11);
		Lexer_tDC14CFA7B390E884510F554D9D1E03188A185E27* L_12 = L_11->___L_2;
		NullCheck(L_12);
		StringBuilder_t* L_13 = L_12->___string_buffer_10;
		FsmContext_tC11B461D4D90680FC71416881106E6AF48CAE21F* L_14 = ___ctx0;
		NullCheck(L_14);
		Lexer_tDC14CFA7B390E884510F554D9D1E03188A185E27* L_15 = L_14->___L_2;
		NullCheck(L_15);
		int32_t L_16 = L_15->___input_char_7;
		NullCheck(L_13);
		StringBuilder_t* L_17;
		L_17 = StringBuilder_Append_m71228B30F05724CD2CD96D9611DCD61BFB96A6E1(L_13, ((int32_t)(uint16_t)L_16), NULL);
	}

IL_0065:
	{
		// while (ctx.L.GetChar ()) {
		FsmContext_tC11B461D4D90680FC71416881106E6AF48CAE21F* L_18 = ___ctx0;
		NullCheck(L_18);
		Lexer_tDC14CFA7B390E884510F554D9D1E03188A185E27* L_19 = L_18->___L_2;
		NullCheck(L_19);
		bool L_20;
		L_20 = Lexer_GetChar_mB847D68CA0D5B450930406D4FBC986DA5C066FAA(L_19, NULL);
		if (L_20)
		{
			goto IL_0002;
		}
	}
	{
		// return true;
		return (bool)1;
	}
}
// System.Boolean Agora.Rtc.LitJson.Lexer::State20(Agora.Rtc.LitJson.FsmContext)
IL2CPP_EXTERN_C IL2CPP_METHOD_ATTR bool Lexer_State20_m7AB439035107082B949A2E84806B0234056451CF (FsmContext_tC11B461D4D90680FC71416881106E6AF48CAE21F* ___ctx0, const RuntimeMethod* method) 
{
	{
		// ctx.L.GetChar ();
		FsmContext_tC11B461D4D90680FC71416881106E6AF48CAE21F* L_0 = ___ctx0;
		NullCheck(L_0);
		Lexer_tDC14CFA7B390E884510F554D9D1E03188A185E27* L_1 = L_0->___L_2;
		NullCheck(L_1);
		bool L_2;
		L_2 = Lexer_GetChar_mB847D68CA0D5B450930406D4FBC986DA5C066FAA(L_1, NULL);
		// switch (ctx.L.input_char) {
		FsmContext_tC11B461D4D90680FC71416881106E6AF48CAE21F* L_3 = ___ctx0;
		NullCheck(L_3);
		Lexer_tDC14CFA7B390E884510F554D9D1E03188A185E27* L_4 = L_3->___L_2;
		NullCheck(L_4);
		int32_t L_5 = L_4->___input_char_7;
		if ((!(((uint32_t)L_5) == ((uint32_t)((int32_t)34)))))
		{
			goto IL_002b;
		}
	}
	{
		// ctx.Return = true;
		FsmContext_tC11B461D4D90680FC71416881106E6AF48CAE21F* L_6 = ___ctx0;
		NullCheck(L_6);
		L_6->___Return_0 = (bool)1;
		// ctx.NextState = 1;
		FsmContext_tC11B461D4D90680FC71416881106E6AF48CAE21F* L_7 = ___ctx0;
		NullCheck(L_7);
		L_7->___NextState_1 = 1;
		// return true;
		return (bool)1;
	}

IL_002b:
	{
		// return false;
		return (bool)0;
	}
}
// System.Boolean Agora.Rtc.LitJson.Lexer::State21(Agora.Rtc.LitJson.FsmContext)
IL2CPP_EXTERN_C IL2CPP_METHOD_ATTR bool Lexer_State21_mAF43928E6128B3D414351408BEC48D9D8A13FE1F (FsmContext_tC11B461D4D90680FC71416881106E6AF48CAE21F* ___ctx0, const RuntimeMethod* method) 
{
	static bool s_Il2CppMethodInitialized;
	if (!s_Il2CppMethodInitialized)
	{
		il2cpp_codegen_initialize_runtime_metadata((uintptr_t*)&Lexer_tDC14CFA7B390E884510F554D9D1E03188A185E27_il2cpp_TypeInfo_var);
		s_Il2CppMethodInitialized = true;
	}
	int32_t V_0 = 0;
	{
		// ctx.L.GetChar ();
		FsmContext_tC11B461D4D90680FC71416881106E6AF48CAE21F* L_0 = ___ctx0;
		NullCheck(L_0);
		Lexer_tDC14CFA7B390E884510F554D9D1E03188A185E27* L_1 = L_0->___L_2;
		NullCheck(L_1);
		bool L_2;
		L_2 = Lexer_GetChar_mB847D68CA0D5B450930406D4FBC986DA5C066FAA(L_1, NULL);
		// switch (ctx.L.input_char) {
		FsmContext_tC11B461D4D90680FC71416881106E6AF48CAE21F* L_3 = ___ctx0;
		NullCheck(L_3);
		Lexer_tDC14CFA7B390E884510F554D9D1E03188A185E27* L_4 = L_3->___L_2;
		NullCheck(L_4);
		int32_t L_5 = L_4->___input_char_7;
		V_0 = L_5;
		int32_t L_6 = V_0;
		if ((((int32_t)L_6) > ((int32_t)((int32_t)92))))
		{
			goto IL_003a;
		}
	}
	{
		int32_t L_7 = V_0;
		if ((((int32_t)L_7) > ((int32_t)((int32_t)39))))
		{
			goto IL_002e;
		}
	}
	{
		int32_t L_8 = V_0;
		if ((((int32_t)L_8) == ((int32_t)((int32_t)34))))
		{
			goto IL_0075;
		}
	}
	{
		int32_t L_9 = V_0;
		if ((((int32_t)L_9) == ((int32_t)((int32_t)39))))
		{
			goto IL_0075;
		}
	}
	{
		goto IL_00a4;
	}

IL_002e:
	{
		int32_t L_10 = V_0;
		if ((((int32_t)L_10) == ((int32_t)((int32_t)47))))
		{
			goto IL_0075;
		}
	}
	{
		int32_t L_11 = V_0;
		if ((((int32_t)L_11) == ((int32_t)((int32_t)92))))
		{
			goto IL_0075;
		}
	}
	{
		goto IL_00a4;
	}

IL_003a:
	{
		int32_t L_12 = V_0;
		if ((((int32_t)L_12) > ((int32_t)((int32_t)102))))
		{
			goto IL_004b;
		}
	}
	{
		int32_t L_13 = V_0;
		if ((((int32_t)L_13) == ((int32_t)((int32_t)98))))
		{
			goto IL_0075;
		}
	}
	{
		int32_t L_14 = V_0;
		if ((((int32_t)L_14) == ((int32_t)((int32_t)102))))
		{
			goto IL_0075;
		}
	}
	{
		goto IL_00a4;
	}

IL_004b:
	{
		int32_t L_15 = V_0;
		if ((((int32_t)L_15) == ((int32_t)((int32_t)110))))
		{
			goto IL_0075;
		}
	}
	{
		int32_t L_16 = V_0;
		switch (((int32_t)il2cpp_codegen_subtract(L_16, ((int32_t)114))))
		{
			case 0:
			{
				goto IL_0075;
			}
			case 1:
			{
				goto IL_00a4;
			}
			case 2:
			{
				goto IL_0075;
			}
			case 3:
			{
				goto IL_006b;
			}
		}
	}
	{
		goto IL_00a4;
	}

IL_006b:
	{
		// ctx.NextState = 22;
		FsmContext_tC11B461D4D90680FC71416881106E6AF48CAE21F* L_17 = ___ctx0;
		NullCheck(L_17);
		L_17->___NextState_1 = ((int32_t)22);
		// return true;
		return (bool)1;
	}

IL_0075:
	{
		// ctx.L.string_buffer.Append (
		//     ProcessEscChar (ctx.L.input_char));
		FsmContext_tC11B461D4D90680FC71416881106E6AF48CAE21F* L_18 = ___ctx0;
		NullCheck(L_18);
		Lexer_tDC14CFA7B390E884510F554D9D1E03188A185E27* L_19 = L_18->___L_2;
		NullCheck(L_19);
		StringBuilder_t* L_20 = L_19->___string_buffer_10;
		FsmContext_tC11B461D4D90680FC71416881106E6AF48CAE21F* L_21 = ___ctx0;
		NullCheck(L_21);
		Lexer_tDC14CFA7B390E884510F554D9D1E03188A185E27* L_22 = L_21->___L_2;
		NullCheck(L_22);
		int32_t L_23 = L_22->___input_char_7;
		il2cpp_codegen_runtime_class_init_inline(Lexer_tDC14CFA7B390E884510F554D9D1E03188A185E27_il2cpp_TypeInfo_var);
		Il2CppChar L_24;
		L_24 = Lexer_ProcessEscChar_m0E97C7D9F98BBEF906B17B4EDB0B93CA2B0BC11D(L_23, NULL);
		NullCheck(L_20);
		StringBuilder_t* L_25;
		L_25 = StringBuilder_Append_m71228B30F05724CD2CD96D9611DCD61BFB96A6E1(L_20, L_24, NULL);
		// ctx.NextState = ctx.StateStack;
		FsmContext_tC11B461D4D90680FC71416881106E6AF48CAE21F* L_26 = ___ctx0;
		FsmContext_tC11B461D4D90680FC71416881106E6AF48CAE21F* L_27 = ___ctx0;
		NullCheck(L_27);
		int32_t L_28 = L_27->___StateStack_3;
		NullCheck(L_26);
		L_26->___NextState_1 = L_28;
		// return true;
		return (bool)1;
	}

IL_00a4:
	{
		// return false;
		return (bool)0;
	}
}
// System.Boolean Agora.Rtc.LitJson.Lexer::State22(Agora.Rtc.LitJson.FsmContext)
IL2CPP_EXTERN_C IL2CPP_METHOD_ATTR bool Lexer_State22_mA8F75DBBADDA9897FF5A4FC0618085644BC527F9 (FsmContext_tC11B461D4D90680FC71416881106E6AF48CAE21F* ___ctx0, const RuntimeMethod* method) 
{
	static bool s_Il2CppMethodInitialized;
	if (!s_Il2CppMethodInitialized)
	{
		il2cpp_codegen_initialize_runtime_metadata((uintptr_t*)&Convert_t7097FF336D592F7C06D88A98349A44646F91EFFC_il2cpp_TypeInfo_var);
		il2cpp_codegen_initialize_runtime_metadata((uintptr_t*)&Lexer_tDC14CFA7B390E884510F554D9D1E03188A185E27_il2cpp_TypeInfo_var);
		s_Il2CppMethodInitialized = true;
	}
	int32_t V_0 = 0;
	int32_t V_1 = 0;
	{
		// int counter = 0;
		V_0 = 0;
		// int mult    = 4096;
		V_1 = ((int32_t)4096);
		// ctx.L.unichar = 0;
		FsmContext_tC11B461D4D90680FC71416881106E6AF48CAE21F* L_0 = ___ctx0;
		NullCheck(L_0);
		Lexer_tDC14CFA7B390E884510F554D9D1E03188A185E27* L_1 = L_0->___L_2;
		NullCheck(L_1);
		L_1->___unichar_13 = 0;
		goto IL_00d5;
	}

IL_0019:
	{
		// if (ctx.L.input_char >= '0' && ctx.L.input_char <= '9' ||
		//     ctx.L.input_char >= 'A' && ctx.L.input_char <= 'F' ||
		//     ctx.L.input_char >= 'a' && ctx.L.input_char <= 'f') {
		FsmContext_tC11B461D4D90680FC71416881106E6AF48CAE21F* L_2 = ___ctx0;
		NullCheck(L_2);
		Lexer_tDC14CFA7B390E884510F554D9D1E03188A185E27* L_3 = L_2->___L_2;
		NullCheck(L_3);
		int32_t L_4 = L_3->___input_char_7;
		if ((((int32_t)L_4) < ((int32_t)((int32_t)48))))
		{
			goto IL_0037;
		}
	}
	{
		FsmContext_tC11B461D4D90680FC71416881106E6AF48CAE21F* L_5 = ___ctx0;
		NullCheck(L_5);
		Lexer_tDC14CFA7B390E884510F554D9D1E03188A185E27* L_6 = L_5->___L_2;
		NullCheck(L_6);
		int32_t L_7 = L_6->___input_char_7;
		if ((((int32_t)L_7) <= ((int32_t)((int32_t)57))))
		{
			goto IL_0073;
		}
	}

IL_0037:
	{
		FsmContext_tC11B461D4D90680FC71416881106E6AF48CAE21F* L_8 = ___ctx0;
		NullCheck(L_8);
		Lexer_tDC14CFA7B390E884510F554D9D1E03188A185E27* L_9 = L_8->___L_2;
		NullCheck(L_9);
		int32_t L_10 = L_9->___input_char_7;
		if ((((int32_t)L_10) < ((int32_t)((int32_t)65))))
		{
			goto IL_0055;
		}
	}
	{
		FsmContext_tC11B461D4D90680FC71416881106E6AF48CAE21F* L_11 = ___ctx0;
		NullCheck(L_11);
		Lexer_tDC14CFA7B390E884510F554D9D1E03188A185E27* L_12 = L_11->___L_2;
		NullCheck(L_12);
		int32_t L_13 = L_12->___input_char_7;
		if ((((int32_t)L_13) <= ((int32_t)((int32_t)70))))
		{
			goto IL_0073;
		}
	}

IL_0055:
	{
		FsmContext_tC11B461D4D90680FC71416881106E6AF48CAE21F* L_14 = ___ctx0;
		NullCheck(L_14);
		Lexer_tDC14CFA7B390E884510F554D9D1E03188A185E27* L_15 = L_14->___L_2;
		NullCheck(L_15);
		int32_t L_16 = L_15->___input_char_7;
		if ((((int32_t)L_16) < ((int32_t)((int32_t)97))))
		{
			goto IL_00d3;
		}
	}
	{
		FsmContext_tC11B461D4D90680FC71416881106E6AF48CAE21F* L_17 = ___ctx0;
		NullCheck(L_17);
		Lexer_tDC14CFA7B390E884510F554D9D1E03188A185E27* L_18 = L_17->___L_2;
		NullCheck(L_18);
		int32_t L_19 = L_18->___input_char_7;
		if ((((int32_t)L_19) > ((int32_t)((int32_t)102))))
		{
			goto IL_00d3;
		}
	}

IL_0073:
	{
		// ctx.L.unichar += HexValue (ctx.L.input_char) * mult;
		FsmContext_tC11B461D4D90680FC71416881106E6AF48CAE21F* L_20 = ___ctx0;
		NullCheck(L_20);
		Lexer_tDC14CFA7B390E884510F554D9D1E03188A185E27* L_21 = L_20->___L_2;
		Lexer_tDC14CFA7B390E884510F554D9D1E03188A185E27* L_22 = L_21;
		NullCheck(L_22);
		int32_t L_23 = L_22->___unichar_13;
		FsmContext_tC11B461D4D90680FC71416881106E6AF48CAE21F* L_24 = ___ctx0;
		NullCheck(L_24);
		Lexer_tDC14CFA7B390E884510F554D9D1E03188A185E27* L_25 = L_24->___L_2;
		NullCheck(L_25);
		int32_t L_26 = L_25->___input_char_7;
		il2cpp_codegen_runtime_class_init_inline(Lexer_tDC14CFA7B390E884510F554D9D1E03188A185E27_il2cpp_TypeInfo_var);
		int32_t L_27;
		L_27 = Lexer_HexValue_mEC657936A38EA8E89F28359F9F244E906F637D1B(L_26, NULL);
		int32_t L_28 = V_1;
		NullCheck(L_22);
		L_22->___unichar_13 = ((int32_t)il2cpp_codegen_add(L_23, ((int32_t)il2cpp_codegen_multiply(L_27, L_28))));
		// counter++;
		int32_t L_29 = V_0;
		V_0 = ((int32_t)il2cpp_codegen_add(L_29, 1));
		// mult /= 16;
		int32_t L_30 = V_1;
		V_1 = ((int32_t)(L_30/((int32_t)16)));
		// if (counter == 4) {
		int32_t L_31 = V_0;
		if ((!(((uint32_t)L_31) == ((uint32_t)4))))
		{
			goto IL_00d5;
		}
	}
	{
		// ctx.L.string_buffer.Append (
		//     Convert.ToChar (ctx.L.unichar));
		FsmContext_tC11B461D4D90680FC71416881106E6AF48CAE21F* L_32 = ___ctx0;
		NullCheck(L_32);
		Lexer_tDC14CFA7B390E884510F554D9D1E03188A185E27* L_33 = L_32->___L_2;
		NullCheck(L_33);
		StringBuilder_t* L_34 = L_33->___string_buffer_10;
		FsmContext_tC11B461D4D90680FC71416881106E6AF48CAE21F* L_35 = ___ctx0;
		NullCheck(L_35);
		Lexer_tDC14CFA7B390E884510F554D9D1E03188A185E27* L_36 = L_35->___L_2;
		NullCheck(L_36);
		int32_t L_37 = L_36->___unichar_13;
		il2cpp_codegen_runtime_class_init_inline(Convert_t7097FF336D592F7C06D88A98349A44646F91EFFC_il2cpp_TypeInfo_var);
		Il2CppChar L_38;
		L_38 = Convert_ToChar_mF1B1B205DDEFDE52251235514E7DAFCAB37D1F24(L_37, NULL);
		NullCheck(L_34);
		StringBuilder_t* L_39;
		L_39 = StringBuilder_Append_m71228B30F05724CD2CD96D9611DCD61BFB96A6E1(L_34, L_38, NULL);
		// ctx.NextState = ctx.StateStack;
		FsmContext_tC11B461D4D90680FC71416881106E6AF48CAE21F* L_40 = ___ctx0;
		FsmContext_tC11B461D4D90680FC71416881106E6AF48CAE21F* L_41 = ___ctx0;
		NullCheck(L_41);
		int32_t L_42 = L_41->___StateStack_3;
		NullCheck(L_40);
		L_40->___NextState_1 = L_42;
		// return true;
		return (bool)1;
	}

IL_00d3:
	{
		// return false;
		return (bool)0;
	}

IL_00d5:
	{
		// while (ctx.L.GetChar ()) {
		FsmContext_tC11B461D4D90680FC71416881106E6AF48CAE21F* L_43 = ___ctx0;
		NullCheck(L_43);
		Lexer_tDC14CFA7B390E884510F554D9D1E03188A185E27* L_44 = L_43->___L_2;
		NullCheck(L_44);
		bool L_45;
		L_45 = Lexer_GetChar_mB847D68CA0D5B450930406D4FBC986DA5C066FAA(L_44, NULL);
		if (L_45)
		{
			goto IL_0019;
		}
	}
	{
		// return true;
		return (bool)1;
	}
}
// System.Boolean Agora.Rtc.LitJson.Lexer::State23(Agora.Rtc.LitJson.FsmContext)
IL2CPP_EXTERN_C IL2CPP_METHOD_ATTR bool Lexer_State23_m40E6D1E13EEAE247AA7A182A25CDB3251ED54DC4 (FsmContext_tC11B461D4D90680FC71416881106E6AF48CAE21F* ___ctx0, const RuntimeMethod* method) 
{
	int32_t V_0 = 0;
	{
		goto IL_0065;
	}

IL_0002:
	{
		// switch (ctx.L.input_char) {
		FsmContext_tC11B461D4D90680FC71416881106E6AF48CAE21F* L_0 = ___ctx0;
		NullCheck(L_0);
		Lexer_tDC14CFA7B390E884510F554D9D1E03188A185E27* L_1 = L_0->___L_2;
		NullCheck(L_1);
		int32_t L_2 = L_1->___input_char_7;
		V_0 = L_2;
		int32_t L_3 = V_0;
		if ((((int32_t)L_3) == ((int32_t)((int32_t)39))))
		{
			goto IL_001a;
		}
	}
	{
		int32_t L_4 = V_0;
		if ((((int32_t)L_4) == ((int32_t)((int32_t)92))))
		{
			goto IL_0036;
		}
	}
	{
		goto IL_0048;
	}

IL_001a:
	{
		// ctx.L.UngetChar ();
		FsmContext_tC11B461D4D90680FC71416881106E6AF48CAE21F* L_5 = ___ctx0;
		NullCheck(L_5);
		Lexer_tDC14CFA7B390E884510F554D9D1E03188A185E27* L_6 = L_5->___L_2;
		NullCheck(L_6);
		Lexer_UngetChar_m46FD110F88E00E60F9E296833913BC84AD8C7BA7(L_6, NULL);
		// ctx.Return = true;
		FsmContext_tC11B461D4D90680FC71416881106E6AF48CAE21F* L_7 = ___ctx0;
		NullCheck(L_7);
		L_7->___Return_0 = (bool)1;
		// ctx.NextState = 24;
		FsmContext_tC11B461D4D90680FC71416881106E6AF48CAE21F* L_8 = ___ctx0;
		NullCheck(L_8);
		L_8->___NextState_1 = ((int32_t)24);
		// return true;
		return (bool)1;
	}

IL_0036:
	{
		// ctx.StateStack = 23;
		FsmContext_tC11B461D4D90680FC71416881106E6AF48CAE21F* L_9 = ___ctx0;
		NullCheck(L_9);
		L_9->___StateStack_3 = ((int32_t)23);
		// ctx.NextState = 21;
		FsmContext_tC11B461D4D90680FC71416881106E6AF48CAE21F* L_10 = ___ctx0;
		NullCheck(L_10);
		L_10->___NextState_1 = ((int32_t)21);
		// return true;
		return (bool)1;
	}

IL_0048:
	{
		// ctx.L.string_buffer.Append ((char) ctx.L.input_char);
		FsmContext_tC11B461D4D90680FC71416881106E6AF48CAE21F* L_11 = ___ctx0;
		NullCheck(L_11);
		Lexer_tDC14CFA7B390E884510F554D9D1E03188A185E27* L_12 = L_11->___L_2;
		NullCheck(L_12);
		StringBuilder_t* L_13 = L_12->___string_buffer_10;
		FsmContext_tC11B461D4D90680FC71416881106E6AF48CAE21F* L_14 = ___ctx0;
		NullCheck(L_14);
		Lexer_tDC14CFA7B390E884510F554D9D1E03188A185E27* L_15 = L_14->___L_2;
		NullCheck(L_15);
		int32_t L_16 = L_15->___input_char_7;
		NullCheck(L_13);
		StringBuilder_t* L_17;
		L_17 = StringBuilder_Append_m71228B30F05724CD2CD96D9611DCD61BFB96A6E1(L_13, ((int32_t)(uint16_t)L_16), NULL);
	}

IL_0065:
	{
		// while (ctx.L.GetChar ()) {
		FsmContext_tC11B461D4D90680FC71416881106E6AF48CAE21F* L_18 = ___ctx0;
		NullCheck(L_18);
		Lexer_tDC14CFA7B390E884510F554D9D1E03188A185E27* L_19 = L_18->___L_2;
		NullCheck(L_19);
		bool L_20;
		L_20 = Lexer_GetChar_mB847D68CA0D5B450930406D4FBC986DA5C066FAA(L_19, NULL);
		if (L_20)
		{
			goto IL_0002;
		}
	}
	{
		// return true;
		return (bool)1;
	}
}
// System.Boolean Agora.Rtc.LitJson.Lexer::State24(Agora.Rtc.LitJson.FsmContext)
IL2CPP_EXTERN_C IL2CPP_METHOD_ATTR bool Lexer_State24_mF032D4CC3EC466A9348FAD9C1054FD29C7214A44 (FsmContext_tC11B461D4D90680FC71416881106E6AF48CAE21F* ___ctx0, const RuntimeMethod* method) 
{
	{
		// ctx.L.GetChar ();
		FsmContext_tC11B461D4D90680FC71416881106E6AF48CAE21F* L_0 = ___ctx0;
		NullCheck(L_0);
		Lexer_tDC14CFA7B390E884510F554D9D1E03188A185E27* L_1 = L_0->___L_2;
		NullCheck(L_1);
		bool L_2;
		L_2 = Lexer_GetChar_mB847D68CA0D5B450930406D4FBC986DA5C066FAA(L_1, NULL);
		// switch (ctx.L.input_char) {
		FsmContext_tC11B461D4D90680FC71416881106E6AF48CAE21F* L_3 = ___ctx0;
		NullCheck(L_3);
		Lexer_tDC14CFA7B390E884510F554D9D1E03188A185E27* L_4 = L_3->___L_2;
		NullCheck(L_4);
		int32_t L_5 = L_4->___input_char_7;
		if ((!(((uint32_t)L_5) == ((uint32_t)((int32_t)39)))))
		{
			goto IL_0038;
		}
	}
	{
		// ctx.L.input_char = '"';
		FsmContext_tC11B461D4D90680FC71416881106E6AF48CAE21F* L_6 = ___ctx0;
		NullCheck(L_6);
		Lexer_tDC14CFA7B390E884510F554D9D1E03188A185E27* L_7 = L_6->___L_2;
		NullCheck(L_7);
		L_7->___input_char_7 = ((int32_t)34);
		// ctx.Return = true;
		FsmContext_tC11B461D4D90680FC71416881106E6AF48CAE21F* L_8 = ___ctx0;
		NullCheck(L_8);
		L_8->___Return_0 = (bool)1;
		// ctx.NextState = 1;
		FsmContext_tC11B461D4D90680FC71416881106E6AF48CAE21F* L_9 = ___ctx0;
		NullCheck(L_9);
		L_9->___NextState_1 = 1;
		// return true;
		return (bool)1;
	}

IL_0038:
	{
		// return false;
		return (bool)0;
	}
}
// System.Boolean Agora.Rtc.LitJson.Lexer::State25(Agora.Rtc.LitJson.FsmContext)
IL2CPP_EXTERN_C IL2CPP_METHOD_ATTR bool Lexer_State25_mFF34556A9AC7D3134B061F186784E9D14D749CB2 (FsmContext_tC11B461D4D90680FC71416881106E6AF48CAE21F* ___ctx0, const RuntimeMethod* method) 
{
	int32_t V_0 = 0;
	{
		// ctx.L.GetChar ();
		FsmContext_tC11B461D4D90680FC71416881106E6AF48CAE21F* L_0 = ___ctx0;
		NullCheck(L_0);
		Lexer_tDC14CFA7B390E884510F554D9D1E03188A185E27* L_1 = L_0->___L_2;
		NullCheck(L_1);
		bool L_2;
		L_2 = Lexer_GetChar_mB847D68CA0D5B450930406D4FBC986DA5C066FAA(L_1, NULL);
		// switch (ctx.L.input_char) {
		FsmContext_tC11B461D4D90680FC71416881106E6AF48CAE21F* L_3 = ___ctx0;
		NullCheck(L_3);
		Lexer_tDC14CFA7B390E884510F554D9D1E03188A185E27* L_4 = L_3->___L_2;
		NullCheck(L_4);
		int32_t L_5 = L_4->___input_char_7;
		V_0 = L_5;
		int32_t L_6 = V_0;
		if ((((int32_t)L_6) == ((int32_t)((int32_t)42))))
		{
			goto IL_0024;
		}
	}
	{
		int32_t L_7 = V_0;
		if ((((int32_t)L_7) == ((int32_t)((int32_t)47))))
		{
			goto IL_002e;
		}
	}
	{
		goto IL_0038;
	}

IL_0024:
	{
		// ctx.NextState = 27;
		FsmContext_tC11B461D4D90680FC71416881106E6AF48CAE21F* L_8 = ___ctx0;
		NullCheck(L_8);
		L_8->___NextState_1 = ((int32_t)27);
		// return true;
		return (bool)1;
	}

IL_002e:
	{
		// ctx.NextState = 26;
		FsmContext_tC11B461D4D90680FC71416881106E6AF48CAE21F* L_9 = ___ctx0;
		NullCheck(L_9);
		L_9->___NextState_1 = ((int32_t)26);
		// return true;
		return (bool)1;
	}

IL_0038:
	{
		// return false;
		return (bool)0;
	}
}
// System.Boolean Agora.Rtc.LitJson.Lexer::State26(Agora.Rtc.LitJson.FsmContext)
IL2CPP_EXTERN_C IL2CPP_METHOD_ATTR bool Lexer_State26_mD4B202B505D9D18BB02A00E78A066B94C3FF041A (FsmContext_tC11B461D4D90680FC71416881106E6AF48CAE21F* ___ctx0, const RuntimeMethod* method) 
{
	{
		goto IL_001a;
	}

IL_0002:
	{
		// if (ctx.L.input_char == '\n') {
		FsmContext_tC11B461D4D90680FC71416881106E6AF48CAE21F* L_0 = ___ctx0;
		NullCheck(L_0);
		Lexer_tDC14CFA7B390E884510F554D9D1E03188A185E27* L_1 = L_0->___L_2;
		NullCheck(L_1);
		int32_t L_2 = L_1->___input_char_7;
		if ((!(((uint32_t)L_2) == ((uint32_t)((int32_t)10)))))
		{
			goto IL_001a;
		}
	}
	{
		// ctx.NextState = 1;
		FsmContext_tC11B461D4D90680FC71416881106E6AF48CAE21F* L_3 = ___ctx0;
		NullCheck(L_3);
		L_3->___NextState_1 = 1;
		// return true;
		return (bool)1;
	}

IL_001a:
	{
		// while (ctx.L.GetChar ()) {
		FsmContext_tC11B461D4D90680FC71416881106E6AF48CAE21F* L_4 = ___ctx0;
		NullCheck(L_4);
		Lexer_tDC14CFA7B390E884510F554D9D1E03188A185E27* L_5 = L_4->___L_2;
		NullCheck(L_5);
		bool L_6;
		L_6 = Lexer_GetChar_mB847D68CA0D5B450930406D4FBC986DA5C066FAA(L_5, NULL);
		if (L_6)
		{
			goto IL_0002;
		}
	}
	{
		// return true;
		return (bool)1;
	}
}
// System.Boolean Agora.Rtc.LitJson.Lexer::State27(Agora.Rtc.LitJson.FsmContext)
IL2CPP_EXTERN_C IL2CPP_METHOD_ATTR bool Lexer_State27_m7A8DB0C14046DC8E864B145D58075823088F7DCC (FsmContext_tC11B461D4D90680FC71416881106E6AF48CAE21F* ___ctx0, const RuntimeMethod* method) 
{
	{
		goto IL_001b;
	}

IL_0002:
	{
		// if (ctx.L.input_char == '*') {
		FsmContext_tC11B461D4D90680FC71416881106E6AF48CAE21F* L_0 = ___ctx0;
		NullCheck(L_0);
		Lexer_tDC14CFA7B390E884510F554D9D1E03188A185E27* L_1 = L_0->___L_2;
		NullCheck(L_1);
		int32_t L_2 = L_1->___input_char_7;
		if ((!(((uint32_t)L_2) == ((uint32_t)((int32_t)42)))))
		{
			goto IL_001b;
		}
	}
	{
		// ctx.NextState = 28;
		FsmContext_tC11B461D4D90680FC71416881106E6AF48CAE21F* L_3 = ___ctx0;
		NullCheck(L_3);
		L_3->___NextState_1 = ((int32_t)28);
		// return true;
		return (bool)1;
	}

IL_001b:
	{
		// while (ctx.L.GetChar ()) {
		FsmContext_tC11B461D4D90680FC71416881106E6AF48CAE21F* L_4 = ___ctx0;
		NullCheck(L_4);
		Lexer_tDC14CFA7B390E884510F554D9D1E03188A185E27* L_5 = L_4->___L_2;
		NullCheck(L_5);
		bool L_6;
		L_6 = Lexer_GetChar_mB847D68CA0D5B450930406D4FBC986DA5C066FAA(L_5, NULL);
		if (L_6)
		{
			goto IL_0002;
		}
	}
	{
		// return true;
		return (bool)1;
	}
}
// System.Boolean Agora.Rtc.LitJson.Lexer::State28(Agora.Rtc.LitJson.FsmContext)
IL2CPP_EXTERN_C IL2CPP_METHOD_ATTR bool Lexer_State28_mE35361243292AE3F746EA665EE51E35AD2F71D58 (FsmContext_tC11B461D4D90680FC71416881106E6AF48CAE21F* ___ctx0, const RuntimeMethod* method) 
{
	{
		goto IL_0033;
	}

IL_0002:
	{
		// if (ctx.L.input_char == '*')
		FsmContext_tC11B461D4D90680FC71416881106E6AF48CAE21F* L_0 = ___ctx0;
		NullCheck(L_0);
		Lexer_tDC14CFA7B390E884510F554D9D1E03188A185E27* L_1 = L_0->___L_2;
		NullCheck(L_1);
		int32_t L_2 = L_1->___input_char_7;
		if ((((int32_t)L_2) == ((int32_t)((int32_t)42))))
		{
			goto IL_0033;
		}
	}
	{
		// if (ctx.L.input_char == '/') {
		FsmContext_tC11B461D4D90680FC71416881106E6AF48CAE21F* L_3 = ___ctx0;
		NullCheck(L_3);
		Lexer_tDC14CFA7B390E884510F554D9D1E03188A185E27* L_4 = L_3->___L_2;
		NullCheck(L_4);
		int32_t L_5 = L_4->___input_char_7;
		if ((!(((uint32_t)L_5) == ((uint32_t)((int32_t)47)))))
		{
			goto IL_0029;
		}
	}
	{
		// ctx.NextState = 1;
		FsmContext_tC11B461D4D90680FC71416881106E6AF48CAE21F* L_6 = ___ctx0;
		NullCheck(L_6);
		L_6->___NextState_1 = 1;
		// return true;
		return (bool)1;
	}

IL_0029:
	{
		// ctx.NextState = 27;
		FsmContext_tC11B461D4D90680FC71416881106E6AF48CAE21F* L_7 = ___ctx0;
		NullCheck(L_7);
		L_7->___NextState_1 = ((int32_t)27);
		// return true;
		return (bool)1;
	}

IL_0033:
	{
		// while (ctx.L.GetChar ()) {
		FsmContext_tC11B461D4D90680FC71416881106E6AF48CAE21F* L_8 = ___ctx0;
		NullCheck(L_8);
		Lexer_tDC14CFA7B390E884510F554D9D1E03188A185E27* L_9 = L_8->___L_2;
		NullCheck(L_9);
		bool L_10;
		L_10 = Lexer_GetChar_mB847D68CA0D5B450930406D4FBC986DA5C066FAA(L_9, NULL);
		if (L_10)
		{
			goto IL_0002;
		}
	}
	{
		// return true;
		return (bool)1;
	}
}
// System.Boolean Agora.Rtc.LitJson.Lexer::GetChar()
IL2CPP_EXTERN_C IL2CPP_METHOD_ATTR bool Lexer_GetChar_mB847D68CA0D5B450930406D4FBC986DA5C066FAA (Lexer_tDC14CFA7B390E884510F554D9D1E03188A185E27* __this, const RuntimeMethod* method) 
{
	int32_t V_0 = 0;
	{
		// if ((input_char = NextChar ()) != -1)
		int32_t L_0;
		L_0 = Lexer_NextChar_m1CFDD13AAD5AAAB76EF810DBFED9DBA381B102BF(__this, NULL);
		int32_t L_1 = L_0;
		V_0 = L_1;
		__this->___input_char_7 = L_1;
		int32_t L_2 = V_0;
		if ((((int32_t)L_2) == ((int32_t)(-1))))
		{
			goto IL_0014;
		}
	}
	{
		// return true;
		return (bool)1;
	}

IL_0014:
	{
		// end_of_input = true;
		__this->___end_of_input_4 = (bool)1;
		// return false;
		return (bool)0;
	}
}
// System.Int32 Agora.Rtc.LitJson.Lexer::NextChar()
IL2CPP_EXTERN_C IL2CPP_METHOD_ATTR int32_t Lexer_NextChar_m1CFDD13AAD5AAAB76EF810DBFED9DBA381B102BF (Lexer_tDC14CFA7B390E884510F554D9D1E03188A185E27* __this, const RuntimeMethod* method) 
{
	{
		// if (input_buffer != 0) {
		int32_t L_0 = __this->___input_buffer_6;
		if (!L_0)
		{
			goto IL_0016;
		}
	}
	{
		// int tmp = input_buffer;
		int32_t L_1 = __this->___input_buffer_6;
		// input_buffer = 0;
		__this->___input_buffer_6 = 0;
		// return tmp;
		return L_1;
	}

IL_0016:
	{
		// return reader.Read ();
		TextReader_tB8D43017CB6BE1633E5A86D64E7757366507C1F7* L_2 = __this->___reader_8;
		NullCheck(L_2);
		int32_t L_3;
		L_3 = VirtualFuncInvoker0< int32_t >::Invoke(10 /* System.Int32 System.IO.TextReader::Read() */, L_2);
		return L_3;
	}
}
// System.Boolean Agora.Rtc.LitJson.Lexer::NextToken()
IL2CPP_EXTERN_C IL2CPP_METHOD_ATTR bool Lexer_NextToken_mE34A5B2E9932497D86F3BCD0B7732A1454A2760E (Lexer_tDC14CFA7B390E884510F554D9D1E03188A185E27* __this, const RuntimeMethod* method) 
{
	static bool s_Il2CppMethodInitialized;
	if (!s_Il2CppMethodInitialized)
	{
		il2cpp_codegen_initialize_runtime_metadata((uintptr_t*)&Lexer_tDC14CFA7B390E884510F554D9D1E03188A185E27_il2cpp_TypeInfo_var);
		s_Il2CppMethodInitialized = true;
	}
	{
		// fsm_context.Return = false;
		FsmContext_tC11B461D4D90680FC71416881106E6AF48CAE21F* L_0 = __this->___fsm_context_5;
		NullCheck(L_0);
		L_0->___Return_0 = (bool)0;
	}

IL_000c:
	{
		// handler = fsm_handler_table[state - 1];
		il2cpp_codegen_runtime_class_init_inline(Lexer_tDC14CFA7B390E884510F554D9D1E03188A185E27_il2cpp_TypeInfo_var);
		StateHandlerU5BU5D_t766A22C9C454D383614ED21CB99EAD5F5F15438B* L_1 = ((Lexer_tDC14CFA7B390E884510F554D9D1E03188A185E27_StaticFields*)il2cpp_codegen_static_fields_for(Lexer_tDC14CFA7B390E884510F554D9D1E03188A185E27_il2cpp_TypeInfo_var))->___fsm_handler_table_1;
		int32_t L_2 = __this->___state_9;
		NullCheck(L_1);
		int32_t L_3 = ((int32_t)il2cpp_codegen_subtract(L_2, 1));
		StateHandler_t8EA5CD11BFA1A958F305A2A0134A0BBB631FAFCB* L_4 = (L_1)->GetAt(static_cast<il2cpp_array_size_t>(L_3));
		// if (! handler (fsm_context))
		FsmContext_tC11B461D4D90680FC71416881106E6AF48CAE21F* L_5 = __this->___fsm_context_5;
		NullCheck(L_4);
		bool L_6;
		L_6 = StateHandler_Invoke_m9CAA7FAB5C4F3F0EBCE63ECC8A3186D52B7FC97E_inline(L_4, L_5, NULL);
		if (L_6)
		{
			goto IL_0033;
		}
	}
	{
		// throw new JsonException (input_char);
		int32_t L_7 = __this->___input_char_7;
		JsonException_t3B214813E48AA5E19793F9026831120B5B2254A1* L_8 = (JsonException_t3B214813E48AA5E19793F9026831120B5B2254A1*)il2cpp_codegen_object_new(((RuntimeClass*)il2cpp_codegen_initialize_runtime_metadata_inline((uintptr_t*)&JsonException_t3B214813E48AA5E19793F9026831120B5B2254A1_il2cpp_TypeInfo_var)));
		NullCheck(L_8);
		JsonException__ctor_m30831B405CB7CE31F396F31A19E41B2F10FEE0D0(L_8, L_7, NULL);
		IL2CPP_RAISE_MANAGED_EXCEPTION(L_8, ((RuntimeMethod*)il2cpp_codegen_initialize_runtime_metadata_inline((uintptr_t*)&Lexer_NextToken_mE34A5B2E9932497D86F3BCD0B7732A1454A2760E_RuntimeMethod_var)));
	}

IL_0033:
	{
		// if (end_of_input)
		bool L_9 = __this->___end_of_input_4;
		if (!L_9)
		{
			goto IL_003d;
		}
	}
	{
		// return false;
		return (bool)0;
	}

IL_003d:
	{
		// if (fsm_context.Return) {
		FsmContext_tC11B461D4D90680FC71416881106E6AF48CAE21F* L_10 = __this->___fsm_context_5;
		NullCheck(L_10);
		bool L_11 = L_10->___Return_0;
		if (!L_11)
		{
			goto IL_00b3;
		}
	}
	{
		// string_value = string_buffer.ToString ();
		StringBuilder_t* L_12 = __this->___string_buffer_10;
		NullCheck(L_12);
		String_t* L_13;
		L_13 = VirtualFuncInvoker0< String_t* >::Invoke(3 /* System.String System.Object::ToString() */, L_12);
		__this->___string_value_11 = L_13;
		Il2CppCodeGenWriteBarrier((void**)(&__this->___string_value_11), (void*)L_13);
		// string_buffer.Remove (0, string_buffer.Length);
		StringBuilder_t* L_14 = __this->___string_buffer_10;
		StringBuilder_t* L_15 = __this->___string_buffer_10;
		NullCheck(L_15);
		int32_t L_16;
		L_16 = StringBuilder_get_Length_mDEA041E7357C68CC3B5885276BB403676DAAE0D8(L_15, NULL);
		NullCheck(L_14);
		StringBuilder_t* L_17;
		L_17 = StringBuilder_Remove_m0D93692674D1C09795C7D6542420A3B6C5F81E90(L_14, 0, L_16, NULL);
		// token = fsm_return_table[state - 1];
		il2cpp_codegen_runtime_class_init_inline(Lexer_tDC14CFA7B390E884510F554D9D1E03188A185E27_il2cpp_TypeInfo_var);
		Int32U5BU5D_t19C97395396A72ECAF310612F0760F165060314C* L_18 = ((Lexer_tDC14CFA7B390E884510F554D9D1E03188A185E27_StaticFields*)il2cpp_codegen_static_fields_for(Lexer_tDC14CFA7B390E884510F554D9D1E03188A185E27_il2cpp_TypeInfo_var))->___fsm_return_table_0;
		int32_t L_19 = __this->___state_9;
		NullCheck(L_18);
		int32_t L_20 = ((int32_t)il2cpp_codegen_subtract(L_19, 1));
		int32_t L_21 = (L_18)->GetAt(static_cast<il2cpp_array_size_t>(L_20));
		__this->___token_12 = L_21;
		// if (token == (int) ParserToken.Char)
		int32_t L_22 = __this->___token_12;
		if ((!(((uint32_t)L_22) == ((uint32_t)((int32_t)65542)))))
		{
			goto IL_00a0;
		}
	}
	{
		// token = input_char;
		int32_t L_23 = __this->___input_char_7;
		__this->___token_12 = L_23;
	}

IL_00a0:
	{
		// state = fsm_context.NextState;
		FsmContext_tC11B461D4D90680FC71416881106E6AF48CAE21F* L_24 = __this->___fsm_context_5;
		NullCheck(L_24);
		int32_t L_25 = L_24->___NextState_1;
		__this->___state_9 = L_25;
		// return true;
		return (bool)1;
	}

IL_00b3:
	{
		// state = fsm_context.NextState;
		FsmContext_tC11B461D4D90680FC71416881106E6AF48CAE21F* L_26 = __this->___fsm_context_5;
		NullCheck(L_26);
		int32_t L_27 = L_26->___NextState_1;
		__this->___state_9 = L_27;
		// while (true) {
		goto IL_000c;
	}
}
// System.Void Agora.Rtc.LitJson.Lexer::UngetChar()
IL2CPP_EXTERN_C IL2CPP_METHOD_ATTR void Lexer_UngetChar_m46FD110F88E00E60F9E296833913BC84AD8C7BA7 (Lexer_tDC14CFA7B390E884510F554D9D1E03188A185E27* __this, const RuntimeMethod* method) 
{
	{
		// input_buffer = input_char;
		int32_t L_0 = __this->___input_char_7;
		__this->___input_buffer_6 = L_0;
		// }
		return;
	}
}
#ifdef __clang__
#pragma clang diagnostic pop
#endif
#ifdef __clang__
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Winvalid-offsetof"
#pragma clang diagnostic ignored "-Wunused-variable"
#endif
bool StateHandler_Invoke_m9CAA7FAB5C4F3F0EBCE63ECC8A3186D52B7FC97E_Multicast(StateHandler_t8EA5CD11BFA1A958F305A2A0134A0BBB631FAFCB* __this, FsmContext_tC11B461D4D90680FC71416881106E6AF48CAE21F* ___ctx0, const RuntimeMethod* method)
{
	il2cpp_array_size_t length = __this->___delegates_13->max_length;
	Delegate_t** delegatesToInvoke = reinterpret_cast<Delegate_t**>(__this->___delegates_13->GetAddressAtUnchecked(0));
	bool retVal = false;
	for (il2cpp_array_size_t i = 0; i < length; i++)
	{
		StateHandler_t8EA5CD11BFA1A958F305A2A0134A0BBB631FAFCB* currentDelegate = reinterpret_cast<StateHandler_t8EA5CD11BFA1A958F305A2A0134A0BBB631FAFCB*>(delegatesToInvoke[i]);
		typedef bool (*FunctionPointerType) (RuntimeObject*, FsmContext_tC11B461D4D90680FC71416881106E6AF48CAE21F*, const RuntimeMethod*);
		retVal = ((FunctionPointerType)currentDelegate->___invoke_impl_1)((Il2CppObject*)currentDelegate->___method_code_6, ___ctx0, reinterpret_cast<RuntimeMethod*>(currentDelegate->___method_3));
	}
	return retVal;
}
bool StateHandler_Invoke_m9CAA7FAB5C4F3F0EBCE63ECC8A3186D52B7FC97E_OpenInst(StateHandler_t8EA5CD11BFA1A958F305A2A0134A0BBB631FAFCB* __this, FsmContext_tC11B461D4D90680FC71416881106E6AF48CAE21F* ___ctx0, const RuntimeMethod* method)
{
	NullCheck(___ctx0);
	typedef bool (*FunctionPointerType) (FsmContext_tC11B461D4D90680FC71416881106E6AF48CAE21F*, const RuntimeMethod*);
	return ((FunctionPointerType)__this->___method_ptr_0)(___ctx0, method);
}
bool StateHandler_Invoke_m9CAA7FAB5C4F3F0EBCE63ECC8A3186D52B7FC97E_OpenStatic(StateHandler_t8EA5CD11BFA1A958F305A2A0134A0BBB631FAFCB* __this, FsmContext_tC11B461D4D90680FC71416881106E6AF48CAE21F* ___ctx0, const RuntimeMethod* method)
{
	typedef bool (*FunctionPointerType) (FsmContext_tC11B461D4D90680FC71416881106E6AF48CAE21F*, const RuntimeMethod*);
	return ((FunctionPointerType)__this->___method_ptr_0)(___ctx0, method);
}
bool StateHandler_Invoke_m9CAA7FAB5C4F3F0EBCE63ECC8A3186D52B7FC97E_OpenStaticInvoker(StateHandler_t8EA5CD11BFA1A958F305A2A0134A0BBB631FAFCB* __this, FsmContext_tC11B461D4D90680FC71416881106E6AF48CAE21F* ___ctx0, const RuntimeMethod* method)
{
	return InvokerFuncInvoker1< bool, FsmContext_tC11B461D4D90680FC71416881106E6AF48CAE21F* >::Invoke(__this->___method_ptr_0, method, NULL, ___ctx0);
}
bool StateHandler_Invoke_m9CAA7FAB5C4F3F0EBCE63ECC8A3186D52B7FC97E_ClosedStaticInvoker(StateHandler_t8EA5CD11BFA1A958F305A2A0134A0BBB631FAFCB* __this, FsmContext_tC11B461D4D90680FC71416881106E6AF48CAE21F* ___ctx0, const RuntimeMethod* method)
{
	return InvokerFuncInvoker2< bool, RuntimeObject*, FsmContext_tC11B461D4D90680FC71416881106E6AF48CAE21F* >::Invoke(__this->___method_ptr_0, method, NULL, __this->___m_target_2, ___ctx0);
}
bool StateHandler_Invoke_m9CAA7FAB5C4F3F0EBCE63ECC8A3186D52B7FC97E_OpenVirtual(StateHandler_t8EA5CD11BFA1A958F305A2A0134A0BBB631FAFCB* __this, FsmContext_tC11B461D4D90680FC71416881106E6AF48CAE21F* ___ctx0, const RuntimeMethod* method)
{
	NullCheck(___ctx0);
	return VirtualFuncInvoker0< bool >::Invoke(il2cpp_codegen_method_get_slot(method), ___ctx0);
}
bool StateHandler_Invoke_m9CAA7FAB5C4F3F0EBCE63ECC8A3186D52B7FC97E_OpenInterface(StateHandler_t8EA5CD11BFA1A958F305A2A0134A0BBB631FAFCB* __this, FsmContext_tC11B461D4D90680FC71416881106E6AF48CAE21F* ___ctx0, const RuntimeMethod* method)
{
	NullCheck(___ctx0);
	return InterfaceFuncInvoker0< bool >::Invoke(il2cpp_codegen_method_get_slot(method), il2cpp_codegen_method_get_declaring_type(method), ___ctx0);
}
bool StateHandler_Invoke_m9CAA7FAB5C4F3F0EBCE63ECC8A3186D52B7FC97E_OpenGenericVirtual(StateHandler_t8EA5CD11BFA1A958F305A2A0134A0BBB631FAFCB* __this, FsmContext_tC11B461D4D90680FC71416881106E6AF48CAE21F* ___ctx0, const RuntimeMethod* method)
{
	NullCheck(___ctx0);
	return GenericVirtualFuncInvoker0< bool >::Invoke(method, ___ctx0);
}
bool StateHandler_Invoke_m9CAA7FAB5C4F3F0EBCE63ECC8A3186D52B7FC97E_OpenGenericInterface(StateHandler_t8EA5CD11BFA1A958F305A2A0134A0BBB631FAFCB* __this, FsmContext_tC11B461D4D90680FC71416881106E6AF48CAE21F* ___ctx0, const RuntimeMethod* method)
{
	NullCheck(___ctx0);
	return GenericInterfaceFuncInvoker0< bool >::Invoke(method, ___ctx0);
}
// System.Void Agora.Rtc.LitJson.Lexer/StateHandler::.ctor(System.Object,System.IntPtr)
IL2CPP_EXTERN_C IL2CPP_METHOD_ATTR void StateHandler__ctor_m7B636AFF08A3049222D6F82BF87AFF9012CE69D2 (StateHandler_t8EA5CD11BFA1A958F305A2A0134A0BBB631FAFCB* __this, RuntimeObject* ___object0, intptr_t ___method1, const RuntimeMethod* method) 
{
	__this->___method_ptr_0 = il2cpp_codegen_get_virtual_call_method_pointer((RuntimeMethod*)___method1);
	__this->___method_3 = ___method1;
	__this->___m_target_2 = ___object0;
	Il2CppCodeGenWriteBarrier((void**)(&__this->___m_target_2), (void*)___object0);
	int parameterCount = il2cpp_codegen_method_parameter_count((RuntimeMethod*)___method1);
	__this->___method_code_6 = (intptr_t)__this;
	if (MethodIsStatic((RuntimeMethod*)___method1))
	{
		bool isOpen = parameterCount == 1;
		if (il2cpp_codegen_call_method_via_invoker((RuntimeMethod*)___method1))
			if (isOpen)
				__this->___invoke_impl_1 = (intptr_t)&StateHandler_Invoke_m9CAA7FAB5C4F3F0EBCE63ECC8A3186D52B7FC97E_OpenStaticInvoker;
			else
				__this->___invoke_impl_1 = (intptr_t)&StateHandler_Invoke_m9CAA7FAB5C4F3F0EBCE63ECC8A3186D52B7FC97E_ClosedStaticInvoker;
		else
			if (isOpen)
				__this->___invoke_impl_1 = (intptr_t)&StateHandler_Invoke_m9CAA7FAB5C4F3F0EBCE63ECC8A3186D52B7FC97E_OpenStatic;
			else
				{
					__this->___invoke_impl_1 = (intptr_t)__this->___method_ptr_0;
					__this->___method_code_6 = (intptr_t)__this->___m_target_2;
				}
	}
	else
	{
		bool isOpen = parameterCount == 0;
		if (isOpen)
		{
			if (__this->___method_is_virtual_12)
			{
				if (il2cpp_codegen_method_is_generic_instance_method((RuntimeMethod*)___method1))
					if (il2cpp_codegen_method_is_interface_method((RuntimeMethod*)___method1))
						__this->___invoke_impl_1 = (intptr_t)&StateHandler_Invoke_m9CAA7FAB5C4F3F0EBCE63ECC8A3186D52B7FC97E_OpenGenericInterface;
					else
						__this->___invoke_impl_1 = (intptr_t)&StateHandler_Invoke_m9CAA7FAB5C4F3F0EBCE63ECC8A3186D52B7FC97E_OpenGenericVirtual;
				else
					if (il2cpp_codegen_method_is_interface_method((RuntimeMethod*)___method1))
						__this->___invoke_impl_1 = (intptr_t)&StateHandler_Invoke_m9CAA7FAB5C4F3F0EBCE63ECC8A3186D52B7FC97E_OpenInterface;
					else
						__this->___invoke_impl_1 = (intptr_t)&StateHandler_Invoke_m9CAA7FAB5C4F3F0EBCE63ECC8A3186D52B7FC97E_OpenVirtual;
			}
			else
			{
				__this->___invoke_impl_1 = (intptr_t)&StateHandler_Invoke_m9CAA7FAB5C4F3F0EBCE63ECC8A3186D52B7FC97E_OpenInst;
			}
		}
		else
		{
			if (___object0 == NULL)
				il2cpp_codegen_raise_exception(il2cpp_codegen_get_argument_exception(NULL, "Delegate to an instance method cannot have null 'this'."), NULL);
			__this->___invoke_impl_1 = (intptr_t)__this->___method_ptr_0;
			__this->___method_code_6 = (intptr_t)__this->___m_target_2;
		}
	}
	__this->___extra_arg_5 = (intptr_t)&StateHandler_Invoke_m9CAA7FAB5C4F3F0EBCE63ECC8A3186D52B7FC97E_Multicast;
}
// System.Boolean Agora.Rtc.LitJson.Lexer/StateHandler::Invoke(Agora.Rtc.LitJson.FsmContext)
IL2CPP_EXTERN_C IL2CPP_METHOD_ATTR bool StateHandler_Invoke_m9CAA7FAB5C4F3F0EBCE63ECC8A3186D52B7FC97E (StateHandler_t8EA5CD11BFA1A958F305A2A0134A0BBB631FAFCB* __this, FsmContext_tC11B461D4D90680FC71416881106E6AF48CAE21F* ___ctx0, const RuntimeMethod* method) 
{
	typedef bool (*FunctionPointerType) (RuntimeObject*, FsmContext_tC11B461D4D90680FC71416881106E6AF48CAE21F*, const RuntimeMethod*);
	return ((FunctionPointerType)__this->___invoke_impl_1)((Il2CppObject*)__this->___method_code_6, ___ctx0, reinterpret_cast<RuntimeMethod*>(__this->___method_3));
}
// System.IAsyncResult Agora.Rtc.LitJson.Lexer/StateHandler::BeginInvoke(Agora.Rtc.LitJson.FsmContext,System.AsyncCallback,System.Object)
IL2CPP_EXTERN_C IL2CPP_METHOD_ATTR RuntimeObject* StateHandler_BeginInvoke_m3A523FE8262513397999E22474569DB2A03E7D62 (StateHandler_t8EA5CD11BFA1A958F305A2A0134A0BBB631FAFCB* __this, FsmContext_tC11B461D4D90680FC71416881106E6AF48CAE21F* ___ctx0, AsyncCallback_t7FEF460CBDCFB9C5FA2EF776984778B9A4145F4C* ___callback1, RuntimeObject* ___object2, const RuntimeMethod* method) 
{
	void *__d_args[2] = {0};
	__d_args[0] = ___ctx0;
	return (RuntimeObject*)il2cpp_codegen_delegate_begin_invoke((RuntimeDelegate*)__this, __d_args, (RuntimeDelegate*)___callback1, (RuntimeObject*)___object2);
}
// System.Boolean Agora.Rtc.LitJson.Lexer/StateHandler::EndInvoke(System.IAsyncResult)
IL2CPP_EXTERN_C IL2CPP_METHOD_ATTR bool StateHandler_EndInvoke_m61A2B4BAC61ECF6D4A4AE37F214276091CE5A893 (StateHandler_t8EA5CD11BFA1A958F305A2A0134A0BBB631FAFCB* __this, RuntimeObject* ___result0, const RuntimeMethod* method) 
{
	RuntimeObject *__result = il2cpp_codegen_delegate_end_invoke((Il2CppAsyncResult*) ___result0, 0);
	return *(bool*)UnBox ((RuntimeObject*)__result);
}
#ifdef __clang__
#pragma clang diagnostic pop
#endif
#ifdef __clang__
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Winvalid-offsetof"
#pragma clang diagnostic ignored "-Wunused-variable"
#endif
// System.String Torymeta.Addressable.AddressableWrapper::get_remotePath()
IL2CPP_EXTERN_C IL2CPP_METHOD_ATTR String_t* AddressableWrapper_get_remotePath_mEB010874531A0D5B8C689EE48A6922BA08161C30 (const RuntimeMethod* method) 
{
	static bool s_Il2CppMethodInitialized;
	if (!s_Il2CppMethodInitialized)
	{
		il2cpp_codegen_initialize_runtime_metadata((uintptr_t*)&AddressableWrapper_tE5A9032A2E5B8B8CC585239824D2603BFF52FC75_il2cpp_TypeInfo_var);
		il2cpp_codegen_initialize_runtime_metadata((uintptr_t*)&Debug_t8394C7EEAECA3689C2C9B9DE9C7166D73596276F_il2cpp_TypeInfo_var);
		il2cpp_codegen_initialize_runtime_metadata((uintptr_t*)&_stringLiteral5D67E25274B2D936623ECD74ACD07BD06587D500);
		il2cpp_codegen_initialize_runtime_metadata((uintptr_t*)&_stringLiteral7BB3A8E1171A70E5B0BF6BC8AF767AB60C516DAF);
		il2cpp_codegen_initialize_runtime_metadata((uintptr_t*)&_stringLiteral8B93D713065FCD706110EEBDDB368C2646BA9761);
		s_Il2CppMethodInitialized = true;
	}
	{
		// if (isTest)
		il2cpp_codegen_runtime_class_init_inline(AddressableWrapper_tE5A9032A2E5B8B8CC585239824D2603BFF52FC75_il2cpp_TypeInfo_var);
		bool L_0 = ((AddressableWrapper_tE5A9032A2E5B8B8CC585239824D2603BFF52FC75_StaticFields*)il2cpp_codegen_static_fields_for(AddressableWrapper_tE5A9032A2E5B8B8CC585239824D2603BFF52FC75_il2cpp_TypeInfo_var))->___isTest_0;
		if (!L_0)
		{
			goto IL_0013;
		}
	}
	{
		// path = "https://test-metabus-unity.s3.ap-northeast-2.amazonaws.com/2.2.005/";
		il2cpp_codegen_runtime_class_init_inline(AddressableWrapper_tE5A9032A2E5B8B8CC585239824D2603BFF52FC75_il2cpp_TypeInfo_var);
		((AddressableWrapper_tE5A9032A2E5B8B8CC585239824D2603BFF52FC75_StaticFields*)il2cpp_codegen_static_fields_for(AddressableWrapper_tE5A9032A2E5B8B8CC585239824D2603BFF52FC75_il2cpp_TypeInfo_var))->___path_1 = _stringLiteral5D67E25274B2D936623ECD74ACD07BD06587D500;
		Il2CppCodeGenWriteBarrier((void**)(&((AddressableWrapper_tE5A9032A2E5B8B8CC585239824D2603BFF52FC75_StaticFields*)il2cpp_codegen_static_fields_for(AddressableWrapper_tE5A9032A2E5B8B8CC585239824D2603BFF52FC75_il2cpp_TypeInfo_var))->___path_1), (void*)_stringLiteral5D67E25274B2D936623ECD74ACD07BD06587D500);
		goto IL_001d;
	}

IL_0013:
	{
		// path = "https://metabus-unity.s3.ap-northeast-2.amazonaws.com/2.2.005/";
		il2cpp_codegen_runtime_class_init_inline(AddressableWrapper_tE5A9032A2E5B8B8CC585239824D2603BFF52FC75_il2cpp_TypeInfo_var);
		((AddressableWrapper_tE5A9032A2E5B8B8CC585239824D2603BFF52FC75_StaticFields*)il2cpp_codegen_static_fields_for(AddressableWrapper_tE5A9032A2E5B8B8CC585239824D2603BFF52FC75_il2cpp_TypeInfo_var))->___path_1 = _stringLiteral8B93D713065FCD706110EEBDDB368C2646BA9761;
		Il2CppCodeGenWriteBarrier((void**)(&((AddressableWrapper_tE5A9032A2E5B8B8CC585239824D2603BFF52FC75_StaticFields*)il2cpp_codegen_static_fields_for(AddressableWrapper_tE5A9032A2E5B8B8CC585239824D2603BFF52FC75_il2cpp_TypeInfo_var))->___path_1), (void*)_stringLiteral8B93D713065FCD706110EEBDDB368C2646BA9761);
	}

IL_001d:
	{
		// Debug.Log("[Debug] runtime Path : " + path);
		il2cpp_codegen_runtime_class_init_inline(AddressableWrapper_tE5A9032A2E5B8B8CC585239824D2603BFF52FC75_il2cpp_TypeInfo_var);
		String_t* L_1 = ((AddressableWrapper_tE5A9032A2E5B8B8CC585239824D2603BFF52FC75_StaticFields*)il2cpp_codegen_static_fields_for(AddressableWrapper_tE5A9032A2E5B8B8CC585239824D2603BFF52FC75_il2cpp_TypeInfo_var))->___path_1;
		String_t* L_2;
		L_2 = String_Concat_m9E3155FB84015C823606188F53B47CB44C444991(_stringLiteral7BB3A8E1171A70E5B0BF6BC8AF767AB60C516DAF, L_1, NULL);
		il2cpp_codegen_runtime_class_init_inline(Debug_t8394C7EEAECA3689C2C9B9DE9C7166D73596276F_il2cpp_TypeInfo_var);
		Debug_Log_m87A9A3C761FF5C43ED8A53B16190A53D08F818BB(L_2, NULL);
		// return path;
		String_t* L_3 = ((AddressableWrapper_tE5A9032A2E5B8B8CC585239824D2603BFF52FC75_StaticFields*)il2cpp_codegen_static_fields_for(AddressableWrapper_tE5A9032A2E5B8B8CC585239824D2603BFF52FC75_il2cpp_TypeInfo_var))->___path_1;
		return L_3;
	}
}
// System.Void Torymeta.Addressable.AddressableWrapper::set_remotePath(System.String)
IL2CPP_EXTERN_C IL2CPP_METHOD_ATTR void AddressableWrapper_set_remotePath_m7C063EDC5F9A5730491CC612ECCFECF8FA82D3CA (String_t* ___value0, const RuntimeMethod* method) 
{
	static bool s_Il2CppMethodInitialized;
	if (!s_Il2CppMethodInitialized)
	{
		il2cpp_codegen_initialize_runtime_metadata((uintptr_t*)&AddressableWrapper_tE5A9032A2E5B8B8CC585239824D2603BFF52FC75_il2cpp_TypeInfo_var);
		s_Il2CppMethodInitialized = true;
	}
	{
		// set { path = value; }
		String_t* L_0 = ___value0;
		il2cpp_codegen_runtime_class_init_inline(AddressableWrapper_tE5A9032A2E5B8B8CC585239824D2603BFF52FC75_il2cpp_TypeInfo_var);
		((AddressableWrapper_tE5A9032A2E5B8B8CC585239824D2603BFF52FC75_StaticFields*)il2cpp_codegen_static_fields_for(AddressableWrapper_tE5A9032A2E5B8B8CC585239824D2603BFF52FC75_il2cpp_TypeInfo_var))->___path_1 = L_0;
		Il2CppCodeGenWriteBarrier((void**)(&((AddressableWrapper_tE5A9032A2E5B8B8CC585239824D2603BFF52FC75_StaticFields*)il2cpp_codegen_static_fields_for(AddressableWrapper_tE5A9032A2E5B8B8CC585239824D2603BFF52FC75_il2cpp_TypeInfo_var))->___path_1), (void*)L_0);
		// set { path = value; }
		return;
	}
}
// System.Void Torymeta.Addressable.AddressableWrapper::.ctor()
IL2CPP_EXTERN_C IL2CPP_METHOD_ATTR void AddressableWrapper__ctor_mD29B9981187BEF2A9107C20C76002F3F6B627028 (AddressableWrapper_tE5A9032A2E5B8B8CC585239824D2603BFF52FC75* __this, const RuntimeMethod* method) 
{
	{
		Object__ctor_mE837C6B9FA8C6D5D109F4B2EC885D79919AC0EA2(__this, NULL);
		return;
	}
}
// System.Void Torymeta.Addressable.AddressableWrapper::.cctor()
IL2CPP_EXTERN_C IL2CPP_METHOD_ATTR void AddressableWrapper__cctor_m2738725C231CBC644F8FDA2B5322056DF0C43A51 (const RuntimeMethod* method) 
{
	static bool s_Il2CppMethodInitialized;
	if (!s_Il2CppMethodInitialized)
	{
		il2cpp_codegen_initialize_runtime_metadata((uintptr_t*)&AddressableWrapper_tE5A9032A2E5B8B8CC585239824D2603BFF52FC75_il2cpp_TypeInfo_var);
		il2cpp_codegen_initialize_runtime_metadata((uintptr_t*)&_stringLiteralDA39A3EE5E6B4B0D3255BFEF95601890AFD80709);
		s_Il2CppMethodInitialized = true;
	}
	{
		// public static bool isTest = false;
		((AddressableWrapper_tE5A9032A2E5B8B8CC585239824D2603BFF52FC75_StaticFields*)il2cpp_codegen_static_fields_for(AddressableWrapper_tE5A9032A2E5B8B8CC585239824D2603BFF52FC75_il2cpp_TypeInfo_var))->___isTest_0 = (bool)0;
		// public static string path = "";
		((AddressableWrapper_tE5A9032A2E5B8B8CC585239824D2603BFF52FC75_StaticFields*)il2cpp_codegen_static_fields_for(AddressableWrapper_tE5A9032A2E5B8B8CC585239824D2603BFF52FC75_il2cpp_TypeInfo_var))->___path_1 = _stringLiteralDA39A3EE5E6B4B0D3255BFEF95601890AFD80709;
		Il2CppCodeGenWriteBarrier((void**)(&((AddressableWrapper_tE5A9032A2E5B8B8CC585239824D2603BFF52FC75_StaticFields*)il2cpp_codegen_static_fields_for(AddressableWrapper_tE5A9032A2E5B8B8CC585239824D2603BFF52FC75_il2cpp_TypeInfo_var))->___path_1), (void*)_stringLiteralDA39A3EE5E6B4B0D3255BFEF95601890AFD80709);
		return;
	}
}
#ifdef __clang__
#pragma clang diagnostic pop
#endif
#ifdef __clang__
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Winvalid-offsetof"
#pragma clang diagnostic ignored "-Wunused-variable"
#endif
// System.UInt32 <PrivateImplementationDetails>::ComputeStringHash(System.String)
IL2CPP_EXTERN_C IL2CPP_METHOD_ATTR uint32_t U3CPrivateImplementationDetailsU3E_ComputeStringHash_m6EA1F233618497AEFF8902A5EDFA24C74E2F2876 (String_t* ___s0, const RuntimeMethod* method) 
{
	uint32_t V_0 = 0;
	int32_t V_1 = 0;
	{
		String_t* L_0 = ___s0;
		if (!L_0)
		{
			goto IL_002a;
		}
	}
	{
		V_0 = ((int32_t)-2128831035);
		V_1 = 0;
		goto IL_0021;
	}

IL_000d:
	{
		String_t* L_1 = ___s0;
		int32_t L_2 = V_1;
		NullCheck(L_1);
		Il2CppChar L_3;
		L_3 = String_get_Chars_mC49DF0CD2D3BE7BE97B3AD9C995BE3094F8E36D3(L_1, L_2, NULL);
		uint32_t L_4 = V_0;
		V_0 = ((int32_t)il2cpp_codegen_multiply(((int32_t)((int32_t)L_3^(int32_t)L_4)), ((int32_t)16777619)));
		int32_t L_5 = V_1;
		V_1 = ((int32_t)il2cpp_codegen_add(L_5, 1));
	}

IL_0021:
	{
		int32_t L_6 = V_1;
		String_t* L_7 = ___s0;
		NullCheck(L_7);
		int32_t L_8;
		L_8 = String_get_Length_m42625D67623FA5CC7A44D47425CE86FB946542D2_inline(L_7, NULL);
		if ((((int32_t)L_6) < ((int32_t)L_8)))
		{
			goto IL_000d;
		}
	}

IL_002a:
	{
		uint32_t L_9 = V_0;
		return L_9;
	}
}
#ifdef __clang__
#pragma clang diagnostic pop
#endif
#ifdef __clang__
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Winvalid-offsetof"
#pragma clang diagnostic ignored "-Wunused-variable"
#endif
#ifdef __clang__
#pragma clang diagnostic pop
#endif
#ifdef __clang__
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Winvalid-offsetof"
#pragma clang diagnostic ignored "-Wunused-variable"
#endif
#ifdef __clang__
#pragma clang diagnostic pop
#endif
IL2CPP_MANAGED_FORCE_INLINE IL2CPP_METHOD_ATTR bool Lexer_get_AllowComments_mBD7811B449819997218E5052F2763E267EFF277B_inline (Lexer_tDC14CFA7B390E884510F554D9D1E03188A185E27* __this, const RuntimeMethod* method) 
{
	{
		// get { return allow_comments; }
		bool L_0 = __this->___allow_comments_2;
		return L_0;
	}
}
IL2CPP_MANAGED_FORCE_INLINE IL2CPP_METHOD_ATTR void Lexer_set_AllowComments_mA16354319A472743B6F147EAFD3175C774878914_inline (Lexer_tDC14CFA7B390E884510F554D9D1E03188A185E27* __this, bool ___value0, const RuntimeMethod* method) 
{
	{
		// set { allow_comments = value; }
		bool L_0 = ___value0;
		__this->___allow_comments_2 = L_0;
		// set { allow_comments = value; }
		return;
	}
}
IL2CPP_MANAGED_FORCE_INLINE IL2CPP_METHOD_ATTR bool Lexer_get_AllowSingleQuotedStrings_mA6F77A0052FA0515743F21C5DA754BE68EF3C7AD_inline (Lexer_tDC14CFA7B390E884510F554D9D1E03188A185E27* __this, const RuntimeMethod* method) 
{
	{
		// get { return allow_single_quoted_strings; }
		bool L_0 = __this->___allow_single_quoted_strings_3;
		return L_0;
	}
}
IL2CPP_MANAGED_FORCE_INLINE IL2CPP_METHOD_ATTR void Lexer_set_AllowSingleQuotedStrings_mA3CBFDE99EF4FF5DCC41B861A2CE6E6271B7382D_inline (Lexer_tDC14CFA7B390E884510F554D9D1E03188A185E27* __this, bool ___value0, const RuntimeMethod* method) 
{
	{
		// set { allow_single_quoted_strings = value; }
		bool L_0 = ___value0;
		__this->___allow_single_quoted_strings_3 = L_0;
		// set { allow_single_quoted_strings = value; }
		return;
	}
}
IL2CPP_MANAGED_FORCE_INLINE IL2CPP_METHOD_ATTR String_t* Lexer_get_StringValue_mFCF7CD0EBB22B34F500B25C26360DFF643FE6132_inline (Lexer_tDC14CFA7B390E884510F554D9D1E03188A185E27* __this, const RuntimeMethod* method) 
{
	{
		// get { return string_value; }
		String_t* L_0 = __this->___string_value_11;
		return L_0;
	}
}
IL2CPP_MANAGED_FORCE_INLINE IL2CPP_METHOD_ATTR bool Lexer_get_EndOfInput_mB1C09B97ED8A1B7141AB706DCA74D9EE4A6C423D_inline (Lexer_tDC14CFA7B390E884510F554D9D1E03188A185E27* __this, const RuntimeMethod* method) 
{
	{
		// get { return end_of_input; }
		bool L_0 = __this->___end_of_input_4;
		return L_0;
	}
}
IL2CPP_MANAGED_FORCE_INLINE IL2CPP_METHOD_ATTR int32_t Lexer_get_Token_m2A2C0BFC698B6DCE0F1C347A70A47449F9035FBF_inline (Lexer_tDC14CFA7B390E884510F554D9D1E03188A185E27* __this, const RuntimeMethod* method) 
{
	{
		// get { return token; }
		int32_t L_0 = __this->___token_12;
		return L_0;
	}
}
IL2CPP_MANAGED_FORCE_INLINE IL2CPP_METHOD_ATTR int32_t String_get_Length_m42625D67623FA5CC7A44D47425CE86FB946542D2_inline (String_t* __this, const RuntimeMethod* method) 
{
	{
		int32_t L_0 = __this->____stringLength_4;
		return L_0;
	}
}
IL2CPP_MANAGED_FORCE_INLINE IL2CPP_METHOD_ATTR bool StateHandler_Invoke_m9CAA7FAB5C4F3F0EBCE63ECC8A3186D52B7FC97E_inline (StateHandler_t8EA5CD11BFA1A958F305A2A0134A0BBB631FAFCB* __this, FsmContext_tC11B461D4D90680FC71416881106E6AF48CAE21F* ___ctx0, const RuntimeMethod* method) 
{
	typedef bool (*FunctionPointerType) (RuntimeObject*, FsmContext_tC11B461D4D90680FC71416881106E6AF48CAE21F*, const RuntimeMethod*);
	return ((FunctionPointerType)__this->___invoke_impl_1)((Il2CppObject*)__this->___method_code_6, ___ctx0, reinterpret_cast<RuntimeMethod*>(__this->___method_3));
}
IL2CPP_MANAGED_FORCE_INLINE IL2CPP_METHOD_ATTR int32_t Stack_1_get_Count_mD08AE71D49787D30DDD9D484BCD323D646744D2E_gshared_inline (Stack_1_tAD790A47551563636908E21E4F08C54C0C323EB5* __this, const RuntimeMethod* method) 
{
	{
		int32_t L_0 = (int32_t)__this->____size_1;
		return L_0;
	}
}
