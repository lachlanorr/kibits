#-------------------------------------------------------------------------------
# CMakeLists.txt - Build script
#
# Kibits - Distributed Game Blockchain Library
# Copyright (c) 2022 Lachlan Orr
#
# This software is provided 'as-is', without any express or implied
# warranty. In no event will the authors be held liable for any damages
# arising from the use of this software.
#
# Permission is granted to anyone to use this software for any purpose,
# including commercial applications, and to alter it and redistribute it
# freely, subject to the following restrictions:
#
#   1. The origin of this software must not be misrepresented; you must not
#   claim that you wrote the original software. If you use this software
#   in a product, an acknowledgment in the product documentation would be
#   appreciated but is not required.
#
#   2. Altered source versions must be plainly marked as such, and must not be
#   misrepresented as being the original software.
#
#   3. This notice may not be removed or altered from any source
#   distribution.
#-------------------------------------------------------------------------------

# googletest
set(BUILD_GMOCK OFF CACHE BOOL "" FORCE)
set(INSTALL_GTEST OFF CACHE BOOL "" FORCE)
add_subdirectory(googletest)
set_target_properties(gtest PROPERTIES
  FOLDER external/googletest
  )
set_target_properties(gtest_main PROPERTIES
  FOLDER external/googletest
  )

# protobuf
set(protobuf_BUILD_TESTS OFF CACHE BOOL "" FORCE)
set(protobuf_BUILD_EXAMPLES OFF CACHE BOOL "" FORCE)
set(protobuf_WITH_ZLIB OFF CACHE BOOL "" FORCE)
add_subdirectory(protobuf/cmake)
set_target_properties(libprotobuf PROPERTIES
  FOLDER external/protobuf
  )
set_target_properties(libprotobuf-lite PROPERTIES
  FOLDER external/protobuf
  )
set_target_properties(libprotoc PROPERTIES
  FOLDER external/protobuf
  )
set_target_properties(protoc PROPERTIES
  FOLDER external/protobuf
  )

