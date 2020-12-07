//
//  CustomCollectionViewCell.swift
//  MarvelProject
//
//  Created by Aleksandr Milashevski on 06/12/20.
//

import UIKit

class CustomCollectionViewCell: UICollectionViewCell {
    
    //    MARK: - outlets
    
    @IBOutlet weak var myImageView: UIImageView!
    @IBOutlet weak var myLabel: UILabel!
    
    //    MARK: - let
    
    let imageCornerRadius = CGFloat(13)
    
    //    MARK: - var
    
    var urlString = "http://mobile.aws.skylabs.it/mobileassignments/marvel/placeholder.png"
    var urlImageNotFound = "http://i.annihil.us/u/prod/marvel/i/mg/b/40/image_not_available"
    
    //    MARK: - flow funcs
    
    func cellConfig(with characters: Character?) {
        self.myLabel.text = characters?.name
        
        if let path = characters?.thumbnail?.path, let thumbnailExtension = characters?.thumbnail?.thumbnailExtension {
            
            if urlImageNotFound == path {
                urlString = "\(urlString)"
            } else {
                urlString = "\(path).\(thumbnailExtension)"
            }
            guard let url = URL(string: urlString) else { return }
            DataProvider.shared.downLoadImage(url: url) { image in
                self.myImageView.image = image
                self.myImageView.layer.cornerRadius = self.imageCornerRadius
            }
        }
    }
    
}
