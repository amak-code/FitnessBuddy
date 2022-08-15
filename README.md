# FitnessBuddy
![FitnessBuddy_icon](./FitnessBuddy/FitnessBuddy/Resources/Assets.xcassets/Icons/dumbell_icon.imageset/dumbell_icon.png)
<p>A fitness app designed to help meet your fitness goals. This app sends reminders for your workout plans, persists data across your iOS personal devices, seamlessly integrates your Spotify music, and gives real-time updates on your heart rate. </p>

## Overview

- [Setup](#Setup)
- [Requirements](#Requirements)
- [Connect](#ConnectwiththeDevelopers)

## Setup

<p>There are a few things that are needed for this application to run:</p>
1. Yelp Fusion API Key
    1. Link to the instructions on how to acquire a Bearer Token: <a href="https://www.yelp.com/developers/documentation/v3/get_started">Get started with the Yelp Fusion API</a>
2. Spotify SDK
    1. <a href="https://developer.spotify.com/documentation/ios/quick-start/">iOS SDK Quick Start</a>
    
<br>
<p>To clone the repository: </p>  
 
```
git clone https://github.com/amak-code/FitnessBuddy.git

```
<br>

<p>Finally, the Yelp Fusion API Key and Spotify SDK must be placed into the file <i>FitnessBuddy/Models/Keys.swift</i> like so:</p>

```

enum Keys: String {
    case exerciseDB = "INSERT Yelp Fusion API Key HERE"
}
```


## Requirements
- Xcode 12+
- iOS 14+
- Swift 5.3+

## Connect with the Developers
|Name|Linkedin|
|----|-----| 
|Aleksandra|<a href="https://www.linkedin.com/in/aleksandra-makhrova-a37061126/">Connect</a>|
|Tatiana|<a href="https://www.linkedin.com/in/tatiana-bondarenko/">Connect</a>|
|Niwei|<a href="https://www.linkedin.com/in/niwei-l-8702b068/">Connect</a>|
|Lily|<a href="https://www.linkedin.com/in/lily-tran-076b8b132/">Connect</a>|
