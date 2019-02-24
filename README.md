# PaginationExample
This is an iOS example project demonstrating:
- [x] MVVM-Coordinator Pattern
- [ ] Protocol Oriented Design
- [ ] Repository Pattern
- [ ] RxSwift


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

## Protocol-Oriented Design
Protocol-Oriented design is a practice to provide some attrative qualities for your program including:
- Access-control
- Testability
- Separation of concerns
- Flexbility

## Repository Pattern
Repository pattern is an abstraction used to combine multiple data providers through a simple interface.

## Reactive Programming
TODO