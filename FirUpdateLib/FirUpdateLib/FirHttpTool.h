//
//  FirHttpTool.h
//  FirUpdateLib
//
//  Created by Jin Jian on 2018/3/15.
//  Copyright © 2018年 com.themoviebook.tmb. All rights reserved.
//

#import <Foundation/Foundation.h>

//typedef void(^SuccessBlock)(id object , NSURLResponse *response);
//typedef void(^failBlock)(NSError *error);
typedef void (^SuccessBlock)(NSDictionary * response);
typedef void (^FailureBlock)(NSError * error);

@interface FirHttpTool : NSObject

- (void)getRequestWithUrl:(NSString *)urlString
               paramaters:(NSDictionary *)paramaters
             successBlock:(SuccessBlock)success
                FailBlock:(FailureBlock)fail;

@end
