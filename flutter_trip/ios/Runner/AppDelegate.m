#include "AppDelegate.h"
#include "GeneratedPluginRegistrant.h"
#import "AsrPlugin.h"
@implementation AppDelegate

- (BOOL)application:(UIApplication *)application
    didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    /// 注册自己的插件
    [AsrPlugin registerWithRegistrar:[self registrarForPlugin:@"AsrPlugin"]];
    
    
  [GeneratedPluginRegistrant registerWithRegistry:self];
  // Override point for customization after application launch.
  return [super application:application didFinishLaunchingWithOptions:launchOptions];
}

@end
