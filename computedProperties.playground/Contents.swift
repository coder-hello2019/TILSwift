import Cocoa

/*
 
 Types can have stored properties - those are your 'regular' properties which are stored in memory.
 
 Computed property are almost like mini functions in that, instead of their values being stored in memory, they are figured out by the code wach time that the property is retrieved. Computed properties provide a getter and an (optional) setter for reading and writing values.
 
 */

// nothing interesting to see here - points here is just a stored property of Points
struct Points {
    var name: String
    var points: Int
}

var demoPoints = Points(name: "Hamilton", points: 100)
print("\(demoPoints.name) has \(demoPoints.points) points")


// points are computed here, based on the difference between scoredPoints and deductedPoints; this just provides a getter method for points
struct ComputedPoints {
    var name: String
    var scoredPoints: Int
    var deductedPoints: Int
    var points: Int {
        scoredPoints - deductedPoints
    }
}

var demoComputedPoints = ComputedPoints(name: "Hamilton", scoredPoints: 100, deductedPoints: 10)
print("\(demoComputedPoints.name) has \(demoComputedPoints.points) points")

struct ComputedPoints2 {
    var name: String
    var scoredPoints: Int
    var deductedPoints: Int
    var points: Int {
        // note that the getter is the same as in the struct above
        get {
          scoredPoints - deductedPoints
        }
        
        // note the use of newValue in the setter - this is provided to us by Swift
        // we change one of the other properties in the setter )which in turn updates what the getter outputs
        set {
            scoredPoints = newValue
        }
    }
}

// this is the same as for ComputedPoints above
var demoComputedPoints2 = ComputedPoints2(name: "Verstappen", scoredPoints: 200, deductedPoints: 20)
print("\(demoComputedPoints2.name) has \(demoComputedPoints2.points) points")

// but see the difference with the setter here
demoComputedPoints2.points = 500
print("\(demoComputedPoints2.name) NOW has \(demoComputedPoints2.points) points")


