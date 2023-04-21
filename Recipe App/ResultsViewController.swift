//
//  ResultsViewController.swift
//  Recipe App
//

import UIKit

class ResultsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate {
    
    @IBOutlet weak var resultsTableView: UITableView!
    
    var recipes: [RecipeHit] = []
    var searchResults: SearchResult? = nil
    
    var selectedRecipe: RecipeResult? = nil
    
    var searchText: String = ""
    var dietOption: String = ""
    var cuisineOption: String = ""
    var mealOption: String = ""
    
    var isFetching = true

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.resultsTableView.dataSource = self
        self.resultsTableView.delegate = self
        
        searchRecipes(url: "") { [weak self] (searchResult) in
            print(searchResult.hits.count)
            self!.recipes = searchResult.hits
            self!.searchResults = searchResult
            DispatchQueue.main.async {
                self!.resultsTableView.reloadData()
                self!.isFetching = false
            }
        }
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if(segue.identifier == "recipeDetail"){
            let detailVC = segue.destination as! RecipeDetailViewController
            detailVC.recipe = self.selectedRecipe
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.recipes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RecipeCell", for: indexPath as IndexPath) as! RecipeCell
        
        cell.loadData(recipe: self.recipes[indexPath.row].recipe)
        cell.selectionStyle = .none

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.selectedRecipe = self.recipes[indexPath.row].recipe
        self.performSegue(withIdentifier: "recipeDetail", sender: self)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let position = scrollView.contentOffset.y
        if(position > resultsTableView.contentSize.height - 100 - scrollView.frame.size.height){
            if(self.searchResults != nil && self.searchResults?._links != nil && !isFetching){
                self.isFetching = true
                print(self.searchResults!._links!.next.href)
                print("fetch now")
                
                searchRecipes(url: self.searchResults!._links!.next.href) { [weak self] (searchResult) in
                    print(searchResult.hits.count)
                    self!.recipes += searchResult.hits
                    self!.searchResults = searchResult
                    DispatchQueue.main.async {
                        self?.resultsTableView.reloadData()
                        self!.isFetching = false
                    }
                }
            }
        }
    }
    
    func searchRecipes(url: String, completionHandler: @escaping (SearchResult) -> Void) {
        var urlString = "https://api.edamam.com/api/recipes/v2?app_id=6ad4d8c7&app_key=07474df3181b2661d300211f4ce656bd&type=public"
        urlString += "&q=\(self.searchText)"
        if(self.dietOption != ""){
            urlString += "&diet=\(self.dietOption)"
        }
        if(cuisineOption != ""){
            urlString += "&cuisineType=\(cuisineOption)"
        }
        if(mealOption != ""){
            urlString += "&mealType=\(mealOption)"
        }
        
        print(urlString)
        if(url != ""){
            urlString = url
        }
        let url = URL(string: urlString)!

        let task = URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
          if let error = error {
            print("Error with fetching films: \(error)")
            return
          }
          
          guard let httpResponse = response as? HTTPURLResponse,
                (200...299).contains(httpResponse.statusCode) else {
              print("Error with the response, unexpected status code: \(String(describing: response))")
            return
          }

          if let data = data,
            let searchResult = try? JSONDecoder().decode(SearchResult.self, from: data) {
            completionHandler(searchResult)
          }
        })
        task.resume()
    }

}
