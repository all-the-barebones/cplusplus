#include <stdint.h>

static uint8_t* vga = (uint8_t*)0xb8000;
static uint64_t vgaoff = 2;

void putc(char c) {
    vga[vgaoff+0] = c;
    vga[vgaoff+1] = 0xf;
    vgaoff += 2;
}
void puts(const char* s) {
    while (*s) {
        putc(*s++);
    }
    vgaoff = (vgaoff / 160 + 1) * 160 + 2;
    vga[vgaoff] = ' ';
    vga[vgaoff+1] = 0xf0;
}

extern "C" void _start() {
    for (uint64_t i = 0;i < 80*25*2;i++) {
        vga[i] = 0;
    }

    puts("Welcome to C++ on bare metal x86_64!");
    puts("  => github.com/all-the-barebones/cplusplus");

    while (true) {
        asm("cli; hlt");
    }
}