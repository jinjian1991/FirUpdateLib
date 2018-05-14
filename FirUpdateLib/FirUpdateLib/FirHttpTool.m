//
//  FirHttpTool.m
//  FirUpdateLib
//
//  Created by Jin Jian on 2018/3/15.
//  Copyright © 2018年 com.themoviebook.tmb. All rights reserved.
//

#import "FirHttpTool.h"

@implementation FirHttpTool

- (void)getRequestWithUrl:(NSString *)urlString
               paramaters:(NSDictionary *)paramaters
             successBlock:(SuccessBlock)success
                FailBlock:(FailureBlock)fail
{
    // 遍历参数字典,一一取出参数,按照参数格式拼接在 url 后面.
    
    NSMutableString *strM = [[NSMutableString alloc] init];
    
    [paramaters enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        
        // 服务器接收参数的 key 值.
        NSString *paramaterKey = key;
        
        // 参数内容
        NSString *paramaterValue = obj;
        
        // appendFormat :可变字符串直接拼接的方法!
        [strM appendFormat:@"%@=%@&",paramaterKey,paramaterValue];
    }];
    
    urlString = [NSString stringWithFormat:@"%@?%@",urlString,strM];
    
    // 截取字符串的方法!
//    urlString = [urlString substringToIndex:urlString.length - 1];
    
//    NSLog(@"urlString:%@",urlString);
    
    NSURL *url = [NSURL URLWithString:urlString];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:15];
    
    // 2. 发送网络请求.
    // completionHandler: 说明网络请求完成!
    [[[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (!data) {
            return ;
        }
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:&error];
        if (!error) {
            if (success) {
                success(dic);
            }
        } else {
            if (fail) {
                fail(error);
            }
        }
        
    }] resume];
}

@end
