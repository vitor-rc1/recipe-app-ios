//
//  FoodMocks.swift
//  RecipeAppTests
//
//  Created by Vitor Conceicao on 23/04/22.
//

import Foundation
@testable import RecipeApp

final class FoodMocks {
    static let shared: FoodMocks = FoodMocks()
    
    func mockMeals() -> [Meal] {
        var meals: [Meal] = []
        meals.append(Meal(id: "52772",
                         name: "Teriyaki Chicken Casserole",
                         thumb: "https://www.themealdb.com/images/media/meals/wvpsxx1468256321.jpg",
                         category: "Chicken",
                         videoURL: "https://www.youtube.com/watch?v=4aZr5hZXP_s"))
        meals.append(Meal(id: "52977",
                         name: "Corba",
                         thumb: "https://www.themealdb.com/images/media/meals/58oia61564916529.jpg",
                         category: "Side",
                         videoURL: "https://www.youtube.com/watch?v=VVnZd8A84z4"))
        meals.append(Meal(id: "53060",
                         name: "Burek",
                         thumb: "https://www.themealdb.com/images/media/meals/tkxquw1628771028.jpg",
                         category: "Side",
                         videoURL: "https://www.youtube.com/watch?v=YsJXZwE5pdY"))
        meals.append(Meal(id: "52977",
                         name: "Kumpir",
                         thumb: "https://www.themealdb.com/images/media/meals/58oia61564916529.jpg",
                         category: "Side",
                         videoURL: "https://www.youtube.com/watch?v=IEDEtZ4UVtI"))
        return meals
    }
    
    func mockMeal() -> Meal {
        return Meal(id: "52772",
                    name: "Teriyaki Chicken Casserole",
                    thumb: "https://www.themealdb.com/images/media/meals/wvpsxx1468256321.jpg",
                    category: "Chicken",
                    videoURL: "https://www.youtube.com/watch?v=4aZr5hZXP_s")
    }
    
    
    func mockDrinks() -> [Drink] {
        var drinks: [Drink] = []
        drinks.append(Drink(id: "15997",
                          name: "GG",
                          thumb: "https://www.thecocktaildb.com/images/media/drink/vyxwut1468875960.jpg",
                          category: "Ordinary Drink",
                          videoURL: nil))
        drinks.append(Drink(id: "17222",
                         name: "A1",
                         thumb: "https://www.thecocktaildb.com/images/media/drink/2x8thr1504816928.jpg",
                         category: "Cocktail",
                         videoURL: nil))
        drinks.append(Drink(id: "13501",
                         name: "ABC",
                         thumb: "https://www.thecocktaildb.com/images/media/drink/tqpvqp1472668328.jpg",
                         category: "Shot",
                         videoURL: nil))
        drinks.append(Drink(id: "17203",
                         name: "Kir",
                         thumb: "https://www.thecocktaildb.com/images/media/drink/apneom1504370294.jpg",
                         category: "Ordinary Drink",
                         videoURL: nil))
        return drinks
    }
    
    func mockDrink() -> Drink {
        return Drink(id: "15997",
                    name: "GG",
                    thumb: "https://www.thecocktaildb.com/images/media/drink/vyxwut1468875960.jpg",
                    category: "Ordinary Drink",
                    videoURL: nil)
    }
}
