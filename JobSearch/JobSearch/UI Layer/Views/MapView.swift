//
//  MapView.swift
//  EffectiveMobile
//
//  Created by Диана Мишкова on 17.03.24.
//

import SwiftUI
import MapKit

struct MapView: View {
    @EnvironmentObject var viewModel: VacanciesViewModel
    @State var vacancy: Vacancy
    var body: some View {
        VStack  {
            HStack {
                Text(vacancy.company ?? "")
                Image(systemName: "checkmark.circle")
                    .resizable()
                    .frame(width: 16, height: 16)
                    .foregroundColor(.gray)
                Spacer()
            }
            Map {}
                
            HStack {
                Text(vacancy.address.town! + ", " + vacancy.address.street! + ", " + vacancy.address.house!)
                Spacer()
            }
        }
        .padding(15)
        .background(
            RoundedRectangle(cornerRadius: 10)
                .fill(Color.gray)
                .opacity(0.4)
        )
    }
}

#Preview {
    MapView(vacancy: Vacancy(id: "cbf0c984-7c6c-4ada-82da-e29dc698bb50", lookingNumber: 2, title: "UI/UX дизайнер", address: Address(town: "Минск", street: "улица Бирюзова", house: "4/5"), company: "Мобирикс", experience: Experience(previewText: "Опыт от 1 до 3 лет", text: "1–3 года"), publishedDate: "2024-02-20", isFavorite: false, salary: Salary(full: "Уровень дохода не указан", short: nil), schedules: ["полная занятость", "полный день"], appliedNumber: 147, description: "Мы ищем специалиста на позицию UX/UI Designer, который вместе с коллегами будет заниматься проектированием пользовательских интерфейсов внутренних и внешних продуктов компании.", responsibilities: "- проектирование пользовательских сценариев и создание прототипов;\n- разработка интерфейсов для продуктов компании (Web+App);\n- работа над созданием и улучшением Дизайн-системы;\n- взаимодействие с командами frontend-разработки;\n- контроль качества внедрения дизайна;\n- ситуативно: создание презентаций и других материалов на основе фирменного стиля компании", questions: ["Где располагается место работы?", "Какой график работы?", "Вакансия открыта?", "Какая оплата труда?"]))
}

