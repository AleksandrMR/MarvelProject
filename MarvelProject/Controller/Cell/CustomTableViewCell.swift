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
    
    //    MARK: - let
    let imageCornerRadius = CGFloat(13)
    
    //    MARK: - var
    var urlString = "http://mobile.aws.skylabs.it/mobileassignments/marvel/placeholder.png"
    var urlImageNotFound = "http://i.annihil.us/u/prod/marvel/i/mg/b/40/image_not_available"
    
    //    MARK: - flow funcs
    func cellConfig(with characters: Character?) {
        self.customCellLabel.text = characters?.name
        self.customCellImageView.layer.cornerRadius = self.imageCornerRadius
        if let path = characters?.thumbnail?.path, let thumbnailExtension = characters?.thumbnail?.thumbnailExtension {
            if urlImageNotFound == path {
                urlString = "\(urlString)"
            } else {
                urlString = "\(path).\(thumbnailExtension)"
            }
            guard let url = URL(string: urlString) else { return }
            DataProvider.shared.downLoadImage(url: url) { image in
                self.customCellImageView.image = image
            }
        }
    }
}
