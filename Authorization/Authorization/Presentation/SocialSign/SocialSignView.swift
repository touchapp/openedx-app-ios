//
//  SocialSignView.swift
//  Authorization
//
//  Created by Eugene Yatsenko on 10.10.2023.
//

import SwiftUI
import Core

struct SocialSignView: View {

    // MARK: - Properties -

    @StateObject var viewModel: SocialSignViewModel

    init(
        signType: SignType = .signIn,
        onSigned: @escaping (Result<Socials, Error>) -> Void
    ) {
        let viewModel: SocialSignViewModel = .init(onSigned: onSigned)
        self._viewModel = .init(wrappedValue: viewModel)
        self.signType = signType
    }

    enum SignType {
        case signIn
        case register
    }
    var signType: SignType = .signIn

    private var title: String {
        switch signType {
        case .signIn:
            return AuthLocalization.signInWith
        case .register:
            return AuthLocalization.signInRegister
        }
    }

    // MARK: - Views -

    var body: some View {
        VStack(spacing: 16) {
            headerView
            buttonsView
        }
        .padding(.vertical, 32)
    }

    private var headerView: some View {
        HStack {
            Text("\(AuthLocalization.or) \(title.lowercased()):")
                .font(.system(size: 17, weight: .medium))
            Spacer()
        }
    }

    private var buttonsView: some View {
        Group {
            SocialButton(
                image: CoreAssets.iconApple.swiftUIImage,
                title: "\(title) \(AuthLocalization.apple)",
                backgroundColor: .black,
                action: viewModel.signInWithApple
            )
            SocialButton(
                image: CoreAssets.iconGoogleWhite.swiftUIImage,
                title: "\(title) \(AuthLocalization.google)",
                textColor: UIColor(red: 0.44, green: 0.44, blue: 0.44, alpha: 1.00).sui,
                backgroundColor: .white,
                borderColor: UIColor(red: 0.44, green: 0.44, blue: 0.44, alpha: 1.00).sui,
                action: viewModel.signInWithGoogle
            )
            SocialButton(
                image: CoreAssets.iconFacebookWhite.swiftUIImage,
                title: "\(title) \(AuthLocalization.facebook)",
                backgroundColor: UIColor(red: 0.09, green: 0.46, blue: 0.95, alpha: 1.00).sui,
                action: viewModel.signInWithFacebook
            )
            SocialButton(
                image: CoreAssets.iconMicrosoftWhite.swiftUIImage,
                title: "\(title) \(AuthLocalization.microsoft)",
                backgroundColor: UIColor(red: 0.18, green: 0.18, blue: 0.18, alpha: 1.00).sui,
                action: viewModel.signInWithMicrosoft
            )
        }
    }
}
