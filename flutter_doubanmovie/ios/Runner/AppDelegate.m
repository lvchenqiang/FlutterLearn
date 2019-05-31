#include "AppDelegate.h"
#include "GeneratedPluginRegistrant.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application
    didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    
    FlutterViewController* controller = (FlutterViewController*)self.window.rootViewController;
    
    FlutterMethodChannel* batteryChannel = [FlutterMethodChannel
                                            methodChannelWithName:@"flutter.doubanmovie/buy"
                                            binaryMessenger:controller];
    
    [batteryChannel setMethodCallHandler:^(FlutterMethodCall* call, FlutterResult result) {
      
        NSLog(@"%@---%@",call.method,call.arguments);
        // TODO
        if([call.method isEqualToString:@"buyTicket"]){
            UIAlertController * alertC = [UIAlertController alertControllerWithTitle:@"Flutter与原生交互" message:@"buyTicket" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction * action = [UIAlertAction  actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                
            }];
            [alertC addAction:action];
            [controller presentViewController:alertC animated:false completion:nil];
            
            
        }else{
            
        }
      
            result(0);
        
        
    }];
    
      [GeneratedPluginRegistrant registerWithRegistry:self];
    
  // Override point for customization after application launch.
  return [super application:application didFinishLaunchingWithOptions:launchOptions];
}

@end
