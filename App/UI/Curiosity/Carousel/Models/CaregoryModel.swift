import Foundation

struct CaregoryModel: Identifiable {

    // Основное
    let id: Int
    let title: String
    let text: String
    let imageName: String


    // Дополнительное
    var topUsers = [User]()
    var links = [Link]()
    var conferences = [Сonference]()
    var masterminds = [User]()
}

struct Link: Identifiable {

    let id: Int
    let link: String
    let description: String
    let imageName: String
}

struct User: Identifiable {

    let id: Int
    let login: String
    let imageName: String
}

struct Сonference: Identifiable {

    let id: Int
    let title: String
    let text: String
    let date: String
    let time: String
}

var categories = [
    CaregoryModel(id: 0, title: "Спорт", text: "fgjkbrekjrgfjbrekjgbekbrgjkbebjkw", imageName: "card"),
    CaregoryModel(id: 1, title: "Спорт", text: "fgjkbrekjrgfjbrekjgbekbrgjkbebjkw", imageName: "card"),
    CaregoryModel(id: 2, title: "Спорт", text: "fgjkbrekjrgfjbrekjgbekbrgjkbebjkw", imageName: "card"),
    CaregoryModel(id: 3, title: "", text: "", imageName: "card"),
    CaregoryModel(id: 4, title: "", text: "", imageName: "card"),
    CaregoryModel(id: 5, title: "", text: "", imageName: "card"),
    CaregoryModel(id: 6, title: "", text: "", imageName: "card"),
    CaregoryModel(id: 7, title: "", text: "", imageName: "card")
]
