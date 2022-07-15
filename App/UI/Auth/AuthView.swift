//import SwiftUI
//import Firebase
//
//
//struct AuthorizationView: View {
//
//    weak var delegate: AuthorizationListener?
//
//    @State var isRegistration = false
//    @State var loginText = ""
//    @State var passwordText = ""
//
//    var body: some View {
//        ZStack {
//            Image(uiImage: VdohnovitelyAsset.authBackgroundImage.image)
//                .resizable()
//                .padding([.top, .bottom], -100)
//
//
//            VStack(alignment: .center) {
//                VStack(alignment: .leading) {
//                    Text(isRegistration ? "Регистрация" : "Логин")
//                        .font(Font.largeTitle.bold())
//                        .foregroundColor(.white)
//                        .padding([.bottom], 60)
//
//                    VStack(alignment: .leading, spacing: 5) {
//                        HStack {
//                            Image(systemName: "person.fill")
//                                .foregroundColor(.white)
//
//                            TextField("", text: $loginText)
//                                .foregroundColor(.white)
//                                .disableAutocorrection(true)
//                                .accentColor(.white)
//                                .placeholder(when: loginText.isEmpty) {
//                                    Text("введите логин")
//                                        .foregroundColor(Color(VdohnovitelyAsset.textFiledPlaceholderColor.color))
//                                }
//                        }
//
//                        Color(.gray)
//                            .frame(height: 1)
//                    }
//                    .padding([.bottom], 50)
//
//
//                    VStack(alignment: .leading, spacing: 5) {
//                        HStack {
//                            Image(systemName: "lock.fill")
//                                .foregroundColor(.white)
//
//                            SecureField("", text: $passwordText)
//                                .foregroundColor(.white)
//                                .disableAutocorrection(true)
//                                .accentColor(.white)
//                                .placeholder(when: passwordText.isEmpty) {
//                                    Text("введите пароль")
//                                        .foregroundColor(Color(VdohnovitelyAsset.textFiledPlaceholderColor.color))
//                                }
//                        }
//
//                        Color(.gray)
//                            .frame(height: 1)
//                    }
//                }
//                .padding([.leading, .trailing], 40)
//                .padding([.bottom], 40)
//
//                Button {
//                    if isRegistration {
//                        Auth.auth().createUser(
//                            withEmail: loginText,
//                            password: passwordText
//                        ) { result, error in
//                            delegate?.authorizationIsEnded()
//                        }
//                    } else {
//                        Auth.auth().signIn(
//                            withEmail: loginText,
//                            password: passwordText
//                        ) { result, error in
//                            delegate?.authorizationIsEnded()
//                        }
//                    }
//                } label: {
//                    Text("войти")
//                        .padding([.leading, .trailing], 130)
//                        .padding([.top, .bottom], 10)
//                        .foregroundColor(.white)
//                        .background(Color(VdohnovitelyAsset.loginButtonColor.color))
//                        .cornerRadius(10)
//                }
//                .padding([.bottom], 10)
//
//                if !isRegistration {
//                    HStack(spacing: 3) {
//                        Text("Еще нет аккаунта?")
//                            .foregroundColor(.white)
//                            .font(Font.system(size: 12))
//
//                        Button {
//                            isRegistration = true
//                        } label: {
//                            Text("Зарегестрироваться")
//                                .foregroundColor(.yellow)
//                                .font(Font.system(size: 12))
//                        }
//                    }
//                }
//            }
//        }
//    }
//}
//
//
//extension View {
//    func placeholder<Content: View>(
//        when shouldShow: Bool,
//        alignment: Alignment = .leading,
//        @ViewBuilder placeholder: () -> Content) -> some View {
//
//            ZStack(alignment: alignment) {
//                placeholder().opacity(shouldShow ? 1 : 0)
//                self
//            }
//        }
//}
