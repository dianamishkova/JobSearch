//
//  VacancyBoxView.swift
//  EffectiveMobile
//
//  Created by Диана Мишкова on 16.03.24.
//

import SwiftUI


struct VacancyBoxView: View {
    @State var vacancy: Vacancy
    @State var isFavorite: Bool = false
    @EnvironmentObject var viewModel: VacanciesViewModel
    var body: some View {
        GroupBox {
            VStack(alignment: .leading) {
                if let lookingNumber = vacancy.lookingNumber {
                    HStack {
                        
                        Text("Сейчас просматривает " + viewModel.peoplePluralForm(lookingNumber))
                            .foregroundStyle(.green)
                        
                        Spacer()
                        
                        Button {
                            vacancy.isFavorite.toggle()
                            viewModel.vacancyId = vacancy.id
                            viewModel.updateFavorite()
                        } label: {
                            Label("", systemImage:  viewModel.getIsFavorite(for: vacancy.id) ? "heart.fill" : "heart")
                                .imageScale(.large)
                                .foregroundStyle(viewModel.getIsFavorite(for: vacancy.id) ? Color.blue : Color.gray)
                        }
                        .padding(.bottom, 2)
                    }
                }
                HStack {
                    Text(vacancy.title ?? "")
                        .font(.title3)
                        .bold()
                        .multilineTextAlignment(.leading)
                        .padding([.bottom], 2)
                    Spacer()
                    if vacancy.lookingNumber == nil {
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
                }
                if ((vacancy.salary.short?.isEmpty) != nil) {
                    Text(vacancy.salary.short ?? "")
                        .font(.title2)
                        .bold()
                        .padding(.bottom, 2)
                }
                Text(vacancy.address.town ?? "")
                HStack {
                    Text(vacancy.company ?? "")
                    Image(systemName: "checkmark.circle")
                        .resizable()
                        .frame(width: 16, height: 16)
                        .foregroundColor(.gray)
                }
                HStack {
                    Image(systemName: "suitcase")
                        .resizable()
                        .frame(width: 16, height: 16)
                    Text(vacancy.experience.previewText ?? "")
                }
                Text("Опубликовано " + viewModel.dateFormatter(vacancy.publishedDate ?? ""))
                    .foregroundStyle(.gray)
                
                Button {        
                    
                } label: {
                    Text("Откликнуться")
                        .frame(maxWidth: .infinity)
                        .padding(4)
                        .foregroundColor(.white)
                }
                
                .buttonStyle(.borderedProminent)
                .buttonBorderShape(.capsule)
                .tint(.green)
            }
            .frame(minWidth: 328, minHeight: 200)
        }
        .padding(.horizontal, 10.0)
    }
}


#Preview {
    VacancyBoxView(vacancy: Vacancy(id: "cbf0c984-7c6c-4ada-82da-e29dc698bb50", lookingNumber: 2, title: "UI/UX дизайнер", address: Address(town: "Минск", street: "улица Бирюзова", house: "4/5"), company: "Мобирикс", experience: Experience(previewText: "Опыт от 1 до 3 лет", text: "1–3 года"), publishedDate: "2024-02-20", isFavorite: false, salary: Salary(full: "Уровень дохода не указан", short: nil), schedules: ["полная занятость", "полный день"], appliedNumber: 147, description: "Мы ищем специалиста на позицию UX/UI Designer, который вместе с коллегами будет заниматься проектированием пользовательских интерфейсов внутренних и внешних продуктов компании.", responsibilities: "- проектирование пользовательских сценариев и создание прототипов;\n- разработка интерфейсов для продуктов компании (Web+App);\n- работа над созданием и улучшением Дизайн-системы;\n- взаимодействие с командами frontend-разработки;\n- контроль качества внедрения дизайна;\n- ситуативно: создание презентаций и других материалов на основе фирменного стиля компании", questions: ["Где располагается место работы?", "Какой график работы?", "Вакансия открыта?", "Какая оплата труда?"]))
        .environmentObject(VacanciesViewModel())
}
