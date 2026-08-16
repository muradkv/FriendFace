# FriendFace

![Swift](https://img.shields.io/badge/Swift-5.0+-FA7343?logo=swift&logoColor=white)
![iOS](https://img.shields.io/badge/iOS-18.0+-000000?logo=apple&logoColor=white)
![Xcode](https://img.shields.io/badge/Xcode-16.0+-147EFB?logo=xcode&logoColor=white)
![Framework](https://img.shields.io/badge/Framework-SwiftUI-007AFF)
![Persistence](https://img.shields.io/badge/Persistence-SwiftData-34C759)
![Architecture](https://img.shields.io/badge/Architecture-MVVM-8A2BE2)

An offline-first iOS social directory application that fetches remote user profiles, maintains persistent relational storage via SwiftData, and delivers a modern reactive browsing experience built with SwiftUI.

FriendFace combines asynchronous networking, robust local database caching, layered architecture, and deep list presentations. The app seamlessly transitions between remote REST API ingestion and local disk retrieval, ensuring complete functionality without an active network connection.

## Preview

<img width="23%" alt="Main" src="https://github.com/user-attachments/assets/b88cd9fe-df09-4481-b277-345daf96f0ea" />
<img width="23%" alt="Filter" src="https://github.com/user-attachments/assets/af4a1c2e-506c-4bf8-8bb8-a5e250b4dcc9" />
<img width="23%" alt="Search" src="https://github.com/user-attachments/assets/2ca2e8cc-2240-4a44-85a6-a84809db66da" />
<img width="23%" alt="Detail" src="https://github.com/user-attachments/assets/eb512e5d-f33e-43c5-ad1c-8bf4577fe493" />

## Features

* **Offline-First Persistence:** Automatically caches remote JSON payloads into local SQLite storage via SwiftData, enabling instant launch and offline access.
* **Asynchronous Networking:** Secure, structured data retrieval via `URLSession` with automated ISO-8601 date parsing strategy.
* **Dynamic Search & Sorting:** Real-time client-side profile filtering by name or company combined with multi-parameter sorting (Name, Company, Age).
* **Relational Detail Presentations:** Hierarchical profile inspections with active status indicators, custom deduplicated interest tags, and interactive friend associations.
* **Modern Error Handling & UX:** System-standard `ContentUnavailableView` empty states, pull-to-refresh synchronization, and granular alert presentations on network failures.

## About the Project & Challenge

This project was developed as a consolidation milestone spanning **Day 60 (Milestone: Projects 10-12)** and **Day 61 (Time for SwiftData)** of Paul Hudson's 100 Days of SwiftUI curriculum. 

The primary objective evolved from building a zero-base network consumer app using `URLSession`, `Codable`, and `NavigationStack` into addressing real-world feature creep: adapting the architecture to support offline-first local persistence powered by **SwiftData**.

Beyond the course requirements, the codebase underwent comprehensive architectural refactoring to mirror production standards:

* **DTO / Domain Layer Separation:** Decoupled the networking contract (`UserDTO`, `FriendDTO`) from domain storage entities (`@Model User`, `@Model Friend`). Raw JSON decoding errors are absorbed at the boundary, and business rules (e.g., tag deduplication) execute during domain mapping.
* **Clean MVVM Architecture:** Isolated presentation logic into `@MainActor` and `@Observable` ViewModels (`UserListViewModel`, `UserDetailViewModel`), keeping SwiftUI Views purely declarative and stateless.
* **Context Synchronization & Cache Management:** Integrated `ModelContext` operations directly within the ViewModel layer. Resolved SQLite race conditions and duplicate ID warnings on pull-to-refresh by enforcing explicit deletion persistence before entity insertion.
* **View Composition:** Decomposed complex list screens into reusable UI components (`UserRowView`, contextual empty states) with isolated Preview containers.

🔗 **[Full project challenge description (Day 60)](https://www.hackingwithswift.com/guide/ios-swiftui/5/3/challenge)** 🔗 **[Full SwiftData challenge description (Day 61)](https://www.hackingwithswift.com/100/swiftui/61)**

## Project Versioning & Changelog

* **v2.0.0 (SwiftData Persistence & Offline-First Mode)** — `commit: 81120b1`  
  Upgraded persistence engine to SwiftData. Converted `User` and `Friend` into `@Model` classes with cascade relationships, configured `ModelContainer` in the App root, integrated `ModelContext` caching in ViewModels, and fixed context deletion persistence during force-refresh.

* **v1.1.0 (Architecture Refactoring & UX Enhancements)** — `commit: 4eb2639`  
  Introduced separated `UserDTO` network mapping layer with automatic tag deduplication. Migrated state handling to `@Observable` ViewModels, added native `.searchable` query pipeline, dynamic sorting menus, `ContentUnavailableView`, and pull-to-refresh alerts.

* **v1.0.0 (Core Challenge MVP)** — `commit: be4d950`  
  Initial baseline release fulfilling Day 60 milestone requirements. Implemented async JSON data fetching with `URLSession` and `Codable`, master-detail navigation with `NavigationStack`, and active status tracking.
