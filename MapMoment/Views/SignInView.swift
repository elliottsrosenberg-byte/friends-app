import AuthenticationServices
import SwiftUI

struct SignInView: View {
    @EnvironmentObject private var model: AppModel

    var body: some View {
        VStack(spacing: 0) {
            Spacer()

            // Working codename — real name and brand come later.
            Text("MapMoment")
                .font(.title2.weight(.semibold))
            Text("Your friend group, on one map.")
                .font(.subheadline)
                .foregroundStyle(.secondary)
                .padding(.top, 6)

            Spacer()

            SignInWithAppleButton(.signIn) { request in
                model.auth.configureRequest(request)
            } onCompletion: { result in
                model.completeAppleSignIn(result)
            }
            .signInWithAppleButtonStyle(.black)
            .frame(height: 50)
            .padding(.horizontal, 24)

            if let message = model.statusMessage {
                Text(message)
                    .font(.footnote)
                    .foregroundStyle(.secondary)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 24)
                    .padding(.top, 12)
            }

            Spacer().frame(height: 48)
        }
    }
}
