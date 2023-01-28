import Cocoa

// we need Foundation as this contains the URLSession class
import Foundation

/* A playground to practice fetching data from an API and using this data with the help of the Codable protocol. We'll be using this api endpoint for practice purposes: https://ergast.com/api/f1/2021/constructors.json.
*/

// MARK: the URLSession API
/*
 The URLSession API is the main way in which we can load URLs into the app. See Apple documentation here: https://developer.apple.com/documentation/foundation/url_loading_system and a helpful Cocoacasts article here: https://cocoacasts.com/networking-fundamentals-how-to-make-an-http-request-in-swift .
 
 A URLSession is an object used to coordinate a series of data-transfer tasks. A single task might, for example, be used for fetching URLs in a single web browser window.
 
 General points to note:
    - URLSession performs tasks asynchronously to avoid freezing apps.
    - Tasks share a common URLSession configuration object.
    - URLSession has a singleton shared session for basic requirements.
 */

// we fetch data through a URLSession using tasks - 'dataTask' is the task that fetches the contents of the specified URL (but we need to create the URL first!)
let url = URL(string: "https://ergast.com/api/f1/2021/constructors.json")!

// then we create the dataTask - note the reference to the 'shared' property of URLSession. This is needed because, as mentioned above, URLSession uses a singleton.
let task = URLSession.shared.dataTask(with: url){ data, response, error in
    if let receivedData = data {
        print("success")
        print(receivedData)
    } else if let receivedError = error {
        print("Error: \(receivedError.localizedDescription)")
    }
}

task.resume()

// so at this point we get some data back, but that's just json turned into a bunch of bytes. We need to transform it into a format that can sensibly be used in our Swift code.
