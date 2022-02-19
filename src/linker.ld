/* Tell the linker that we want an x86_64 ELF64 output file */
OUTPUT_FORMAT(elf64-x86-64)
OUTPUT_ARCH(i386:x86-64)

/* We want the symbol _start to be our entry point */
ENTRY(_start)

PHDRS
{
    null PT_NULL FLAGS(0);
    text PT_LOAD FLAGS((1 << 0) | (1 << 2));
    rodata PT_LOAD FLAGS((1 << 2));
    data PT_LOAD FLAGS((1 << 1) | (1 << 2));
    tls PT_TLS FLAGS((1 << 1) | (1 << 2));
}

SECTIONS
{
    . = 2<<20;
    .text : {
        *(.text .text.*)
    } :text
    . += CONSTANT(MAXPAGESIZE);
    .rodata : {
        *(.rodata .rodata.*)
    } :rodata
    . += CONSTANT(MAXPAGESIZE);
    .data : {
        *(.data .data.*)
    } :data
    .bss : {
        *(COMMON)
        *(.bss .bss.*)
    } :data
    .tls : {
        *(COMMON)
        *(.tbss .tbss.*)
    } :tls
}
