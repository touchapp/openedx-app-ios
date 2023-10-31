//
//  SignInViewModel.swift
//  Authorization
//
//  Created by Vladimir Chekyrta on 14.09.2022.
//

import Foundation
import Core
import SwiftUI
import Alamofire

public class SignInViewModel: ObservableObject {

    enum State: Equatable {
        case loading
        case loaded
        case error(AlertView.AlertType, String)
    }
    @Published var state: State = .loaded
    
    let router: AuthorizationRouter
    
    private let interactor: AuthInteractorProtocol
    private let analytics: AuthorizationAnalytics
    private let validator: Validator
    
    public init(
        interactor: AuthInteractorProtocol,
        router: AuthorizationRouter,
        analytics: AuthorizationAnalytics,
        validator: Validator
    ) {
        self.interactor = interactor
        self.router = router
        self.analytics = analytics
        self.validator = validator
    }
    
    @MainActor
    func login(username: String, password: String) async {
        guard validator.isValidEmail(username) else {
            state =  .error(.bar, AuthLocalization.Error.invalidEmailAddress)
            return
        }
        guard validator.isValidPassword(password) else {
            state = .error(.bar, AuthLocalization.Error.invalidPasswordLenght)
            return
        }
        
        state = .loading
        do {
            let user = try await interactor.login(username: username, password: password)
            analytics.setUserID("\(user.id)")
            analytics.userLogin(method: .password)
            router.showMainScreen()
        } catch let error {
            state = .loaded
            if let validationError = error.validationError,
               let value = validationError.data?["error_description"] as? String {
                state = .error(.bar, value)
            } else if case APIError.invalidGrant = error {
                state = .error(.bar, CoreLocalization.Error.invalidCredentials)
            } else if error.isInternetError {
                state = .error(.bar, CoreLocalization.Error.slowOrNoInternetConnection)
            } else {
                state = .error(.bar, CoreLocalization.Error.unknownError)
            }
        }
    }
    
    func trackSignUpClicked() {
        analytics.signUpClicked()
    }
    
    func trackForgotPasswordClicked() {
        analytics.forgotPasswordClicked()
    }
}
