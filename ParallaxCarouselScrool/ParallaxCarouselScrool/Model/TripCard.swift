//
//  TripCard.swift
//  ParallaxCarouselScrool
//
//  Created by Yunus Emre Berdibek on 26.09.2023.
//

import Foundation

struct TripCard: Identifiable, Hashable {
    var id: UUID = UUID()
    var title: String
    var subtitle: String
    var image: String
}

var tripCards: [TripCard] = [
        .init(title: "London", subtitle: "England", image: "london"),
        .init(title: "Moskow", subtitle: "Russia", image: "moskow"),
        .init(title: "Paris", subtitle: "France", image: "paris"),
]
