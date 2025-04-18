//
// Copyright © 2025 Eus Goed.
// All Rights Reserved

import SwiftUI
import CachedAsyncImage

struct GameDetailScreen: View {
    @State var game: Game
    @Environment(\.openURL) var openURL
    @Environment(NetworkMonitor.self) private var networkMonitor
    
    @State private var summaryExpanded: Bool = false
    @State private var offset: CGFloat = 0
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                if let cover = game.cover?.coverImage() {
                    headerView(cover: cover)
                }
                
                VStack {
                    if !networkMonitor.isConnected {
                        NoNetworkConnectionView()
                    }
                    nameView()
                    
                    if let summary = game.summary {
                        summaryView(summary)
                    }
                    
                    if let screenshots = game.screenshots?.map({  $0.genericImage() }) {
                        carouselView(title: "Screenshots", images: screenshots)
                    }
                    
                    if let artworks = game.artworks?.map({  $0.genericImage() }) {
                        carouselView(title: "Artworks", images: artworks)
                    }
                    
                    Button(action: { openURL(game.url) }) {
                        HStack {
                            Image(systemName: "safari.fill")
                            Text("More details")
                        }
                        .foregroundStyle(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.accentColor)
                        .cornerRadius(8)
                    }
                }
                .padding(.horizontal)
                
                Spacer()
            }
        }
        .safeAreaPadding(.bottom)
        .safeAreaPadding(game.cover == nil ? .top : [])
        .coordinateSpace(name: "scroll")
    }
    
    @ViewBuilder
    func headerView(cover: ImageLoadable) -> some View {
        let aspectRatio = cover.height / cover.width
        let baseHeight = UIScreen.main.bounds.width * aspectRatio
        
        GeometryReader { geo in
            let minY = geo.frame(in: .named("scroll")).minY
            let width = geo.size.width
            let height = baseHeight + max(minY, 0)

            CachedAsyncImage(url: cover.imageURL, urlCache: .imageCache) { image in
                image
                    .resizable()
                    .scaledToFill()
                    .frame(width: width, height: height)
                    .clipped()
                    .offset(y: -max(minY, 0))
            } placeholder: {
                imagePlaceholder
                    .frame(width: width, height: height)
                    .offset(y: -max(minY, 0))
            }
        }
        .frame(height: baseHeight)
    }
    
    @ViewBuilder
    func nameView() -> some View {
        HStack {
            Text(game.name)
                .font(.largeTitle)
                .bold()
                .frame(maxWidth: .infinity, alignment: .leading)
            
            if let rating = game.rating {
                Spacer()
                Text("\(String(format: "%.1f", rating / 10.0)) / 10 ⭐️")
                    .bold()
            }
        }
    }
    
    @ViewBuilder
    func summaryView(_ summary: String) -> some View {
        Button(action: {
            withAnimation {
                summaryExpanded.toggle()
            }
        }) {
            Text(summary)
              .font(.body)
              .frame(maxHeight: summaryExpanded ? .infinity : 100, alignment: .topLeading)
              .frame(maxWidth: .infinity, alignment: .leading)
              .layoutPriority(1)
        }
        .buttonStyle(.plain)
    }
    
    @ViewBuilder
    func carouselView(title: String, images: [ImageLoadable]) -> some View {
        VStack {
            Text(title)
                .frame(maxWidth: .infinity, alignment: .leading)
                .font(.title)
                .bold()
            
            ScrollView(.horizontal) {
                LazyHStack {
                    ForEach(images, id: \.imageId) { screenshot in
                        CachedAsyncImage(url: screenshot.imageURL, urlCache: .imageCache) { image in
                            image
                                .resizable()
                                .scaledToFit()
                                .cornerRadius(8)
                        } placeholder: {
                            imagePlaceholder
                        }
                        .frame(maxHeight: 200)
                    }
                }
                .scrollTargetLayout()
            }
            .scrollTargetBehavior(.paging)
            .scrollIndicators(.visible)
        }
        .navigationTitle(game.name)
        .navigationBarTitleDisplayMode(.inline)
    }
    
    var imagePlaceholder: some View {
        ZStack {
            Color.gray.opacity(0.3)
            if networkMonitor.isConnected {
                ProgressView()
            } else {
                Image(systemName: "network.slash")
                    .foregroundStyle(.white)
            }
        }
        .frame(width: 200, height: 200)
        .cornerRadius(8)
    }
}

#Preview {
    GameDetailScreen(game: Game(from: PreviewData.gameDetailGame))
}
