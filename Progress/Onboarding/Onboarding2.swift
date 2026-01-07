//
//  Onboarding2.swift
//  Progress
//
//  Created by Лия Кошеленко on 2025-10-09.
//

import SwiftUI

struct Onboarding2: View {
    
    var actionButton: () -> Void
    
    var body: some View {
        ZStack {
            
            //Color(red: 5/255, green: 114/255, blue: 161/255)
            Color("Background")
            

            GeometryReader { geo in
                // geo.size.height - высота контейнера или экрана в points (pt)
                // Вычитание safeAreaInsets → реальная доступная высота, где можно рисовать контент. Без этого элементы могут попасть под чёлку или Home indicator
                let height =
                        geo.size.height
                        - geo.safeAreaInsets.top
                        - geo.safeAreaInsets.bottom

                    let scale: CGFloat = {
                        if height >= 850 {
                            // Если экран большой (height >= 850 pt) → scale = 1
                            return 1.0
                        } else if height >= 750 {
                            // Средний экран (height >= 750 pt) → scale = 0.65
                            return 0.65
                        } else {
                            // Маленький экран (height < 750 pt) → scale = 0.35
                            return 0.35
                        }
                    }()
                
                VStack(alignment: .center, spacing: 0) {
                    
                    Spacer()
                    
                    Image("girl2")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                    // scale возвращает размер экрана, если экран большой то вернет 1.0
                    // geo.size.width - это вся достурная ширина картинки
                    // тогда ширина * 1.0 = изображение большое
                    // или ширина * 0.35 = изображение маленькое
                        .frame(maxWidth: geo.size.width * scale)
                        .padding(.horizontal, 40)
                        .padding(.bottom, 70)

                    Text("Set your goals")
                        .font(.system(size: 26, weight: .bold, design: .default))
                        .foregroundStyle(Color.black)
                        .padding(.bottom, 20)
                    
                    Text("Choose what you want to achieve and take your first step toward progress.")
                        .foregroundStyle(Color.black)
                        .padding(.bottom, 150)
                        .multilineTextAlignment(.center)
                    
                    Button {
                        // TODO
                        actionButton()
                    } label: {
                        ZStack {
                            RoundedRectangle(cornerRadius: 15)
                                .fill(Color.pink)
                                .frame(height: 50)
                               // .frame(maxWidth: 400)
                            
                            Text("Get Started")
                                .font(.system(size: 20, weight: .semibold))
                                .foregroundStyle(Color.white)
                            
                        }
                    }.padding(.bottom, 115)
                    
                }
                .padding(.horizontal)
            }
                

        }
    }
}

#Preview {
    Onboarding2 {
        // nothing
    }
}
