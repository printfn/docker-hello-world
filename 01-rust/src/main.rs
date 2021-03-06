#![no_std]
#![no_main]
#![feature(rustc_private)]

extern crate libc;

#[no_mangle]
pub extern "C" fn main(_argc: isize, _argv: *const *const u8) -> isize {
    // Since we are passing a C string the final null character is mandatory.
    // `puts` automatically appends a newline
    const HELLO: &'static str = "Hello World\0";
    unsafe {
        libc::puts(HELLO.as_ptr() as *const _);
    }
    0
}

#[panic_handler]
fn my_panic(_info: &core::panic::PanicInfo) -> ! {
    loop {}
}

