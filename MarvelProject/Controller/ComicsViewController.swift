//
//  ComicsViewController.swift
//  MarvelProject
//
//  Created by Aleksandr Milashevski on 06/12/20.
//

import UIKit

class ComicsViewController: UIViewController {
    
    //    MARK: - outlets
    @IBOutlet weak var myTabelView: UITableView!
    
    //    MARK: - let
    let heightForRowAt = CGFloat(100)
    
    //    MARK: - var
    var characterComics = [ComicsResult?]()
    
    //    MARK: - lifecycle funcs
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.myTabelView.reloadData()
    }
}
//MARK: - extensione
extension ComicsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return characterComics.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "SecondCustomTableViewCell") as? SecondCustomTableViewCell else {
            return UITableViewCell()
        }
        cell.cellConfig(with: characterComics[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return heightForRowAt
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
