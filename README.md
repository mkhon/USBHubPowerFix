# USBHubPowerFix

This codeless kext fixes "USB Device Needs Power" alert with non-Apple non-powered USB hubs
in El Capitan (OS X 10.11) and later.

Many of such hubs worked flawlessly in Yosemite but stopped working in El Capitan.
Whenever a USB device is plugged in into the hub the "USB Device Needs Power" alert appears with
the following error in the */var/log/system.log*:

```
Aug 10 09:25:08 Maximilians-iMac kernel[0]: 034851.758657 USB Mass Storage Device@fa124000: IOUSBHostDevice::setConfigurationGated: 480mA of bus current is not available
Aug 10 09:25:08 Maximilians-iMac kernel[0]: 034851.758664 AppleUSBCDCCompositeDevice@: AppleUSBHostCompositeDevice::ConfigureDevice: unable to set a configuration (0xe0005001)
```

I noticed that Apple USB Hub in Apple Keyboard however works in El Capitan.

The properties injected by this kext are copied from *Apple Aluminium Keyboard Properties*
from *AppleUSBHub.kext* driver (see here: */System/Library/Extensions/IOUSBHostFamily.kext/Contents/PlugIns/AppleUSBHub.kext/Contents/Info.plist*).

## Installation

1. Edit Vendor and Product ids to match your hub in *USBHubPowerFix.kext/Contents/Info.plist*
(you can find them by looking at idProduct and idVendor properties in `ioreg -c IOUSBHostDevice -r -l -w0` output).
2. Run `make install`.

Note: This kext is not signed. You need either to [disable SIP](http://apple.stackexchange.com/questions/208478/how-do-i-disable-system-integrity-protection-sip-aka-rootless-on-os-x-10-11) or sign it (see [Signing](#signing) below).

## Testing

1. Run `sudo kextload /Library/Extensions/USBHubPowerFix.kext` or `make load`
2. Check the output of `ioreg -c IOUSBHostDevice -r -l -w0` - *kUSBConfigurationCurrentOverride* property should appear in the output.
3. Please send me (as pull request or to fjoe@samodelkin.net) product id, vendor id and USB hub name if the fix works.

## Signing

You need to have Apple Developer Program subscription and [request a kext signing certificate](https://developer.apple.com/contact/kext/).

1. Modify IDENTITY= in Makefile
2. Run `make sign`
