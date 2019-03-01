# PaginationExample
TODO:
- [x] MVVM-C Structure
- [x] Implement list with mock data
- [x] Connect up api to fetch data
- [x] Make object to handle network requests
- [x] Detect table view scroll to trigger network
- [ ] Make detail page for notes

This is an iOS example project to pull data from JSONPlaceholder and maybe paginate it. It will* be demonstrating:
- MVVM-Coordinator Pattern
- Some Protocol Oriented Design

## MVVM-Coordinator Pattern

### MVVM (Model-View-ViewModel)
MVVM has become a popular architecture for modern applications. The structure is as follows:
```
ViewController ->ViewModel -> Model
```

### Coordinators
Coordinators are like building blocks of your app.  They are responsible for:
1. Instantiation of your view controllers
2. Handling routing events from your view controllers

```swift
protocol RootCoordinator {
	func instantiateRoot() -> UIViewController?
}
```

