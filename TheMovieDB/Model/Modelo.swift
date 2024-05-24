

//
//  MoviesModel.swift
//  MovieApp
//
//  Created by Daniela Ciciliano on 22/05/24.
//

import Foundation
// MARK: - MovieTitles
struct MovieModel: Codable, Hashable {
    let page: Int?
    let next: String?
    let entries: Int?
    let results: [Movies]?
    
}

// MARK: - Result
struct Movies: Codable, Hashable, Identifiable {
    let id, resultID: String
    let primaryImage: PrimaryImage?
    let titleType: TitleType
    let titleText, originalTitleText: TitleText
    let releaseYear: ReleaseYear
    let releaseDate: ReleaseDate
    let genres: [String]?

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case resultID = "id"
        case primaryImage, titleType, titleText, originalTitleText, releaseYear, releaseDate, genres
    }
}

// MARK: - TitleText
struct TitleText: Codable, Hashable {
    let text1: String?
    let typename: OriginalTitleTextTypename

    enum CodingKeys: String, CodingKey {
        case text1
        case typename = "__typename"
    }
}

enum OriginalTitleTextTypename: String, Codable {
    case titleText = "TitleText"
}

// MARK: - PrimaryImage
struct PrimaryImage: Codable, Hashable {
    let id: String
    let width, height: Int
    let url: String
    let caption: Caption
    let typename: String

    enum CodingKeys: String, CodingKey {
        case id, width, height, url, caption
        case typename = "__typename"
    }
}

// MARK: - Caption
struct Caption: Codable,Hashable {
    let plainText: String
    let typename: CaptionTypename

    enum CodingKeys: String, CodingKey {
        case plainText
        case typename = "__typename"
    }
}

enum CaptionTypename: String, Codable {
    case markdown = "Markdown"
}

// MARK: - ReleaseDate
struct ReleaseDate: Codable, Hashable {
    let day, month, year: Int
    let typename: ReleaseDateTypename

    enum CodingKeys: String, CodingKey {
        case day, month, year
        case typename = "__typename"
    }
}

enum ReleaseDateTypename: String, Codable {
    case releaseDate = "ReleaseDate"
}

// MARK: - ReleaseYear
struct ReleaseYear: Codable, Hashable {
    let year: Int
    let endYear: String?
    let typename: ReleaseYearTypename

    enum CodingKeys: String, CodingKey {
        case year, endYear
        case typename = "__typename"
    }
}

enum ReleaseYearTypename: String, Codable {
    case yearRange = "YearRange"
}

// MARK: - TitleType
struct TitleType: Codable, Hashable {
    let displayableProperty: DisplayableProperty?
    let text: Text2
    let id: ID
    let isSeries, isEpisode: Bool
    let categories: [Category]?
    let canHaveEpisodes: Bool?
    let typename: TitleTypeTypename

    enum CodingKeys: String, CodingKey {
        case displayableProperty, text, id, isSeries, isEpisode, categories, canHaveEpisodes
        case typename = "__typename"
    }
}

// MARK: - Category
struct Category: Codable, Hashable {
    let value, typename: String

    enum CodingKeys: String, CodingKey {
        case value
        case typename = "__typename"
    }
}

// MARK: - DisplayableProperty
struct DisplayableProperty: Codable, Hashable {
    let value: Caption
    let typename: String

    enum CodingKeys: String, CodingKey {
        case value
        case typename = "__typename"
    }
}

enum ID: String, Codable {
    case movie = "movie"
    case short = "short"
    case tvSeries = "tvSeries"
}

enum Text2: String, Codable {
    case movie = "Movie"
    case short = "Short"
    case tvSeries = "TV Series"
}

enum TitleTypeTypename: String, Codable {
    case titleType = "TitleType"
}
