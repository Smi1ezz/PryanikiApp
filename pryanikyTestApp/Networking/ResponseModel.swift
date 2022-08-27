//
//  ResponseModel.swift
//  pryanikyTestApp
//
//  Created by admin on 18.07.2022.
//

import Foundation
import SwiftUI

protocol TextResponse {
    var text: String? {get set}
}

protocol PictureResponse {
    var text: String? {get}
    var url: String? {get}
}

protocol VariantsResponse {
    var selectedID: Int? {get set}
    var variants: [Variant]? {get set}
}

protocol VideoResponse {
    var text: String? {get}
    var url: String? {get}
    var coverUrl: String? {get}
    var mediaUrl: String? {get}
}

protocol AudioResponse {
    var text: String? {get}
    var coverUrl: String? {get}
    var mediaUrl: String? {get}
}

// MARK: - RecivedData
struct RecivedData: Codable {
    let data: [CellType]
    let view: [String]
}

// MARK: - CellType
struct CellType: Codable {
    let name: String
    let data: Content
}

// MARK: - Content
struct Content: Codable, TextResponse, PictureResponse, VariantsResponse, VideoResponse, AudioResponse {
    var text: String?
    var url: String?
    var selectedID: Int?
    var variants: [Variant]?
    var coverUrl: String?
    var mediaUrl: String?

    enum CodingKeys: String, CodingKey {
        case text
        case url
        case selectedID = "selectedId"
        case variants
        case coverUrl
        case mediaUrl
    }
}

// MARK: - Variant
struct Variant: Codable {
    let id: Int
    let text: String
}
