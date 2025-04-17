//
// Copyright © 2025 Eus Goed.
// All Rights Reserved

import SwiftUI

struct GameView: View {
    
    let game: GameDTO
    
    var body: some View {
        ZStack {
            backgroundView
                .frame(height: 200)
                .cornerRadius(8)
            
            VStack(alignment: .leading) {
                Spacer()
                Text(game.name)
                    .colorScheme(.dark)
                    .bold()
                Text(game.createdAt.formatted())
                    .colorScheme(.dark)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal)
            .padding(.bottom, 8)
        }
        .clipShape(RoundedRectangle(cornerRadius: 8))
    }
    
    @ViewBuilder
    var backgroundView: some View {
        if let imageUrl = (game.screenshots ?? game.artworks)?.first?.imageURL {
            GeometryReader { geo in
                AsyncImage(url: imageUrl) { image in
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
                        ProgressView()
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
        GameView(game: PreviewData.screenshotGame)
        GameView(game: PreviewData.noScreenshotGame)
        GameView(game: PreviewData.loadingGame)
    }
    .padding()
}

