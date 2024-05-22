//
//  DigitCellView.swift
//  EffectiveMobile
//
//  Created by Диана Мишкова on 14.03.24.
//

import SwiftUI

struct DigitCellView: View {

    @FocusState private var activeTextField: Int?
    @EnvironmentObject var viewModel: VacanciesViewModel
    var body: some View {
        VStack(alignment: .leading, spacing: 15) {        
            HStack {
                ForEach(0..<4) { index in
                    TextField("*", text: $viewModel.code[index])
                        .keyboardType(.numberPad)
                        .onChange(of: viewModel.code[index], { oldValue, newValue in
                            if let newChar = newValue.first {
                                viewModel.code[index] = String(newChar)
                                if newValue.count > 0 && index < 3 {
                                    activeTextField = index + 1
                                }
                            }                            
                        })
                        .frame(width: 48, height: 48)
                        .multilineTextAlignment(.center)
                        .font(.largeTitle)
                        .focused($activeTextField, equals: index)
                        .padding(7)
                        .background(
                            RoundedRectangle(cornerRadius: 10)
                                .fill(Color.gray)
                                .opacity(0.1))
                }
                Spacer()
            }
        }
    }
}
    

#Preview {
    DigitCellView()
        .environmentObject(VacanciesViewModel())
}
