//
//  ContentView.swift
//  EffectiveMobile
//
//  Created by Диана Мишкова on 13.03.24.
//

import SwiftUI


struct FirstLoginView: View {
    
    @EnvironmentObject var vacanciesViewModel: VacanciesViewModel
    @State private var continueButtonTouched: Bool = false
    @State private var validEmail: Bool = true
    @State private var passwordButtonTouched: Bool = false
    @State private var showPasswordButton: Bool = false
    var body: some View {
        VStack {
            HStack  {
                Text("Вход в личный кабинет")
                    .font(.title2)
                    .bold()
                Spacer()
            }
            .padding()
            Spacer(minLength: 150)
            GroupBox(label: Text("Поиск работы").font(.title3)) {
                VStack(spacing: 10) {
                    HStack {
                        if vacanciesViewModel.email.isEmpty {
                            Image(systemName: "envelope")
                                .resizable()
                                .frame(width: 24, height: 16)
                                .foregroundColor(.gray)
                        }
                        TextField("Электорнная почта или телефон", text: $vacanciesViewModel.email)
                            .frame(height: 33)
                        if !vacanciesViewModel.email.isEmpty {
                            Button {
                                vacanciesViewModel.email = ""
                            } label: {
                                Label("", systemImage: "multiply")
                                    .foregroundStyle(Color.gray)
                            }
                        }
                    }
                    .padding(7)
                    .background(
                        RoundedRectangle(cornerRadius: 10)
                            .fill(Color.gray)
                            .opacity(0.1)
                            .overlay(RoundedRectangle(cornerRadius: 10)
                            .stroke(validEmail ? Color.clear : Color.red)))
                    if passwordButtonTouched {
                        HStack {
                            if vacanciesViewModel.password.isEmpty {
                                Image(systemName: "key.horizontal")
                                    .resizable()
                                    .frame(width: 24, height: 14)
                                    .foregroundColor(.gray)
                            }
                            if !showPasswordButton {
                                SecureField("Пароль", text: $vacanciesViewModel.password)
                                    .frame(height: 33)
                                
                            } else {
                                TextField("Пароль", text: $vacanciesViewModel.password)
                                    .frame(height: 33)
                            }
                            if !vacanciesViewModel.password.isEmpty {
                                Button {
                                    showPasswordButton.toggle()
                                } label: {
                                    Label("", systemImage: showPasswordButton ? "eye" : "eye.slash")
                                        .foregroundStyle(Color.gray)
                                }
                            }
                        }
                        .padding(7)
                        .background(
                            RoundedRectangle(cornerRadius: 10)
                                .fill(Color.gray)
                                .opacity(0.1))
                    }
                    HStack {
                        if !validEmail {
                            Text("Вы ввели неверный e-mail")
                                .foregroundStyle(.red)
                            Spacer()
                        }
                    }
                    
                    HStack {
                        Button {
                            if !vacanciesViewModel.isEmaiValid {
                                validEmail = false
                            } else {
                                validEmail = true
                                continueButtonTouched = true
                            }
                        } label: {
                            Text("Продолжить")
                                .padding(6)
                                .frame(maxWidth: .infinity)
                        }
                        .disabled(vacanciesViewModel.email.isEmpty || (passwordButtonTouched && vacanciesViewModel.password.isEmpty))
                        .buttonStyle(.borderedProminent)
                        
                        Button {
                            passwordButtonTouched.toggle()
                        } label: {
                            if !passwordButtonTouched {
                                Text("Войти с паролем")
                                    .frame(maxWidth: 150)
                            } else {
                                Text("Войти с кодом")
                                    .frame(maxWidth: 150)
                            }
                        }
                    }
                    .navigationDestination(isPresented: $continueButtonTouched) {
                        SecondLoginView(email: vacanciesViewModel.email)
                    }
                }
            }
            .padding(10)
            GroupBox(label: Text("Поиск сотрудников").font(.title3)) {
                VStack(spacing: 15) {
                    HStack {
                        Text("Размещение вакансий и доступ к базе резюме")
                            .font(.footnote)
                        Spacer()
                    }
                    
                    Button {
                    } label: {
                        Text("Я ищу сотрудников")
                            .frame(maxWidth: .infinity)
                            .padding(4)
                    }
                    .buttonStyle(.borderedProminent)
                    .buttonBorderShape(.capsule)
                    .tint(.green)
                }
            }
            .padding(10)
            Spacer()
        }
    }
}

#Preview {
    FirstLoginView()
        .environmentObject(VacanciesViewModel())
}
