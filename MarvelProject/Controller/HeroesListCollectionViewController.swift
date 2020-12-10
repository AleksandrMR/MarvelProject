//
//  CollectionViewController.swift
//  MarvelProject
//
//  Created by Aleksandr Milashevski on 06/12/20.
//

import UIKit

private let reuseIdentifier = "Cell"

class HeroesListCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    //    MARK: - let
    let itemsPerRow: CGFloat = 2
    let sectionInserts = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
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
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "arrow.up.arrow.down"), style: .done, target: self, action: #selector(filterAlphabeticallyButtonPressed))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        collectionView.reloadData()
    }
    //    MARK: - outlets
    @IBAction func filterAlphabeticallyButtonPressed(_ sender: UIButton) {
        
    }
    
    // MARK: - UICollectionViewDataSource
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if isFiltering {
            return filteredArray.count
        }
        return characterArray.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CustomCollectionViewCell", for: indexPath) as? CustomCollectionViewCell else { return UICollectionViewCell()
        }
        if isFiltering {
            cell.cellConfig(with: filteredArray[indexPath.row])
        } else {
            cell.cellConfig(with: characterArray[indexPath.row])
        }
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        guard let controller = self.storyboard?.instantiateViewController(identifier: "DetailViewController") as? DetailViewController else { return }
        controller.detail = characterArray[indexPath.row]
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let paddingWidth = sectionInserts.left * (itemsPerRow + 1)
        let availableWidth = collectionView.frame.width - paddingWidth
        let widthPerItem = availableWidth / itemsPerRow
        return CGSize(width: widthPerItem, height: widthPerItem)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInserts
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return sectionInserts.left
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return sectionInserts.left
    }
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        if offsetY > contentHeight - scrollView.frame.size.height {
            RequestManager.shared.offsetIndex += 20
            RequestManager.shared.sendRequest { [weak self] characters in
                self?.characterArray.append(contentsOf: characters?.data?.results ?? [])
                DispatchQueue.main.async {
                    self?.collectionView.reloadData()
                }
            }
        }
    }
    
    private func filterContentAscending() {
        characterArray = characterArray.sorted {(character: Character, characterFiltered: Character) -> Bool in
            let chracter = character.name
            let characterFiltered = characterFiltered.name
            return (chracter?.localizedCaseInsensitiveCompare(characterFiltered ?? "") == .orderedAscending)
        }
        collectionView.reloadData()
    }
    
    private func filterContentDescending() {
        characterArray = characterArray.sorted {(character: Character, characterFiltered: Character) -> Bool in
            let chracter = character.name
            let characterFiltered = characterFiltered.name
            return (chracter?.localizedCaseInsensitiveCompare(characterFiltered ?? "") == .orderedDescending)
        }
        collectionView.reloadData()
    }
}
//MARK: - extensions
extension HeroesListCollectionViewController: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        self.filterContentForSearchText(searchController.searchBar.text!)
    }
    
    private func filterContentForSearchText(_ searchText: String) {
        filteredArray = characterArray.filter {(character: Character) -> Bool in
            return (character.name?.lowercased().contains(searchText.lowercased()) ?? false)
        }
        self.collectionView.reloadData()
    }
}
