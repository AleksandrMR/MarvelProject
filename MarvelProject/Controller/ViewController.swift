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
    @IBOutlet weak var labelConstraint: NSLayoutConstraint!
    @IBOutlet weak var nameAppLabel: UIImageView!
    
    //    MARK: - let
    
    let myCornerRadius = CGFloat(13)
    
    //    MARK: - lifecycle funcs
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupCornerRadius()
    }
    //    MARK: - IBActions
    
    @IBAction func tabelViewButtonPressed(_ sender: UIButton) {
        self.goToTableViewControlle()
        self.animationConstraint()
    }
    
    @IBAction func collectionViewButtonPressed(_ sender: UIButton) {
        self.goToCollectionViewController()
        self.animationConstraint()
    }
    
    //    MARK: - flow funcs
    
    func goToCollectionViewController() {
        RequestManager.shared.sendRequest { [weak self] characters in
            DispatchQueue.main.async {
                guard let controller = self?.storyboard?.instantiateViewController(identifier: "CollectionViewController") as? CollectionViewController else { return }
                controller.characterArray = characters?.data?.results ?? []
                self?.navigationController?.pushViewController(controller, animated: true)
            }
        }
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
    
    func animationConstraint() {
//        self.labelConstraint.constant += 1200
        UIView.animate(withDuration: 2, animations: {
            self.view.backgroundColor = .white
            self.nameAppLabel.alpha = 0
            self.tabelViewButton.alpha = 0
            self.collectionViewButton.alpha = 0
            self.view.layoutIfNeeded()
        }, completion: { (_) in
//            self.labelConstraint.constant -= 1200
            UIView.animate(withDuration: 2) {
                self.view.backgroundColor = .black
                self.nameAppLabel.alpha = 1
                self.tabelViewButton.alpha = 1
                self.collectionViewButton.alpha = 1
                self.view.layoutIfNeeded()
            }
        })
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
