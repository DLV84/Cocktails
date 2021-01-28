//
//  DrinkViewController.swift
//  Cocktails
//
//  Created by Daniel Villedrouin on 1/27/21.
//

import UIKit

class DrinkViewController: UIViewController {
    
    //MARK: - Outlets
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var drinkImageView: UIImageView!
    @IBOutlet weak var drinkNameLabel: UILabel!
    @IBOutlet weak var drinkInstructionsLabel: UILabel!
    @IBOutlet weak var supriseMeButton: UIButton!
    
    
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        searchBar.autocapitalizationType = .none
        supriseMeButton.layer.cornerRadius = 8
    }
    
    //MARK: - Actions
    @IBAction func supriseMeButtonTapped(_ sender: Any) {
        
        
        DrinkController.fetchRandomDrink { [weak self] (result) in
            DispatchQueue.main.async {
                switch result {
                
                case .success(let drink):
                    self?.fetchDrinkAndUpdateViews(drink: drink)
                case .failure(let error):
                    self?.presentErrorToUser(localizedError: error)
                }
            }
        }
    }
    
    
    //MARK: - Helper Functions
    func fetchDrinkAndUpdateViews(drink: Drink) {
        DrinkController.fetchDrinkImage(for: drink) { (result) in
            DispatchQueue.main.async {
                switch result {
                
                case .success(let thumbnail):
                    self.drinkImageView.image = thumbnail
                    self.drinkNameLabel.text = drink.strDrink
                    self.drinkInstructionsLabel.text = drink.strInstructions
                case .failure(let error):
                    self.presentErrorToUser(localizedError: error)
                }
            }
        }
    }
    
}// End of class

extension DrinkViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchTerm = searchBar.text?.capitalized else { return }
        
        DrinkController.fetchDrinks(searchTerm: searchTerm) { (result) in
            DispatchQueue.main.async {
                switch result {
                
                case .success(let drink):
                    self.fetchDrinkAndUpdateViews(drink: drink)
                case .failure(let error):
                    self.presentErrorToUser(localizedError: error)
                }
            }
        }
    }
}
