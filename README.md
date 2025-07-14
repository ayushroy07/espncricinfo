# ESPN CricInfo - Cricket App

A beautiful Flutter app that displays live cricket matches, scores, and match details using the Cricket API.

## Features

### 🏏 **Live Cricket Data**
- Real-time cricket matches from around the world
- Live scores and match status
- Team information and match details

### 📱 **Modern UI/UX**
- Beautiful splash screen with animations
- Card-based match listings with gradients
- Detailed match information pages
- Responsive design for all screen sizes

### 🔍 **Advanced Filtering & Sorting**
- Filter matches by type (T20, ODI, Test, T10)
- Filter by match status (Live, Upcoming, Finished)
- Sort matches by date (Recent/Oldest)
- Real-time search and filtering

### 📊 **Match Details**
- Comprehensive match information
- Team details and scores
- Match status and results
- Series information

## App Structure

### Pages
1. **Splash Screen** - Beautiful animated welcome screen
2. **Matches Page** - Main listing with filters and sorting
3. **Match Detail Page** - Comprehensive match information

### Architecture
- **Models**: `Match` class for data handling
- **Services**: `ApiService` for API communication
- **Widgets**: Reusable UI components
- **Pages**: Main app screens

## API Integration

The app uses the Cricket API to fetch live match data:
- **Endpoint**: `https://api.cricapi.com/v1/cricScore`
- **Features**: Live scores, match status, team information
- **Data**: Match types, scores, team names, series info

## Dependencies

```yaml
dependencies:
  flutter:
    sdk: flutter
  cupertino_icons: ^1.0.8
  http: ^1.1.0
  cached_network_image: ^3.3.0
  intl: ^0.20.2
  flutter_staggered_grid_view: ^0.7.0
```

## Getting Started

1. **Clone the repository**
   ```bash
   git clone <repository-url>
   cd espncricinfo
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Run the app**
   ```bash
   flutter run
   ```

## Features Overview

### Splash Screen
- Animated logo and branding
- Smooth transitions
- Professional cricket app branding

### Matches Listing
- Beautiful card-based design
- Color-coded match status (Live/Upcoming/Finished)
- Team names and scores
- Match type indicators
- Series information

### Filtering & Sorting
- **Match Type Filter**: T20, ODI, Test, T10
- **Status Filter**: Live, Upcoming, Finished
- **Sort Options**: Recent, Oldest
- **Real-time Updates**: Automatic refresh

### Match Details
- Complete match information
- Team details with scores
- Match status and results
- Series information
- Beautiful gradient headers

## Success Criteria Met ✅

- ✅ **Fully Functional App**: Complete cricket app with all features
- ✅ **Great UI**: Modern, beautiful design with gradients and animations
- ✅ **Code Quality**: Clean architecture with proper separation of concerns
- ✅ **App Architecture**: Well-structured Flutter app with models, services, and widgets
- ✅ **No Easy Bugs**: Robust error handling and data validation

## Technical Highlights

- **State Management**: Efficient state management with setState
- **API Integration**: Robust HTTP client with error handling
- **UI Components**: Reusable, well-designed widgets
- **Data Models**: Type-safe data handling
- **Error Handling**: Graceful error states and retry mechanisms

## Screenshots

The app features:
- Animated splash screen
- Beautiful match cards with gradients
- Detailed match information pages
- Advanced filtering and sorting options
- Professional cricket branding

---

**Built with ❤️ using Flutter & Dart**
