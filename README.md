 # FitnessBuddy 
![FitnessBuddy_icon](/FitnessBuddy/FitnessBuddy/Resources/Assets.xcassets/AppIcon.appiconset/100.png)
<p>A fitness app designed to help meet your fitness goals. This app sends reminders for your workout plans, persists data across your iOS personal devices, seamlessly integrates your Spotify music, and gives real-time updates on your heart rate. </p>

## Overview

- [Setup](#Setup)
- [TechStack](#TechStack)
- [Requirements](#Requirements)
- [Connect](#ConnectwiththeDevelopers)


## Setup

<p>There are a few things that are needed for this application to run:</p>
1. ExerciseDB Key
    1.  <a href="https://rapidapi.com/justin-WFnsXH_t6/api/exercisedb/details">ExerciseDB Overview</a>
2. Spotify SDK Key
    1. <a href="https://developer.spotify.com/documentation/ios/quick-start/">iOS SDK Quick Start</a>
    
<br>
<p>To clone the repository: </p>  
 
```
git clone https://github.com/amak-code/FitnessBuddy.git

```
<br>

<p>Finally, the ExerciseDB Key and Spotify SDK must be placed into the file <i>FitnessBuddy/Models/Keys.swift</i> like so:</p>

```

enum Keys: String {
    case exerciseDB = "INSERT ExerciseDB Key HERE"
}
```

## Tech Stack
- Firebase: Authentication and authorization, Realtime database
- Healthkit: Health data
- Spotify SDK: Playlist access
- JSONDecode: Decode json data from RapidAPI: ExerciseDB
- Webkit: Web Browser for gif views 


## Requirements
- Xcode 12+
- iOS 14+
- Swift 5.3+


## Connect with the Developers
|Name|Linkedin|Role|
|----|-----|
|Tiffany| Connect |Project Manager| 
|Aleksandra|<a href="https://www.linkedin.com/in/aleksandra-makhrova-a37061126/">Connect</a>|Future Senior iOS Developer|
|Tatiana|<a href="https://www.linkedin.com/in/tatiana-bondarenko/">Connect</a>|Future Senior iOS Developer|
|Niwei|<a href="https://www.linkedin.com/in/niwei-l-8702b068/">Connect</a>|Future Senior iOS Developer|
|Lily|<a href="https://www.linkedin.com/in/lily-tran-076b8b132/">Connect</a>|Future Senior iOS Developer|
