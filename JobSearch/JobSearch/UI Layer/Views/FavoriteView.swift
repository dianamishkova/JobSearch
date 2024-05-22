//
//  FavoriteView.swift
//  EffectiveMobile
//
//  Created by Диана Мишкова on 19.03.24.
//

import SwiftUI

struct FavoriteView: View {
    @EnvironmentObject var viewModel: VacanciesViewModel
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 15){
                HStack{
                    Text("Избранное")
                        .font(.title)
                        .bold()
                        .padding(10)
                    Spacer()
                }
                
                Text(viewModel.vacancyPluralForm(viewModel.favoriteVacancies().count))
                    .foregroundStyle(.gray)
                    .padding(.horizontal, 10)
                
                ForEach(viewModel.favoriteVacancies()) { vacancy in
                    NavigationLink(destination: VacancyDetailsView(vacancy: vacancy)) {
                        VacancyBoxView(vacancy: vacancy)
                            .foregroundStyle(Color.white)
                    }
                }
            }
        }
    }
}
    


#Preview {
    FavoriteView()
        .environmentObject(VacanciesViewModel())
}
