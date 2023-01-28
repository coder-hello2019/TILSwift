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

/*
 So at this point we get some data back, but that's just json turned into a bunch of bytes. We need to transform it into a format that can sensibly be used in our Swift code. We normally do this using a JSONDecoder and the Codable protocol (Codable encapsulates both Encodable and Decodable).
 
 As per Apple's documentation:
    * a JSONDecoder is 'an object that decodes instances of a data type from JSON objects' (i.e. this is the thing doing the decoding); and
    * Codable is 'a type that can convert itself into and out of an external representation' (i.e. this is the thing that we are decoding into).
 */

// Create the Codable struct. This will need to be nested, so that our Codable struct follows the structure of the json that we receive from Ergast.

struct F1TeamData: Codable {
    
    // this is the topmost level
    var MRData: MRData
    
    struct MRData: Codable {
        var xmlns: String
        var series: String
        var url: String
        var limit: String
        var offset: String
        var total: String
        var ConstructorTable: ConstructorTable
    }
    
    // this is one level above Constructor
    struct ConstructorTable: Codable {
        var season: String
        var Constructors: [Constructor]
    }
    
    // this is the bottom-most level of the nested json we receive from Ergast
    struct Constructor: Codable {
        var constructorId: String
        var url: String
        var name: String
        var nationality: String
    }
}

// let's create another dataTask to grab data from Ergast and decode it into the structure above.

let task1 = URLSession.shared.dataTask(with: url){ data, response, error in
    if let receivedData = data {
        //if we've received some data back, use a JSONDecoder to decode that data into F1TeamData
        if let decodedData = try? JSONDecoder().decode(F1TeamData.self, from: receivedData) {
            print(decodedData)
        } else {
            print("failed to decode")
        }
    } else if let receivedError = error {
        print("Error: \(receivedError.localizedDescription)")
    }
}

task1.resume()
