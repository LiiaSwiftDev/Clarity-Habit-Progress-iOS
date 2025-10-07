//
//  ProgressBarView.swift
//  Progress
//
//  Created by Лия Кошеленко on 2025-10-07.
//

import SwiftUI

struct ProgressBarView: View {
    
    var body: some View {
        
        HStack(spacing: 0) {
            Text("25")
                .font(.system(size: 12))
                .bold()
                .foregroundStyle(.red)
            
            Text("%")
                .font(.system(size: 12))
                .foregroundStyle(.red)
                .padding(.trailing, 10)
            
            ZStack(alignment: .leading) {
                Capsule()
                // сначала цвет потом frame
                    .fill(Color.gray.opacity(0.3))
                    .frame(height: 5)
                Capsule()
                    .fill(Color.red)
                    .frame(width: 100 * 0.25, height: 5)
                
            } .frame(width: 80)
        }
    }
}

#Preview {
    ProgressBarView()
}
