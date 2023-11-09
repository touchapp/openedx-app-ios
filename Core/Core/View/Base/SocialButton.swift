//
//  LabelButton.swift
//  Core
//
//  Created by Eugene Yatsenko on 10.10.2023.
//

import SwiftUI

public struct SocialButton: View {

    // MARK: - Properties -

    private var image: Image
    private var title: String
    private var textColor: Color
    private var backgroundColor: Color
    private var borderColor: Color?
    private var cornerRadius: CGFloat
    private var action: () -> Void

    public init(
        image: Image,
        title: String,
        textColor: Color = .white,
        backgroundColor: Color = .accentColor,
        borderColor: Color? = nil,
        cornerRadius: CGFloat = Theme.Shapes.buttonRadius,
        action: @escaping () -> Void
    ) {
        self.image = image
        self.title = title
        self.textColor = textColor
        self.backgroundColor = backgroundColor
        self.borderColor = borderColor
        self.cornerRadius = cornerRadius
        self.action = action
    }

    // MARK: - Views -

    public var body: some View {
        Button {
            action()
        } label: {
            Label {
                Text(title)
                    .foregroundStyle(textColor)
                    .font(.system(size: 17, weight: .medium))
                    .padding(.leading, 10)
                Spacer()
            } icon: {
                image.padding(.leading, 10)
            }
        }
        .frame(height: 44)
        .background {
            Theme.Shapes.buttonShape
                .fill(backgroundColor)
        }
        .overlay(
            RoundedRectangle(cornerRadius: cornerRadius)
                    .stroke(style: .init(lineWidth: 1, lineCap: .round, lineJoin: .round, miterLimit: 1))
                    .foregroundColor(borderColor ?? backgroundColor)
        )

    }
}
