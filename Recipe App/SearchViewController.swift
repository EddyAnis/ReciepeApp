//
//  ViewController.swift
//  Recipe App
//

import UIKit

class SearchViewController: UIViewController {

    @IBOutlet weak var searchTextField: UITextField!
    
    @IBOutlet weak var dietSelector: UISegmentedControl!
    
    @IBOutlet weak var cousineSelector: UISegmentedControl!
    
    @IBOutlet weak var mealSelector: UISegmentedControl!
    
    var recipes: [RecipeHit] = []
    
    let dietOptions = ["", "high-fiber", "low-carb", "low-fat"]
    let cuisineOptions = ["", "American", "Chinese", "Indian"]
    let mealOptions = ["", "Breakfast", "Lunch", "Dinner"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "showResultsPage"){
            let resultsVC = segue.destination as! ResultsViewController
            resultsVC.searchText = self.searchTextField.text!
            resultsVC.dietOption = self.dietOptions[dietSelector.selectedSegmentIndex]
            resultsVC.cuisineOption = self.cuisineOptions[cousineSelector.selectedSegmentIndex]
            resultsVC.mealOption = self.mealOptions[mealSelector.selectedSegmentIndex]
        }
    }

    @IBAction func searchButtonPressed(_ sender: Any) {
        if(self.searchTextField.text == "") {
            return
        }
        
        self.performSegue(withIdentifier: "showResultsPage", sender: self)
    }
}

