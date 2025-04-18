//
// Copyright © 2025 Eus Goed.
// All Rights Reserved

import SwiftUI
import CachedAsyncImage

struct GameView: View {
    
    let game: Game
    let isConnected: Bool
    
    var body: some View {
        ZStack {
            backgroundView
                .frame(height: 200)
                .cornerRadius(8)
            
            VStack(alignment: .leading) {
                Spacer()
                Text(game.name)
                    .font(.title2)
                    .bold()
                    .multilineTextAlignment(.leading)
                
                HStack {
                    Text(game.createdAt.formatted())
                    Spacer()
                    if let rating = game.rating {
                        Text("\(String(format: "%.1f", rating / 10.0)) / 10 ⭐️")
                        .bold()
                    }
                }
            }
            .foregroundStyle(.white)
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal)
            .padding(.bottom, 8)
        }
        .clipShape(RoundedRectangle(cornerRadius: 8))
    }
    
    @ViewBuilder
    var backgroundView: some View {
        if let imageUrl = (game.screenshots ?? game.artworks)?.first?.genericImage().imageURL {
            GeometryReader { geo in
                CachedAsyncImage(url: imageUrl, urlCache: .imageCache) { image in
                    image
                        .resizable()
                        .scaledToFill()
                        .frame(maxWidth: geo.size.width)
                        .clipped()
                        .overlay {
                            LinearGradient(colors: [Color.clear, Color.black],
                                           startPoint: .center,
                                           endPoint: .bottom)
                        }
                } placeholder: {
                    ZStack {
                        Color.gray
                        if isConnected {
                            ProgressView()
                        } else {
                            Image(systemName: "network.slash")
                                .foregroundStyle(.white)
                        }
                    }
                }
            }
        } else {
            ZStack {
                Color.gray
                Image(.noScreenshot)
                    .resizable()
                    .scaledToFit()
                    .frame(height: 150)
                    .padding(.bottom, 50)
            }
        }
    }
}

#Preview {
    LazyVStack(spacing: 8) {
        GameView(game: Game(from: PreviewData.screenshotGame), isConnected: true)
        GameView(game: Game(from: PreviewData.noScreenshotGame), isConnected: true)
        GameView(game: Game(from: PreviewData.loadingGame), isConnected: true)
        GameView(game: Game(from: PreviewData.loadingGame), isConnected: false)
    }
    .padding()
}

