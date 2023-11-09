//
//  TitleTextField.swift
//  Core
//
//  Created by Eugene Yatsenko on 08.11.2023.
//

import SwiftUI

public struct TitleTextField: View {

    public var title: String?
    public let placeholder: String
    public var keyboardType: UIKeyboardType
    public var textContentType: UITextContentType?
    public var style: UITextAutocapitalizationType
    public var isAutocorrectionDisabled: Bool
    public var isSecure: Bool
    public var allPadding: Double

    @Binding public var text: String

    public init(
        title: String? = nil,
        placeholder: String,
        keyboardType: UIKeyboardType = .default,
        textContentType: UITextContentType? = nil,
        style: UITextAutocapitalizationType = .words,
        isAutocorrectionDisabled: Bool = false,
        isSecure: Bool = false,
        allPadding: Double = 14,
        text: Binding<String>
    ) {
        self.title = title
        self.placeholder = placeholder
        self.keyboardType = keyboardType
        self.textContentType = textContentType
        self.style = style
        self.isAutocorrectionDisabled = isAutocorrectionDisabled
        self.isSecure = isSecure
        self.allPadding = allPadding
        self._text = text
    }

    public var body: some View {
        VStack(alignment: .leading) {
            title.flatMap {
                Text($0)
                    .font(Theme.Fonts.labelLarge)
                    .foregroundColor(Theme.Colors.textPrimary)
            }
            if isSecure {
                SecureField(placeholder, text: $text)
                    .padding(.all, allPadding)
                    .background(
                        Theme.Shapes.textInputShape
                            .fill(.clear)
                    )
                    .overlay(
                        Theme.Shapes.textInputShape
                            .stroke(lineWidth: 1)
                            .fill(Theme.Colors.textInputStroke)
                    )
            } else {
                TextField(placeholder, text: $text)
                    .keyboardType(keyboardType)
                    .textContentType(textContentType)
                    .autocapitalization(style)
                    .if(isAutocorrectionDisabled) { view in
                        view.autocorrectionDisabled()
                    }
                    .padding(.all, allPadding)
                    .background(
                        Theme.Shapes.textInputShape
                            .fill(.clear)
                    )
                    .overlay(
                        Theme.Shapes.textInputShape
                            .stroke(lineWidth: 1)
                            .fill(Theme.Colors.textInputStroke)
                    )
            }
        }
    }

}
