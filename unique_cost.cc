#include <memory>

extern "C" {

void bar(int* ptr) noexcept;

// Takes ownership
void baz_raw(int* ptr) noexcept;

void foo_raw(int* ptr) {
    if (*ptr > 42) {
        bar(ptr);
        *ptr = 42;
    }
    baz_raw(ptr);
}

// As shown in the talk, with _talk suffix

// Takes ownership
void baz_talk(std::unique_ptr<int>&& ptr) noexcept;

void foo_talk(std::unique_ptr<int>&& ptr) {
    if (*ptr > 42) {
        bar(ptr.get());
        *ptr = 42;
    }
    baz_talk(std::move(ptr));
}

// My design, with _my prefix and inline wrapper functions converting
// unique_ptr to raw ptr then to unique_ptr again, so that only raw ptrs
// are passed through true function boundaries, while an std::unique_ptr
// api is exposed to callers.
void baz_my_impl(int* ptr) noexcept;
void foo_my_impl(int* ptr);

// Takes ownership
inline void baz_my(std::unique_ptr<int> ptr) noexcept {
    baz_my_impl(ptr.release());
}

inline void foo_my(std::unique_ptr<int> ptr) {
    foo_my_impl(ptr.release());
}

void foo_my_impl(int* ptr_raw) {
    std::unique_ptr<int> ptr(ptr_raw);
    if (*ptr > 42) {
        bar(ptr.get());
        *ptr = 42;
    }
    baz_my(std::move(ptr));
}

// Dummy functions so we can easily see different sections of the
// generated assembly corresponding to three different versions.
// (actually gcc inlined everything so this didn't work well ...)
// void calling_raw_version() noexcept;
// void calling_talk_version() noexcept;
// void calling_my_version() noexcept;

// int call_all_three() {
//     int* raw_ptr = new int;
//     std::unique_ptr<int> talk_ptr(new int);
//     std::unique_ptr<int> my_ptr(new int);
    
//     calling_raw_version();
//     foo_raw(raw_ptr);
    
//     calling_talk_version();
//     foo_talk(std::move(talk_ptr));
    
//     calling_my_version();
//     foo_my(std::move(my_ptr));
// }

} // end extern "C"
