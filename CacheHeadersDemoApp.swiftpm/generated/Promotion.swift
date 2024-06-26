//
// Promotion.swift
//
// Generated by openapi-generator
// https://openapi-generator.tech
//

import Foundation
#if canImport(AnyCodable)
import AnyCodable
#endif

public struct Promotion: Codable, JSONEncodable, Hashable {

    public var id: Int64?
    public var type: String?
    public var title: String?
    public var fullText: String?
    public var discount: Double?
    public var imageUrl: String?
    public var startDate: Date?
    public var endDate: Date?
    public var code: String?

    public init(id: Int64? = nil, type: String? = nil, title: String? = nil, fullText: String? = nil, discount: Double? = nil, imageUrl: String? = nil, startDate: Date? = nil, endDate: Date? = nil, code: String? = nil) {
        self.id = id
        self.type = type
        self.title = title
        self.fullText = fullText
        self.discount = discount
        self.imageUrl = imageUrl
        self.startDate = startDate
        self.endDate = endDate
        self.code = code
    }

    public enum CodingKeys: String, CodingKey, CaseIterable {
        case id
        case type
        case title
        case fullText
        case discount
        case imageUrl
        case startDate
        case endDate
        case code
    }

    // Encodable protocol methods

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(id, forKey: .id)
        try container.encodeIfPresent(type, forKey: .type)
        try container.encodeIfPresent(title, forKey: .title)
        try container.encodeIfPresent(fullText, forKey: .fullText)
        try container.encodeIfPresent(discount, forKey: .discount)
        try container.encodeIfPresent(imageUrl, forKey: .imageUrl)
        try container.encodeIfPresent(startDate, forKey: .startDate)
        try container.encodeIfPresent(endDate, forKey: .endDate)
        try container.encodeIfPresent(code, forKey: .code)
    }
}

