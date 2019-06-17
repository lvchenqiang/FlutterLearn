//
//  AsrManager.m
//  Runner
//
//  Created by 吕陈强 on 2019/6/17.
//  Copyright © 2019 The Chromium Authors. All rights reserved.
//

#import "AsrManager.h"
#import "BDSASRDefines.h"
#import "BDSASRParameters.h"
#import "BDSEventManager.h"

const NSString* APP_ID = @"16523852";
const NSString* API_KEY = @"aCIy051vjGPAydnksc6rfnIb";
const NSString* SECRET_KEY = @"uIa9ICxBv1HfxmgvXke3kFpalncahRIG";

@interface AsrManager ()<BDSClientASRDelegate>
@property (strong, nonatomic) BDSEventManager *asrEventManager;
@property(nonatomic, copy) AsrCallBack success;
@property(nonatomic, copy) AsrCallBack failure;
@end


@implementation AsrManager



+ (instancetype)initWithCallBck:(AsrCallBack)success faliure:(AsrCallBack)failure
{
    AsrManager * manager = [AsrManager new];
    manager.success = success;
    manager.failure = failure;
    
    
    
    
    return manager;
}


- (instancetype)init
{
    if(self = [super init]){
       _asrEventManager = [BDSEventManager createEventManagerWithName:BDS_ASR_NAME];
         [self configVoiceRecognitionClient];
    }
    return self;
}


- (void)start
{
  
    [self.asrEventManager setParameter:@(NO) forKey:BDS_ASR_NEED_CACHE_AUDIO];
    [self.asrEventManager setDelegate:self];
    
    [self.asrEventManager setParameter:@"" forKey:BDS_ASR_AUDIO_INPUT_STREAM];
    [self.asrEventManager setParameter:@"" forKey:BDS_ASR_AUDIO_FILE_PATH];
    [self.asrEventManager sendCommand:BDS_ASR_CMD_START];
    
    
    
}

- (void)stop
{
    [self.asrEventManager sendCommand:BDS_ASR_CMD_STOP];
}

- (void)cancel
{
    [self.asrEventManager sendCommand:BDS_ASR_CMD_CANCEL];
}

- (void)configVoiceRecognitionClient {
    //设置DEBUG_LOG的级别
    [self.asrEventManager setParameter:@(EVRDebugLogLevelTrace) forKey:BDS_ASR_DEBUG_LOG_LEVEL];
    //配置API_KEY 和 SECRET_KEY 和 APP_ID
    [self.asrEventManager setParameter:@[API_KEY, SECRET_KEY] forKey:BDS_ASR_API_SECRET_KEYS];
    [self.asrEventManager setParameter:APP_ID forKey:BDS_ASR_OFFLINE_APP_CODE];
    //配置端点检测（二选一）
    [self configModelVAD];
    //    [self configDNNMFE];
    
    //    [self.asrEventManager setParameter:@"15361" forKey:BDS_ASR_PRODUCT_ID];
    // ---- 语义与标点 -----
    //    [self enableNLU];
    //    [self enablePunctuation];
    // ------------------------
    
    //---- 语音自训练平台 ----
    //    [self configSmartAsr];
}


- (void)configModelVAD {
    NSString *modelVAD_filepath = [[NSBundle mainBundle] pathForResource:@"bds_easr_basic_model" ofType:@"dat"];
    [self.asrEventManager setParameter:modelVAD_filepath forKey:BDS_ASR_MODEL_VAD_DAT_FILE];
    [self.asrEventManager setParameter:@(YES) forKey:BDS_ASR_ENABLE_MODEL_VAD];
}


- (void)VoiceRecognitionClientWorkStatus:(int)workStatus obj:(id)aObj {
    switch (workStatus) {
        case EVoiceRecognitionClientWorkStatusNewRecordData: {
           
            break;
        }
            
        case EVoiceRecognitionClientWorkStatusStartWorkIng: {
//            NSDictionary *logDic = [self parseLogToDic:aObj];
            
            break;
        }
        case EVoiceRecognitionClientWorkStatusStart: {
           
            break;
        }
        case EVoiceRecognitionClientWorkStatusEnd: {
           
            break;
        }
        case EVoiceRecognitionClientWorkStatusFlushData: {
          
            break;
        }
        case EVoiceRecognitionClientWorkStatusFinish: {
          //
            if([aObj isKindOfClass:[NSDictionary class]]){
                NSString * result = aObj[@"results_recongnition"][0];
                if(_success)_success(result);
                
            }
            
            break;
        }
        case EVoiceRecognitionClientWorkStatusMeterLevel: {
            break;
        }
        case EVoiceRecognitionClientWorkStatusCancel: {
         
            break;
        }
        case EVoiceRecognitionClientWorkStatusError: {
         //
            if(_failure) _failure( [(NSString * )aObj description]);
            
            break;
        }
        case EVoiceRecognitionClientWorkStatusLoaded: {
          
            break;
        }
        case EVoiceRecognitionClientWorkStatusUnLoaded: {
          
            break;
        }
        case EVoiceRecognitionClientWorkStatusChunkThirdData: {
            break;
        }
        case EVoiceRecognitionClientWorkStatusChunkNlu: {
            NSString *nlu = [[NSString alloc] initWithData:(NSData *)aObj encoding:NSUTF8StringEncoding];
          
            break;
        }
        case EVoiceRecognitionClientWorkStatusChunkEnd: {
           
            break;
        }
        case EVoiceRecognitionClientWorkStatusFeedback: {
            NSDictionary *logDic = [self parseLogToDic:aObj];
           
            break;
        }
        case EVoiceRecognitionClientWorkStatusRecorderEnd: {
         
            break;
        }
        case EVoiceRecognitionClientWorkStatusLongSpeechEnd: {
         
            break;
        }
        default:
            break;
    }
}

- (NSDictionary *)parseLogToDic:(NSString *)logString
{
    NSArray *tmp = NULL;
    NSMutableDictionary *logDic = [[NSMutableDictionary alloc] initWithCapacity:3];
    NSArray *items = [logString componentsSeparatedByString:@"&"];
    for (NSString *item in items) {
        tmp = [item componentsSeparatedByString:@"="];
        if (tmp.count == 2) {
            [logDic setObject:tmp.lastObject forKey:tmp.firstObject];
        }
    }
    return logDic;
}
@end


