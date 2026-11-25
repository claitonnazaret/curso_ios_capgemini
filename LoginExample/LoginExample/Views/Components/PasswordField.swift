//
//  PasswordField.swift
//  LoginExample
//
//  Created by Nazaret, Claiton Milton Augusto on 25/11/26.
//

import SwiftUI

struct PasswordField: View {
    let placeholder: String
    @Binding var text: String
    @State var isVisible: Bool = false
    
    init(_ placeholder: String, text: Binding<String>) {
        self.placeholder = placeholder
        self._text = text
    }
    
    var body: some View {
        HStack {
            ZStack(alignment: .leading) {
                TextField(placeholder, text: $text)
                    .autocorrectionDisabled()
                    .textContentType(.oneTimeCode)
                    .opacity(isVisible ? 1 : 0)
                    .allowsHitTesting(isVisible)
                
                SecureField(placeholder, text: $text)
                    .textContentType(.oneTimeCode)
                    .opacity(isVisible ? 0 : 1)
                    .allowsHitTesting(!isVisible)
            }
            
            Button {
                isVisible.toggle()
            } label: {
                Image(systemName: isVisible ? "eye.slash" : "eye")
                    .foregroundStyle(.secondary)
                    .contentTransition(.symbolEffect(.replace))
            }
        }
        .padding()
        .background(Color(.secondarySystemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 12))
    }
}
