import UIKit

class NewReservationViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    // MARK: outlets
    @IBOutlet weak var departureAirportPickerView: UIPickerView!
    @IBOutlet weak var lblTotalCost: UILabel!
    @IBOutlet weak var textName: UITextField!
    @IBOutlet weak var pickerDate: UIDatePicker!
    
    // MARK: Picker View functions
    // number of columns in the pickerview: one for departure airports and second one for arrival airports
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    
    // total number of items in the pickerview
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if (component == 0) {
            return Datasource.shared.departureAirportsList.count
        } else {
            let selectedDepartureAirport = departureAirportPickerView.selectedRow(inComponent: 0)
            return Datasource.shared.departureAirportsList[selectedDepartureAirport].arrivalAirports.count
        }
    }
    
    // what should be displayed in the pickerview
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if (component == 0) {
            return Datasource.shared.departureAirportsList[row].name
        } else {
            let selectedDepartureAirport = departureAirportPickerView.selectedRow(inComponent: 0)
            return Datasource.shared.departureAirportsList[selectedDepartureAirport].arrivalAirports[row]
        }
    }
    
    // reload the arrival airports picker view every time selecting the row
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        pickerView.reloadComponent(1)
    }
    
    
    // viewDidLoad()
    override func viewDidLoad() {
        super.viewDidLoad()
        // add screen title
        navigationItem.title = "Create New Reservation"
        self.departureAirportPickerView.delegate = self
        self.departureAirportPickerView.dataSource = self
    }
    
    
    // MARK: actions
    @IBAction func reserveButtonPressed(_ sender: Any) {
        // get the date as a formatted String
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM dd, YYYY"
        let departureDateString = dateFormatter.string(from: pickerDate.date)
        
        // get the indexes selected from pickerview (deaprture and arrival airports indexes)
        let selectedDepartureIndex = self.departureAirportPickerView.selectedRow(inComponent: 0)
        let selectedArrivalIndex = self.departureAirportPickerView.selectedRow(inComponent: 1)
        
        // create new reservation and add to the reservation list
        Datasource.shared.reservationsList.append(Reservation(name: textName.text!, departureDate: departureDateString, departureAirport: Datasource.shared.departureAirportsList[selectedDepartureIndex].name, arrivalAirport: Datasource.shared.departureAirportsList[selectedDepartureIndex].arrivalAirports[selectedArrivalIndex]))
        print("Created new reservation!")
        
        // calculate the cost of the flight by multiplying flight distance, price per km, and 13% sales taxes
        Datasource.shared.reservationsList[Datasource.shared.reservationsList.count - 1].cost = Datasource.shared.reservationsList[Datasource.shared.reservationsList.count - 1].distance * Datasource.shared.pricePerKm * 1.13
        // Display the cost for the reservation on the screen
        lblTotalCost.text = "Flight Total Cost (including taxes):\nCA $\(String(format: "%.2f", Datasource.shared.reservationsList[Datasource.shared.reservationsList.count - 1].cost))"
    }
    
}
