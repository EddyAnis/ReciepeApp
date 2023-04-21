//
//  RecipeModels.swift
//  Recipe App
//

import Foundation

struct SearchResult: Decodable {
    let hits: [RecipeHit]
    let from: Int
    let to: Int
    let count: Int
    let _links: SearchLinks?
    
    enum CodingKeys: String, CodingKey {
      case hits, from, to, count, _links
    }
}

struct SearchLinks: Decodable {
    let next: NextLinks
  
    enum CodingKeys: String, CodingKey {
        case next
    }
}

struct NextLinks: Decodable {
    let href: String
  
  enum CodingKeys: String, CodingKey {
      case href
  }
}

struct RecipeHit: Decodable {
    let recipe: RecipeResult
  
  enum CodingKeys: String, CodingKey {
      case recipe
  }
}

struct RecipeResult: Decodable {
    let label: String
    let image: String
    let calories: Float
    let totalWeight: Float
    let cuisineType: [String]
    let mealType: [String]
    let ingredientLines: [String]
  
  enum CodingKeys: String, CodingKey {
      case label, image, calories, totalWeight, cuisineType, mealType, ingredientLines
  }
}
