#include <HsFFI.h>

#ifdef __cplusplus
extern "C" {
#endif

    // Haskell�� foreign export ccall �����֐���錾
    extern HsInt32 getDictValue(HsInt32 key);

    // VBA�⑼���ꂩ��Ăяo������
    __declspec(dllexport) int getDictValueWrapper(int key) {
        return getDictValue(key);
    }

#ifdef __cplusplus
}
#endif
