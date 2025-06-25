#include <windows.h>
#include <oleauto.h>
#include <HsFFI.h>
#include <wchar.h>
#include <stdio.h>

#pragma comment(lib, "oleaut32")
#pragma comment(lib, "ole32")

#ifdef __cplusplus
extern "C" {
#endif

    // Haskell関数のプロトタイプ（4パラメータ版）
    extern HsInt32 real_len(const wchar_t* s, HsInt32 len_c, HsInt32 elem1, HsInt32 elem2);
    extern HsInt32 real_len_advanced(const wchar_t* s, HsInt32 len_c, HsInt32 elem1, HsInt32 elem2);
    extern HsInt32 real_value_new_improved(const wchar_t* s, HsInt32 len_c, HsInt32 elem1, HsInt32 elem2);

    // グローバル変数（既存のコードスタイルを維持）
    static volatile int g_hs_initialized = 0;
    static CRITICAL_SECTION g_init_cs;
    static volatile int g_cs_initialized = 0;

    // 初期化関数（既存のコードを維持）
    static int ensure_hs_initialized() {
        if (!g_cs_initialized) {
            static volatile LONG cs_init_flag = 0;
            if (InterlockedCompareExchange(&cs_init_flag, 1, 0) == 0) {
                InitializeCriticalSection(&g_init_cs);
                g_cs_initialized = 1;
            }
            else {
                while (!g_cs_initialized) {
                    Sleep(1);
                }
            }
        }

        if (!g_hs_initialized) {
            EnterCriticalSection(&g_init_cs);
            if (!g_hs_initialized) {
                int argc = 1;
                char* argv[] = { "MyLib", NULL };
                char** args = argv;
                hs_init(&argc, &args);
                g_hs_initialized = 1;
                OutputDebugStringA("Haskellランタイム初期化完了\n");
            }
            LeaveCriticalSection(&g_init_cs);
        }
        return 1;
    }

    // DllMain（既存のコードを維持）
    BOOL WINAPI DllMain(HINSTANCE hinstDLL, DWORD fdwReason, LPVOID lpvReserved) {
        switch (fdwReason) {
        case DLL_PROCESS_ATTACH:
            break;
        case DLL_PROCESS_DETACH:
            if (g_hs_initialized) {
                hs_exit();
            }
            if (g_cs_initialized) {
                DeleteCriticalSection(&g_init_cs);
            }
            break;
        }
        return TRUE;
    }

    // 既存のreal_len_wrapper（BSTR版）
    __declspec(dllexport) HsInt32 __stdcall real_len_wrapper(BSTR s, HsInt32 elem1, HsInt32 elem2) {
        if (!ensure_hs_initialized()) {
            OutputDebugStringA("real_len_wrapper: Haskellランタイム初期化失敗\n");
            return -999;
        }

        OutputDebugStringA("real_len_wrapper: 関数が呼ばれました\n");

        if (s == NULL) {
            OutputDebugStringA("real_len_wrapper: BSTRがNULLです\n");
            return -1;
        }

        UINT len = SysStringLen(s);
        char debug_msg[256];
        sprintf_s(debug_msg, sizeof(debug_msg), "real_len_wrapper: BSTRポインタ=0x%p, 長さ=%u, elem1=%d, elem2=%d\n", (void*)s, len, elem1, elem2);
        OutputDebugStringA(debug_msg);

        return real_len((const wchar_t*)s, (HsInt32)len, elem1, elem2);
    }

    // 既存のreal_len_wrapper_wstr（wchar_t*版）
    __declspec(dllexport) HsInt32 __stdcall real_len_wrapper_wstr(const wchar_t* s, HsInt32 elem1, HsInt32 elem2) {
        if (!ensure_hs_initialized()) {
            OutputDebugStringA("real_len_wrapper_wstr: Haskellランタイム初期化失敗\n");
            return -999;
        }

        OutputDebugStringA("real_len_wrapper_wstr: 関数が呼ばれました\n");

        if (s == NULL) {
            OutputDebugStringA("real_len_wrapper_wstr: 文字列がNULLです\n");
            return -1;
        }

        HsInt32 len = (HsInt32)wcslen(s);
        char debug_msg[256];
        sprintf_s(debug_msg, sizeof(debug_msg), "real_len_wrapper_wstr: 文字列ポインタ=0x%p, 長さ=%d, elem1=%d, elem2=%d\n", (void*)s, len, elem1, elem2);
        OutputDebugStringA(debug_msg);

        return real_len(s, len, elem1, elem2);
    }

    // real_len_advanced_wrapper（パターンマッチング版）
    __declspec(dllexport) HsInt32 __stdcall real_len_advanced_wrapper(const wchar_t* s, HsInt32 len_c, HsInt32 elem1, HsInt32 elem2) {
        if (!ensure_hs_initialized()) {
            OutputDebugStringA("real_len_advanced_wrapper: Haskellランタイム初期化失敗\n");
            return -999;
        }

        OutputDebugStringA("real_len_advanced_wrapper: 関数が呼ばれました\n");

        if (s == NULL) {
            OutputDebugStringA("real_len_advanced_wrapper: 文字列がNULLです\n");
            return -1;
        }

        char debug_msg[256];
        sprintf_s(debug_msg, sizeof(debug_msg), "real_len_advanced_wrapper: 文字列ポインタ=0x%p, 長さ=%d, elem1=%d, elem2=%d\n", (void*)s, len_c, elem1, elem2);
        OutputDebugStringA(debug_msg);

        return real_len_advanced(s, len_c, elem1, elem2);
    }

    // ★real_value_new_wrapper（値取得版）
    __declspec(dllexport) HsInt32 __stdcall real_value_new_wrapper(const wchar_t* s, HsInt32 len_c, HsInt32 elem1, HsInt32 elem2) {
        if (!ensure_hs_initialized()) {
            OutputDebugStringA("real_value_new_wrapper: Haskellランタイム初期化失敗\n");
            return -999;
        }

        OutputDebugStringA("real_value_new_wrapper: 関数が呼ばれました\n");

        if (s == NULL) {
            OutputDebugStringA("real_value_new_wrapper: 文字列がNULLです\n");
            return -1;
        }

        char debug_msg[256];
        sprintf_s(debug_msg, sizeof(debug_msg), "real_value_new_wrapper: 文字列ポインタ=0x%p, 長さ=%d, elem1=%d, elem2=%d\n", (void*)s, len_c, elem1, elem2);
        OutputDebugStringA(debug_msg);

        return real_value_new_improved(s, len_c, elem1, elem2);
    }
    
    __declspec(dllexport) int __stdcall initialize_haskell() {
        return ensure_hs_initialized() ? 1 : 0;
    }
#ifdef __cplusplus
}
#endif
