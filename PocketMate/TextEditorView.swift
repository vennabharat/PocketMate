//
//  TextEditorView.swift
//  PocketMate
//
//  Created by bharat venna on 09/03/24.
//

import SwiftUI

struct TextEditorView: View {
    
    var textName: String
    var textPlaceholder: String
    @Binding var textValue: String
    
    var valueName: String
    var valuePlaceholder: String
    @Binding var money: Double
    
    enum Field {
        case name, value
    }
    
    @FocusState var focusField: Field?
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(textName)
                .font(.footnote)
                .fontWeight(.semibold)
            TextField(textPlaceholder, text: $textValue)
                .submitLabel(.next)
                .focused($focusField, equals: .name)
                .onSubmit {
                    focusField = .value
                }
            HStack {
                
            }
            .frame(width: UIScreen.main.bounds.width-15, height: 2)
            .background(.gray)
            
            Text(valueName)
                .font(.footnote)
                .fontWeight(.semibold)
            TextField(valuePlaceholder, value: $money, format: .currency(code: "INR"))
                .keyboardType(.numbersAndPunctuation)
                .submitLabel(.return)
                .focused($focusField, equals: .value)
                .onSubmit {
                    focusField = nil
                }
            HStack {
                
            }
            .frame(width: UIScreen.main.bounds.width-15, height: 2)
            .background(.gray)
        }
        .padding(.horizontal)
    }
}

struct TextEditorView_Previews: PreviewProvider {
    static var previews: some View {
        TextEditorView(textName: "Expense Name", textPlaceholder: "Choclates", textValue: .constant(""), valueName: "Cost", valuePlaceholder: "0.0", money: .constant(0.0))
    }
}
