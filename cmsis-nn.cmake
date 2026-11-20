include(FetchContent)

set(cmsis_nn_dir ${download_dir}/cmsis_nn)
set(cmsis_nn_zip ${download_dir}/cmsis_nn.zip)
set(ZIP_PREFIX_NN "88f1982a69c00ed13dd633a63da1009c48abbb4d")
set(CMSIS_NN_MD5 "703bf3b2508a697aaf81f1a235788ceb")
set(CMSIS_NN_URL "http://github.com/ARM-software/CMSIS-NN/archive/${ZIP_PREFIX_NN}.zip")

set(_cmsis_nn_fetch_args
  cmsis_nn
  SOURCE_DIR ${cmsis_nn_dir}
  URL      "${CMSIS_NN_URL}"
  URL_HASH "MD5=${CMSIS_NN_MD5}"
)

if(CMAKE_VERSION VERSION_GREATER_EQUAL "3.24")
  list(APPEND _cmsis_nn_fetch_args DOWNLOAD_EXTRACT_TIMESTAMP TRUE)
endif()

FetchContent_Declare(${_cmsis_nn_fetch_args})

# FetchContent keeps its archive in the build tree, which a pristine build wipes. Cache the
# archive here instead, keyed by MD5, so the build also works offline.
set(_cmsis_nn_stamp "${download_dir}/cmsis_nn_extract.ok")

# Step 1: validate the archive. A bad one invalidates the extraction, so drop stamp and tree too.
set(_cmsis_nn_zip_ok FALSE)
if(EXISTS "${cmsis_nn_zip}")
  file(MD5 "${cmsis_nn_zip}" _cmsis_nn_zip_md5)
  if(_cmsis_nn_zip_md5 STREQUAL CMSIS_NN_MD5)
    set(_cmsis_nn_zip_ok TRUE)
  else()
    if(COMMAND ameba_warning)
      ameba_warning("cmsis-nn: ${cmsis_nn_zip} md5 mismatch (${_cmsis_nn_zip_md5} != ${CMSIS_NN_MD5}), re-downloading")
    else()
      message(WARNING "cmsis-nn: ${cmsis_nn_zip} md5 mismatch (${_cmsis_nn_zip_md5} != ${CMSIS_NN_MD5}), re-downloading")
    endif()
    file(REMOVE "${cmsis_nn_zip}")
  endif()
endif()

if(NOT _cmsis_nn_zip_ok)
  file(REMOVE "${_cmsis_nn_stamp}")
  file(REMOVE_RECURSE "${cmsis_nn_dir}")
  # Verify after download rather than via EXPECTED_MD5, which aborts configure on mismatch
  # and leaves the bad payload behind.
  file(DOWNLOAD "${CMSIS_NN_URL}" "${cmsis_nn_zip}" STATUS _cmsis_nn_dl_status)
  list(GET _cmsis_nn_dl_status 1 _cmsis_nn_dl_msg)
  set(_cmsis_nn_zip_md5 "")
  if(EXISTS "${cmsis_nn_zip}")
    file(MD5 "${cmsis_nn_zip}" _cmsis_nn_zip_md5)
  endif()
  if(NOT _cmsis_nn_zip_md5 STREQUAL CMSIS_NN_MD5)
    file(REMOVE "${cmsis_nn_zip}")
    # FATAL_ERROR, not ameba_fatal: the latter is a SEND_ERROR and would keep configuring.
    message(FATAL_ERROR "cmsis-nn: archive check failed (${_cmsis_nn_dl_msg}, md5 ${_cmsis_nn_zip_md5} != ${CMSIS_NN_MD5}). Offline builds need a valid ${cmsis_nn_zip}.")
  endif()
endif()

# Step 2: extract when the stamp is missing (written last, so it marks a complete extract).
if(NOT EXISTS "${_cmsis_nn_stamp}" OR NOT IS_DIRECTORY "${cmsis_nn_dir}")
  file(REMOVE_RECURSE "${cmsis_nn_dir}" "${download_dir}/CMSIS-NN-${ZIP_PREFIX_NN}")
  file(ARCHIVE_EXTRACT INPUT "${cmsis_nn_zip}" DESTINATION "${download_dir}")
  file(RENAME "${download_dir}/CMSIS-NN-${ZIP_PREFIX_NN}" "${cmsis_nn_dir}")
  file(WRITE "${_cmsis_nn_stamp}" "")
endif()

# Source is present, so pin it: this stops FetchContent from populating (or downloading) at all.
set(FETCHCONTENT_SOURCE_DIR_CMSIS_NN "${cmsis_nn_dir}" CACHE PATH
    "Pre-populated cmsis-nn sources; when set, no download is performed" FORCE)

FetchContent_MakeAvailable(cmsis_nn)

if(CMSIS_NN_USE_MVE)
  # GCC 10 codegen bug: vcreateq_s32(0, 0) in arm_nnsupportfunctions.h generates
  # `vmov q[2],q[0],Rn,Rn` with Rn==Rn, which the assembler rejects (Rn must != Rm).
  # Root cause: GCC 10 allocates the same GP register for both identical arguments.
  # Fix: replace vcreateq_s32(0, 0) with the semantically equivalent vdupq_n_s32(0),
  # which GCC compiles to `vmov.i32 q, #0` (immediate form, no GP registers needed).
  # Fixed upstream in GCC 11.
  set(_hdr "${cmsis_nn_dir}/Include/arm_nnsupportfunctions.h")
  if(EXISTS "${_hdr}")
    file(READ "${_hdr}" _hdr_src)
    string(REPLACE "vcreateq_s32(0, 0)" "vdupq_n_s32(0)" _hdr_src "${_hdr_src}")
    file(WRITE "${_hdr}" "${_hdr_src}")
  endif()
endif()

get_target_property(TARGET_COMPILE_OPTIONS cmsis-nn COMPILE_OPTIONS)
if (TARGET_COMPILE_OPTIONS)
    # The compiler option *'-fno-builtin'* does not utilize optimized implementations of e.g. memcpy and memset,
    # which are heavily used by CMSIS-NN
    list(REMOVE_ITEM TARGET_COMPILE_OPTIONS "-fno-builtin" "-fno-builtin-memcpy" "-fno-builtin-memset")
    list(APPEND TARGET_COMPILE_OPTIONS "-Wno-undef")
    if(NOT CMSIS_NN_USE_MVE)
      list(APPEND TARGET_COMPILE_OPTIONS "-DCMSIS_NN_USE_REQUANTIZE_INLINE_ASSEMBLY")
    endif()
    set_target_properties(cmsis-nn PROPERTIES COMPILE_OPTIONS "${TARGET_COMPILE_OPTIONS}")
endif()
