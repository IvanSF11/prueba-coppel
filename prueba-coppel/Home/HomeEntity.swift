//
//  HomeEntity.swift
//  prueba-coppel
//
//  Created by Pedro Soriano on 27/09/22.
//

import Foundation
import UIKit

enum typeMovies: String {
    case popular = "popular"
    case topRated = "top_rated"
}

enum typeTV: String {
    case onTv = "on_the_air"
    case airingToday = "airing_today"
}

public enum LayoutConstant {
    static let spacing: CGFloat = 16.0
    static let itemHeight: CGFloat = 350.0
}

public struct MoviesResponse: Codable {
    let page: Int
    let totalResults: Int
    let totalPages: Int
    let results: [Movie]
}

public struct Movie: Codable {
    
    let id: Int
    let title: String
    let backdropPath: String?
    let posterPath: String?
    let overview: String
    let releaseDate: Date
    let voteAverage: Double
    let voteCount: Int
    let adult: Bool
    
    public var posterURL: URL {
        return URL(string: "https://image.tmdb.org/t/p/w500\(posterPath ?? "")")!
    }
    
    public var backdropURL: URL {
        return URL(string: "https://image.tmdb.org/t/p/original\(backdropPath ?? "")")!
    }
    
    public var voteAveragePercentText: String {
        return "\(Int(voteAverage * 10))%"
    }
    
}


public struct TVResponse: Codable {
    let page: Int?
    let results: [TV]?
    let totalPages: Int?
    let totalResults: Int?
}

public struct TV: Codable {
    let backdropPath: String?
    let firstAirDate: Date
    let genre_ids: [Int]?
    let id: Int
    let name: String?
    let original_language: String?
    let original_name: String?
    let origin_country: [String]?
    let overview: String?
    let popularity: Double?
    let posterPath: String?
    let voteAverage: Double
    let voteCount: Int?
    
    public var posterURL: URL {
        return URL(string: "https://image.tmdb.org/t/p/w500\(posterPath ?? "")")!
    }
    
    public var backdropURL: URL {
        return URL(string: "https://image.tmdb.org/t/p/original\(backdropPath ?? "")")!
    }
    
    public var voteAveragePercentText: String {
        return "\(Int(voteAverage * 10))%"
    }
}
