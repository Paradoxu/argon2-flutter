function createWasmMemory(mem) {
    const KB = 1024;
    const MB = 1024 * KB;
    const GB = 1024 * MB;
    const WASM_PAGE_SIZE = 64 * KB;

    const totalMemory = (2 * GB - 64 * KB) / WASM_PAGE_SIZE;
    const initialMemory = Math.min(
        Math.max(Math.ceil((mem * KB) / WASM_PAGE_SIZE), 256) + 256,
        totalMemory
    );

    return new WebAssembly.Memory({
        initial: initialMemory,
        maximum: totalMemory,
    });
}