# libsodium
set(libsodium_SOURCES
  libsodium/src/libsodium/crypto_generichash/crypto_generichash.c
  libsodium/src/libsodium/crypto_generichash/blake2b/generichash_blake2.c
  libsodium/src/libsodium/crypto_generichash/blake2b/ref/blake2b-compress-ref.c
  libsodium/src/libsodium/crypto_generichash/blake2b/ref/blake2b-compress-ssse3.c
  libsodium/src/libsodium/crypto_generichash/blake2b/ref/blake2b-compress-avx2.c
  libsodium/src/libsodium/crypto_generichash/blake2b/ref/blake2b-compress-sse41.c
  libsodium/src/libsodium/crypto_generichash/blake2b/ref/generichash_blake2b.c
  libsodium/src/libsodium/crypto_generichash/blake2b/ref/blake2b-ref.c
  libsodium/src/libsodium/crypto_kx/crypto_kx.c
  libsodium/src/libsodium/crypto_sign/crypto_sign.c
  libsodium/src/libsodium/crypto_sign/ed25519/sign_ed25519.c
  libsodium/src/libsodium/crypto_sign/ed25519/ref10/obsolete.c
  libsodium/src/libsodium/crypto_sign/ed25519/ref10/sign.c
  libsodium/src/libsodium/crypto_sign/ed25519/ref10/keypair.c
  libsodium/src/libsodium/crypto_sign/ed25519/ref10/open.c
  libsodium/src/libsodium/crypto_secretbox/crypto_secretbox.c
  libsodium/src/libsodium/crypto_secretbox/crypto_secretbox_easy.c
  libsodium/src/libsodium/crypto_secretbox/xsalsa20poly1305/secretbox_xsalsa20poly1305.c
  libsodium/src/libsodium/crypto_secretbox/xchacha20poly1305/secretbox_xchacha20poly1305.c
  libsodium/src/libsodium/crypto_pwhash/crypto_pwhash.c
  libsodium/src/libsodium/crypto_pwhash/argon2/blake2b-long.c
  libsodium/src/libsodium/crypto_pwhash/argon2/argon2-core.c
  libsodium/src/libsodium/crypto_pwhash/argon2/argon2-fill-block-avx512f.c
  libsodium/src/libsodium/crypto_pwhash/argon2/argon2-fill-block-ref.c
  libsodium/src/libsodium/crypto_pwhash/argon2/argon2-fill-block-ssse3.c
  libsodium/src/libsodium/crypto_pwhash/argon2/pwhash_argon2i.c
  libsodium/src/libsodium/crypto_pwhash/argon2/pwhash_argon2id.c
  libsodium/src/libsodium/crypto_pwhash/argon2/argon2.c
  libsodium/src/libsodium/crypto_pwhash/argon2/argon2-fill-block-avx2.c
  libsodium/src/libsodium/crypto_pwhash/argon2/argon2-encoding.c
  libsodium/src/libsodium/crypto_pwhash/scryptsalsa208sha256/scrypt_platform.c
  libsodium/src/libsodium/crypto_pwhash/scryptsalsa208sha256/crypto_scrypt-common.c
  libsodium/src/libsodium/crypto_pwhash/scryptsalsa208sha256/pwhash_scryptsalsa208sha256.c
  libsodium/src/libsodium/crypto_pwhash/scryptsalsa208sha256/pbkdf2-sha256.c
  libsodium/src/libsodium/crypto_pwhash/scryptsalsa208sha256/nosse/pwhash_scryptsalsa208sha256_nosse.c
  libsodium/src/libsodium/crypto_pwhash/scryptsalsa208sha256/sse/pwhash_scryptsalsa208sha256_sse.c
  libsodium/src/libsodium/crypto_verify/sodium/verify.c
  libsodium/src/libsodium/crypto_auth/crypto_auth.c
  libsodium/src/libsodium/crypto_auth/hmacsha512/auth_hmacsha512.c
  libsodium/src/libsodium/crypto_auth/hmacsha512256/auth_hmacsha512256.c
  libsodium/src/libsodium/crypto_auth/hmacsha256/auth_hmacsha256.c
  libsodium/src/libsodium/crypto_kdf/crypto_kdf.c
  libsodium/src/libsodium/crypto_kdf/blake2b/kdf_blake2b.c
  libsodium/src/libsodium/crypto_shorthash/crypto_shorthash.c
  libsodium/src/libsodium/crypto_shorthash/siphash24/shorthash_siphash24.c
  libsodium/src/libsodium/crypto_shorthash/siphash24/shorthash_siphashx24.c
  libsodium/src/libsodium/crypto_shorthash/siphash24/ref/shorthash_siphashx24_ref.c
  libsodium/src/libsodium/crypto_shorthash/siphash24/ref/shorthash_siphash24_ref.c
  libsodium/src/libsodium/crypto_scalarmult/crypto_scalarmult.c
  libsodium/src/libsodium/crypto_scalarmult/ristretto255/ref10/scalarmult_ristretto255_ref10.c
  libsodium/src/libsodium/crypto_scalarmult/ed25519/ref10/scalarmult_ed25519_ref10.c
  libsodium/src/libsodium/crypto_scalarmult/curve25519/scalarmult_curve25519.c
  libsodium/src/libsodium/crypto_scalarmult/curve25519/sandy2x/curve25519_sandy2x.c
  libsodium/src/libsodium/crypto_scalarmult/curve25519/sandy2x/fe_frombytes_sandy2x.c
  libsodium/src/libsodium/crypto_scalarmult/curve25519/sandy2x/fe51_invert.c
  libsodium/src/libsodium/crypto_scalarmult/curve25519/ref10/x25519_ref10.c
  libsodium/src/libsodium/crypto_onetimeauth/crypto_onetimeauth.c
  libsodium/src/libsodium/crypto_onetimeauth/poly1305/onetimeauth_poly1305.c
  libsodium/src/libsodium/crypto_onetimeauth/poly1305/donna/poly1305_donna.c
  libsodium/src/libsodium/crypto_onetimeauth/poly1305/sse2/poly1305_sse2.c
  libsodium/src/libsodium/randombytes/randombytes.c
  libsodium/src/libsodium/randombytes/sysrandom/randombytes_sysrandom.c
  libsodium/src/libsodium/randombytes/internal/randombytes_internal_random.c
  libsodium/src/libsodium/crypto_box/crypto_box_easy.c
  libsodium/src/libsodium/crypto_box/crypto_box_seal.c
  libsodium/src/libsodium/crypto_box/crypto_box.c
  libsodium/src/libsodium/crypto_box/curve25519xsalsa20poly1305/box_curve25519xsalsa20poly1305.c
  libsodium/src/libsodium/crypto_box/curve25519xchacha20poly1305/box_curve25519xchacha20poly1305.c
  libsodium/src/libsodium/crypto_box/curve25519xchacha20poly1305/box_seal_curve25519xchacha20poly1305.c
  libsodium/src/libsodium/sodium/codecs.c
  libsodium/src/libsodium/sodium/runtime.c
  libsodium/src/libsodium/sodium/core.c
  libsodium/src/libsodium/sodium/utils.c
  libsodium/src/libsodium/sodium/version.c
  libsodium/src/libsodium/crypto_stream/crypto_stream.c
  libsodium/src/libsodium/crypto_stream/xchacha20/stream_xchacha20.c
  libsodium/src/libsodium/crypto_stream/chacha20/stream_chacha20.c
  libsodium/src/libsodium/crypto_stream/chacha20/ref/chacha20_ref.c
  libsodium/src/libsodium/crypto_stream/chacha20/dolbeau/chacha20_dolbeau-avx2.c
  libsodium/src/libsodium/crypto_stream/chacha20/dolbeau/chacha20_dolbeau-ssse3.c
  libsodium/src/libsodium/crypto_stream/salsa20/stream_salsa20.c
  libsodium/src/libsodium/crypto_stream/salsa20/ref/salsa20_ref.c
  libsodium/src/libsodium/crypto_stream/salsa20/xmm6int/salsa20_xmm6int-avx2.c
  libsodium/src/libsodium/crypto_stream/salsa20/xmm6int/salsa20_xmm6int-sse2.c
  libsodium/src/libsodium/crypto_stream/salsa20/xmm6/salsa20_xmm6.c
  libsodium/src/libsodium/crypto_stream/salsa2012/stream_salsa2012.c
  libsodium/src/libsodium/crypto_stream/salsa2012/ref/stream_salsa2012_ref.c
  libsodium/src/libsodium/crypto_stream/salsa208/stream_salsa208.c
  libsodium/src/libsodium/crypto_stream/salsa208/ref/stream_salsa208_ref.c
  libsodium/src/libsodium/crypto_stream/xsalsa20/stream_xsalsa20.c
  libsodium/src/libsodium/crypto_hash/crypto_hash.c
  libsodium/src/libsodium/crypto_hash/sha512/hash_sha512.c
  libsodium/src/libsodium/crypto_hash/sha512/cp/hash_sha512_cp.c
  libsodium/src/libsodium/crypto_hash/sha256/hash_sha256.c
  libsodium/src/libsodium/crypto_hash/sha256/cp/hash_sha256_cp.c
  libsodium/src/libsodium/crypto_aead/xchacha20poly1305/sodium/aead_xchacha20poly1305.c
  libsodium/src/libsodium/crypto_aead/aes256gcm/aesni/aead_aes256gcm_aesni.c
  libsodium/src/libsodium/crypto_aead/chacha20poly1305/sodium/aead_chacha20poly1305.c
  libsodium/src/libsodium/crypto_secretstream/xchacha20poly1305/secretstream_xchacha20poly1305.c
  libsodium/src/libsodium/crypto_core/salsa/ref/core_salsa_ref.c
  libsodium/src/libsodium/crypto_core/hchacha20/core_hchacha20.c
  libsodium/src/libsodium/crypto_core/hsalsa20/core_hsalsa20.c
  libsodium/src/libsodium/crypto_core/hsalsa20/ref2/core_hsalsa20_ref2.c
  libsodium/src/libsodium/crypto_core/ed25519/core_ed25519.c
  libsodium/src/libsodium/crypto_core/ed25519/core_ristretto255.c
  libsodium/src/libsodium/crypto_core/ed25519/ref10/ed25519_ref10.c
  libsodium/src/libsodium/crypto_generichash/blake2b/ref/blake2b-load-sse2.h
  libsodium/src/libsodium/crypto_generichash/blake2b/ref/blake2b-load-avx2.h
  libsodium/src/libsodium/crypto_generichash/blake2b/ref/blake2.h
  libsodium/src/libsodium/crypto_generichash/blake2b/ref/blake2b-compress-ssse3.h
  libsodium/src/libsodium/crypto_generichash/blake2b/ref/blake2b-load-sse41.h
  libsodium/src/libsodium/crypto_generichash/blake2b/ref/blake2b-compress-avx2.h
  libsodium/src/libsodium/crypto_generichash/blake2b/ref/blake2b-compress-sse41.h
  libsodium/src/libsodium/crypto_sign/ed25519/ref10/sign_ed25519_ref10.h
  libsodium/src/libsodium/include/sodium.h
  libsodium/src/libsodium/include/sodium/crypto_stream_salsa2012.h
  libsodium/src/libsodium/include/sodium/crypto_auth.h
  libsodium/src/libsodium/include/sodium/utils.h
  libsodium/src/libsodium/include/sodium/crypto_core_hchacha20.h
  libsodium/src/libsodium/include/sodium/crypto_hash_sha512.h
  libsodium/src/libsodium/include/sodium/core.h
  libsodium/src/libsodium/include/sodium/export.h
  libsodium/src/libsodium/include/sodium/crypto_core_salsa20.h
  libsodium/src/libsodium/include/sodium/crypto_shorthash_siphash24.h
  libsodium/src/libsodium/include/sodium/randombytes.h
  libsodium/src/libsodium/include/sodium/crypto_hash_sha256.h
  libsodium/src/libsodium/include/sodium/crypto_stream.h
  libsodium/src/libsodium/include/sodium/crypto_auth_hmacsha512.h
  libsodium/src/libsodium/include/sodium/crypto_aead_xchacha20poly1305.h
  libsodium/src/libsodium/include/sodium/crypto_stream_salsa20.h
  libsodium/src/libsodium/include/sodium/crypto_onetimeauth_poly1305.h
  libsodium/src/libsodium/include/sodium/crypto_scalarmult_ristretto255.h
  libsodium/src/libsodium/include/sodium/crypto_kx.h
  libsodium/src/libsodium/include/sodium/crypto_hash.h
  libsodium/src/libsodium/include/sodium/crypto_sign.h
  libsodium/src/libsodium/include/sodium/crypto_kdf.h
  libsodium/src/libsodium/include/sodium/crypto_auth_hmacsha256.h
  libsodium/src/libsodium/include/sodium/crypto_box.h
  libsodium/src/libsodium/include/sodium/crypto_verify_32.h
  libsodium/src/libsodium/include/sodium/crypto_core_ristretto255.h
  libsodium/src/libsodium/include/sodium/crypto_stream_xchacha20.h
  libsodium/src/libsodium/include/sodium/crypto_core_salsa208.h
  libsodium/src/libsodium/include/sodium/crypto_auth_hmacsha512256.h
  libsodium/src/libsodium/include/sodium/crypto_aead_chacha20poly1305.h
  libsodium/src/libsodium/include/sodium/randombytes_sysrandom.h
  libsodium/src/libsodium/include/sodium/runtime.h
  libsodium/src/libsodium/include/sodium/crypto_stream_salsa208.h
  libsodium/src/libsodium/include/sodium/crypto_aead_aes256gcm.h
  libsodium/src/libsodium/include/sodium/crypto_core_salsa2012.h
  libsodium/src/libsodium/include/sodium/crypto_secretbox_xchacha20poly1305.h
  libsodium/src/libsodium/include/sodium/crypto_scalarmult.h
  libsodium/src/libsodium/include/sodium/crypto_pwhash.h
  libsodium/src/libsodium/include/sodium/crypto_verify_16.h
  libsodium/src/libsodium/include/sodium/crypto_stream_chacha20.h
  libsodium/src/libsodium/include/sodium/crypto_stream_xsalsa20.h
  libsodium/src/libsodium/include/sodium/crypto_core_hsalsa20.h
  libsodium/src/libsodium/include/sodium/crypto_kdf_blake2b.h
  libsodium/src/libsodium/include/sodium/crypto_scalarmult_curve25519.h
  libsodium/src/libsodium/include/sodium/crypto_shorthash.h
  libsodium/src/libsodium/include/sodium/crypto_pwhash_argon2id.h
  libsodium/src/libsodium/include/sodium/crypto_secretstream_xchacha20poly1305.h
  libsodium/src/libsodium/include/sodium/crypto_pwhash_scryptsalsa208sha256.h
  libsodium/src/libsodium/include/sodium/crypto_sign_ed25519.h
  libsodium/src/libsodium/include/sodium/crypto_onetimeauth.h
  libsodium/src/libsodium/include/sodium/crypto_verify_64.h
  libsodium/src/libsodium/include/sodium/crypto_box_curve25519xchacha20poly1305.h
  libsodium/src/libsodium/include/sodium/crypto_core_ed25519.h
  libsodium/src/libsodium/include/sodium/crypto_pwhash_argon2i.h
  libsodium/src/libsodium/include/sodium/randombytes_internal_random.h
  libsodium/src/libsodium/include/sodium/crypto_generichash.h
  libsodium/src/libsodium/include/sodium/crypto_secretbox_xsalsa20poly1305.h
  libsodium/src/libsodium/include/sodium/crypto_secretbox.h
  libsodium/src/libsodium/include/sodium/crypto_scalarmult_ed25519.h
  libsodium/src/libsodium/include/sodium/crypto_box_curve25519xsalsa20poly1305.h
  libsodium/src/libsodium/include/sodium/crypto_generichash_blake2b.h
  libsodium/src/libsodium/include/sodium/crypto_sign_edwards25519sha512batch.h
  libsodium/src/libsodium/include/sodium/private/ed25519_ref10.h
  libsodium/src/libsodium/include/sodium/private/ed25519_ref10_fe_25_5.h
  libsodium/src/libsodium/include/sodium/private/ed25519_ref10_fe_51.h
  libsodium/src/libsodium/include/sodium/private/sse2_64_32.h
  libsodium/src/libsodium/include/sodium/private/common.h
  libsodium/src/libsodium/include/sodium/private/mutex.h
  libsodium/src/libsodium/include/sodium/private/chacha20_ietf_ext.h
  libsodium/src/libsodium/include/sodium/private/implementations.h
  libsodium/src/libsodium/crypto_pwhash/argon2/blamka-round-ref.h
  libsodium/src/libsodium/crypto_pwhash/argon2/blamka-round-avx2.h
  libsodium/src/libsodium/crypto_pwhash/argon2/argon2.h
  libsodium/src/libsodium/crypto_pwhash/argon2/blamka-round-ssse3.h
  libsodium/src/libsodium/crypto_pwhash/argon2/argon2-encoding.h
  libsodium/src/libsodium/crypto_pwhash/argon2/blake2b-long.h
  libsodium/src/libsodium/crypto_pwhash/argon2/blamka-round-avx512f.h
  libsodium/src/libsodium/crypto_pwhash/argon2/argon2-core.h
  libsodium/src/libsodium/crypto_pwhash/scryptsalsa208sha256/crypto_scrypt.h
  libsodium/src/libsodium/crypto_pwhash/scryptsalsa208sha256/pbkdf2-sha256.h
  libsodium/src/libsodium/crypto_shorthash/siphash24/ref/shorthash_siphash_ref.h
  libsodium/src/libsodium/crypto_scalarmult/curve25519/scalarmult_curve25519.h
  libsodium/src/libsodium/crypto_scalarmult/curve25519/sandy2x/consts_namespace.h
  libsodium/src/libsodium/crypto_scalarmult/curve25519/sandy2x/ladder_namespace.h
  libsodium/src/libsodium/crypto_scalarmult/curve25519/sandy2x/fe.h
  libsodium/src/libsodium/crypto_scalarmult/curve25519/sandy2x/ladder_base_namespace.h
  libsodium/src/libsodium/crypto_scalarmult/curve25519/sandy2x/ladder.h
  libsodium/src/libsodium/crypto_scalarmult/curve25519/sandy2x/fe51.h
  libsodium/src/libsodium/crypto_scalarmult/curve25519/sandy2x/curve25519_sandy2x.h
  libsodium/src/libsodium/crypto_scalarmult/curve25519/sandy2x/fe51_namespace.h
  libsodium/src/libsodium/crypto_scalarmult/curve25519/sandy2x/ladder_base.h
  libsodium/src/libsodium/crypto_scalarmult/curve25519/ref10/x25519_ref10.h
  libsodium/src/libsodium/crypto_onetimeauth/poly1305/onetimeauth_poly1305.h
  libsodium/src/libsodium/crypto_onetimeauth/poly1305/donna/poly1305_donna.h
  libsodium/src/libsodium/crypto_onetimeauth/poly1305/donna/poly1305_donna64.h
  libsodium/src/libsodium/crypto_onetimeauth/poly1305/donna/poly1305_donna32.h
  libsodium/src/libsodium/crypto_onetimeauth/poly1305/sse2/poly1305_sse2.h
  libsodium/src/libsodium/crypto_stream/chacha20/stream_chacha20.h
  libsodium/src/libsodium/crypto_stream/chacha20/ref/chacha20_ref.h
  libsodium/src/libsodium/crypto_stream/chacha20/dolbeau/u4.h
  libsodium/src/libsodium/crypto_stream/chacha20/dolbeau/chacha20_dolbeau-ssse3.h
  libsodium/src/libsodium/crypto_stream/chacha20/dolbeau/u0.h
  libsodium/src/libsodium/crypto_stream/chacha20/dolbeau/u1.h
  libsodium/src/libsodium/crypto_stream/chacha20/dolbeau/chacha20_dolbeau-avx2.h
  libsodium/src/libsodium/crypto_stream/chacha20/dolbeau/u8.h
  libsodium/src/libsodium/crypto_stream/salsa20/stream_salsa20.h
  libsodium/src/libsodium/crypto_stream/salsa20/ref/salsa20_ref.h
  libsodium/src/libsodium/crypto_stream/salsa20/xmm6int/u4.h
  libsodium/src/libsodium/crypto_stream/salsa20/xmm6int/u0.h
  libsodium/src/libsodium/crypto_stream/salsa20/xmm6int/u1.h
  libsodium/src/libsodium/crypto_stream/salsa20/xmm6int/salsa20_xmm6int-avx2.h
  libsodium/src/libsodium/crypto_stream/salsa20/xmm6int/u8.h
  libsodium/src/libsodium/crypto_stream/salsa20/xmm6int/salsa20_xmm6int-sse2.h
  libsodium/src/libsodium/crypto_stream/salsa20/xmm6/salsa20_xmm6.h
  libsodium/src/libsodium/crypto_core/ed25519/ref10/fe_25_5/constants.h
  libsodium/src/libsodium/crypto_core/ed25519/ref10/fe_25_5/fe.h
  libsodium/src/libsodium/crypto_core/ed25519/ref10/fe_25_5/base2.h
  libsodium/src/libsodium/crypto_core/ed25519/ref10/fe_25_5/base.h
  libsodium/src/libsodium/crypto_core/ed25519/ref10/fe_51/constants.h
  libsodium/src/libsodium/crypto_core/ed25519/ref10/fe_51/fe.h
  libsodium/src/libsodium/crypto_core/ed25519/ref10/fe_51/base2.h
  libsodium/src/libsodium/crypto_core/ed25519/ref10/fe_51/base.h
  )

