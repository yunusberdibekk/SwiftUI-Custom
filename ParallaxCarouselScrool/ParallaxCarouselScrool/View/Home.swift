//
//  Home.swift
//  ParallaxCarouselScrool
//
//  Created by Yunus Emre Berdibek on 26.09.2023.
//

import SwiftUI

struct Home: View {
    @State var searchText = ""

    var body: some View {
        ScrollView(.vertical) {
            VStack(spacing: 15) {
                HStack (spacing: 12) {
                    Button {

                    } label: {
                        Image(systemName: "line.3.horizontal")
                            .font(.title)
                            .foregroundColor(.blue)
                    }

                    HStack(spacing: 12) {
                        Image(systemName: "magnifyingglass")
                        TextField("Search", text: $searchText)
                    }
                        .padding(.horizontal, 15)
                        .padding(.vertical, 10)
                        .background(.ultraThinMaterial)
                        .cornerRadius(10)
                }

                Text("Where do you want to travel?")
                    .font(.largeTitle.bold())
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.top, 10)

                //Parallax carousel
                GeometryReader { geometry in
                    let size = geometry.size

                    ScrollView (.horizontal) {
                        HStack(spacing: 10) {
                            ForEach(tripCards) { card in
                                ///In order to Move the Card in Reverse Direction (Parallax effect)
                                GeometryReader { proxy in
                                    let cardSize = proxy.size
                                    ///Simple parallax efect(1)
                                    //let minX = proxy.frame(in: .scrollView).minX - 30
                                    ///Efect 2. Burada image daha büyük gözükmektedir.
                                    let minX = min(((proxy.frame(in: .scrollView).minX - 30) * 1.4), size.width * 1.4)

                                    Image(card.image)
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                        .offset(x: -minX)
                                        .frame(width: proxy.size.width * 2.5) //efect 2
                                    .frame(width: cardSize.width, height: cardSize.height)
                                        .overlay {
                                        OverlayView(card)
                                    }
                                        .clipShape(.rect(cornerRadius: 15))
                                        .shadow(color: .black.opacity(0.25), radius: 8, x: 5, y: 10)
                                }
                                    .frame(width: size.width - 60, height: size.height - 50)
                                ///Scroll animation
                                .scrollTransition(.interactive, axis: .horizontal) { view, phase in
                                    view
                                        .scaleEffect(phase.isIdentity ? 1 : 0.95)
                                }
                            }
                        }
                            .padding(.horizontal, 30)
                            .scrollTargetLayout()
                            .frame(height: size.height, alignment: .top)
                    }
                        .scrollTargetBehavior(.viewAligned)
                        .scrollIndicators(.hidden)
                }
                    .frame(height: 500)
                    .padding(.horizontal, -15)
                    .padding(.top)
            }
                .padding(15)
        }
    }

    ///Overlay view
    @ViewBuilder
    func OverlayView(_ card: TripCard) -> some View {
        ZStack(alignment: .bottomLeading) {
            LinearGradient(colors: [
                    .clear,
                    .clear,
                    .clear,
                    .clear,
                    .clear,
                    .black.opacity(0.1),
                    .black.opacity(0.5),
                    .black
                ], startPoint: .top, endPoint: .bottom)

            VStack(alignment: .leading, spacing: 4) {
                Text(card.title)
                    .font(.title2)
                    .fontWeight(.black)
                    .foregroundStyle(.white)

                Text(card.subtitle)
                    .font(.callout)
                    .foregroundStyle(.white.opacity(0.8))
            }
                .padding(20)
        }
    }

}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
