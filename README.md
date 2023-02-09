# IPS Assignment - by loyd

✅ Done List

Lessons list screen: 

- Show title “Lessons”
- Implement the lesson list screen using SwiftUI
- Show a thumbnail image and name for each lesson
- List of lessons has to be fetched when opening the application (from URL or local cache when no connection)

Lesson details screen:

- Implement the lessons details screen programmatically using UIKit
- Show video player
- Show a “Download” button to start download for offline viewing
- Show a “Cancel download” and progress bar when video is downloading
- Show lesson title
- Show lesson description
- Show a “Next lesson” button to play next lesson from the list
- Show video in full screen when app rotates to landscape

📝 TODO List

Testing

- Write unit and UI automated tests with XCTest. 
- Tests have to be meaningful and comprehensive and cover all important functionality of the app.

Noted for modified

- Have to change AsyncImage class to other ( The 'AsyncImage' class available more iOS 15.0. Should consider under 15 version phone )
- The detail View screen should be available scrolling for small screen sizes.
- Play Button in detail view is small.
- When caches, the image also should be cached [ Reference link: https://levelup.gitconnected.com/image-caching-with-urlcache-4eca5afb543a]
