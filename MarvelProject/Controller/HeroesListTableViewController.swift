//
//  TableViewController.swift
//  MarvelProject
//
//  Created by Aleksandr Milashevski on 04/12/20.
//

import UIKit

class HeroesListTableViewController: UITableViewController {
    
    //    MARK: - let
    let heightForRowAt = CGFloat(150)
    let searchController = UISearchController(searchResultsController: nil)
    
    //    MARK: - var
    var characterArray = [Character]()
    var filteredArray = [Character]()
    private var searchBarIsEmpty: Bool {
        guard let text = searchController.searchBar.text else { return false }
        return text.isEmpty
    }
    
    private var isFiltering: Bool {
        return searchController.isActive && !searchBarIsEmpty
    }
    
    //    MARK: - lifecycle funcs
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // setup thr SearchController
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.searchTextField.attributedPlaceholder = NSAttributedString(string: "Search", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        navigationItem.searchController = searchController
        definesPresentationContext = true
        
        self.title = "Marvel Characters"
//        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "arrow.up.arrow.down"), style: .done, target: self, action: #selector(filterAlphabeticallyButtonPressed))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tableView.reloadData()
    }
    //    MARK: - IBActions
    @IBAction func filterAlphabeticallyButtonPressed(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        if sender.isSelected == false {
            filterContentAscending()
        }
        if sender.isSelected == true {
            filterContentDescending()
        }
    }
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if isFiltering {
            return filteredArray.count
        }
        return characterArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CustomTableViewCell") as? CustomTableViewCell else {
            return UITableViewCell()
        }
        
        if isFiltering {
            cell.cellConfig(with: filteredArray[indexPath.row])
        } else {
            cell.cellConfig(with: characterArray[indexPath.row])
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return heightForRowAt
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        guard let controller = self.storyboard?.instantiateViewController(identifier: "DetailViewController") as? DetailViewController else { return }
        controller.detail = characterArray[indexPath.row]
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
    
    private func filterContentAscending() {
        characterArray = characterArray.sorted(by: { (character: Character, characterFiltered: Character) -> Bool in
            let chracter = character.name
            let characterFiltered = characterFiltered.name
            return (chracter?.localizedCaseInsensitiveCompare(characterFiltered ?? "") == .orderedAscending)
        })
       tableView.reloadData()
    }
    
    private func filterContentDescending() {
        characterArray = characterArray.sorted(by: { (character: Character, characterFiltered: Character) -> Bool in
            let chracter = character.name
            let characterFiltered = characterFiltered.name
            return (chracter?.localizedCaseInsensitiveCompare(characterFiltered ?? "") == .orderedDescending)
        })
        tableView.reloadData()
    }
    
}
//MARK: - extensione
extension HeroesListTableViewController: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        self.filterContentForSearchText(searchController.searchBar.text!)
    }
    
    private func filterContentForSearchText(_ searchText: String) {
        
        filteredArray = characterArray.filter({ (character: Character) -> Bool in
            return (character.name?.lowercased().contains(searchText.lowercased()) ?? false)
        })
        self.tableView.reloadData()
    }
    
}
