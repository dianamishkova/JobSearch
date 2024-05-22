//
//  MainView.swift
//  EffectiveMobile
//
//  Created by Диана Мишкова on 15.03.24.
//

import SwiftUI

struct MainView: View {
    @EnvironmentObject var viewModel: VacanciesViewModel
    @State var searching: String = ""
    static let wrapperViewInsets = EdgeInsets(top: 16, leading: 0, bottom: 12, trailing: 0)
    var body: some View {
        ScrollView {
            VStack {
                HStack(spacing: 15) {
                    HStack {
                        Image(systemName: "magnifyingglass")
                            .resizable()
                            .frame(width: 24, height: 24)
                            .foregroundColor(.gray)
                            .padding(.leading, 8)
                            .contrast(2)
                        TextField("Должность, ключевые слова", text: $searching)
                            .font(.subheadline)
                            .contrast(2)
                    }
                    .navigationBarBackButtonHidden()
                    .frame(height: 40)
                    .padding(3)
                    .background(
                        RoundedRectangle(cornerRadius: 10)
                            .fill(Color.gray.opacity(0.4))
                    )
                    HStack {
                        Button {
                        } label: {
                            Label("", systemImage: "slider.horizontal.3")
                                .foregroundStyle(Color.gray)
                                .contrast(2)
                                .padding(.leading, 8)
                        }
                    }
                    .frame(width: 40, height: 40)
                    .padding(3)
                    .background(
                        RoundedRectangle(cornerRadius: 10)
                            .fill(Color.gray.opacity(0.4))
                    )
                }
                .padding(10)
                
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        GroupBox(label: Label("", image: "Location")) {
                            VStack {
                                HStack {
                                    Text("Вакансии рядом с вами")
                                        .font(.system(size: 14))
                                        .padding(.bottom, 4)
                                    Spacer()
                                }
                            }
                            .padding(MainView.wrapperViewInsets)
                        }
                        .frame(maxWidth: 150, minHeight: 140)
                        
                        GroupBox(label: Label("", image: "Star")) {
                            VStack {
                                HStack {
                                    Text("Поднять резюме в поиске")
                                        .font(.system(size: 14))
                                    Spacer()
                                }
                                .padding(.top, 16)
                                HStack {
                                    Text("Поднять")
                                        .font(.system(size: 14))
                                        .foregroundStyle(.green)
                                    Spacer()
                                }
                            }
                        }
                        .frame(maxWidth: 154, minHeight: 140)
                        GroupBox(label: Label("", image: "PartTime")) {
                            HStack {
                                Text("Временная работа и подработка")
                                    .font(.system(size: 14))
                                    .padding(.top, 16)
                                Spacer()
                            }
                        }
                        .frame(maxWidth: 154, minHeight: 140)
                    }
                }
                .padding(.horizontal, 10)
                
                HStack {
                    Text("Вакансии для вас")
                        .font(.title3)
                        .bold()
                    Spacer()
                }
                .padding(.horizontal, 10)
                
                ForEach(viewModel.vacancies.prefix(3)) { vacancy in
                    NavigationLink(destination: VacancyDetailsView(vacancy: vacancy)) {
                        VacancyBoxView(vacancy: vacancy)
                            
                    }
                    .buttonStyle(PlainButtonStyle())
                }
                
                Button {
                } label: {
                    Text("Еще " + viewModel.vacancyPluralForm(viewModel.vacancies.count))
                        .padding(6)
                        .frame(maxWidth: .infinity)
                }
                .buttonStyle(.borderedProminent)
                .padding(10)
            }
            
        }
    }
}

#Preview {
    MainView()
        .environmentObject(VacanciesViewModel())
}
