//
//  StartupViewModel.swift
//  Authorization
//
//  Created by SaeedBashir on 10/23/23.
//

import Foundation
import Core

public class StartupViewModel: ObservableObject {
    let router: AuthorizationRouter
    @Published var searchQuery: String?
    
    let config: ConfigProtocol

    public init(
        router: AuthorizationRouter,
        config: ConfigProtocol
    ) {
        self.router = router
        self.config = config
    }

    var loginBackgroundEnabled: Bool {
        config.theme.backgroundLoginImageEnabled
    }
}
