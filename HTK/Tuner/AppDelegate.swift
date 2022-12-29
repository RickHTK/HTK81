//import UIKit
//import SwiftUI
import AVFoundation
import AudioKit
//import AudioKitUI
//import Accelerate
import GoogleMobileAds

//@UIApplicationMain

/*
/// error is possibly an apple bug..
class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.

        #if os(iOS)
        
        GADMobileAds.sharedInstance().start(completionHandler: nil)
        
        do {
 
            Settings.bufferLength = .short
            try AVAudioSession.sharedInstance().setPreferredIOBufferDuration(Settings.bufferLength.duration)
            try AVAudioSession.sharedInstance().setCategory(.playAndRecord,
                                                            options: [.defaultToSpeaker, .mixWithOthers, .allowBluetoothA2DP]
            )
            try AVAudioSession.sharedInstance().setActive(true)
        } catch let err {
            print(err)
        }
        #endif
        
        

        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication,
                     configurationForConnecting connectingSceneSession: UISceneSession,
                     options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    
    
}
*/

import SwiftUI
import AVFoundation
import AudioKit
//import AudioKitUI
//import Accelerate
import GoogleMobileAds

@main
struct HTK202201App: App {
    
    var mainAudioEngine : AudioEngine = AudioEngine()
    
    init ()
    {
        
#if os(iOS)
        
        GADMobileAds.sharedInstance().start(completionHandler: nil)
        
        
    do {
        Settings.bufferLength = .short
        try AVAudioSession.sharedInstance().setPreferredIOBufferDuration(Settings.bufferLength.duration)
        try AVAudioSession.sharedInstance().setCategory(.playAndRecord,
                                                        options: [.defaultToSpeaker, .mixWithOthers, .allowBluetoothA2DP])
        try AVAudioSession.sharedInstance().setActive(true)
    } catch let err {
        print(err)
    }
    
    
        
#endif
    }
    var body: some Scene {
        WindowGroup {
            SplashView ()

        }
    }
}
