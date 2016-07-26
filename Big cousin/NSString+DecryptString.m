//
//  NSString+DecryptString.m
//  Big cousin
//
//  Created by Mushroom on 16/7/19.
//  Copyright © 2016年 Twilight. All rights reserved.
//

#import "NSString+DecryptString.h"
#import <CommonCrypto/CommonCryptor.h>

#define DES_KEY @"BJCYIBQ8"

@implementation NSString (DecryptString)

/** 解密 base64 */
- (NSString *)decryptedString
{
    //base64 decrypt
    NSData *data = [[NSData alloc] initWithBase64EncodedString:self options:NSDataBase64DecodingIgnoreUnknownCharacters];
    
    //DES key
    NSData *key = [DES_KEY dataUsingEncoding:NSUTF8StringEncoding];
    
    //DES decrypt
    size_t numBytesEncrypted = 0;
    size_t bufferSize = 0x400;//data.length + kCCBlockSizeDES;
    void *buffer_decrypt = malloc(bufferSize);
    CCCryptorStatus result = CCCrypt(kCCDecrypt,
                                     kCCAlgorithmDES,
                                     kCCOptionPKCS7Padding,
                                     key.bytes,
                                     kCCKeySizeDES,
                                     NULL, //这个参数好像蛮关键。如果调用直接出不来可用URL，可能被重复加密
                                     data.bytes,
                                     data.length,
                                     buffer_decrypt,
                                     bufferSize,
                                     &numBytesEncrypted);
    
    NSData *output = [NSData dataWithBytes:buffer_decrypt length:numBytesEncrypted];
    free(buffer_decrypt);
    if( result == kCCSuccess)
    {
        return [[NSString alloc] initWithData:output encoding:NSUTF8StringEncoding];
    }
    else
    {
        return nil;
    }
}

/** 解密原来的加密字符，并且将重复加密的字符替换域名，成可用url */
/** Decrypt the encrypted characters, and to replace the domain name, repeat the encrypted characters into available url */
- (NSString *)replacingStringToURL
{
   NSString *result = [[self decryptedString] stringByReplacingOccurrencesOfString:@"ivwt?)(kdn" withString:@"http://cdn"];
//    NSLog(@"替换后的可用URL:%@",result);
    return result;
}

@end
