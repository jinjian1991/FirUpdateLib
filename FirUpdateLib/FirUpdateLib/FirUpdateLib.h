//
//  FirUpdateLib.h
//  FirUpdateLib
//
//  Created by Jin Jian on 2018/3/15.
//  Copyright © 2018年 com.themoviebook.tmb. All rights reserved.
//

#import <Foundation/Foundation.h>


#define FIR_SERVER      @"http://api.fir.im/apps/latest/"
#define FIR_UPDATEURL   @"https://fir.im/udapp"
#define FIR_TOKEN       @"f862d8abfe923cc8bacbf90f8521a4c3"
#define FIR_APPID       @"5aea7c87959d6953cada53bc"
#define ALERT_MESSAGE   @"监测到新版本，请更新!"

@interface FirUpdateLib : NSObject

+ (FirUpdateLib *)shared;
- (void)newVersion;

@end
