//
//  MusicPlayerView.swift
//  Quidco Staging
//
//  Created by George Quentin Ngounou on 13/08/2020.
//  Copyright © 2020 Maple Syrup Media. All rights reserved.
//
// using Neumorphism design - it is all about subtle contrast and solid colors.
// https://www.justinmind.com/blog/neumorphism-ui/
// https://neumorphism.io/#536ef3
// https://www.youtube.com/watch?v=z3tJdxwlo_Y

import SwiftUI
import Combine

// MARK: - podcast app Neumorphism design

class PodcastPlayerStore: ObservableObject {
    
    let didChange = PassthroughSubject<Void, Never>()
    
    @Published var currentTime: TimeInterval = 0.0
    var episode: Episode
    var episodes: [Episode] = []
    private var episodesIterator: IndexingIterator<[Episode]>
    
    init(episode: Episode) {
        self.episode = episode
        self.episodesIterator = episodes.makeIterator()
    }
    
    func advance() {
        /*
        episode = episodesIterator.next() ?? episodes[0]
        currentTime = 0.0
        // notify subscribers that the player has changed
        didChange.send()
        */
    }
    
    func play() {
        print("Play")
    }
    
    func skipForward() {
        print("Skip Forward")
    }
    
    func skipBackward() {
        print("Skip Backward")
    }
}

struct MusicPlayerView: View {
    @EnvironmentObject var playStore: PodcastPlayerStore
    @Environment(\.colorScheme) var colorScheme
    @State var isPlaying: Bool = false
    
    var body: some View {
        ZStack {
            if colorScheme == .dark {
                LinearGradient(Color.darkStart, Color.darkEnd)
            } else {
                LinearGradient(Color.whiteStart, Color.whiteEnd)
            }
            VStack(spacing: 50) {
                VStack(spacing: 10) {
                    Text(playStore.episode.title)
                        .font(.headline)
                        .padding([.leading, .trailing])
                        .foregroundColor(.primary)
                    Text(playStore.episode.showTitle)
                        .padding([.leading, .trailing])
                        .font(.caption)
                        .foregroundColor(Color.secondary)
                    
                    HStack(spacing: 20) {
                        BackwardButton()
                        PlayButton(isPlaying: $isPlaying)
                        ForwardButton()
                    }.padding(EdgeInsets(top: 30, leading: 0, bottom: 0, trailing: 0))
                    
                }
                .frame(minWidth: 0, maxWidth: 320, minHeight: 0, maxHeight: 320)
                .background(CustomCircularBackground())
                .shadow(color: Color.black.opacity(0.2), radius: 10, x: 10, y: 10)
                .shadow(color: Color.white.opacity(0.7), radius: 10, x: -8, y: -8)
 
                VStack {
                    Text("\(playStore.currentTime)")
                        .foregroundColor(.primary)
                    ZStack(alignment: Alignment(horizontal: .leading, vertical: .center), content: {
                        Capsule()
                            .fill(Color.secondary.opacity(0.2))
                            .frame(height: 6)
                        ZStack(alignment: Alignment(horizontal: .trailing, vertical: .center)) {
                            Capsule()
                                .fill(LinearGradient(Color.lightEnd, Color.lightStart))
                                .frame(width: CGFloat(playStore.currentTime), height: 6)
                            
                            Circle()
                                .fill(LinearGradient(Color.lightStart, Color.lightEnd))
                                .frame(width: 10, height: 10)
                                .padding(.all, 8)
                                .background(colorScheme == .dark ? Color.white : Color.black)
                                .clipShape(Circle())
                                .shadow(color: (colorScheme == .dark ? Color.darkStart.opacity(0.6) : Color.whiteStart).opacity(0.9), radius: 10, x: 4, y: 2)
                        }
                    })
                    .gesture(DragGesture().onChanged({ (value) in
                        if value.location.x <= UIScreen.main.bounds.width - 15 && value.location.x >= 15 {
                            self.playStore.currentTime = Double(value.location.x)
                        }
                    })).padding(.all, 10)
                }
            }
            
        }.edgesIgnoringSafeArea(.all)
    }
}

struct MusicPlayerView_Previews: PreviewProvider {

    static var previews: some View {
        Group {
            MusicPlayerView().environmentObject(PodcastPlayerStore(episode: Episode(title: "Fireside Chat with Geo", showTitle: "Becoming an iOS developer")))
            MusicPlayerView().environmentObject(PodcastPlayerStore(episode: Episode(title: "Fireside Chat with Geo", showTitle: "Becoming an iOS developer")))
                .environment(\.colorScheme, .dark)
        }
    }

}

struct PlayButton: View {
    @Binding var isPlaying: Bool // 25) this view should not own a source of truth by having @State, instead, use Binding because this can derive from a State.
    var body: some View {
        Toggle(isOn: $isPlaying) {
            Image(systemName: isPlaying ? "pause.circle" : "play.circle")
                .resizable()
                .foregroundColor(Color.primary)
                .scaledToFill()
                .frame(width: 50, height: 50, alignment: .center)
                .padding(.all, 5)
        }.toggleStyle(CustomButtonToggleStyle())
    }
}

struct ForwardButton: View {
    @EnvironmentObject var playStore: PodcastPlayerStore
    var body: some View {
        Button(action: {
            self.playStore.skipForward()
        }) {
            Image(systemName: "goforward.15" )
                .resizable()
                .foregroundColor(Color.primary)
                .scaledToFill()
                .frame(width: 30, height: 30, alignment: .center)
                .padding(.all, 5)
        }.buttonStyle(CustomButtonStyle())
    }
}

struct BackwardButton: View {
    @EnvironmentObject var playStore: PodcastPlayerStore
    var body: some View {
        Button(action: {
            self.playStore.skipBackward()
        }) {
            Image(systemName: "gobackward.15" )
                .resizable()
                .foregroundColor(Color.primary)
                .scaledToFill()
                .frame(width: 30, height: 30, alignment: .center)
                .padding(.all, 5)
        }.buttonStyle(CustomButtonStyle())
    }
}
