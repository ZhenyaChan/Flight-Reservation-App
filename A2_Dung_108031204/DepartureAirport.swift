import Foundation

class DepartureAirport {
    // class attributes
    var name:String
    var arrivalAirports:[String]
    
    // initializer
    init(name:String, arrivalAirports:[String]) {
        self.name = name
        self.arrivalAirports = arrivalAirports
    }
}
