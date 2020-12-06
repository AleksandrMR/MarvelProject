//
//  TableViewController.swift
//  MarvelProject
//
//  Created by Aleksandr Milashevski on 04/12/20.
//

import UIKit

class TableViewController: UITableViewController {
    
    
    //    MARK: - let
    
    let heightForRowAt = CGFloat(150)
    
    //    MARK: - var
    
    var characterArray = [Character]()
    
    //    MARK: - lifecycle funcs
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Marvel Characters"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "arrow.up.arrow.down"), style: .done, target: self, action: #selector(filterAlphabeticallyButtonPressed))
        
        
        
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    //    MARK: - IBActions
    
    @IBAction func filterAlphabeticallyButtonPressed(_ sender: UIButton) {
        
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return characterArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CustomTableViewCell") as? CustomTableViewCell else {
            return UITableViewCell()
        }
        cell.cellConfig(with: characterArray[indexPath.row])
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return heightForRowAt
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        guard let controller = self.storyboard?.instantiateViewController(identifier: "DetailViewController") as? DetailViewController else { return }
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        
        if offsetY > contentHeight - scrollView.frame.size.height {
            
            RequestManager.shared.offsetIndex += 20
            RequestManager.shared.sendRequest { [weak self] characters in
                self?.characterArray.append(contentsOf: characters?.data?.results ?? [])
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                }
            }
        }
    }
}
