# nasa_api
Research over Nasa´s public API

## ===== Requirements ======

The app must contemplate the following requirements:

Have two screens: a list of the images and a detail screen
The images list must display the title, date and provide a search field in the top (find by title or date)
The detail screen must have the image and the texts: date, title and explanation
Must work offline (will be tested with airplane mode)
Must support multiple resolutions and sizes
Regarding the screen with the list, it would be nice to have pull-to-refresh and pagination features

ETD(Estimated time of delivery): 3 days.

## ===== Dev Instructions =====

1. Clone the repo
2. In the command line run
     ```
     flutter pub get.
     ```
3. Open an emulator. Youcan use either flutter's, android studio or simulator in iOS or your own cellphone connected to the pc
4. In the command line run, 
    ```
    flutter run
    ```
5. The application will build and install in your emulator or device. Remember if you have more than one connected the user interface will ask you to choose one.
6. If you need to run the tests perform the next command line instruction
    ```
    flutter test
    ```
7. Once you have downloaded the app add a new .env file in the root directory, edit it and add the next line API_KEY="your_nasa_api_key".
8. Enjoy it!


## ===== Inside the app, main functionalities =====

Once the app is up and running you will get to the landing page directly where it will display last week pictures of the day that are available at Nasa's site through their API. Clicking in any of the pictures will lead you to the picture details. You can also search for an specific picture by their title in the upper input search bar. You need to at least type 3 characters to perform the search. If cleaning up the input will show you all the results again.
 
In the picture details page you will see the picture in full length an will show extra data about it. 

Each time you want to go back, you may click in the upper left icon(back button).

The app can still work offline if the user at least was able to have internet connection to download the pictures locally. 

## ===== Good practices =====
Here I'm listing all the good practices used in this project.  

1. BLOC pattern
2. Flutter_modular to manage routing. This also gives you the ability to apply beautiful transitions.
3. Testing.
4. DI using modular package
5. API integration
6. Constants usage to avoid magic strings
7. Clean aruitecture by Uncle Bob(feature based)
8. Sembast as local db to be able to use the app without connection.
9. Used dotenv to securely store privater keys

## ===== Review after deliver and fixes =====

I have done all the reviews in a day.

1. Documentation: No instructions for running the tests; - Done
2. Security: API Key embedded in the code, which is extremely insecure;  - Done. Used dotenv to address this issue.
3. Code structure: The local DataSource is implemented outside the feature layers, which can make maintenance and evolution of the code more difficult; Base class is outside the feature layer along with the generic repository implementation. Each particular implmentation is done in each feature.
4. Code structure: There is no exception handling in the remote DataSource, which can cause unexpected failures; The data source had a try catch block to handled this situation.
5.  Code structure: Exceptions in the repository are all treated as server exceptions, without proper distinction between different types of errors. Implemented a new LocalServerFailure type in order to differentiate a local and remote server failures.
6. Code: The method _hasInternetConnection in the ConnectivityProvider class only returns true if google.com responds with 200, which may not be the ideal behavior; The idea behind is to know if can ping point an external resource any every usage website should do the trick.
7. Code structure: The repository does not fetch data from the cache in case of a request failure, which affects the resilience of the application; If you do not have internet and the local repository fails, I would not know where to take the information from(Quite strange review this one)