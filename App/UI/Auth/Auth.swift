import SwiftUI

struct AuthorizationView: View {

    @State var loginText = ""
    @State var passwordText = ""

    var body: some View {
        ZStack {
            LinearGradient(
                colors: [.red, .blue],
                startPoint: UnitPoint(x: 0, y: 0),
                endPoint: UnitPoint(x: 0, y: 1)
            )
            .padding(-50)

            VStack(alignment: .center) {
                VStack(alignment: .leading) {
                    Text("Логин")
                        .font(Font.largeTitle.bold())
                        .foregroundColor(.white)
                        .padding([.bottom], 60)

                    VStack(alignment: .leading, spacing: 5) {
                        HStack {
                            Image(systemName: "person.fill")
                                .foregroundColor(.white)

                            TextField("введите логин", text: $loginText)
                                .foregroundColor(.white)
                                .disableAutocorrection(true)
                                .accentColor(.white)
                        }

                        Color(.gray)
                            .frame(height: 1)
                    }
                    .padding([.bottom], 50)


                    VStack(alignment: .leading, spacing: 5) {
                        HStack {
                            Image(systemName: "lock.fill")
                                .foregroundColor(.white)

                            SecureField("введите пароль", text: $passwordText)
                                .foregroundColor(.white)
                                .disableAutocorrection(true)
                                .accentColor(.white)
                        }

                        Color(.gray)
                            .frame(height: 1)
                    }
                }
                .padding([.leading, .trailing], 40)
                .padding([.bottom], 40)

                Button {
                    print("ок")
                } label: {
                    Text("Логин")
                        .padding([.leading, .trailing], 130)
                        .padding([.top, .bottom], 10)
                        .foregroundColor(.white)
                        .background(.purple)
                        .cornerRadius(10)
                }

                Button {
                    print("fgknfgklj")
                } label: {
                    Text("зарегестрироваться")
                        .foregroundColor(.white)
                }

            }
        }
    }
}


