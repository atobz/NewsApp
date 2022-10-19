
import Foundation

struct News: Codable {
    let status: String
    let totalResults: Int
    let articles: [Article]
}

struct Article: Codable {
    let source: Source
    let author: String?
    let title: String
    let url: String
    let urlToImage: String?
    let content: String
}

struct Source: Codable {
    let id: String?
    let name: String
}
