#  LibraryAPI
First project using SwiftUI to get books from openlibrary.org

## Features
- Search for works
- Authofill and suggestions in search
- Show details
- Chaching for offline mode


## Search To Details 
https://github.com/user-attachments/assets/e6ba30f5-dedd-4acf-b986-c7979dcc5f9a

##  Autofill 
https://github.com/user-attachments/assets/b99acbcb-78f2-48ad-8fcf-74ee0d26997f

## Pagination 
https://github.com/user-attachments/assets/fda4cbc0-3057-46a7-9414-6cafadad4fb8

## Error State
https://github.com/user-attachments/assets/8c38010c-6047-4a58-9a44-f5c81a749832


## Localization
|  Image Cover |  Detail View  |
|  ---------  |  ---------  |
|  ![Simulator Screenshot - iPhone 16 Pro - 2025-01-29 at 07 15 58](https://github.com/user-attachments/assets/67b33d29-7f6a-4902-82df-d5aa8a8da98b)  |  ![Simulator Screenshot - iPhone 16 Pro - 2025-01-29 at 07 16 04](https://github.com/user-attachments/assets/bd550872-4d34-46b5-a7d8-8db3d3eb15bb)  |

### Data Persistence
 - Used simple HTTP Caching as it was simple to implement. Another option would have been CoreData of SwiftData but this seemed unnecessary as we are just read JSON from the server and not manipulating the data

### Architecture
 - Used a simple MVVM as I think it goes well with SwiftUI and keeps all the business logic in the view models.

### Testing
 - Added Unit tests to TechTestCore framework to check decoding
 - Added tests to check network calls, searching, etc. Basically wanted to test all viewModels business logic
 - Added one UI tests for a quick run through


### Additional functionality added
 - Localization is set up (Separate Target added for testing)
 - Custom font added for description text
 - Custom flip view added (code for this is found online and sourced)
 - Moved Models into own framework incase it is needed for a different project (separate unit tests here for decoding)
 - Added autocomplete/ suggestions for searches

## Style 
Follows Rey Wenderlich style guide https://github.com/raywenderlich/swift-style-guide

## Credited Work
Card flip taken from https://www.youtube.com/watch?v=v2Xf1gwcQSA
