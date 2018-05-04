//
//
// CryptFunc.c
// Created by Alex on 2018/5/4
// Copyright © 2018年 alexiuce.github.io. All rights reserved.

//

#include <stdio.h>

#include <CommonCrypto/CommonCrypto.h>


char * md5(char * text){
    static unsigned char result[CC_MD5_DIGEST_LENGTH];
    unsigned int textLength =  (unsigned int)strlen(text);
    bzero(result, CC_MD5_DIGEST_LENGTH);
    CC_MD5(text,textLength, result);
    static  char swift_md5[CC_MD5_DIGEST_LENGTH * 2];
    for (int i = 0; i < CC_MD5_DIGEST_LENGTH; i++) {
        sprintf(&swift_md5[i * 2], "%02x",result[i]);
    }
    return swift_md5;
}

/*
char *sha1(char * text){
 
}
 */

