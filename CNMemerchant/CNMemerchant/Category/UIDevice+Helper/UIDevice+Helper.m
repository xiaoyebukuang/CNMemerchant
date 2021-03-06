//
//  UIDevice+Helper.m
//  cwz51
//
//  Created by 陈晓 on 2018/11/5.
//  Copyright © 2018年 XYBK. All rights reserved.
//

#import "UIDevice+Helper.h"
#import "KeyChainStore.h"
#include <ifaddrs.h>
#include <arpa/inet.h>
#include <net/if.h>
#import <AdSupport/AdSupport.h>
#define IOS_VPN         @"utun0"
#define IOS_WIFI        @"en0"
#define IOS_WIFI_MAC    @"en5"
#define IOS_CELLULAR    @"pdp_ip0"
#define IP_ADDR_IPv4    @"ipv4"
#define IP_ADDR_IPv6    @"ipv6"

@implementation UIDevice (Helper)
+ (NSString *)getIDFA {
    // 获取IDFA
    NSString * IDFA = [NSString safe_string:[[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString]];
    NSString *tempIDFA = [IDFA stringByReplacingOccurrencesOfString:@"-" withString:@""];
    tempIDFA = [tempIDFA stringByReplacingOccurrencesOfString:@"0" withString:@""];
    if (tempIDFA.length == 0) {
        return @"";
    }
    return IDFA;
}
/** 设备唯一id ->UUID */
+ (NSString *)getDeviceOnlyUUID {
    NSString * strUUID = (NSString *)[KeyChainStore load:KEY_USERNAME_PASSWORD];
    //首次执行该方法时，uuid为空
    if ([strUUID isEqualToString:@""]||!strUUID) {
        //生成一个uuid的方法
//        CFUUIDRef uuidRef = CFUUIDCreate(kCFAllocatorDefault);
//        strUUID = (NSString *)CFBridgingRelease(CFUUIDCreateString (kCFAllocatorDefault,uuidRef));
        strUUID = [[UIDevice currentDevice].identifierForVendor UUIDString];
        //将该uuid保存到keychain
        [KeyChainStore save:KEY_USERNAME_PASSWORD data:strUUID];
    }
    return [NSString safe_string:strUUID];
}
/** 获取设备IP地址 */
+ (NSString *)getDeviceIPAddress:(BOOL)preferIPv4 {
    NSArray *searchArray = @[IOS_VPN @"/" IP_ADDR_IPv4, IOS_WIFI @"/" IP_ADDR_IPv4, IOS_WIFI_MAC @"/" IP_ADDR_IPv4, IOS_CELLULAR @"/" IP_ADDR_IPv4];
//    NSArray *searchArray = preferIPv4 ?
//    @[ IOS_VPN @"/" IP_ADDR_IPv4, IOS_VPN @"/" IP_ADDR_IPv6, IOS_WIFI @"/" IP_ADDR_IPv4, IOS_WIFI @"/" IP_ADDR_IPv6, IOS_CELLULAR @"/" IP_ADDR_IPv4, IOS_CELLULAR @"/" IP_ADDR_IPv6 ] :
//    @[ IOS_VPN @"/" IP_ADDR_IPv6, IOS_VPN @"/" IP_ADDR_IPv4, IOS_WIFI @"/" IP_ADDR_IPv6,  IOS_WIFI @"/" IP_ADDR_IPv4, IOS_CELLULAR @"/" IP_ADDR_IPv6, IOS_CELLULAR @"/" IP_ADDR_IPv4 ] ;
    NSDictionary *addresses = [self getIPAddresses];
    __block NSString *address;
    [searchArray enumerateObjectsUsingBlock:^(NSString *key, NSUInteger idx, BOOL *stop) {
         address = addresses[key];
         if(address) *stop = YES;
     } ];
    return address ? address : @"0.0.0.0";
}
+ (NSDictionary *)getIPAddresses {
    NSMutableDictionary *addresses = [NSMutableDictionary dictionaryWithCapacity:8];
    // retrieve the current interfaces - returns 0 on success
    struct ifaddrs *interfaces;
    if(!getifaddrs(&interfaces)) {
        // Loop through linked list of interfaces
        struct ifaddrs *interface;
        for(interface=interfaces; interface; interface=interface->ifa_next) {
            if(!(interface->ifa_flags & IFF_UP) /* || (interface->ifa_flags & IFF_LOOPBACK) */ ) {
                continue; // deeply nested code harder to read
            }
            const struct sockaddr_in *addr = (const struct sockaddr_in*)interface->ifa_addr;
            char addrBuf[ MAX(INET_ADDRSTRLEN, INET6_ADDRSTRLEN) ];
            if(addr && (addr->sin_family==AF_INET || addr->sin_family==AF_INET6)) {
                NSString *name = [NSString stringWithUTF8String:interface->ifa_name];
                NSString *type;
                if(addr->sin_family == AF_INET) {
                    if(inet_ntop(AF_INET, &addr->sin_addr, addrBuf, INET_ADDRSTRLEN)) {
                        type = IP_ADDR_IPv4;
                    }
                } else {
                    const struct sockaddr_in6 *addr6 = (const struct sockaddr_in6*)interface->ifa_addr;
                    if(inet_ntop(AF_INET6, &addr6->sin6_addr, addrBuf, INET6_ADDRSTRLEN)) {
                        type = IP_ADDR_IPv6;
                    }
                }
                if(type) {
                    NSString *key = [NSString stringWithFormat:@"%@/%@", name, type];
                    addresses[key] = [NSString stringWithUTF8String:addrBuf];
                }
            }
        }
        // Free memory
        freeifaddrs(interfaces);
    }
    return [addresses count] ? addresses : nil;
}
+ (NSString *)getAppVersion {
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    NSString *app_Version = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
    return [NSString safe_string:app_Version];
}
+ (NSString *)getAppName {
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    NSString *app_Name = [infoDictionary objectForKey:@"CFBundleDisplayName"];
    return [NSString safe_string:app_Name];
}
+ (NSString *)getAppBuildID {
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    NSString *app_buildId = [infoDictionary objectForKey:@"CFBundleIdentifier"];
    return [NSString safe_string:app_buildId];
}
+ (void)callTel:(NSString *)tel {
    NSString *telStr = [NSString stringWithFormat:@"tel://%@",tel];
    /// 大于等于10.0系统使用此openURL方法
    if (@available(iOS 10.0, *)) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:telStr] options:@{} completionHandler:nil];
    } else {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:telStr]];
    }
}
+ (void)openURLStr:(NSString *)urlStr {
    if ([[UIApplication sharedApplication]canOpenURL:[NSURL URLWithString:urlStr]]) {
        [[UIApplication sharedApplication]openURL:[NSURL URLWithString:urlStr]];
    }
}
+ (void)openSetting {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
}

@end
