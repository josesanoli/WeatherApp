
# WeatherApp

WeatherApp is an iOS application that provides the weather in a random location through coordinates. WeatherApp uses the data http://openweathermap.org/current API to get the information to show.
Just tap the button to get a new location weather. If there is a city in the location the app show its name, else the coordinates will be shown.

### API Key
You will need to provide API KEY to fetch the data from Weather API
First, Signup at https://openweathermap.org/ and get your API KEY.
Then, copy the Key and write it in APIEndpoints.swift file at API_KEY constant.

### ChangeLog
1.0.0: (14-2-2021)
* Initial release

### Installation and use
Download the project and run WeatherApp target to launch the app.

### Running the tests
On Xcode, go to Test Navigator in the left navigation menu, and press the Run button on the test you want to execute.
Also go to Product -> Test, to launch all tests.

### Development tools:
* Xcode 12.4
* Swift 5.3
* Dependencies: none

## Projet development:

In this iOS project, the principles of Clean Architecture with 3 layers have been applied to separate the business logic (Domain layer), the presentation of data (Presentation layer) and the collecting of the necesary data (Data layer).

In the project tree you can see the layers in these groups:
* Domain: Entities, Use Cases and Repositories Interfaces
* Data Repositories: Repositories Implementations and API call (NetworkService)
* Presentation: ViewModel and View

There is implemented the MVVM architecture with use cases and repository, each class has a single responsibility, each implementation can be replaced by another only maintaining the same protocol and could be extended with new use cases or repositories. 
The communication between the different layers is done through the dependencies injection with the implementation of their interfaces(protocols), the direction of the dependencies can be seen in the WheatherSceneDIContainer class, from the ViewController, it goes through the ViewModel to the use case and this implements the repository and if necessary the NetWorkService, with the response and with the dependencies inversion, the data we need reaches the domain layer of the use case with the object(WeatherData) we need to show.

### Use cases and Data layers
These use cases have been implemented:
* GetLocatioUseCase: It is intended to let the app that could be expandable, now the coordinates are obtained randomly, but this coordinates also can be get from device's GPS, or with a service where you choose a city and it returns coordinates, or with user data... for this reason, this use case can add methods that will connect with the needed repository.
* FetchWeatherUseCase: In this use case we want to obtain the weather data in our data model (WeatherData) object, we get this data from the API (http://openweathermap.org/current), for this, the WeatherAPIRepository interface is implemented and this repository implements NetworkService. With NetworkService we obtain the JSON String, in the repository we transform that json into an object (WeatherResponse) with all the info provided by the service. Finally, the use case only collects the data that the ViewModel has requested.

### Presentation layer
The design pattern with observables has been used for the viewController and viewModel, this allows that, if in the future, you want to migrate the view to SwiftUI only has to subscribe the viewController to the same observables as the current one. This way we also avoid using UIKit in the viewModel and this class does not depend on any View class.

## Next steps:
* Obtain data from the device's GPS and give the possibility to show the weather in your location.
* As if there were a loading view, quickly change the coordinate numbers while app is waiting the response from the API.
* Show other data: local time, sunrise and sunset, country, wind direction ...
* Modify the background color according to the weather and hour of day.
* Add a view to show the location obtained by the coordinates on a map.


### Author:
Jose Luis Sánchez - https://github.com/josesanoli
