//
//  SignInContentView.swift
//  Authorization
//
//  Created by Eugene Yatsenko on 08.11.2023.
//

import SwiftUI
import Core

public struct SignInContentView: View {

    @ObservedObject
    private var viewModel: SignInViewModel

    @State private var email: String = ""
    @State private var password: String = ""

    public init(viewModel: SignInViewModel) {
        self.viewModel = viewModel
    }

    public var body: some View {
        VStack(alignment: .center) {
            ScrollView {
                VStack {
                    VStack(alignment: .leading) {
                        welcomText
                        fields
                        ProgressStyledButton(
                            title: AuthLocalization.SignIn.logInBtn,
                            isShowProgress: viewModel.state == .loading
                        ) {
                            Task {
                                await viewModel.login(username: email, password: password)
                            }
                        }.padding(.top, 20)
                    }
                    registerForgotButtons
                    SocialSignView(onSigned: viewModel.sign)
                }
                .padding(.horizontal, 24)
                .padding(.top, 50)
            }
            .roundedBackground(Theme.Colors.background)
            .scrollAvoidKeyboard(dismissKeyboardByTap: true)
        }
    }

    private var welcomText: some View {
        Group {
            Text(AuthLocalization.SignIn.logInTitle)
                .font(Theme.Fonts.displaySmall)
                .foregroundColor(Theme.Colors.textPrimary)
                .padding(.bottom, 4)
            Text(AuthLocalization.SignIn.welcomeBack)
                .font(Theme.Fonts.titleSmall)
                .foregroundColor(Theme.Colors.textPrimary)
                .padding(.bottom, 20)
        }
    }

    private var fields: some View {
        VStack(spacing: 18) {
            TitleTextField(
                title: AuthLocalization.SignIn.email,
                placeholder: AuthLocalization.SignIn.email,
                keyboardType: .emailAddress,
                textContentType: .emailAddress,
                style: .none,
                isAutocorrectionDisabled: true,
                text: $email
            )
            TitleTextField(
                title: AuthLocalization.SignIn.password,
                placeholder: AuthLocalization.SignIn.password,
                isSecure: true,
                text: $password
            )
        }
    }

    private var registerForgotButtons: some View {
        HStack {
            Button(AuthLocalization.SignIn.registerBtn) {
                viewModel.trackSignUpClicked()
                viewModel.router.showRegisterScreen()
            }
            .font(.system(size: 16, weight: .medium))
            .foregroundColor(Theme.Colors.accentColor)

            Spacer()

            Button(AuthLocalization.SignIn.forgotPassBtn) {
                viewModel.trackForgotPasswordClicked()
                viewModel.router.showForgotPasswordScreen()
            }
            .font(.system(size: 16, weight: .medium))
            .foregroundColor(Theme.Colors.accentColor)
        }
        .padding(.top, 10)
    }
}
