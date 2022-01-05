//
//  ContentView.swift
//  ParallelaxMovie
//
//  Created by Ierchenko Anna  on 12/20/21.
//

import SwiftUI

//adding model
struct  Movie: Identifiable {
    var id: String { title }
    let title: String
    let rating: Int
    let imgString: String
    var bgString: String?
    
    static let sampleMovies = [
        Movie(title: "How to train Dragon", rating: 4, imgString: "img1", bgString: "img1"),
        Movie(title: "Star War", rating: 2, imgString: "img2", bgString: "img2"),
        Movie(title: "Find Dori", rating: 5, imgString: "img3", bgString: "img3"),
        Movie(title: "Forsage", rating: 5, imgString: "img4", bgString: "img4"),
        Movie(title: "Code da Vinchi", rating: 5, imgString: "img5", bgString: "img5"),
        Movie(title: "King Arthur", rating: 5, imgString: "img6", bgString: "img6"),
        Movie(title: "Mickie&Mouse", rating: 5, imgString: "img7", bgString: "img7"),
        Movie(title: "Marvel", rating: 5, imgString: "img8", bgString: "img8"),
    ]
}

struct ContentView: View {
    
    let movies = Movie.sampleMovies
    
    //Tracking ScrollView Content OffsetX
    @State private var offsetX: CGFloat = 0
    @State private var maxOffsetX: CGFloat = -1
    
    var body: some View {
        GeometryReader { reader in
            let screenSize = reader.size
            ZStack {
                backgroundCarousel(screenSize: screenSize)
                
                moviesCarousel(reader: reader)
              
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
    }
    
    //adding background parallax effect
    func backgroundCarousel(screenSize: CGSize) -> some View {
        let bgWidth: CGFloat = screenSize.width * CGFloat(movies.count)
        let scrollPercentage = offsetX / maxOffsetX
        let clampedPercentage: CGFloat = 1 - max(0, min(scrollPercentage, 1))
        let posX: CGFloat = (bgWidth - screenSize.width) * clampedPercentage
        
       return HStack(spacing: 0) {
        ForEach(movies.reversed()) { movie in
                Image(movie.bgString ?? movie.imgString)
                    .resizable()
                    .scaledToFill()
                    .frame(width: screenSize.width)
                    .frame(maxHeight: .infinity)
                    .blur(radius: 1)
                    .scaleEffect(1.004)
                    .clipped()
                    .overlay(Color.black.opacity(0.45))
                    .ignoresSafeArea()
            }
        }
        .frame(width: bgWidth)
       .position(x: bgWidth / 2 - posX,
                 y: screenSize.height / 2)
    }
    
    func moviesCarousel(reader: GeometryProxy) -> some View {
        let screenSize = reader.size
        let itemWidth: CGFloat = screenSize.width * 0.8
        
        //centering scroll
        let paddingX: CGFloat = (screenSize.width - itemWidth) / 2
        
        let spacing: CGFloat = 10
        return ScrollView(.horizontal) {
            HStack(spacing: 0) {
                GeometryReader { geo -> Color in
                    DispatchQueue.main.async {
                        offsetX = (geo.frame(in: .global).minX - paddingX) * -1
                        let scrollContentWidth = itemWidth * CGFloat(movies.count) + spacing * CGFloat(movies.count - 1)
                        let maxOffsetX = scrollContentWidth + 2 * paddingX - screenSize.width
                        if self.maxOffsetX == -1 {
                            self.maxOffsetX = maxOffsetX
                        }
    //                    print(offsetX / maxOffsetX)
                    }
                    return Color.clear
                }
                .frame(width: 0)
                HStack(spacing: spacing) {
                    ForEach(movies) { movie in
                        MovieItem(movie: movie, screenSize: screenSize, width: itemWidth)
                    }
                }
            }
            .padding(.horizontal, paddingX)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
