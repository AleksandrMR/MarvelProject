//
//  CustomTableViewCell.swift
//  MarvelProject
//
//  Created by Aleksandr Milashevski on 04/12/20.
//

import UIKit

class CustomTableViewCell: UITableViewCell {

    //    MARK: - outlets
    
    @IBOutlet weak var customCellImageView: UIImageView!
    @IBOutlet weak var customCellLabel: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
