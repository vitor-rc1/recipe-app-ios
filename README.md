![](https://github.com/vitor-rc1/recipe-app-ios/actions/workflows/main_status.yml/badge.svg)

# Recipe App iOS - MVVM+C+S

## Features
- Search meals or drinks by:
  - Name
  - Ingredient
  - First letter
- Random meal or drink
- See meal or drink details

## APIs
- [TheMealDB API](https://www.themealdb.com/)
- [The CockTailDB API](https://www.thecocktaildb.com/api.php)
## Minimum Requirements 
 - XCode 13.1+
 - CocoaPod 1.11.3+
 - Ruby 2.6.3+

## Installation
1. Clone the repository
2. Run `pod install` in the project directory
3. Run `bundle install` in the project directory
4. Now you can open RecipeApp.xcworkspace and run the project
5. If you want to run the tests, you can run `bundle exec fastlane tests` in the project directory
6. To check the coverage, you can run `bundle exec fastlane tests_coverage` in the project directory

## Pods
- SwiftLint
- Alamofire
- SDWebImage
- Mocker
- SnapshotTesting

## Images

|<img src="./Public/launch-screen.png" width="300"> |
|:---:|
| Launch screen |

|<img src="./Public/meals-main.png" width="300">| <img src="./Public/meal-detail.png" width="300"> |
|:---:| :---:|
| Meals | Meal details|

|<img src="./Public/drinks-main.png" width="300">| <img src="./Public/drink-detail.png" width="300"> |
|:---:| :---:|
| Drinks | Drink details|

|<img src="./Public/not-found.png" width="300">| <img src="./Public/loading.png" width="300"> |
|:---:| :---:|
| Not found | Loading|

## Video preview
[![Watch the video](https://img.youtube.com/vi/XF0ukSnF1y4/hqdefault.jpg)](https://youtu.be/XF0ukSnF1y4)
