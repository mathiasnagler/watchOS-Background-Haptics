# watchOS-Background-Haptics

This is an example project demonstrating how to trigger vibrations on an Apple Watch with watchOS 3.x while the app is in the background.

## Requirements

- iOS 10.2
- watchOS 3.1
- Xcode 8.2.1 with Swift 3.0

Other version may work but are untested.

## Build and Installation

In order for this to work the app will need to be signed with a valid provisioning profile that contains the `HealthKit` entitlement. Be sure to change the Development Team to your own Team for all three available targets. Xcode will try to create the needed provisioning profiles. If there are any signing issues or you use a wildcard provisioning profile **running in the background will not work**.
It's also possible to disable automatic signing. In that case you are responsible for creating and using the correct provisioning profiles with matching entitlements.
