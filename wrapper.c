#include <HsFFI.h>

#ifdef __cplusplus
extern "C" {
#endif

    // Haskell‚Å foreign export ccall ‚µ‚½ŠÖ”‚ğéŒ¾
    extern HsInt32 getDictValue(HsInt32 key);

    // VBA‚â‘¼Œ¾Œê‚©‚çŒÄ‚Ño‚·‘‹Œû
    __declspec(dllexport) int getDictValueWrapper(int key) {
        return getDictValue(key);
    }

#ifdef __cplusplus
}
#endif
