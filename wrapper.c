#include <HsFFI.h>

#ifdef __cplusplus
extern "C" {
#endif

    // Haskell�� foreign export ccall �����֐���錾
    extern HsInt32 getDictValue(HsInt32 key);

    // VBA�⑼���ꂩ��Ăяo������
    // �߂�l�̈Ӗ�:
    //   >=0  ... Haskell������Right�l
    //   -1   ... Haskell�����ɃL�[�����݂��Ȃ�
    //   -2   ... Haskell������Left�l���i�[����Ă���
    __declspec(dllexport) int getDictValueWrapper(int key) {
        int result = getDictValue(key);

        // ������C���ŃG���[�����╪����\
        // ��:
        // if (result == -1) { /* �L�[�Ȃ��̏��� */ }
        // else if (result == -2) { /* Left�l�̏��� */ }
        // else { /* �ʏ�l */ }

        return result;
    }

#ifdef __cplusplus
}
#endif
