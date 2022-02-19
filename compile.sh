set -ex

nasm -fbin bootelf/bootelf.asm -o build/bootelf.bin -Ibootelf
clang++ -target x86_64-elf -Iinc src/main.cc -c -o build/main.o -ggdb -O0
ld.lld -Tsrc/linker.ld build/main.o -o build/atb_cplusplus.elf

cat build/bootelf.bin build/atb_cplusplus.elf >build/atb_cplusplus.bin
