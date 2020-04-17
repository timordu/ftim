#import "FtimPlugin.h"
#if __has_include(<ftim/ftim-Swift.h>)
#import <ftim/ftim-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "ftim-Swift.h"
#endif

@implementation FtimPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftFtimPlugin registerWithRegistrar:registrar];
}
@end
