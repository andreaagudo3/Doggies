# Doggies - Clean Architecture and MVVM
This simple project probably doesn't need this overengineering, it is just an example of clean architecture and MVVM pattern written in swift.
No template was used on this project.

![Alt text](README_FILES/CLEAN+MVVM.png?raw=true "Clean Architecture Layers")

## Layers
* **Domain Layer** = Entities + Use Cases + Repositories Interfaces
* **Data Repositories Layer** = Repositories Implementations + API (Network) + Persistence DB
* **Presentation Layer (MVVM)** = ViewModels + Views

### Dependency Direction
![Alt text](README_FILES/Dependency.png?raw=true "Modules Dependencies")

**Note:** **Domain Layer** should not include anything from other layers(e.g Presentation — UIKit or SwiftUI or Data Layer — Mapping Codable)

## Architecture concepts used here
* Clean Architecture https://blog.cleancoder.com/uncle-bob/2012/08/13/the-clean-architecture.html
* [MVVM](Doggies/Presentation/Scenes/BreedsList) 
* [Dependency Injection](Doggies/Presentation/Scenes/BreedsList/BreedsListConfigurator.swift)
* [Flow Coordinator](Doggies/Presentation/Coordinators/BreedsCoordinator.swift)

## Includes
* Dark Mode
* SwiftUI example, demostration that presentation layer does not change, only UI.
* [SPM] Swift Package Manager is a tool for managing the project dependencies.

## Dependencies
* [Nuke] Image Loading System (https://github.com/kean/Nuke)
 
## To DO:
### Improvements
- Cache breeds list
- Add search on the breeds list scene
- Separate the different layers in modules. [Modular Architecture] (https://medium.com/@leandromperez/a-modular-architecture-in-swift-aafd9026aa99)
	- ✅ Already created the **Networking module**
- Add refresh button on the breed random images.
- Make breed image bigger when tapping it (as a pop up).

### Must
- Add tests
- Create DTO objects and map them toDomain().

# Recommendations
- Run the app on iOS 14 or above to see the breeds list with Swift UI. Run it under iOS 14 and see a better design with UIKit.
- Feel free to change the code so to see the different breeds list designs.

