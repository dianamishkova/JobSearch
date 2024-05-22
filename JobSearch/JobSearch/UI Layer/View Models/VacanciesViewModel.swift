//
//  VacanciesViewModel.swift
//  EffectiveMobile
//
//  Created by Диана Мишкова on 13.03.24.
//

import Foundation
import Combine

class VacanciesViewModel: ObservableObject {
    private var persistentController = VacancyPersistentController()
    
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var isEmaiValid: Bool = false
    
    @Published var validCode: Bool = false
    @Published var code = Array(repeating: "", count: 4)
        
    @Published var isFavorite: Bool = false
    @Published var vacancyId: String = ""

    @Published private(set) var error: DataError? = nil
    @Published var vacancies: [Vacancy] = []
    
    
    private var cancellables = Set<AnyCancellable>()
    
    private let apiService: VacancyAPILogic

    init(apiService: VacancyAPILogic = VacanciesAPI(),
         persistentController: VacancyPersistentController = VacancyPersistentController()) {
        self.apiService = apiService
        self.persistentController = persistentController
        $email
            .receive(on: DispatchQueue.main)
            .map { [weak self] email in
                self?.isValidEmail(email) ?? false
            }
            .assign(to: \.isEmaiValid, on: self)
            .store(in: &cancellables)
        
        $password
            .receive(on: DispatchQueue.main)
            .sink { _ in }
            .store(in: &cancellables)
        
        $vacancyId
            .receive(on: DispatchQueue.main)
            .sink { _ in }
            .store(in: &cancellables)
        
        $code
            .receive(on: DispatchQueue.main)
            .map { [weak self] code in
                self?.isCodeValid(code) ?? false
            }
            .assign(to: \.validCode, on: self)
            .store(in: &cancellables)
    }
    
    func getVacancies() {
        apiService.getVacancies { [weak self] result in
            switch result {
            case .success(let vacancies) :
                self?.vacancies = vacancies ?? []
                self?.persistentController.updateAndAddServerDataToCoreData(vacanciesFromBack: vacancies)
            
            case .failure(let error):
                self?.error = error
            }
        }
    }
    
    
    
    func updateFavorite() {
        self.persistentController.updateFavorite(vacancyID: vacancyId)
    }
    
    func getIsFavorite(for id: String) -> Bool {
        self.persistentController.fetchIsFavoriteFromCoreData(vacancyID: id) ?? false
    }


    func favoriteIDs() -> [String] {
        self.persistentController.getFavoriteIds()
    }
    
    func favoriteVacancies() -> [Vacancy] {
        let favoriteIds = favoriteIDs()
        
        let favoriteVacancies = vacancies.filter { vacancy in
            favoriteIds.contains(vacancy.id)
        }
        
        return favoriteVacancies
    }
    
    func dateFormatter(_ date: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        guard let date = formatter.date(from: date) else {
            return "Дата недоступна"
        }

        let russianFormatter = DateFormatter()
        russianFormatter.locale = Locale(identifier: "ru_RU")
        russianFormatter.dateFormat = "d MMMM"
        let formattedDate = russianFormatter.string(from: date)
        return formattedDate
    }
    
    func peoplePluralForm(_ count: Int) -> String {
        let cases: [String] = ["человек", "человека"]
        var index = 0
        let mod10 = count % 10
        let mod100 = count % 100
        if mod10 >= 2 && mod10 <= 4 && !(mod100 >= 12 && mod100 <= 14) {
            index = 1
        }
        return "\(count) \(cases[index])"
    }
    
    
    func arrayToString(_ arr: [String]) -> String {
        return arr.joined(separator: ", ")
    }
    
    private func isValidEmail(_ email: String) -> Bool {
        let emailRegex = "[0-9a-z._%+-]+@[a-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailPredicate.evaluate(with: email)
    }
    
    private func isCodeValid(_ code: [String]) -> Bool {
        for sym in code {
            if sym == "" {
                return false
            }
        }
        return true
    }
    
    func vacancyPluralForm(_ count: Int) -> String {
        let cases: [String] = ["вакансия", "вакансии", "вакансий"]
        var index = 2
        if count % 10 == 1 && count % 100 != 11 {
            index = 0
        } else if count % 10 >= 2 && count % 10 <= 4 && !(count % 100 >= 12 && count % 100 <= 14) {
            index = 1
        }
        return "\(count) \(cases[index])"
    }
}
