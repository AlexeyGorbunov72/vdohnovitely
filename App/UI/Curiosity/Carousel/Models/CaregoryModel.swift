import Foundation

struct CaregoryModel: Identifiable {
    var id: Int
    var title: String
    var text: String
    var imageName: String
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
