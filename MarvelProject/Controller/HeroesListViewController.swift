//
//  HeroesListViewController.swift
//  MarvelProject
//
//  Created by Aleksandr Milashevski on 10/12/20.
//

import UIKit

class HeroesListViewController: UIViewController, UISearchBarDelegate {
    
    @IBOutlet weak var mySearchBar: UISearchBar!
    @IBOutlet weak var myTableView: UITableView!
    @IBOutlet weak var topBarView: UIView!
    
    //    MARK: - let
    let heightForRowAt = CGFloat(150)
    
    //    MARK: - var
    var characterArray = [Character]()
    var filteredArray = [Character]()
    private var searchBarIsEmpty: Bool {
        guard let text = mySearchBar.text else { return false }
        return text.isEmpty
    }
    private var isFiltering: Bool {
        return !searchBarIsEmpty
    }
    //    MARK: - lifecycle funcs
    override func viewDidLoad() {
        super.viewDidLoad()
        
        topBarView.myShadowTopBar()
        myTableView.delegate = self
        mySearchBar.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        myTableView.reloadData()
    }
    //    MARK: - IBActions
    @IBAction func backButtonPressed(_ sender: UIButton) {
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    @IBAction func filterAlphabeticallyButtonPressed(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        if sender.isSelected == false {
            filterContentAscending()
        }
        if sender.isSelected == true {
            filterContentDescending()
        }
    }
    //    MARK: - flow funcs
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filteredArray = characterArray.filter {(character: Character) -> Bool in
            return (character.name?.lowercased().contains(searchText.lowercased()) ?? false)
        }
        self.myTableView.reloadData()
    }
    
    private func filterContentAscending() {
        characterArray = characterArray.sorted {(character: Character, characterFiltered: Character) -> Bool in
            let chracter = character.name
            let characterFiltered = characterFiltered.name
            return (chracter?.localizedCaseInsensitiveCompare(characterFiltered ?? "") == .orderedAscending)
        }
        myTableView.reloadData()
    }
    
    private func filterContentDescending() {
        characterArray = characterArray.sorted {(character: Character, characterFiltered: Character) -> Bool in
            let chracter = character.name
            let characterFiltered = characterFiltered.name
            return (chracter?.localizedCaseInsensitiveCompare(characterFiltered ?? "") == .orderedDescending)
        }
        myTableView.reloadData()
    }
}
//MARK: - extensions
extension HeroesListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFiltering {
            return filteredArray.count
        }
        return characterArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
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
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return heightForRowAt
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        guard let controller = self.storyboard?.instantiateViewController(identifier: "DetailViewController") as? DetailViewController else { return }
        controller.detail = characterArray[indexPath.row]
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        if offsetY > contentHeight - scrollView.frame.size.height {
            RequestManager.shared.offsetIndex += 20
            RequestManager.shared.sendRequest { [weak self] characters in
                self?.characterArray.append(contentsOf: characters?.data?.results ?? [])
                DispatchQueue.main.async {
                    self?.myTableView.reloadData()
                }
            }
        }
    }
}
