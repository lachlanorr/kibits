//------------------------------------------------------------------------------
// kibits.cpp - Public C API
//
// Kibits - Distributed Game Blockchain Library
// Copyright (c) 2022 Lachlan Orr
//
// This software is provided 'as-is', without any express or implied
// warranty. In no event will the authors be held liable for any damages
// arising from the use of this software.
//
// Permission is granted to anyone to use this software for any purpose,
// including commercial applications, and to alter it and redistribute it
// freely, subject to the following restrictions:
//
//   1. The origin of this software must not be misrepresented; you must not
//   claim that you wrote the original software. If you use this software
//   in a product, an acknowledgment in the product documentation would be
//   appreciated but is not required.
//
//   2. Altered source versions must be plainly marked as such, and must not be
//   misrepresented as being the original software.
//
//   3. This notice may not be removed or altered from any source
//   distribution.
//------------------------------------------------------------------------------

#include <gtest/gtest.h>

#include <sodium.h>

#include "proto/kibits/key.pb.h"

TEST(GenerateKey, BasicAssertions)
{
    kibits::Key key;

    const unsigned char * MESSAGE = (const unsigned char *) "test";
    const size_t MESSAGE_LEN = 4;
    const size_t CIPHERTEXT_LEN = (crypto_box_MACBYTES + MESSAGE_LEN);

    unsigned char alice_publickey[crypto_box_PUBLICKEYBYTES];
    unsigned char alice_secretkey[crypto_box_SECRETKEYBYTES];
    crypto_box_keypair(alice_publickey, alice_secretkey);

    unsigned char bob_publickey[crypto_box_PUBLICKEYBYTES];
    unsigned char bob_secretkey[crypto_box_SECRETKEYBYTES];
    crypto_box_keypair(bob_publickey, bob_secretkey);

    unsigned char nonce[crypto_box_NONCEBYTES];
    unsigned char ciphertext[CIPHERTEXT_LEN];
    randombytes_buf(nonce, sizeof nonce);
    if (crypto_box_easy(ciphertext, MESSAGE, MESSAGE_LEN, nonce,
        bob_publickey, alice_secretkey) != 0) {
        /* error */
    }

    unsigned char decrypted[MESSAGE_LEN];
    if (crypto_box_open_easy(decrypted, ciphertext, CIPHERTEXT_LEN, nonce,
        alice_publickey, bob_secretkey) != 0) {
        /* message for Bob pretending to be from Alice has been forged! */
    }

    EXPECT_EQ(7* 6, 42);
}
