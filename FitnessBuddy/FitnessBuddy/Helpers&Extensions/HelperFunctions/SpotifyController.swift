
//
//  SpotifyController.swift
//  SpotifyQuickStart
//


import SwiftUI
//import SpotifyiOS
import Combine

class SpotifyController: NSObject, ObservableObject {
    let spotifyClientID = "b571d39cbd2d4c9480db8f86ef6bb738"
    let spotifyRedirectURL = URL(string:"fitnessbuddy://")!
    
    @Published var accessToken: String? = nil
    @Published var playerState: SPTAppRemotePlayerState?
    @Published var trackImage: UIImage?
    
    var playURI = ""
    
//    private var connectCancellable: AnyCancellable?
//
//    private var disconnectCancellable: AnyCancellable?
    
    override init() {
        super.init()
//        connectCancellable = NotificationCenter.default.publisher(for: UIApplication.didBecomeActiveNotification)
//            .receive(on: DispatchQueue.main)
//            .sink { _ in
//                self.connect()
//            }
//
//        disconnectCancellable = NotificationCenter.default.publisher(for: UIApplication.willResignActiveNotification)
//            .receive(on: DispatchQueue.main)
//            .sink { _ in
//                self.disconnect()
//            }

    }
        
    lazy var configuration = SPTConfiguration(
        clientID: spotifyClientID,
        redirectURL: spotifyRedirectURL
    )

    lazy var appRemote: SPTAppRemote = {
        let appRemote = SPTAppRemote(configuration: configuration, logLevel: .debug)
        appRemote.connectionParameters.accessToken = self.accessToken
        appRemote.delegate = self
        return appRemote
    }()
    
    
    func update(playState: SPTAppRemotePlayerState) {
        if playerState?.track.uri != playState.track.uri {
            fetchArtwork(for: playState.track)
        }
       playerState = playState
      

      
    }
    
    func setAccessToken(from url: URL) {
        let parameters = appRemote.authorizationParameters(from: url)
        
        if let accessToken = parameters?[SPTAppRemoteAccessTokenKey] {
            appRemote.connectionParameters.accessToken = accessToken
            self.accessToken = accessToken
            appRemote.connect()
        } else if let errorDescription = parameters?[SPTAppRemoteErrorDescriptionKey] {
            print(errorDescription)
        }
        
    }
    
    func connect() {
        guard let _ = self.appRemote.connectionParameters.accessToken else {
            self.appRemote.authorizeAndPlayURI("")
            return
        }
        
        appRemote.connect()
    }
    
    func disconnect() {
        if appRemote.isConnected {
            appRemote.disconnect()
        }
    }
    
}

extension SpotifyController: SPTAppRemoteDelegate {
    func appRemoteDidEstablishConnection(_ appRemote: SPTAppRemote) {
        self.appRemote = appRemote
        self.appRemote.playerAPI?.delegate = self
        self.appRemote.playerAPI?.subscribe(toPlayerState: { (result, error) in
            if let error = error {
                debugPrint(error.localizedDescription)
            }
//            self.playerState = result as? SPTAppRemotePlayerState
        })
    }
    
    func appRemote(_ appRemote: SPTAppRemote, didFailConnectionAttemptWithError error: Error?) {
        print("failed")
    }
    
    func appRemote(_ appRemote: SPTAppRemote, didDisconnectWithError error: Error?) {
        print("disconnected")
    }
    
    func fetchArtwork(for track: SPTAppRemoteTrack) {
        appRemote.imageAPI?.fetchImage(forItem: track, with: CGSize.zero, callback: {(image, error) in
            if let error = error {
                print("Error fetching track image: " + error.localizedDescription)
            } else if let image = image as? UIImage {
                self.trackImage = image
                print("IMAGE WAS FETCHED")
            }
        })
    }
    
}



//extension SpotifyController: SPTAppRemotePlayerStateDelegate {
//    func playerStateDidChange(_ playerState: SPTAppRemotePlayerState) {
//        debugPrint("Track name: %@", playerState.track.name)
//    }
//
//}

extension SpotifyController: SPTAppRemotePlayerStateDelegate {
    func playerStateDidChange(_ playerState: SPTAppRemotePlayerState) {
        update(playState: playerState)
     //   self.playerState = playerState
        
    }
    
}

