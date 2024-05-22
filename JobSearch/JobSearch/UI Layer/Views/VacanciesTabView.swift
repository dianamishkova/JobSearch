//
//  VacanciesTabView.swift
//  EffectiveMobile
//
//  Created by Диана Мишкова on 15.03.24.
//

import SwiftUI

struct VacanciesTabView: View {
    
    @EnvironmentObject var viewModel: VacanciesViewModel
    var body: some View {
        TabView {
            VStack {
                if viewModel.validCode {
                    MainView()
                } 
            }
            .tabItem {  Label("Поиск", systemImage: "magnifyingglass") }
            
            VStack {
                if viewModel.validCode {
                    FavoriteView()
                }
            }
            
            .tabItem { Label("Избранное", systemImage: "suit.heart") }
            VStack {
                
            }
            .tabItem { Label("Отклики", systemImage: "envelope") }
            VStack {
                
            }
            .tabItem { Label("Сообщения", systemImage: "message") }
            
            VStack {
                
            }
            .tabItem { Label("Профиль", systemImage: "person") }
        }
        .opacity(1)
        .navigationBarBackButtonHidden()
        
    }
    
}


#Preview {
    VacanciesTabView()
        .environmentObject(VacanciesViewModel())
}

