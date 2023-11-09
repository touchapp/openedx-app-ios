//
//  SignInView.swift
//  Authorization
//
//  Created by Vladimir Chekyrta on 13.09.2022.
//

import SwiftUI
import Core

public struct SignInView: View {

    @Environment (\.isHorizontal) private var isHorizontal

    @ObservedObject
    private var viewModel: SignInViewModel
    
    public init(viewModel: SignInViewModel) {
        self.viewModel = viewModel
    }
    
    public var body: some View {
        ZStack(alignment: .top) {
            VStack {
                CoreAssets.authBackground.swiftUIImage
                    .resizable()
                    .edgesIgnoringSafeArea(.top)
            }.frame(maxWidth: .infinity, maxHeight: 200)
            VStack(alignment: .center) {
                CoreAssets.appLogo.swiftUIImage
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(maxWidth: 189, maxHeight: 54)
                    .padding(.top, isHorizontal ? 20 : 40)
                    .padding(.bottom, isHorizontal ? 10 : 40)
                SignInContentView(viewModel: viewModel)
            }
            if case .error(let type, let message) = viewModel.state {
                AlertBarView(
                    message: message,
                    type: type,
                    onDismiss: { viewModel.state = .loaded }
                )
            }
        }
        .hideNavigationBar()
        .navigationBarBackButtonHidden(true)
        .navigationBarHidden(true)
        .ignoresSafeArea(.all, edges: .horizontal)
        .background(Theme.Colors.background.ignoresSafeArea(.all))
    }
}

#if DEBUG
struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        let vm = SignInViewModel(
            interactor: AuthInteractor.mock,
            router: AuthorizationRouterMock(),
            analytics: AuthorizationAnalyticsMock(),
            validator: Validator()
        )
        
        SignInView(viewModel: vm)
            .preferredColorScheme(.light)
            .previewDisplayName("SignInView Light")
            .loadFonts()
        
        SignInView(viewModel: vm)
            .preferredColorScheme(.dark)
            .previewDisplayName("SignInView Dark")
            .loadFonts()
    }
}
#endif
