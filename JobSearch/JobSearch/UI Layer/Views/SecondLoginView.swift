//
//  SecondLoginView.swift
//  EffectiveMobile
//
//  Created by Диана Мишкова on 14.03.24.
//

import SwiftUI


struct SecondLoginView: View {
    var email: String
    @State var isPressed = false
    @EnvironmentObject var viewModel: VacanciesViewModel
    @State private var code: String = ""
    var body: some View {
        ScrollView {
            Spacer(minLength: 150)
            VStack(alignment: .leading, spacing: 15) {
                
                Text("Отправили код на " + email)
                    .font(.title2)
                
                Text("Напишите его, чтобы подтвердить, что это вы, а не кто-то другой входит в личный кабинет")
                    .font(.title3)
                
                DigitCellView()
                Button {
                    isPressed = true
                } label: {
                    Text("Продолжить")
                        .padding(6)
                        .frame(maxWidth: .infinity)
                }
                .disabled(!viewModel.validCode)
                .buttonStyle(.borderedProminent)
                .navigationDestination(isPresented: $isPressed) {
                    VacanciesTabView()
                }
                Spacer(minLength: 300)
            }
            .padding(.horizontal, 10)
            .navigationBarBackButtonHidden()
        }
    }
}


#Preview {
    SecondLoginView(email: "example@gmail.com")
        .environmentObject(VacanciesViewModel())
}
