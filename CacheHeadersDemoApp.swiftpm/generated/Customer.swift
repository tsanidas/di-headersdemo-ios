//
// Customer.swift
//
// Generated by openapi-generator
// https://openapi-generator.tech
//

import Foundation
#if canImport(AnyCodable)
import AnyCodable
#endif

public struct Customer: Codable, JSONEncodable, Hashable {

    public var id: Int64?
    public var name: String?
    public var email: String?
    public var phone: String?
    public var address: String?
    public var city: String?
    public var state: String?
    public var zip: String?
    public var country: String?

    public init(id: Int64? = nil, name: String? = nil, email: String? = nil, phone: String? = nil, address: String? = nil, city: String? = nil, state: String? = nil, zip: String? = nil, country: String? = nil) {
        self.id = id
        self.name = name
        self.email = email
        self.phone = phone
        self.address = address
        self.city = city
        self.state = state
        self.zip = zip
        self.country = country
    }

    public enum CodingKeys: String, CodingKey, CaseIterable {
        case id
        case name
        case email
        case phone
        case address
        case city
        case state
        case zip
        case country
    }

    // Encodable protocol methods

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(id, forKey: .id)
        try container.encodeIfPresent(name, forKey: .name)
        try container.encodeIfPresent(email, forKey: .email)
        try container.encodeIfPresent(phone, forKey: .phone)
        try container.encodeIfPresent(address, forKey: .address)
        try container.encodeIfPresent(city, forKey: .city)
        try container.encodeIfPresent(state, forKey: .state)
        try container.encodeIfPresent(zip, forKey: .zip)
        try container.encodeIfPresent(country, forKey: .country)
    }
}
