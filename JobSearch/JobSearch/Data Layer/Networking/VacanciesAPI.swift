//
//  VacanciesAPI.swift
//  EffectiveMobile
//
//  Created by Диана Мишкова on 16.03.24.
//

import Alamofire
import Foundation

typealias VacanciesAPIResponse = (Swift.Result<[Vacancy]?, DataError>) -> Void

protocol VacancyAPILogic {
    func getVacancies(completion: @escaping (VacanciesAPIResponse))
}

class VacanciesAPI: VacancyAPILogic {
    private struct Constants {
        static let vacanciesListURL = "https://run.mocky.io/v3/ed41d10e-0c1f-4439-94fa-9702c9d95c14"
    }
    
    func getVacancies(completion: @escaping (VacanciesAPIResponse)) {
        URLCache.shared.removeAllCachedResponses()
        AF.request(Constants.vacanciesListURL)
            .validate()
            .responseDecodable(of: VacancyRootResult.self) { response in
                switch response.result {
                case .failure(let error):
                    completion(.failure(.networkingError(error.localizedDescription)))
                case .success(let vacancies):
                    completion(.success(vacancies.vacancies))
                }
            }
    }
}

