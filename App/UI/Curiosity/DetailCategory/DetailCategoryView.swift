import Foundation
import SwiftUI
import LinkPresentation

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
    @State var redrawPreview = false

    var body: some View {

        VStack(alignment: .leading) {

            Group {
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
                Text("Полезные ссылки")
                    .font(Font.headline.bold())
                    .foregroundColor(.orange)
                    .padding([.top], 30)
            }

            VStack {
                ForEach(category.links) { link in
                    LinkRow(previewURL: URL(string: link.urlString)!, redraw: self.$redrawPreview)
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

struct LinkRow : UIViewRepresentable {

    var previewURL:URL
    @Binding var redraw: Bool

    func makeUIView(context: Context) -> LPLinkView {
        let view = LPLinkView(url: previewURL)

        let provider = LPMetadataProvider()
        provider.startFetchingMetadata(for: previewURL) { (metadata, error) in
            if let md = metadata {
                DispatchQueue.main.async {
                    view.metadata = md
                    view.sizeToFit()
                    self.redraw.toggle()
                }
            }
        }

        return view
    }

    func updateUIView(_ view: LPLinkView, context: Context) {}
}
