//
//  RecipeCell.swift
//  Recipe App
//

import UIKit

class RecipeCell: UITableViewCell {
    
    @IBOutlet weak var recipeImage: UIImageView!
    
    @IBOutlet weak var RecipeName: UILabel!
    
    @IBOutlet weak var callories: UILabel!
    
    @IBOutlet weak var ingredients: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func loadData(recipe: RecipeResult) {
        self.RecipeName.text = recipe.label
        self.callories.text = "Calories: \(recipe.calories)"
        self.ingredients.text = "ingredients: \(recipe.ingredientLines.count)"
        self.loadImage(url: recipe.image)
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

}
