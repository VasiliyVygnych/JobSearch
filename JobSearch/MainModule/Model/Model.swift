//
//  Model.swift
//  JobSearch
//
//  Created by Vasiliy Vygnych on 08.11.2023.
//

import Foundation

// MARK: - JobsData
struct JobsData: Codable {
    let perPage, page: Int
    let items: [Items?]

    enum CodingKeys: String, CodingKey {
        case perPage = "per_page"
        case page
        case items = "items"
    }
}
// MARK: Item - for a list of vacancies
struct Items: Codable {
    let id: String
    let name: String
//    let area: Area
    let salary: Salary?
    let address: Address?
    let publishedAt: String
    let createdAt: String
    let employer: Employer
    let snippet: Snippet
//    let professionalRoles: [Employment]
    let experience, employment: Employment

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
//        case area = "area"
        case salary = "salary" //"currency"
        case address = "street"
        case publishedAt = "published_at"
        case createdAt = "created_at"
        case employer = "employer"
        case snippet = "snippet"
//        case professionalRoles = "professional_roles"
        case experience = "experience"
        case employment = "employment"
    }
}
// MARK: ItemData - for a detailed screen
struct ItemData: Codable {
    let id: String
    let name: String
//    let area: Area
    let salary: Salary?
    let address: Address?
    let experience, schedule, employment: BillingType
    let contacts: Contacts?
    let description: String
    let keySkills: [KeySkill]
    let professionalRoles: [BillingType]
    let employer: Employer
    let publishedAt, createdAt: String

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
//        case area = "area"
        case salary = "salary"
        case address = "address"
        case experience
        case schedule
        case employment
        case description
        case contacts = "email"
        case keySkills = "key_skills"
        case professionalRoles = "professional_roles"
        case employer = "employer"
        case publishedAt = "published_at"
        case createdAt = "created_at"
    }
}
// MARK: - Address
struct Address: Codable {
    let city, street: String
    let raw: String
    let metro: Metro?
    let metroStations: [Metro]

    enum CodingKeys: String, CodingKey {
        case city = "city"
        case street = "street"
        case raw, metro
        case metroStations = "metro_stations"
    }
}
// MARK: - Metro
struct Metro: Codable {
    let stationName, lineName, stationID, lineID: String

    enum CodingKeys: String, CodingKey {
        case stationName = "station_name"
        case lineName = "line_name"
        case stationID = "station_id"
        case lineID = "line_id"
    }
}
// MARK: - Area
struct Area: Codable {
    let id, name: String
}

// MARK: - Employer
struct Employer: Codable {
    let id, name: String
    let logoUrls: LogoUrls?

    enum CodingKeys: String, CodingKey {
        case id, name
        case logoUrls = "logo_urls"
    }
}
// MARK: - LogoUrls
struct LogoUrls: Codable {
    let the90, the240: String
    let original: String

    enum CodingKeys: String, CodingKey {
        case the90 = "90"
        case the240 = "240"
        case original
    }
}
// MARK: - Employment
struct Employment: Codable {
    let id, name: String
}
// MARK: - Salary
struct Salary: Codable {
    let from: Int?
    let to: Int?
    let currency: Currency?
    
    enum CodingKeys: String, CodingKey {
        case from = "from"
        case to = "to"
        case currency = "currency"
    }
}
enum Currency: String, Codable {
    case byr = "BYR"
    case rur = "RUR"
    case usd = "USD"
    case kzt = "KZT"
    case eur = "EUR"
    case kgs = "KGS"
}
// MARK: - Snippet
struct Snippet: Codable {
    let requirement: String
    let responsibility: String?
    
    enum CodingKeys: String, CodingKey {
        case requirement //= "requirement"
        case responsibility = "responsibility"
    }
}
// MARK: - BillingType
struct BillingType: Codable {
    let id, name: String
}
// MARK: - Contacts
struct Contacts: Codable {
    let name, email: String
    let phones: [Phone]
    
    enum CodingKeys: String, CodingKey {
        case name = "name"
        case email = "email"
        case phones
    }
}
// MARK: - Phone
struct Phone: Codable {
    let comment: String
    let city, number, country, formatted: String
}
// MARK: - KeySkill
struct KeySkill: Codable {
    let name: String
}
