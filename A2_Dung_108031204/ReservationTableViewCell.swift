//
//  ReservationTableViewCell.swift
//  A2_Dung_108031204
//
//  Created by Zane Chan on 2022-11-06.
//

import UIKit

class ReservationTableViewCell: UITableViewCell {
    
    // MARK: outlets
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var lblDepartureAirport: UILabel!
    @IBOutlet weak var lblArrivalAirport: UILabel!
    @IBOutlet weak var lblCost: UILabel!

    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
