//
//  DetailViewController.swift
//  MarvelProject
//
//  Created by Aleksandr Milashevski on 04/12/20.
//

import UIKit

class DetailViewController: UIViewController {
    
    //    MARK: - outlets
    @IBOutlet weak var viewOfImageView: UIView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var descriptionView: UIView!
    @IBOutlet weak var comicsView: UIView!
    
    //    MARK: - var
    var detail: Character?
    var urlString = "http://mobile.aws.skylabs.it/mobileassignments/marvel/placeholder.png"
    var urlImageNotFound = "http://i.annihil.us/u/prod/marvel/i/mg/b/40/image_not_available"
    
    //    MARK: - lifecycle funcs
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.viewOfImageView.myShadow()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let detail = self.detail {
            self.updateInterfaceWith(details: detail)
        }
    }
    //    MARK: - IBActions
    @IBAction func switchSegmentedControl(_ sender: UISegmentedControl) {
        
        if sender.selectedSegmentIndex == 0 {
            descriptionView.alpha = 1
            comicsView.alpha = 0
        } else {
            descriptionView.alpha = 0
            comicsView.alpha = 1
        }
    }
    //    MARK: - flow funcs
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if case segue.identifier = "DescriptionViewController" {
            guard let destination = segue.destination as? DescriptionViewController else { return }
            destination.characterDescription = detail
        }
        if case segue.identifier = "ComicsViewController" {
            guard let destination = segue.destination as? ComicsViewController else { return }
            destination.characterComics = detail
        }
    }
    
    func updateInterfaceWith(details: Character?) {
        
        title = details?.name
        if let path = details?.thumbnail?.path, let thumbnailExtension = details?.thumbnail?.thumbnailExtension {
            
            if urlImageNotFound == path {
                urlString = "\(urlString)"
            } else {
                urlString = "\(path).\(thumbnailExtension)"
            }
            guard let url = URL(string: urlString) else { return }
            DataProvider.shared.downLoadImage(url: url) { image in
                self.imageView.image = image
            }
        }
    }
}
