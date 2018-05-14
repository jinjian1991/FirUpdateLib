//
//  FirUpdateLib.h
//  FirUpdateLib
//
//  Created by Jin Jian on 2018/3/15.
//  Copyright © 2018年 com.themoviebook.tmb. All rights reserved.
//

#import <Foundation/Foundation.h>


#define FIR_SERVER      @"http://api.fir.im/apps/latest/"
#define FIR_UPDATEURL   @""
#define FIR_TOKEN       @""
#define FIR_APPID       @""
#define ALERT_MESSAGE   @"监测到新版本，请更新!"

@interface FirUpdateLib : NSObject

+ (FirUpdateLib *)shared;
- (void)newVersion;

@end
