#include <HsFFI.h>
#include <stddef.h>  // �� �����ǉ�

// DllMain�͐�΂ɒ�`���Ȃ��ł�������

// Haskell�����^�C���̎蓮�������֐�
void HsStart() {
    int argc = 1;
    char* argv[] = { "ghcDll", NULL };
    char** args = argv;
    hs_init(&argc, &args);
}

// Haskell�����^�C���̎蓮�I���֐�
void HsEnd() {
    hs_exit();
}
