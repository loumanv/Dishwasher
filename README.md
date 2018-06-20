# Dishwasher

An iPad app that displays dishwasher products. The app is written in Swift and supports iOS 11+ and both potrait and landscape orientations.

The app gets the data from an API that is accessible through the endpoint: https://api.johnlewis.com/v1/products/search

- On launch the app connects to the API to asynchronously get the first 20 dishwasher products.
- Presents the dishwashers inside a collection view showing their title, price and image.

### Architecture

The app is developed using the `MVVM` architecture:

- The Model consists of a `Dishwasher` and a `Price` object.
- The viewModel is called `DishwashersViewModel` that handles the manipulation of the data in order to be shown by the ViewController.
- The ViewController is called `DishwashersViewController`. Inside `DishwashersViewController` all the related methods for populating the collection view. The view controller implements the `ContentLoadable` protocol that handles the logic of loading the data. 
- The network layer consists of the `NetworkClient` class that deals with all the network calls.

The use of protocols like `ContentLoadable` and `NetworkSession` helps with reusability as well as testability of the various components.

This separation of concerns makes unit testing of the layers easier and the codebase easier to maintain and expand further. 