find_package(Git)
if(GIT_FOUND)
  message("git found: ${GIT_EXECUTABLE} in version ${GIT_VERSION_STRING}")
endif()

execute_process(
  COMMAND ${GIT_EXECUTABLE} tag --points-at HEAD
  WORKING_DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR}/libsodium
  OUTPUT_VARIABLE libsodium_tag
  )

string(STRIP ${libsodium_tag} VERSION)

if(NOT "${VERSION}" MATCHES "^[0-9]+\\.[0-9]+\\.[0-9]+$")
  message(FATAL_ERROR "Invalid libsodium version='${VERSION}'")
endif()

string(REGEX MATCH "^([0-9]+)\\.([0-9]+)\\.[0-9]+$" reout "${VERSION}")
set(SODIUM_LIBRARY_VERSION_MAJOR ${CMAKE_MATCH_1})
set(SODIUM_LIBRARY_VERSION_MINOR ${CMAKE_MATCH_2})

configure_file(
  libsodium/src/libsodium/include/sodium/version.h.in
  ${CMAKE_CURRENT_BINARY_DIR}/libsodium/include/sodium/version.h
  )

add_library(libsodium
  ${libsodium_SOURCES}
  )

target_include_directories(libsodium PRIVATE
  ${CMAKE_CURRENT_SOURCE_DIR}/libsodium/src/libsodium/include/sodium
  ${CMAKE_CURRENT_BINARY_DIR}/libsodium/include/sodium
  )

target_include_directories(libsodium SYSTEM INTERFACE
  ${CMAKE_CURRENT_SOURCE_DIR}/libsodium/src/libsodium/include
  ${CMAKE_CURRENT_SOURCE_DIR}/libsodium/src/libsodium/include/sodium
  ${CMAKE_CURRENT_BINARY_DIR}/libsodium/include
  )

target_compile_definitions(libsodium
  PUBLIC SODIUM_STATIC
  PRIVATE CONFIGURED
  )

set_target_properties(libsodium PROPERTIES
  FOLDER external/libsodium
  )

foreach(source IN LISTS libsodium_SOURCES)
  string(SUBSTRING ${source} 24 -1 source_stripped) # strip off libsodium/src/libsodium prefix
  get_filename_component(source_path "${source_stripped}" PATH)
  string(REPLACE "/" "\\" source_path_msvc "${source_path}")
  source_group("${source_path_msvc}" FILES "${source}")
endforeach()
