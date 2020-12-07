//
//  DescriptionViewController.swift
//  MarvelProject
//
//  Created by Aleksandr Milashevski on 06/12/20.
//

import UIKit

class DescriptionViewController: UIViewController {
    
    @IBOutlet weak var descriptionTextView: UITextView!
    
    var characterDescription: Character?
    var noDescription = "We offer our apologies. Unfortunately, this character has no description, we hope that in the near future it will appear."
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let description = self.characterDescription?.description {
            if description.description == "" {
                self.descriptionTextView.text = noDescription
            } else {
                self.descriptionTextView.text = description.description
            }
        }
    }
}
