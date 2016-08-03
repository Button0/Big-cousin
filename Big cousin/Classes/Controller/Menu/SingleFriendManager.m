//
//  SingleFriendManager.m
//  Big cousin
//
//  Created by wuhan107 on 16/7/19.
//  Copyright © 2016年 Twilight. All rights reserved.
//

#import "SingleFriendManager.h"

@implementation SingleFriendManager

//单例
static SingleFriendManager *singleManager = nil;
+(instancetype)shareSingleFriendManager{
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        singleManager=[[SingleFriendManager alloc]init];
    });
    return singleManager;
}


//从服务器获取好友
-(NSArray *)requestAllFrineds{
    
    EMError *error = nil;
    NSArray *friendList = [[EMClient sharedClient].contactManager getContactsFromServerWithError:&error];
    
    if (!error) {
        
        NSLog(@"成功获取好友--\n%@",friendList);
    }else{
        
        NSLog(@"%@",error.errorDescription);
    }
    
    return friendList;
}

//添加好友 (用户A添加用户B)
-(void)addFriendWithName:(NSString *)useName{
    
    //参数1：好友用户名    参数2：邀请信息
    EMError *error = [[EMClient sharedClient].contactManager addContact:useName message:@"shabi"];
    if (!error) {
        NSLog(@"添加好友请求已发送--\n");
    }else{
        
        NSLog(@"%@",error);
    }
}

//删除好友
-(void)deleteFriendWithName:(NSString *)useName{
    
    
    EMError *error = [[EMClient sharedClient].contactManager deleteContact:useName];
    if (!error) {
        NSLog(@"删除好友成功--\n");
    }else{
        
        NSLog(@"%@",error);
    }
}


//加入黑名单
-(void)addFriendToBlackListWithName:(NSString *)userName{
    
    //参数2 --relationshipBoth： 是否同时屏蔽发给对方的消息
    EMError *error = [[EMClient sharedClient].contactManager addUserToBlackList:userName relationshipBoth:YES];
    if (!error) {
        NSLog(@"加入黑名单请求发送成功");
        
    }else{
        
        NSLog(@"%@",error);
    }
}

//将好友从黑名单移除
-(void)removeBlackListWithUserName:(NSString *)userName{
    
    
    EMError *error = [[EMClient sharedClient].contactManager removeUserFromBlackList:userName];
    if (!error) {
        NSLog(@"将好友从黑名单中移除的请求发送成功");
        
    }else{
        
        NSLog(@"%@",error);
    }
}




@end
