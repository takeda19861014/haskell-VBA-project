#include <HsFFI.h>
#include <stddef.h>  // ← これを追加

// DllMainは絶対に定義しないでください

// Haskellランタイムの手動初期化関数
void HsStart() {
    int argc = 1;
    char* argv[] = { "ghcDll", NULL };
    char** args = argv;
    hs_init(&argc, &args);
}

// Haskellランタイムの手動終了関数
void HsEnd() {
    hs_exit();
}
