# blood_glucose 
This a simple Application  to retrieve data from an external API, read the data and plot a line graph.
 

## App Features 

1.   User can view up to 100 sample in the graph.
2.   User can filter samples by date.
3.   User can view the min,max,average and median values of the graph.
4.   User can highlight min and max values by hovering on them.

## App architecture
Based on clean architecture Bloc, and dependancy injection

### The app includes the following main components:

* A web api service for shorten the URLs.
* A repository that works with the cache and the api service, providing a unified data interface. 
* Use cases for the user actions.
* A DI module to handle Prod and Test modes. 

### App Packages:
* **core** - contains shared models and usecases.
* **data** - contains :
  * remote - contains the api classes to make api calls using Retrofit and Dio.
  * repo - contains real and mocked repository classes for triggering API requests and caching the Glucose samples.
* **domain** - contains busniess logic and the app usecases.
* **di** - contains dependency injection modules for Injectable lib.
* **presentation** - contains screens and widgets and BloCs.
* **utils** - contains Utils classes.

### App Envs:
* **Prod** - main.dart : the dependancy injection will be set to Prod mode and it will use real datasourse.
* **Test** - not completed yet!
### App Specs
* Developed with Flutter 2.0.6 SDK
* Dart. 
* Bloc Architecture.
* Injectable and GetIT for dependency injection.
* Prod and Test Enves
* Retrofit for API integration. 
------ 

### Run the app
 
#####  Debug Mode
flutter run 
#####  Profile Mode:
flutter run --profile
 
 