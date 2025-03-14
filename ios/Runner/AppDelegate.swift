import UIKit
import Flutter
import GoogleMaps

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GMSServices.provideAPIKey("AIzaSyB9lsTqNLuNMb1jkQdNie-jOAwW8PN2Zdo")

    if let userDefaults = UserDefaults(suiteName: "group.com.katkootalwadi.katkootalwadi.onesignal") {
              userDefaults.set("test 1" as AnyObject, forKey: "key1")
              userDefaults.set("test 2" as AnyObject, forKey: "key2")
              userDefaults.synchronize()
          }
          if let userDefaults = UserDefaults(suiteName: "group.com.katkootalwadi.katkootalwadi.onesignal_service") {
              let value1 = userDefaults.string(forKey: "key1")
              let value2 = userDefaults.string(forKey: "key2")
              print("value1 = ", value1?.description ?? "No value")
              print("value2 = ", value2?.description ?? "No value")
          }
    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
