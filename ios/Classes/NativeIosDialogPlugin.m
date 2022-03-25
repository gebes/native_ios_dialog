#import "NativeIosDialogPlugin.h"
#if __has_include(<native_ios_dialog/native_ios_dialog-Swift.h>)
#import <native_ios_dialog/native_ios_dialog-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "native_ios_dialog-Swift.h"
#endif

@implementation NativeIosDialogPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftNativeIosDialogPlugin registerWithRegistrar:registrar];
}
@end
