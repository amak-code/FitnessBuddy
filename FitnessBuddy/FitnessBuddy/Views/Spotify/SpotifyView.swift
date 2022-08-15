////
////  SpotifyView.swift
////  FitnessBuddy
////
////  Created by antikiller on 11.08.2022.
////
//#if os(iOS)
//
//import SwiftUI
//
//struct SpotifyView: View {
//    @EnvironmentObject var spotifyController: SpotifyController
//    
//    var body: some View {
//        VStack{
//            if spotifyController.accessToken != nil {
//                Button {
//                    if let playerState = spotifyController.playerState, playerState.isPaused {
//                        
//                        spotifyController.appRemote.playerAPI?.resume()
//                    } else {
//                        
//                        spotifyController.appRemote.playerAPI?.pause()
//                        
//                    }
//                    
//                    
//                } label: {
//                    VStack{
//                        Image(uiImage: (spotifyController.trackImage ?? UIImage(named: "launchBackground"))!)
//                            .resizable()
//                            .frame(width: 300, height: 300, alignment: .center)
//                        Text(spotifyController.playerState?.track.name ?? "Unknown name of track")
//                            .font(.custom("BarlowCondensed-ExtraBoldItalic", size: 20))
//                            .padding()
//                        Text(spotifyController.playerState?.isPaused ?? true ? "Play" : "Pause")
//                            .foregroundColor(.white)
//                            .font(.custom("BarlowCondensed-ExtraBoldItalic", size: 30))
//                            .frame(width: 100, height: 100)
//                            .background(Color("AccentLight"))
//                            .clipShape(Circle())
//                    }
//                }
//            } else {
//                Button {
//                   
//                    spotifyController.connect()
//                   
//                   
//                } label: {
//                    VStack{
//                        Text("Play music from ")
//                            .font(.custom("BarlowCondensed-ExtraBoldItalic", size: 35))
//                            .foregroundColor(Color("AccentColor"))
//                            .padding()
//                        HStack{
//                            Image("spotify_icon")
//                                .resizable()
//                                .frame(width: 40, height: 40, alignment: .leading)
//                            Text("Spotify")
//                                .font(.custom("BarlowCondensed-ExtraBoldItalic", size: 30))
//                                .foregroundColor(Color("AccentDark"))
//                                .fontWeight(.thin)
//                        }
//                        Spacer()
//                        Text("Connect")
//                            .foregroundColor(.white)
//                            .font(.custom("BarlowCondensed-ExtraBoldItalic", size: 30))
//                            .frame(width: 100, height: 100)
//                            .background(Color("AccentLight"))
//                            .clipShape(Circle())
//                        Spacer()
//                        
//                    }
//                }
//            }
//            
//
//        }
//        
//    }
//}
//
//struct SpotifyView_Previews: PreviewProvider {
//    static var previews: some View {
//        SpotifyView()
//    }
//}
//
//#endif
