# PaginationExample

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

[File](PaginationExample/PaginationExample/Utils/Result.swift)

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

You also get to dodge passing errors along with your data. Typically we might add `Optional<Error>` to be given to a callback along with data just in case something messes up. It might look like this:
```
func somethingAsync(callback: (Data, Error?)->) {/* */}

somethingAsync(callback: { data, error in
    if let error = error {
        // error handling
        return
    }
    
    // mess with data now
})
```

Now instead if we use the `Result` type in our callback method, we get a much nicer syntax (well in my opinion anyway). This clearly isn't for free though
1. We might make more objects so they need to be allocated memory
2. The minimum number of function calls increases as we need to pass a closure into the `Result.map` method since thats how we access the data.

```swift
func somethingAsync(callback: (Result<Data>)->()) {/* */}

somethingAsync(callback: { result in
    result.map({ data in
        // mess with data now
    })
    .catchError({ error in
        // error handling
    })
})
```


# TODO
- [x] MVVM-C Structure
- [x] Implement list with mock data
- [x] Connect up api to fetch data
- [x] Make object to handle network requests
- [x] Detect table view scroll to trigger network
- [x] Make detail page for notes
- [ ] Write a better readme.md
- [ ] Write a long medium post about how to start iOS development, because there isn't enough of those posts...

