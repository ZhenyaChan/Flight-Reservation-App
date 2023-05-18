import Foundation

// singleton class
class Datasource {
    static let shared = Datasource()
    private init() {}
    
    // list of departure Airports with the possible arrival airports
    let departureAirportsList:[DepartureAirport] = [DepartureAirport(name: "Toronto - YYZ", arrivalAirports: ["Vancouver - YVR", "Montreal - YUL"]), DepartureAirport(name: "Winnipeg - YWG", arrivalAirports: ["Toronto - YYZ"])]
    
    // total cost for all reservations made
    var totalPaid:Double = 0.0
    var pricePerKm:Double = 0.32
    var reservationsList:[Reservation] = []
}
