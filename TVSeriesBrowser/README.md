# 🎥 TVSeriesBrowser

A simple and elegant iOS app built with **SwiftUI** using the TVMaze public API. The app allows users to discover TV shows, view detailed information about each show and its episodes, and favorite them for later viewing.

---

## ✨ Features

- ✅ List of trending TV shows with infinite scroll  
- ✅ Search shows by name with debounce  
- ✅ Show detail screen with:  
- ✅ Poster image, schedule, genres, and summary  
- ✅ List of episodes grouped by season  
- ✅ Episode detail screen with summary and image  
- ✅ Favorite any show and access them through a dedicated tab  
- ✅ Responsive, modern and native iOS UX

---

## 🎓 Tech Stack

- **Swift 5.9**
- **SwiftUI**
- **MVVM + Clean Architecture**
- **UserDefaults** for persistence
- **Async/Await** for networking
- **XCTest** for ViewModel testing

---

## 🔁 Architecture Overview

```
TabView
 └── Discover (TVShowListView)
     └── TVShowListViewModel
         └── TVShowRepositoryProtocol
             └── NetworkService

 └── Favorites (FavoritesView)
     └── FavoritesManager (UserDefaults)
```

- Models are declared with clear separation: `TVShow`, `Episode`, `PosterImage`, etc.  
- Networking uses a `TVMazeRequest` protocol and a generic `NetworkService`  
- Repositories abstract data source logic  
- ViewModels handle state and logic, isolated from the views

---

## 📅 Requirements

- Xcode 15+
- iOS 16+

---

## 🛠 Setup & Run

1. Clone this repository:
```bash
git clone https://github.com/your-user/TVSeriesBrowser.git
```

2. Open the project:
```bash
open TVSeriesBrowser.xcodeproj
```

3. Run on any iOS 16+ simulator

---

## 🧪 Tests

Unit tests are written for key ViewModels using mocked repositories. Run them with:

```bash
Cmd + U
```

---

## 📦 Bonus Features Implemented

- [x] Favorites with persistence
- [x] Favorite badge shown in detail and list
- [ ] PIN lock (not implemented)
- [ ] FaceID/TouchID (not implemented)
