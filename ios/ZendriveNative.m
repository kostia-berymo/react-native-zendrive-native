#import <Foundation/Foundation.h>
#import <React/RCTBridgeModule.h>

@interface RCT_EXTERN_MODULE(DutyController, NSObject)
RCT_EXTERN_METHOD(setDriverId: (nonnull NSString *)driverId)
RCT_EXTERN_METHOD(ondutyButtonTapped)
RCT_EXTERN_METHOD(goOffDutyButtonTapped)
RCT_EXTERN_METHOD(acceptNewRequestButtonTapped)
RCT_EXTERN_METHOD(cancelPickupButtonTapped)
RCT_EXTERN_METHOD(pickupPassengerButtonTapped)
RCT_EXTERN_METHOD(dropPassengerButtonTapped)
@end
