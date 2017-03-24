//
//  LDNetPing.m
//  LDNetCheckServiceDemo
//
//  Created by 庞辉 on 14-10-29.
//  Copyright (c) 2014年 庞辉. All rights reserved.
//
#include <sys/socket.h>
#include <netdb.h>

#import "LYTNetPing.h"
#import "LYTNetTimer.h"

//#define MAXCOUNT_PING 4
static NSInteger MAXCOUNT_PING ;
@interface LYTNetPing () {
    BOOL _isStartSuccess; //监测第一次ping是否成功
    NSInteger _sendCount;  //当前执行次数
    long _startTime; //每次执行的开始时间
    NSString *_hostAddress; //目标域名的IP地址
    BOOL _isLargePing;
    NSTimer *timer;
}

@property (nonatomic, strong, readwrite) LYTSimplePing *pinger;

@end


@implementation LYTNetPing
@synthesize pinger = _pinger;


- (void)dealloc
{
    [self->_pinger stop];
}


/**
 * 停止当前ping动作
 */
- (void)stopPing
{
    [self->_pinger stop];
    self.pinger = nil;
    _sendCount = MAXCOUNT_PING + 1;
}


/*
 * 调用pinger解析指定域名
 * @param hostName 指定域名
 */
- (void)runWithHostName:(NSString *)hostName normalPing:(BOOL)normalPing count:(NSInteger) count{
    MAXCOUNT_PING = count;
    assert(self.pinger == nil);
    self.pinger = [[LYTSimplePing alloc] initWithHostName:hostName];
    assert(self.pinger != nil);
    
    _isLargePing = !normalPing;
    self.pinger.delegate = self;
    [self.pinger start];
    
    //在当前线程一直执行
    _sendCount = 1;
    do {
        [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]];
    } while (self.pinger != nil || _sendCount <= MAXCOUNT_PING);
}


/*
 * 发送Ping数据，pinger会组装一个ICMP控制报文的数据发送过去
 *
 */
- (void)sendPing
{
    if (timer) {
        [timer invalidate];
    }
    if (_sendCount > MAXCOUNT_PING) {
        _sendCount++;
        self.pinger = nil;
        if (self.delegate && [self.delegate respondsToSelector:@selector(netPingDidEnd)]) {
            [self.delegate netPingDidEnd];
        }
    }
    
    else {
        assert(self.pinger != nil);
        _sendCount++;
        _startTime = [LYTNetTimer getMicroSeconds];
        if (_isLargePing) {
            NSString *testStr = @"";
            for (int i=0; i<408; i++) {
                testStr = [testStr stringByAppendingString:@"abcdefghi "];
            }
            testStr = [testStr stringByAppendingString:@"abcdefgh"];
            NSData *data = [testStr dataUsingEncoding:NSASCIIStringEncoding];
            [self.pinger sendPingWithData:data];
        } else {
            [self.pinger sendPingWithData:nil];
        }
        timer = [NSTimer scheduledTimerWithTimeInterval:3.0
                                                 target:self
                                               selector:@selector(pingTimeout:)
                                               userInfo:[NSNumber numberWithInteger:_sendCount]
                                                repeats:NO];
    }
}

- (void)pingTimeout:(NSTimer *)index
{
    if ([[index userInfo] intValue] == _sendCount && _sendCount <= MAXCOUNT_PING + 1 &&
        _sendCount > 1) {
        NSString *timeoutLog =
        [NSString stringWithFormat:@"ping: cannot resolve %@: TimeOut", _hostAddress];
        LYTPingInfo *info = [[LYTPingInfo alloc] init];
        info.infoStr = timeoutLog;
    
        if (self.delegate && [self.delegate respondsToSelector:@selector(appendPingLog:)]) {
            [self.delegate appendPingLog:info];
        }
        [self sendPing];
    }
}


#pragma mark - Pingdelegate
/*
 * PingDelegate: 套接口开启之后发送ping数据，并开启一个timer（1s间隔发送数据）
 *
 */
