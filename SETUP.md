# Basic Setup

In order to perform API request, you must implement the protocol `Dispatcher`. You are welcome to create your own implementations, but we provide one we believe that will sufice common needs. By providing objects for our `Environment` class and a few protocols, you may initialize the `CommonMoyaDispatcher`. In the following sections, we will explore the dependencies of this class. 

```swift
open class CommonMoyaDispatcher: MoyaDispatcher {

    public var environment: Environment
    public let resultHandler: ResultHandler
    public let errorFilter: ErrorFilter
    public let interceptor: RequestInterceptor

//...
```

For information on the [RequestInterceptor](https://github.com/Alamofire/Alamofire/blob/master/Source/RequestInterceptor.swift), please consult [Alamofire](https://github.com/Alamofire/Alamofire).

## Environment

```swift
public class Environment {

    public let baseURL: URL?

    public let type: EnvironmentSpecifying // protocol used to define the environment (development, production, store..)

    public let name: String

    public var commonHeaders: Headers

    public let cachePolicy: URLRequest.CachePolicy

    public let fixturesType: FixtureTypeSpecifying // protocol to define how data is simulated

    public var specificHeaders: SpecificHeaders // protocol to define headers to specific group of endpoints

    public var serverTrustManager: ServerTrustManager

// ...
```

The goal for this class is to be used to distinct the environment which the request is being performed. Its attributes will be used to modify requests and how responses are dealt with. There are multiple convenience inits to help initialize this class.

It is also in the environment where you can easily setup certificate pinning. By either providing a direct implementation of the class `ServerTrustManager` or a implementation of the protocol `Certificate` (recommended), the pinning will be enabled. 

## ResultHandler

By conforming to this protocol, you can intercept the result before it is returned to its caller (dispatcher methods that map the response). By doing this you will be able to handle results in specific ways. For instance you may navigate to a specific screen when the session expires or a breach is detected.

```swift
public class TFResultHandler: ResultHandler {

    internal weak var coordinator: SignOutSceneCoordinating?

    public init(coordinator: SignOutSceneCoordinating?) {
        self.coordinator = coordinator
    }

    public func handleRequest(response: Response?, completion: @escaping GenericCompletion<Void>) {
        completion(.success(()))
    }

    public func handleRequest(error: Error?, completion: @escaping GenericCompletion<Void>) {
        guard let interactionError = error as? InteractionError else {
            completion(.success(()))
            return
        }
        switch interactionError {
        case .expiredUserSession:
            handleExpiredUserSession()
            completion(.success(()))
        default:
            completion(.success(()))
        }
    }

    private func handleExpiredUserSession() {
        coordinator?.didSignOut()
    }
}
```
## ErrorFilter
