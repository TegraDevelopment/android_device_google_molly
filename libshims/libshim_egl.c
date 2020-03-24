/*
 * [Dmitry Grinberg] Problems:
     1. Molly's GFX libraries were made to work with android 5.0.
     2. Android M changed a few things around that make it not work
       a. dlopen is now posix compliant and thus things like dlopen("egl/abc.so") will no longer look anywhere except root
     3. Due to this, we must do something.

  * Curious data snippets:
      Due to peculiarities of the ELF format, when a binary baz imports function foo() from libbar.so,
      nowhere in baz's ELF file does it say that foo() must from from libbar. In fact there are two
      separate records. One that says that libbar is "NEED"ed, and another that says that there is an
      import of function "foo". What that means is that if the process wer to also load libxyz, which
      also exported foo(), there is no way to be sure which foo() would get called. Why do we care?
      Well, considering our problems above. We need to provide functions and variables that existing
      libraries no longer do. How?

  * A tricky but clever solution: INTERPOSITION library:
      1. We'll edit the libEGL_tegra_impl.so and replace one of its "NEED" record with one referencing a new library
         which we'll create. Need a library name? why not "libshim_egl.so"? We'll also edit the function name
         from dlopen to LibLdr() to make sure our function gets called.
      2. Make sure that libshim_egl.so's NEED records include the library whose record we replaced in libnvos.so
         library, to make sure that the linker brings it in afterall and all symbols in it are found
      3. Implement libshim_egl.so such that it provides LibLdr() and backs that wil a proper call to dlopen()
         with the proper path

  * Result: GFX libraries works on M, with the help of libshim_egl.so.

 * [dhacker29]:
     Tegra 4 is a bit different compared to T3 GL blobs:

     egl/libGLESv1_CM_tegra.so loads /system/lib/egl/libEGL_tegra.so
     egl/libGLESv2_tegra.so loads /system/lib/egl/libEGL_tegra.so
     libEGL_tegra_impl.so loads egl/libGLESv2_tegra.so and also loads any
     *_impl GL blobs in path.

     libEGL_tegra_impl.so is the only GL blob using egl/ to load a binary
     and should be the only binary patched

 * [npjohnson]:
     To make this re-creatable:
     `patchelf --add-needed libshim_egl.so proprietary/lib/libEGL_tegra_impl.so`

     Note: `patchelf` must be v0.9 due to some peculiarities with newer versions
     when editing ARM ELF files.

     We'll pin the modified `libEGL_tegra_impl.so` in proprietary-files.txt so
     it doesn't get overwritten by future proprietary file extractions. When
     extract_utils support blob_fixup in later LineageOS versions, we'll add
     support for that.
 */

#define LOG_TAG "libshim_egl.so"
#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#include <utils/Log.h>
#include <string.h>
#include <dlfcn.h>

typedef uintptr_t NvError;
struct NvOsLibraryHandle;

NvError NvOsLibraryLoad(const char *name, struct NvOsLibraryHandle *library);
NvError molly_m_libload(const char *name, struct NvOsLibraryHandle *library)
{
    static const char *prepend = "/system/lib/";
    char *path;
    NvError err;

    err = NvOsLibraryLoad(name, library);
    if (!err)
        return err;

    //now try full path
    //then try in /system/lib
    path = malloc(strlen(name) + strlen(prepend) + 1);
    if (!path)
        return err;
    sprintf(path, "%s%s", prepend, name);
    err = NvOsLibraryLoad(path, library);
    if (!err)
        ALOGI("Just saved you by loading '%s' instead of '%s'", path, name);
    free(path);

    return err;
}

void libEvtLoading(void) __attribute__((constructor));
void libEvtLoading(void)
{
    ALOGI("Loaded to help save your day\n");

}

