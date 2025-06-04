#include <HsFFI.h>

extern HsInt32 doubleValue(HsInt32);

__declspec(dllexport) int doubleValueWrapper(int x) {
    return doubleValue(x);
}