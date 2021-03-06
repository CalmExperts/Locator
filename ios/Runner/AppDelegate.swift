import UIKit
import Flutter
import GoogleMaps
import Firebase         

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
    override func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?
        ) -> Bool {
        FirebaseApp.configure()
        GMSServices.provideAPIKey("AIzaSyBfLsD34HzCRxkd8AoN7HJfTDbvgzjHzyw")
        GeneratedPluginRegistrant.register(with: self)
        return super.application(application, didFinishLaunchingWithOptions: launchOptions)
    }
}
