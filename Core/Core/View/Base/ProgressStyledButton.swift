//
//  ProgressStyledButton.swift
//  Core
//
//  Created by Eugene Yatsenko on 08.11.2023.
//

import SwiftUI

public struct ProgressStyledButton: View {

    public var title: String
    public var isShowProgress: Bool
    public var isTransparent: Bool
    public var color: Color
    public var isActive: Bool
    public var onTap: () -> Void

    public init(
        title: String,
        isShowProgress: Bool,
        isTransparent: Bool = false,
        color: Color = Theme.Colors.accentColor,
        isActive: Bool = true,
        onTap: @escaping () -> Void
    ) {
        self.title = title
        self.isShowProgress = isShowProgress
        self.isTransparent = isTransparent
        self.color = color
        self.isActive = isActive
        self.onTap = onTap
    }

    public var body: some View {
        if isShowProgress {
            HStack(alignment: .center) {
                ProgressBar(size: 40, lineWidth: 8)
            }.frame(maxWidth: .infinity)
        } else {
            StyledButton(
                title,
                action: onTap,
                isTransparent: isTransparent,
                color: color,
                isActive: isActive
            )
            .frame(maxWidth: .infinity)
        }
    }
}