- (void)simplePing:(LYTSimplePing *)pinger didStartWithAddress:(NSData *)address
{
#pragma unused(pinger)
    assert(pinger == self.pinger);
    assert(address != nil);
    _hostAddress = [self DisplayAddressForAddress:address];
    NSLog(@"pinging %@", _hostAddress);
    
    // Send the first ping straight away.
    _isStartSuccess = YES;
    [self sendPing];
}

/*
 * PingDelegate: ping命令发生错误之后，立即停止timer和线程
 *
 */
- (void)simplePing:(LYTSimplePing *)pinger didFailWithError:(NSError *)error
{
#pragma unused(pinger)
    assert(pinger == self.pinger);
#pragma unused(error)
    NSString *failCreateLog = [NSString stringWithFormat:@"#%zd try create failed: %@", _sendCount,
                               [self shortErrorFromError:error]];
    LYTPingInfo *info = [[LYTPingInfo alloc] init];
    info.infoStr = failCreateLog;
    if (self.delegate && [self.delegate respondsToSelector:@selector(appendPingLog:)]) {
        [self.delegate appendPingLog:info];
    }
    
    //如果不是创建套接字失败，都是发送数据过程中的错误,可以继续try发送数据
    if (_isStartSuccess) {
        [self sendPing];
    } else {
        [self stopPing];
    }
}

/*
 * PingDelegate: 发送ping数据成功
 *
 */
- (void)simplePing:(LYTSimplePing *)pinger didSendPacket:(NSData *)packet sequenceNumber:(uint16_t)sequenceNumber;
{
#pragma unused(pinger)
    assert(pinger == self.pinger);
#pragma unused(packet)
//    NSLog(@"#%u sent success",sequenceNumber);
}


/*
 * PingDelegate: 发送ping数据失败
 */
- (void)simplePing:(LYTSimplePing *)pinger didFailToSendPacket:(NSData *)packet sequenceNumber:(uint16_t)sequenceNumber error:(NSError *)error
{
#pragma unused(pinger)
    assert(pinger == self.pinger);
#pragma unused(packet)
#pragma unused(error)
    NSString *sendFailLog =
    [NSString stringWithFormat:@"#%u send failed: %@",sequenceNumber,
     [self shortErrorFromError:error]];
    //记录
    LYTPingInfo *info = [[LYTPingInfo alloc] init];
    info.infoStr = sendFailLog;
    info.sequence = [NSString stringWithFormat:@"%u",sequenceNumber];
    if (self.delegate && [self.delegate respondsToSelector:@selector(appendPingLog:)]) {
        [self.delegate appendPingLog:info];
    }
    
    [self sendPing];
}


/*
 * PingDelegate: 成功接收到PingResponse数据
 */
- (void)simplePing:(LYTSimplePing *)pinger didReceivePingResponsePacket:(NSData *)packet sequenceNumber:(uint16_t)sequenceNumber
{
#pragma unused(pinger)
    assert(pinger == self.pinger);
#pragma unused(packet)
    //由于IPV6在IPheader中不返回TTL数据，所以这里不返回TTL，改为返回Type
    //http://blog.sina.com.cn/s/blog_6a1837e901012ds8.html
    NSString *icmpReplyType = [NSString stringWithFormat:@"%@", [LYTSimplePing icmpInPacket:packet]->type == 129 ? @"ICMPv6TypeEchoReply" : @"ICMPv4TypeEchoReply"];
    NSString *successLog = [NSString
                            stringWithFormat:@"%lu bytes from %@ icmp_seq=#%u type=%@ time=%ldms",
                            (unsigned long)[packet length], _hostAddress,
                            sequenceNumber,
                            icmpReplyType,
                            [LYTNetTimer computeDurationSince:_startTime] / 1000];
    LYTPingInfo *info = [[LYTPingInfo alloc] init];
    info.infoStr = successLog;
    info.durationTime = [LYTNetTimer computeDurationSince:_startTime] / 1000;
    info.sequence = [NSString stringWithFormat:@"%zd",sequenceNumber];
   const struct ICMPHeader *headr = [LYTSimplePing icmpInPacket:packet];
    info.identifier = [NSString stringWithFormat:@"%u", headr->identifier];
    //记录ping成功的数据
    if (self.delegate && [self.delegate respondsToSelector:@selector(appendPingLog:)]) {
        [self.delegate appendPingLog:info];
    }
    
    [self sendPing];
}


