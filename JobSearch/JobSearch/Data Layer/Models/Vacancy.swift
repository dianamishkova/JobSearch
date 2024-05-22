//
//  Vacancy.swift
//  EffectiveMobile
//
//  Created by Диана Мишкова on 16.03.24.
//

import Foundation

struct VacancyRootResult: Codable {
    let vacancies: [Vacancy]
    let offers: [Offer]
    
    enum CodingKeys: String, CodingKey {
        case vacancies
        case offers
    }
}

struct Vacancy: Codable, Identifiable {
    let id: String
    let lookingNumber: Int?
    let title: String?
    let address: Address
    let company: String?
    let experience: Experience
    let publishedDate: String?
    var isFavorite: Bool
    let salary: Salary
    let schedules: [String]?
    let appliedNumber: Int?
    let description: String?
    let responsibilities: String?
    let questions: [String]?
    
    enum CodingKeys: String, CodingKey {
        case id
        case lookingNumber
        case title
        case address
        case company
        case experience
        case publishedDate
        case isFavorite
        case salary
        case schedules
        case appliedNumber
        case description
        case responsibilities
        case questions
    }
}

struct Address: Codable {
    let town: String?
    let street: String?
    let house: String?
    
    enum CodingKeys: String, CodingKey {
        case town
        case street
        case house
    }
}

struct Experience: Codable {
    let previewText: String?
    let text: String?
    
    enum CodeingKeys: String, CodingKey {
        case previewText
        case text
    }
}

struct Salary: Codable {
    let full: String?
    let short: String?
    
    enum CodingKeys: String, CodingKey {
        case full
        case short
    }
}

struct Offer: Codable {
    struct Offer: Codable {
        let id: String
        let title: String
        let link: String
        let button: Button?
        
        struct Button: Codable {
            let text: String
        }
    }
}
