//
//  ViewController.swift
//  MarvelProject
//
//  Created by Aleksandr Milashevski on 04/12/20.
//

import UIKit

class ViewController: UIViewController {

    
    //    MARK: - outlets
    
    @IBOutlet weak var tabelViewButton: UIButton!
    @IBOutlet weak var collectionViewButton: UIButton!
    
    //    MARK: - let
    
    let myCornerRadius = CGFloat(13)
    
    //    MARK: - var
    
    
    
    //    MARK: - lifecycle funcs
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        self.setupCornerRadius()
//        self.setupShadow()
        
    }
    //    MARK: - IBActions
    
    @IBAction func tabelViewButtonPressed(_ sender: UIButton) {
        guard let controller = self.storyboard?.instantiateViewController(identifier: "TableViewController") as? TableViewController else { return }
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    @IBAction func collectionViewButtonPressed(_ sender: UIButton) {
    }
    
    //    MARK: - flow funcs
    
    func setupCornerRadius() {
        self.tabelViewButton.layer.cornerRadius = myCornerRadius
        self.collectionViewButton.layer.cornerRadius = myCornerRadius
    }
    
    func setupShadow() {
        self.tabelViewButton.myShadowOne()
        self.collectionViewButton.myShadowOne()
    }
    
    
    
    
    
    
}
