//
//  JobSearchApp.swift
//  JobSearch
//
//  Created by Диана Мишкова on 7.05.24.
//

import SwiftUI

@main
struct JobSearchApp: App {
    let vacanciesViewModel = VacanciesViewModel()
    
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                FirstLoginView()
                    .onAppear {
                        vacanciesViewModel.getVacancies()
                    }
                VacanciesTabView()
                    
            }
            
        }
        .environmentObject(vacanciesViewModel)
        
        WindowGroup {
            NavigationStack {
                MainView()
                VacanciesTabView()
                    
            }
        }
        .environmentObject(vacanciesViewModel)
    }
}
