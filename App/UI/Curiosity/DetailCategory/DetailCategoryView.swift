import Foundation
import SwiftUI

extension Array where Element : Equatable {
    func index(of element: Element) -> Int? {
        for (index, item) in self.enumerated() {
            if item == element {
                return index
            }
        }

        return nil
    }
}

struct DetailCategoryView: View {

    let category: CaregoryModel

    var body: some View {

        VStack(alignment: .leading) {
            Text(category.title)
                .font(Font.largeTitle.bold())
                .foregroundColor(.white)

            Text(category.text)
                .font(Font.body)
                .foregroundColor(.white)
                .padding([.top], 3)

            if !category.topUsers.isEmpty {
                Text("Топ пользователей")
                    .font(Font.headline.bold())
                    .foregroundColor(.orange)
                    .padding([.top], 7)
            }

            VStack {
                ForEach(category.topUsers) { user in

                    ZStack {
                        Color(VdohnovitelyAsset.cardBackgroundColor.color)
                            .cornerRadius(10)
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(
                                        .orange,
                                        lineWidth: category.topUsers.index(of: user)! == 0 ? 1 : 0)
                            )

                        HStack(spacing: 20) {
                            Text("\(category.topUsers.index(of: user)! + 1)")
                                .font(Font.title2)
                                .foregroundColor(category.topUsers.index(of: user)! == 0 ? .orange : .white)
                                .padding([.leading], 15)

                            Color(.white)
                                .frame(width: 1, height: 50)

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
                    .font(Font.headline.bold())
                    .foregroundColor(.orange)
                    .padding([.top], 30)
            }

            VStack {
                ForEach(category.links) { link in
                    ZStack {
                        Color(VdohnovitelyAsset.cardBackgroundColor.color)
                            .cornerRadius(10)

                        HStack(spacing: 20) {
                            Image(link.imageName)
                                .resizable()
                                .frame(width: 65, height: 65)
                                .cornerRadius(16)
                                .padding([.leading], 15)

                            VStack(alignment: .leading) {
                                Link(destination: URL(string: link.urlString)!) {
                                    Text(link.title)
                                        .font(Font.headline)
                                        .foregroundColor(.white)
                                        .padding([.bottom], 2)
                                }

                                Text(link.description)
                                    .font(Font.caption)
                                    .foregroundColor(.white)
                            }


                            Spacer()
                        }
                    }
                    .frame(
                        height: 80
                    )
                }
            }

            if !category.conferences.isEmpty {
                Text("Коференции")
                    .font(Font.headline.bold())
                    .foregroundColor(.orange)
                    .padding([.top], 30)
            }

            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(category.conferences) { conference in
                        ZStack {
                            Color(VdohnovitelyAsset.cardBackgroundColor.color)
                                .cornerRadius(10)

                            HStack {
                                VStack(alignment: .leading) {

                                    Link(destination: URL(string: conference.urlString)!) {
                                        Text(conference.title)
                                            .font(Font.headline.bold())
                                            .foregroundColor(.white)
                                    }

                                    Text(conference.text)
                                        .font(Font.caption)
                                        .foregroundColor(.white)
                                        .padding([.top], 5)

                                    Spacer()

                                    HStack {
                                        Image(systemName: "calendar")
                                            .frame(width: 13, height: 13)
                                            .foregroundColor(.white)

                                        Text(conference.date)
                                            .font(Font.caption)
                                            .foregroundColor(.white)

                                        Spacer()

                                        Image(systemName: "clock")
                                            .frame(width: 13, height: 13)
                                            .foregroundColor(.white)

                                        Text(conference.time)
                                            .font(Font.caption)
                                            .foregroundColor(.white)
                                    }
                                }
                                .padding([.top, .bottom, .leading], 10)

                                Spacer()
                            }
                        }
                        .frame(width: 221, height: 122)
                    }
                }
            }

            if !category.masterminds.isEmpty {
                Text("Вдохновители")
                    .font(Font.headline.bold())
                    .foregroundColor(.orange)
                    .padding([.top], 30)
            }

            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(category.masterminds) { user in
                        ZStack {
                            Image(user.imageName)
                                .resizable()
                                .clipped()

                            Color(.black.withAlphaComponent(0.5))

                            VStack(alignment: .leading) {
                                Spacer()

                                Text(user.login)
                                    .font(Font.headline.bold())
                                    .foregroundColor(.white)

                                Text(user.description)
                                    .font(Font.body)
                                    .foregroundColor(.white)
                                    .padding([.bottom], 10)
                            }
                            .padding([.leading, .trailing], 10)

                        }
                        .frame(width: 300, height: 300)
                        .cornerRadius(16)

                    }
                }
            }
        }
        .padding([.leading, .trailing], 10)
        .background(.clear)
    }
}

struct DetailCategoryView_Previews: PreviewProvider {
    static var previews: some View {
        DetailCategoryView(category: SuperModel)
    }
}
