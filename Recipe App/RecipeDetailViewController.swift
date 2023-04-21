//
//  RecipeDetailViewController.swift
//  Recipe App
//

import UIKit

class RecipeDetailViewController: UIViewController {
    
    @IBOutlet weak var recipeImage: UIImageView!
    
    @IBOutlet weak var recipeName: UILabel!
    
    @IBOutlet weak var caloriesLabel: UILabel!
    
    @IBOutlet weak var cuisineLabel: UILabel!
    
    @IBOutlet weak var mealLabel: UILabel!
    
    @IBOutlet weak var ingrediantsTextView: UITextView!
    
    var recipe: RecipeResult? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.recipeName.text = recipe!.label
        self.caloriesLabel.text = "Calories: \(recipe!.calories)"
        self.cuisineLabel.text = "Cuisine: \(recipe!.cuisineType[0])"
        self.mealLabel.text = "Meal: \(recipe!.mealType[0])"
        self.ingrediantsTextView.text = "Recipe:  \(recipe!.ingredientLines[0])"
        for recipeIng in 1...recipe!.ingredientLines.count-1 {
            self.ingrediantsTextView.text += "\r\n\(recipe!.ingredientLines[recipeIng])"
        }
        self.loadImage(url: self.recipe!.image)
    }
    
    func loadImage(url: String) {
        DispatchQueue.global().async {
            let url = URL(string: url)!
            let data = try? Data(contentsOf: url)
            DispatchQueue.main.async {
                if((data) != nil){
                    self.recipeImage.image = UIImage(data: data!)
                }
            }
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
