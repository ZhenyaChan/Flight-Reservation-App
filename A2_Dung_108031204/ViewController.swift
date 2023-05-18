import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    // MARK: outlets
    @IBOutlet weak var reservationsTableView: UITableView!
    @IBOutlet weak var lblTotalPaid: UILabel!
    
    // MARK: Table View functions
    // the total number of items to display in the table view
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Datasource.shared.reservationsList.count
    }
    
    // content that's displayed in each row of the table
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // get a reference to the row (cell)
        let cell = reservationsTableView.dequeueReusableCell(withIdentifier: "reservationCell") as! ReservationTableViewCell
        
        // configure the cell (what data to put in a row)
        let currentReservation = Datasource.shared.reservationsList[indexPath.row]
        cell.lblName.text = currentReservation.name
        cell.lblCost.text = "CA $\(String(format: "%.2f",currentReservation.cost))"
        cell.lblDate.text = currentReservation.departureDate
        cell.lblDepartureAirport.text = currentReservation.departureAirport
        cell.lblArrivalAirport.text = currentReservation.arrivalAirport
        
        
        return cell
    }
    
    // deleting existing reservations
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == UITableViewCell.EditingStyle.delete) {
            // output to the console
            print("User wants to delete the reservation number \(indexPath.row) for:  \(Datasource.shared.reservationsList[indexPath.row].name)")
            
            // update the total cost for all reservations and display appropriate message
            Datasource.shared.totalPaid -= Datasource.shared.reservationsList[indexPath.row].cost
            if (Datasource.shared.totalPaid > 0) {
                lblTotalPaid.text = "Total Paid: CA $\(String(format: "%.2f", Datasource.shared.totalPaid))"
            } else {
                // No reservations on the list
                lblTotalPaid.text = "Error: No Reservations Made"
            }
            
            // delete the selected item from the data source array (reservations list)
            Datasource.shared.reservationsList.remove(at: indexPath.row)
            print("Updated number of reservations in the list: \(Datasource.shared.reservationsList.count)")
            
            // delete the selected reservation from the tableview UI
            reservationsTableView.deleteRows(at: [indexPath], with: UITableView.RowAnimation.automatic)
        }
    }
    

    // viewWillAppear() function executes every time it is going to show main screen
    override func viewWillAppear(_ animated: Bool) {
        // reload the table to display updated data
        self.reservationsTableView.reloadData()
        
        // count total fare for all reservations
        Datasource.shared.totalPaid = 0.0
        for reservation in Datasource.shared.reservationsList {
            Datasource.shared.totalPaid += reservation.cost
        }
        
        // display appropriate message based on the total paid
        if (Datasource.shared.totalPaid > 0) {
            lblTotalPaid.text = "Total Paid:\n CA $\(String(format: "%.2f", Datasource.shared.totalPaid))"
        } else {
            // No reservations on the list
            lblTotalPaid.text = "Error: No Reservations Made"
        }
    }
    
    // viewDidLoad() function
    override func viewDidLoad() {
        super.viewDidLoad()
        // add screen title
        navigationItem.title = "Flight Reservations List"
        // programmatically add bar button item to navigate to another screen
        // - using one of the predefined options (System Item)
        let createReservationButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(createReservation))
        navigationItem.rightBarButtonItem = createReservationButton
        
        // setup the outlet with delegate and data source
        self.reservationsTableView.dataSource = self
        self.reservationsTableView.delegate = self
    }
    
    
    // MARK: actions
    @IBAction func createReservation(_ sender: Any) {
        // programatic reference to the destination screen
        guard let createReservationScreen = storyboard?.instantiateViewController(identifier: "newReservationScreen") as? NewReservationViewController else {
            // This will execute if we cannot find a screen with the provided storyboard id
            print("Cannot find a screen with the provided id")
            return
        }
        
        // 2. show that destination screen
        show(createReservationScreen, sender:self)
    }
}
