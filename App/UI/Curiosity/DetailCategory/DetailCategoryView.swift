import Foundation
import SwiftUI

struct DetailCategoryView: View {

    var category = CaregoryModel(
        id: 1,
        title: "Спорт",
        text: "gjdnglfndkgj",
        imageName: "card",
        topUsers: [
            User(id: 1, login: "Алексей Попков", imageName: "card"),
            User(id: 2, login: "Миша Пупкин", imageName: "card"),
            User(id: 3, login: "Как какать", imageName: "card")
        ],
        links: [
            Link(id: 1, link: "pornhub.com", description: "лутший сайт", imageName: "card"),
            Link(id: 2, link: "pornhub.com", description: "лутший сайт", imageName: "card")
        ],
        conferences: [
            Сonference(id: 1, title: "zoom", text: "ссылка туда", date: "21.12.2001", time: "11:30"),
            Сonference(id: 2, title: "discord", text: "ссылка туда", date: "21.12.2021", time: "11:30"),
            Сonference(id: 3, title: "zoom", text: "ссылка туда", date: "21.12.2008", time: "11:30")
        ],
        masterminds: [
            User(id: 1, login: "Алексей Попков", imageName: "card"),
            User(id: 2, login: "Миша Пупкин", imageName: "card"),
            User(id: 3, login: "Как какать", imageName: "card")
        ]
    )

    var body: some View {

        VStack(alignment: .leading) {
            Text(category.title)
                .font(Font.largeTitle)
                .foregroundColor(.white)

            Text(category.text)
                .font(Font.body)
                .foregroundColor(.white)

            if !category.topUsers.isEmpty {
                Text("Топ-5 пользователей")
                    .font(Font.body)
                    .foregroundColor(.white)
            }

            VStack {
                ForEach(category.topUsers) { user in

                    ZStack {
                        Color(.red)
                            .cornerRadius(10)

                        HStack(spacing: 20) {
                            Text("1")
                                .font(Font.title)
                                .foregroundColor(.white)
                                .padding([.leading], 15)

                            Color(.white)
                                .frame(width: 2, height: 50)

                            Image(user.imageName)
                                .resizable()
                                .frame(width: 32, height: 32)
                                .cornerRadius(16)

                            Text(user.login)
                                .font(Font.headline)
                                .foregroundColor(.white)

                            Spacer()
                        }
                    }
                    .frame(
                        height: 50
                    )
                }
            }

            if !category.links.isEmpty {
                Text("Полезныйе ссылки")
                    .font(Font.body)
                    .foregroundColor(.white)
            }

            VStack {
                ForEach(category.links) { link in

                    ZStack {
                        Color(.red)
                            .cornerRadius(10)

                        HStack(spacing: 20) {
                            Image(link.imageName)
                                .resizable()
                                .frame(width: 32, height: 32)
                                .cornerRadius(16)
                                .padding([.leading], 15)

                            VStack {
                                Text(link.link)
                                    .font(Font.headline)
                                    .foregroundColor(.white)

                                Text(link.description)
                                    .font(Font.body)
                                    .foregroundColor(.white)
                            }


                            Spacer()
                        }
                    }
                    .frame(
                        height: 50
                    )
                }
            }

            if !category.conferences.isEmpty {
                Text("Коференции")
                    .font(Font.body)
                    .foregroundColor(.white)
            }

            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(category.conferences) { conference in
                        ZStack {
                            Color(.red)

                            HStack {
                                VStack(alignment: .leading) {
                                    Text(conference.title)
                                        .font(Font.headline)

                                    Text(conference.text)
                                        .font(Font.body)

                                    Spacer()

                                    HStack {
                                        Text(conference.date)
                                            .font(Font.body)

                                        Spacer()

                                        Text(conference.time)
                                            .font(Font.body)
                                    }
                                }

                                Spacer()
                            }
                        }
                        .frame(width: 221, height: 122)
                    }
                }
            }

            if !category.masterminds.isEmpty {
                Text("Вдохновители")
                    .font(Font.body)
                    .foregroundColor(.white)
            }

            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(category.masterminds) { user in
                        ZStack {
                            Image(user.imageName)
                                .resizable()
                                .cornerRadius(16)

                            VStack {
                                Spacer()

                                Text(user.login)
                                    .font(Font.headline)
                            }

                        }
                        .frame(width: 300, height: 300)
                    }
                }
            }
        }.padding([.leading, .trailing], 10)
    }
}
