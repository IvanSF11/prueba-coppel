//
//  DetailEntity.swift
//  prueba-coppel
//
//  Created by Pedro Soriano on 28/09/22.
//

import Foundation


// MARK: - DetailTV
struct DetailTV: Codable {
    let adult: Bool
    let backdropPath: String?
    let createdBy: [CreatedBy]
    let episodeRunTime: [Int]
    let firstAirDate: Date
    let genres: [Genre]
    let homepage: String
    let id: Int
    let inProduction: Bool
    let languages: [String]
    let lastAirDate: String
    let lastEpisodeToAir: LastEpisodeToAir
    let name: String
    let networks: [Network]
    let numberOfEpisodes, numberOfSeasons: Int
    let originCountry: [String]
    let originalLanguage, originalName, overview: String
    let popularity: Double
    let posterPath: String?
    let productionCompanies: [Network]?
    let productionCountries: [ProductionCountry]?
    let seasons: [Season]?
    let spokenLanguages: [SpokenLanguage]?
    let status, tagline, type: String?
    let voteAverage: Double?
    let voteCount: Int
    
    public var posterURL: URL {
        return URL(string: "https://image.tmdb.org/t/p/w500\(posterPath ?? "")")!
    }
    
    public var backdropURL: URL {
        return URL(string: "https://image.tmdb.org/t/p/original\(backdropPath ?? "")")!
    }
    
    public var voteAveragePercentText: String {
        return "\(Int(voteAverage ?? 0.0 * 10))%"
    }
}

struct CreatedBy: Codable {
    let id: Int
    let creditID, name: String?
    let gender: Int
    let profilePath: String?
    
    public var posterURL: URL {
        return URL(string: "https://image.tmdb.org/t/p/w500\(profilePath ?? "")")!
    }
}

struct Genre: Codable {
    let id: Int?
    let name: String?
}

struct LastEpisodeToAir: Codable {
    let airDate: String?
    let episodeNumber, id: Int?
    let name, overview, productionCode: String?
    let seasonNumber, showID: Int?
    let stillPath: String?
    let voteAverage: Double?
    let voteCount: Int?
}

struct Network: Codable {
    let id: Int?
    let name, logoPath, originCountry: String?
}

struct Season: Codable {
    let airDate: String?
    let episodeCount, id: Int?
    let name, overview, posterPath: String?
    let seasonNumber: Int?
}

struct SpokenLanguage: Codable {
    let englishName, iso639_1, name: String?
}

struct ProductionCountry: Codable {
    let iso3166_1, name: String?
}

// MARK: - DetailMovie
struct DetailMovie: Codable {
    let adult: Bool
    let backdropPath: String?
//    let belongsToCollection: String?
    let budget: Int
    let genres: [Genre]
    let homepage: String
    let id: Int
    let imdbID, originalLanguage, originalTitle, overview: String?
    let popularity: Double
    let posterPath: String?
    let productionCompanies: [ProductionCompanyMovie]
    let productionCountries: [ProductionCountryMovie]
    let releaseDate: Date
    let revenue, runtime: Int
    let spokenLanguages: [SpokenLanguageMovie]
    let status, tagline, title: String
    let video: Bool
    let voteAverage: Double?
    let voteCount: Int
    
    public var posterURL: URL {
        return URL(string: "https://image.tmdb.org/t/p/w500\(posterPath ?? "")")!
    }
    
    public var backdropURL: URL {
        return URL(string: "https://image.tmdb.org/t/p/original\(backdropPath ?? "")")!
    }
    
    public var voteAveragePercentText: String {
        return "\(Int(voteAverage ?? 0.0 * 10))%"
    }
}

struct GenreMovie: Codable {
    let id: Int?
    let name: String?
}

struct ProductionCompanyMovie: Codable {
    let id: Int?
    let logoPath: String?
    let name, originCountry: String?
    
    public var posterURL: URL {
        return URL(string: "https://image.tmdb.org/t/p/w500\(logoPath ?? "")")!
    }
}

struct ProductionCountryMovie: Codable {
    let iso3166_1, name: String?
}

struct SpokenLanguageMovie: Codable {
    let iso639_1, name: String?
}

