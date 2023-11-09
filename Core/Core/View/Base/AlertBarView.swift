//
//  AlertBarView.swift
//  Core
//
//  Created by Eugene Yatsenko on 08.11.2023.
//

import SwiftUI

public struct AlertBarView: View {

    public enum AlertType {
        case alert
        case bar
    }

    public var message: String?
    public var type: AlertType
    public var onDismiss: (() -> Void)?

    public init(
        message: String?,
        type: AlertType = .alert,
        onDismiss: (() -> Void)? = nil
    ) {
        self.message = message
        self.type = type
        self.onDismiss = onDismiss
    }

    public var body: some View {
        VStack {
            switch type {
            case .alert:
                alert
            case .bar:
                snack
            }
        }
        .transition(.move(edge: type == .alert ? .top : .bottom))
    }

    private var alert: some View {
        VStack {
            Text(message ?? "")
                .shadowCardStyle(
                    bgColor: Theme.Colors.accentColor,
                    textColor: .white
                )
                .padding(.top, 80)
            Spacer()
        }
        .onAppear {
            doAfter(Theme.Timeout.snackbarMessageLongTimeout) {
                onDismiss?()
            }
        }
    }

    private var snack: some View {
        VStack {
            Spacer()
            SnackBarView(message: message)
        }
        .onTapGesture {
            onDismiss?()
        }
        .onAppear {
            doAfter(Theme.Timeout.snackbarMessageLongTimeout) {
                onDismiss?()
            }
        }
    }
}
