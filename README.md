# PaginationExample
TODO:
- [x] MVVM-C Structure
- [x] Implement list with mock data
- [x] Connect up api to fetch data
- [x] Make object to handle network requests
- [x] Detect table view scroll to trigger network
- [ ] Make detail page for notes

This is an iOS example project to pull data from JSONPlaceholder and maybe paginate it. It will feature:
- MVVM-Coordinator Pattern
- Some Protocol Oriented Design
- Some monads in the form of the `Result` type 

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


## Result (monad part)

The result type is like an `Either<A,B>` seen in other languages like Haskell. It's takes two generic parameters A and B which represent the possible type of the value it returns. My defintion of result is like this `Result ~ Either<A, Error>`.  It makes it easy to handle errors as they are can be propogated down long chains of logic. Like below...
```swift
Result.wrap("http://download.something")
    .map(buildRequest)
    .map(performRequest)
    .map(showTheUser)
    .catchError({ error in
        switch error {
        case let as NetworkError: // possible error from performRequest function
        case let as UIError: // possible error from showTheUser function
        default: break
        }
    })
```


