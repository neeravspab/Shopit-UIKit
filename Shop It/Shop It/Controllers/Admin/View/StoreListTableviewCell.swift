//
//  StoreListTableviewCell.swift
//  Shop It
//
//  Created by niravkumar patel on 4/21/22.
//

import UIKit

class StoreListTableviewCell: UITableViewCell {

    @IBOutlet weak var lblStoreId: UILabel!
    @IBOutlet weak var lblStoreName: UILabel!
    @IBOutlet weak var lblCity: UILabel!
    @IBOutlet weak var lblstatus: UILabel!
    @IBOutlet weak var lblCountry: UILabel!
    @IBOutlet weak var btnDisapprove: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
