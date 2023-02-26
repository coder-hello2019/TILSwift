import UIKit

/*
 Singleton is an object / instance of a class that is created once and used multiple times. A singleton guarantees that we'll only have that
one instance and no more. Helpful e.g. in networking where you don't necessarily
 want to be re-creating the same URL etc. over and over again.
 
 Some built-in classes, such as URLSession (URLSession.shared) / UserDefaults / FileManager, actually have singletons built in.
 
 Analysis:
 - globally available - can be a pro or a con, depending on circumstances
 - unit testing - difficult to isolate specific situations so can make testing difficult
 - can be difficult to track (e.g. how do you keep track of objects that are affected by changes to the singleton)
 See here for further discussion on singletons: https://cocoacasts.com/are-singletons-bad/
 
 */

// Basic implementation looks like this

class Settings {
    // this statis property gives other objects access to the singleton object of the Settings class.
    static let shared = Settings()
    var username: String?
    
    // private init is important because it prevents other parts of our code from trying to create a Settings class instance
    // it means that only the Settings class can create instances of itself
    private init() { }
}

// we could access this singleton like so
func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    print(Settings.shared)
    return true
}
