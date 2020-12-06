//
//  Сharacters.swift
//  MarvelProject
//
//  Created by Aleksandr Milashevski on 04/12/20.
//

import Foundation

// MARK: - CharacterDataWrapper
struct CharacterDataWrapper: Codable {
    var code: Int?
    var status, copyright, attributionText, attributionHTML: String?
    var etag: String?
    var data: CharacterDataContainer?
}

// MARK: - CharacterDataContainer
struct CharacterDataContainer: Codable {
    var offset, limit, total, count: Int?
    var results: [Character]?
}

// MARK: - Character
struct Character: Codable {
    var id: Int?
    var name, description: String?
    var modified: String?
    var thumbnail: Image?
    var resourceURI: String?
    var comics: ComicList?
    var series: SeriesList?
    var stories: StoryList?
    var events: EventList?
    var urls: [Url]?
    
    enum CodingKeys: String, CodingKey {
        case id, name
        case description = "description"
        case modified, thumbnail, resourceURI, comics, series, stories, events, urls
    }
}

// MARK: - Image
struct Image: Codable {
    var path: String?
    var thumbnailExtension: String?
    
    enum CodingKeys: String, CodingKey {
        case path
        case thumbnailExtension = "extension"
    }
}

// MARK: - ComicList
struct ComicList: Codable {
    var available: Int?
    var collectionURI: String?
    var items: [ComicSummary]?
    var returned: Int?
}

// MARK: - ComicSummary
struct ComicSummary: Codable {
    var resourceURI: String?
    var name: String?
}

// MARK: - SeriesList
struct SeriesList: Codable {
    var available: Int?
    var collectionURI: String?
    var items: [SeriesSummary]?
    var returned: Int?
}

// MARK: - SeriesSummary
struct SeriesSummary: Codable {
    var resourceURI: String?
    var name: String?
}

// MARK: - StoryList
struct StoryList: Codable {
    var available: Int?
    var returned: Int?
    var collectionURI: String?
    var items: [StorySummary]?
}

// MARK: - StorySummary
struct StorySummary: Codable {
    var resourceURI: String?
    var name: String?
    var type: String?
}

// MARK: - EventList
struct EventList: Codable {
    var available: Int?
    var collectionURI: String?
    var items: [EventSummary]?
    var returned: Int?
}

// MARK: - EventSummary
struct EventSummary: Codable {
    var resourceURI: String?
    var name: String?
}

// MARK: - Url
struct Url: Codable {
    var type: String?
    var url: String?
}
