//
//  VacancyDetailsView.swift
//  EffectiveMobile
//
//  Created by Диана Мишкова on 17.03.24.
//

import SwiftUI
import MapKit

struct VacancyDetailsView: View {
    @State var vacancy: Vacancy
    @State var letter = ""
    @EnvironmentObject var viewModel: VacanciesViewModel
    @State private var isPressed = false
    
    var body: some View {
        TabView  {
            VStack {
                ScrollView {
                    VStack(alignment: .leading){
                        HStack(spacing: 15) {
                            Button {
                                isPressed = true
                            } label: {
                                Label("", systemImage: "arrow.left")
                                    .foregroundColor(.white)
                            }
                            .navigationDestination(isPresented: $isPressed) {
                                VacanciesTabView()
                            }
                            
                            Spacer()
                            Image(systemName: "eye")
                                .resizable()
                                .frame(width: 27, height: 17)
                                .foregroundColor(.white)
                            Image("Share")
                                .resizable()
                                .frame(width: 24, height: 27)
                                .padding(.top, 5)
                            Button {
                                vacancy.isFavorite.toggle()
                                viewModel.vacancyId = vacancy.id
                                viewModel.updateFavorite()
                                
                            } label: {
                                Label("", systemImage:  viewModel.getIsFavorite(for: vacancy.id) ? "heart.fill" : "heart")
                                    .imageScale(.large)
                                    .foregroundStyle(viewModel.getIsFavorite(for: vacancy.id) ? Color.blue : Color.gray)
                            }
                        }
                        
                        
                        Text(vacancy.title ?? "")
                            .font(.title2)
                            .bold()
                            .padding(.vertical, 15)
                            
                        Text(vacancy.salary.full ?? "")
                            .padding(.bottom, 15)
                        Text("Требуемый опыт: " + (vacancy.experience.text ?? ""))
                        if let schedules = vacancy.schedules {
                            Text(viewModel.arrayToString(schedules))
                                .padding(.bottom, 10)
                        }
                            
                        HStack {
                            if let applied = vacancy.appliedNumber, applied > 0 {
                                HStack {
                                    Text(viewModel.peoplePluralForm(applied) + " уже откликнулись")
                                        .frame(maxWidth: 140)
                                    
                                    Image("Person")
                                        .padding(.bottom, 20)
                                    
                                }
                                .padding(7)
                                .background(
                                    RoundedRectangle(cornerRadius: 10)
                                        .fill(Color.green)
                                        .opacity(0.4))
                            }
                            if let looking = vacancy.lookingNumber, looking > 0 {
                                HStack {
                                    Text(viewModel.peoplePluralForm(looking) + " сейчас смотрят")
                                        .frame(maxWidth: 140)
                                    Image("Eye")
                                        .padding(.bottom, 20)
                                }
                                .padding(7)
                                .background(
                                    RoundedRectangle(cornerRadius: 10)
                                        .fill(Color.green)
                                        .opacity(0.4))
                            }
                        }
                        .padding(.vertical, 10)
                        
                        MapView(vacancy: vacancy)
                            .frame(minHeight: 150)
                            .padding(.bottom, 5)
                        
                        if let description = vacancy.description {
                            Text(description)
                        }
                        
                        Text("Ваши задачи")
                            .font(.title2)
                            .bold()
                            .padding(.vertical, 3)
                            
                        
                        Text(vacancy.responsibilities ?? "")
                        Spacer(minLength: 30)
                        Text("Задайте вопрос работодателю")
                            .padding(.vertical, 5)
                        Text("Он получит его с откликом на вакансию")
                            .foregroundStyle(.gray)
                            .padding(.bottom, 10)
                            
                        ForEach(vacancy.questions ?? [], id: \.self) { question in
                            HStack {
                                Text(question)
                                    .font(.callout)
                            }
                            .padding(10)
                            .background(
                                RoundedRectangle(cornerRadius: 20)
                                    .fill(Color.gray)
                                    .opacity(0.4))
                        }
                    }
                    .padding()
                  
                }
                
                Button {
                } label: {
                    Text("Откликнуться")
                        .padding(6)
                        .frame(maxWidth: .infinity)
                }
              
                .buttonStyle(.borderedProminent)
                .tint(.green)
                .padding(.horizontal, 15)
                .padding(.bottom, 10)
            }
            .tabItem {  Label("Поиск", systemImage: "magnifyingglass") }
            
            FavoriteView()
                .tabItem { Label("Избранное", systemImage: "heart") }
            VStack {}
                .tabItem { Label("Отклики", systemImage: "envelope") }
            VStack {}
                .tabItem { Label("Сообщения", systemImage: "message") }
            VStack {}
                .tabItem { Label("Профиль", systemImage: "person") }
        }
        .navigationBarBackButtonHidden()
    }
}

#Preview {
    VacancyDetailsView(vacancy: Vacancy(id: "cbf0c984-7c6c-4ada-82da-e29dc698bb50", lookingNumber: 2, title: "UI/UX дизайнер", address: Address(town: "Минск", street: "улица Бирюзова", house: "4/5"), company: "Мобирикс", experience: Experience(previewText: "Опыт от 1 до 3 лет", text: "1–3 года"), publishedDate: "2024-02-20", isFavorite: false, salary: Salary(full: "Уровень дохода не указан", short: nil), schedules: ["полная занятость", "полный день"], appliedNumber: 147, description: "Мы ищем специалиста на позицию UX/UI Designer, который вместе с коллегами будет заниматься проектированием пользовательских интерфейсов внутренних и внешних продуктов компании.", responsibilities: "- проектирование пользовательских сценариев и создание прототипов;\n- разработка интерфейсов для продуктов компании (Web+App);\n- работа над созданием и улучшением Дизайн-системы;\n- взаимодействие с командами frontend-разработки;\n- контроль качества внедрения дизайна;\n- ситуативно: создание презентаций и других материалов на основе фирменного стиля компании", questions: ["Где располагается место работы?", "Какой график работы?", "Вакансия открыта?", "Какая оплата труда?"]))
        .environmentObject(VacanciesViewModel())
}
