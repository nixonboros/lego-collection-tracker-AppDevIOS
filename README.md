# Lego Collection Tracker - Assignment 3
A SwiftUI app that helps Lego enthusiasts organize, track, and manage their Lego collections. Built for iOS as part of an App Development group assignment at UTS.

## Github Repository
https://github.com/nixonboros/lego-collection-tracker-AppDevIOS

## Team Members
- Nixon Boros - 24566667 
- Rohan Gupta - 25495033
- Michael Elasi - 24844755

## Project App Features
### 1. Home Page
- **Purpose**: Quick overview of your collection and stats
- **Functionality**: Acts as the central hub of the app, showing summary counts and navigation options
- **Buttons**:
  - `+ Add New Set` → navigates to *Add Set Page*
  - `View Collection` → navigates to *Collection Page*
  - `View Wishlist` → navigates to *Wishlist Page*

---

### 2. Add Set Page
- **Purpose**: Search and add Lego sets from a built-in set database (using CSV data from Rebrickable)
- **Functionality**: Search Lego sets by name/set number, filter results, and add selected sets to your collection
- **Buttons**:
  - `Search` (real-time or submit)
  - `Filter` (theme/year)
  - `Add to Collection`
  - `Cancel`

---

### 3. Collection Page
- **Purpose**: Show all added sets
- **Functionality**: View your collection, apply filters, sort sets, and search for specific entries
- **Buttons**:
  - `Filter` (by theme/year/status)
  - `Sort` (by name/year)
  - `Search` bar
  - `Tap a Set` → opens *Set Detail Page*

---

### 4. Set Detail Page
- **Purpose**: View and manage a single set from collection 
- **Functionality**: See detailed information of a selected set, and edit or remove it from your collection
- **Buttons**:
  - `Edit Set`
  - `Delete Set`
  - `Mark as Complete/Incomplete`
  - `Back`

---

### 5. Wishlist Page
- **Purpose**: Show planned sets to collect
- **Functionality**: Add sets you're interested in, track wishlist progress, and move purchased sets to collection
- **Buttons**:
  - `+ Add to Wishlist`
  - `Mark as Purchased` → moves item to collection
  - `Edit Wishlist Item`
  - `Delete`

