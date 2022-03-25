#import <Flutter/Flutter.h>

#import <Foundation/Foundation.h>

NS_INLINE NSException * _Nullable tryBlock(void(^_Nonnull tryBlock)(void)) {
@try {
tryBlock();
}
@catch (NSException *exception) {
return exception;
}
return nil;
}
@interface NativeIosDialogPlugin : NSObject<FlutterPlugin>
@end
