//
//  ViewController.swift
//  MarvelProject
//
//  Created by Aleksandr Milashevski on 04/12/20.
//

import UIKit
import CryptoKit

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
        self.goToTableViewControlle()
    }
    
    @IBAction func collectionViewButtonPressed(_ sender: UIButton) {
        self.goToCollectionViewController()
    }
    
    //    MARK: - flow funcs
    
    func goToCollectionViewController() {
        
    }
    
    func goToTableViewControlle() {
        
        RequestManager.shared.sendRequest { [weak self] characters in
            DispatchQueue.main.async {
                guard let controller = self?.storyboard?.instantiateViewController(identifier: "TableViewController") as? TableViewController else { return }
                controller.characterArray = characters?.data?.results ?? []
                self?.navigationController?.pushViewController(controller, animated: true)
            }
        }
    }
    
    func setupCornerRadius() {
        self.tabelViewButton.layer.cornerRadius = myCornerRadius
        self.collectionViewButton.layer.cornerRadius = myCornerRadius
    }
    
    func setupShadow() {
        self.tabelViewButton.myShadowOne()
        self.collectionViewButton.myShadowOne()
    }
}
