#include <HsFFI.h>
#include <windows.h>

BOOL WINAPI DllMain(HINSTANCE hInstance, DWORD dwReason, LPVOID lpReserved) {
    if (dwReason == DLL_PROCESS_ATTACH) {
        hs_init(NULL, NULL);
    } else if (dwReason == DLL_PROCESS_DETACH) {
        hs_exit();
    }
    return TRUE;
}
