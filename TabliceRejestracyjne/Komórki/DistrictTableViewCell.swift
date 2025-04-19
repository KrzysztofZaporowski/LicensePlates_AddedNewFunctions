//
//  DistrictTableViewCell.swift
//  TabliceRejestracyjne
//
//  Created by Krzysztof Zaporowski on 15/04/2025.
//

import UIKit

class DistrictTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    @IBOutlet weak var districtImg: UIImageView!
    
    @IBOutlet weak var powLabel: UILabel!
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
