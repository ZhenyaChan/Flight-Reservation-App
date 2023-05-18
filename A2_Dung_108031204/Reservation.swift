import Foundation

class Reservation {
    // attributes
    var name:String
    var departureDate:String
    var departureAirport:String
    var arrivalAirport:String
    var distance:Double
    var cost:Double
    
    // initializer
    init(name:String, departureDate:String, departureAirport:String, arrivalAirport:String) {
        self.name = name
        self.departureDate = departureDate
        self.departureAirport = departureAirport
        self.arrivalAirport = arrivalAirport
        self.cost = 0.0
        
        // setting the distance based on the departure and arrival airports
        if (departureAirport == "Toronto - YYZ") {
            switch (arrivalAirport) {
            case "Vancouver - YVR":
                self.distance = 3361
                break
            case "Montreal - YUL":
                self.distance = 503
                break
            default:
                self.distance = 0
                break
            }
        } else {
            switch (arrivalAirport) {
            case "Toronto - YYZ":
                self.distance = 1513
                break
            default:
                self.distance = 0
                break
            }
        }
    }    
}
