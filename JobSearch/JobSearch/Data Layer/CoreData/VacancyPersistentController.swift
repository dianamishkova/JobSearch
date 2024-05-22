//
//  VacancyPersistentController.swift
//  EffectiveMobile
//
//  Created by Диана Мишкова on 18.03.24.
//


import Foundation
import CoreData


class VacancyPersistentController: ObservableObject {
    var persistentContainer = NSPersistentContainer(name: "Vacancies")
    private var vacanciesFetchRequest = IsFavoriteCD.fetchRequest()
    
    init() {
        persistentContainer.loadPersistentStores { storeDescription, error in
            if let error = error {
                print("error: \(error)")
            }
        }
    }    
    
    func updateAndAddServerDataToCoreData(vacanciesFromBack: [Vacancy]?) {
        var vacanciesIdDict: [String: Vacancy] = [:]
        var vacanciesIdList: [String] = []
        
        guard let vacancies = vacanciesFromBack, !vacancies.isEmpty else {
            return
        }
        
        for vacancy in vacancies {
            vacanciesIdDict[vacancy.id] = vacancy
        }
        vacanciesIdList = vacancies.map { $0.id }
        
        vacanciesFetchRequest.predicate = NSPredicate(format: "id IN %@", vacanciesIdList)
        let managedObjectContext = persistentContainer.viewContext
        let vacanciesCD = try? managedObjectContext.fetch(vacanciesFetchRequest)
        
        guard let vacanciesCD = vacanciesCD else {
            return
        }
        
        for vacancyCD in vacanciesCD {
            managedObjectContext.delete(vacancyCD)
        }
        
        for vacancy in vacancies {
            let vacancyCD = IsFavoriteCD(context: managedObjectContext)
            vacancyCD.id = vacancy.id
            vacancyCD.isFavorite = vacancy.isFavorite
            
        }
        try? managedObjectContext.save()
    }
    
    func updateFavorite(vacancyID: String) {
        vacanciesFetchRequest.predicate = NSPredicate(format: "id == %@", vacancyID)
        let managedObjectContext = persistentContainer.viewContext
        let vacancies = try? managedObjectContext.fetch(vacanciesFetchRequest)
        
        let favoriteObject = vacancies?.first
        favoriteObject?.isFavorite.toggle()
        
        try? managedObjectContext.save()
    }
    
    func fetchIsFavoriteFromCoreData(vacancyID: String) -> Bool? {
        vacanciesFetchRequest.predicate = NSPredicate(format: "id == %@", vacancyID)
        let managedObjectContext = persistentContainer.viewContext
        let vacancies = try? managedObjectContext.fetch(vacanciesFetchRequest)
        
        let favoriteObject = vacancies?.first
        
        return favoriteObject?.isFavorite
    }
    
    func getFavoriteIds() -> [String] {
        vacanciesFetchRequest.predicate = NSPredicate(format: "isFavorite == true")
        let managedObjectContext = persistentContainer.viewContext
        let ids = try? managedObjectContext.fetch(vacanciesFetchRequest)
        
        let favoriteIds = ids?.compactMap { $0.id }
        
        return favoriteIds ?? []
    }
}
