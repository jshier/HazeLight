HazeLight
=========

HazeLight is a basic client for CloudFlare™ on iOS 8.1+. Developed using the Cocoa Touch APIs and test driven development, it is still a work in progress.

CloudFlare API Key and Email Address
=========

HazeLight requires an email address and associated CloudFlare API key to function. Create the files email.txt and apiKey.txt containing your CloudFlare email API key in the HazeLight/HazeLight directory. Never commit these files to the repository.

How to Build
=========

HazeLight uses CocoaPods to manage its testing frameworks. If you wish to build without tests, just build the Xcode project like normal. Otherwise, install [CocoaPods](http://cocoapods.org) and run `pod install` from the cloned directory.