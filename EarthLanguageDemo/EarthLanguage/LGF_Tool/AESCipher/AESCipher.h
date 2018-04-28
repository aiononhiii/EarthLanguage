//
//  AESCipher.h
//  AESCipher
//
//  Created by Welkin Xie on 8/13/16.
//  Copyright © 2016 WelkinXie. All rights reserved.
//
//  https://github.com/WelkinXie/AESCipher-iOS
//

#import <Foundation/Foundation.h>

@interface AESCipher : NSObject


/**
 aes加密

 @param content 加密字符串
 @param key 加密key
 @return 返回加密数据
 */
+ (NSString *)encryptAES:(NSString *)content key:(NSString *)key;


/**
 aes解密

 @param content 解密字符串
 @param key 解密key
 @return 返回解密数据
 */
+ (NSString *)decryptAES:(NSString *)content key:(NSString *)key;

@end