/*
 * PingDelegate: 接收到错误的pingResponse数据
 */
- (void)simplePing:(LYTSimplePing *)pinger didReceiveUnexpectedPacket:(NSData *)packet
{
    const ICMPHeader *icmpPtr;
    if (self.pinger && pinger == self.pinger) {
        icmpPtr = [LYTSimplePing icmpInPacket:packet];
        NSString *errorLog = @"";
        LYTPingInfo *info = [[LYTPingInfo alloc] init];
        
        if (icmpPtr != NULL) {
            unsigned int seqenceNumber = (unsigned int)OSSwapBigToHostInt16(icmpPtr->sequenceNumber);
            unsigned int icmpType = (unsigned int)icmpPtr->type;
            unsigned int icmpCode = (unsigned int)icmpPtr->code;
            unsigned int icmpId = (unsigned int)OSSwapBigToHostInt16(icmpPtr->identifier);
            errorLog = [NSString
                        stringWithFormat:@"#%u unexpected ICMP type=%u, code=%u, identifier=%u",
                        seqenceNumber,
                        icmpType,
                        icmpCode,
                        icmpId];
            
            info.sequence = [NSString stringWithFormat:@"%zd",seqenceNumber];
            info.identifier = [NSString stringWithFormat:@"%zd",icmpId];
            
        } else {
            errorLog = [NSString stringWithFormat:@"#%zd try unexpected packet size=%zu", _sendCount,
                        (size_t)[packet length]];
        }
        info.infoStr  = errorLog;
        //记录
        if (self.delegate && [self.delegate respondsToSelector:@selector(appendPingLog:)]) {
            [self.delegate appendPingLog:info];
        }
    }
    
    //当检测到错误数据的时候，再次发送
    [self sendPing];
}

/**
 * 将ping接收的数据转换成ip地址
 * @param address 接受的ping数据
 */
-(NSString *)DisplayAddressForAddress:(NSData *)address
{
    int err;
    NSString *result;
    char hostStr[NI_MAXHOST];
    
    result = nil;
    
    if (address != nil) {
        err = getnameinfo([address bytes], (socklen_t)[address length], hostStr, sizeof(hostStr),
                          NULL, 0, NI_NUMERICHOST);
        if (err == 0) {
            result = [NSString stringWithCString:hostStr encoding:NSASCIIStringEncoding];
            assert(result != nil);
        }
    }
    
    return result;
}

/*
 * 解析错误数据并翻译
 */
- (NSString *)shortErrorFromError:(NSError *)error
{
    NSString *result;
    NSNumber *failureNum;
    int failure;
    const char *failureStr;
    
    assert(error != nil);
    
    result = nil;
    
    // Handle DNS errors as a special case.
    
    if ([[error domain] isEqual:(NSString *)kCFErrorDomainCFNetwork] &&
        ([error code] == kCFHostErrorUnknown)) {
        failureNum = [[error userInfo] objectForKey:(id)kCFGetAddrInfoFailureKey];
        if ([failureNum isKindOfClass:[NSNumber class]]) {
            failure = [failureNum intValue];
            if (failure != 0) {
                failureStr = gai_strerror(failure);
                if (failureStr != NULL) {
                    result = [NSString stringWithUTF8String:failureStr];
                    assert(result != nil);
                }
            }
        }
    }
    
    // Otherwise try various properties of the error object.
    
    if (result == nil) {
        result = [error localizedFailureReason];
    }
    if (result == nil) {
        result = [error localizedDescription];
    }
    if (result == nil) {
        result = [error description];
    }
    assert(result != nil);
    return result;
}
@end
