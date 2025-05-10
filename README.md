<!-- # bharat_nxt_assignment

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
 -->

markdown 
CopyEdit 
# Flutter Article App 
 
A Flutter app that fetches and displays a list of articles from a public 
API. 
 
## Features - List of articles - Search functionality - Detail view - Responsive UI 
 
## Setup Instructions 
1. Clone the repo: 
   git clone <https://github.com/ishita1226/bharatNXT.git> 
   cd bharat_nxt_assignment 
 
2. Install dependencies: 
   flutter pub get 
 
3. Run the app: 
   flutter run 
 
## Tech Stack - Flutter SDK: [3.29.3] - State Management: [Bloc] - HTTP Client: [http] - Persistence: [hive]
## State Management Explanation 
[Write 2-3 sentences about your choice and data flow]
The app uses Bloc for state management, chosen for its robust separation of business logic and UI. The ArticleBloc handles events like fetching articles, searching, and toggling favorites, emitting states (ArticleInitial, ArticleLoading, ArticleLoaded, ArticleError) to update the UI reactively. Data flows from API calls (via ApiService) and Hive storage to the Bloc, which provides a single source of truth for all screens. 
 
## Known Issues / Limitations 
[List anything incomplete or improvable] 

Client-Side Search: Local filtering may slow down with very large datasets.
No Offline Mode: Articles require an internet connection to load initially.
Basic Error Handling: Displays error messages for network failures but lacks advanced retry mechanisms.
Hive Storage: Stores only article IDs to minimize storage, limiting offline access to favorited articles.
Favorite Toggle Delay: Rapid toggling may cause slight delays on slower devices due to Hive writes.
 
## Screenshots (Optional) 
[Add if applicable] 
