//
//  SecondCustomTableViewCell.swift
//  MarvelProject
//
//  Created by Aleksandr Milashevski on 06/12/20.
//

import UIKit

class SecondCustomTableViewCell: UITableViewCell {

    //    MARK: - outlets
    @IBOutlet weak var secondCustomCellImageView: UIImageView!
    @IBOutlet weak var secondCustomCellLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    //    MARK: - let
    let imageCornerRadius = CGFloat(13)
    
    //    MARK: - var
    var urlString = "http://mobile.aws.skylabs.it/mobileassignments/marvel/placeholder.png"
    var urlImageNotFound = "http://i.annihil.us/u/prod/marvel/i/mg/b/40/image_not_available"
    
    //    MARK: - flow funcs
    func cellConfig(with comicsResalt: ComicsResult?) {
        self.secondCustomCellLabel.text = comicsResalt?.title
        self.priceLabel.text = "Price: \(comicsResalt?.prices?.first?.price ?? 0.0) $"
        self.secondCustomCellImageView.layer.cornerRadius = self.imageCornerRadius
        if let path = comicsResalt?.thumbnail?.path, let thumbnailExtension = comicsResalt?.thumbnail?.thumbnailExtension {
            if urlImageNotFound == path {
                urlString = "\(urlString)"
            } else {
                urlString = "\(path).\(thumbnailExtension)"
            }
            guard let url = URL(string: urlString) else { return }
            DataProvider.shared.downLoadImage(url: url) { image in
                self.secondCustomCellImageView.image = image
            }
        }
    }
}
