#include <HsFFI.h>

#ifdef __cplusplus
extern "C" {
#endif

    // Haskellで foreign export ccall した関数を宣言
    extern HsInt32 getDictValue(HsInt32 key);

    // VBAや他言語から呼び出す窓口
    // 戻り値の意味:
    //   >=0  ... Haskell辞書のRight値
    //   -1   ... Haskell辞書にキーが存在しない
    //   -2   ... Haskell辞書にLeft値が格納されている
    __declspec(dllexport) int getDictValueWrapper(int key) {
        int result = getDictValue(key);

        // ここでC側でエラー処理や分岐も可能
        // 例:
        // if (result == -1) { /* キーなしの処理 */ }
        // else if (result == -2) { /* Left値の処理 */ }
        // else { /* 通常値 */ }

        return result;
    }

#ifdef __cplusplus
}
#endif
