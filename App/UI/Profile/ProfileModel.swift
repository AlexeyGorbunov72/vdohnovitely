import Foundation
import SwiftUI

struct ProfileModel {
  var name: String
  var familyName: String
  var about: String
  let image: UIImage?
  let achievements: [AchievementModel]
  let goalsCart: ChartsStatModel
  let dreamsCart: ChartsStatModel
}

struct AchievementModel: Identifiable {
  let id: Int
  let completed: Bool
  let image: UIImage
}

struct ChartsStatModel {
  let completedCount: Int
  let count: Int
}

extension ProfileModel {
  static let stub = ProfileModel(
    name: "Алексей",
    familyName: "Геннадиевич",
    about: "Ещё очень люблю хорошую погоду. Когда просыпаешься, а сквозь ещё закрытые веки солнечные лучи. Вот это я люблю!",
    image: VdohnovitelyAsset.profileTestImage.image,
    achievements: [
      AchievementModel(
        id: 1,
        completed: true,
        image: VdohnovitelyAsset.achivmentIcon1.image
      ),
      AchievementModel(
        id: 2,
        completed: true,
        image: VdohnovitelyAsset.achivmentIcon2.image
      ),
      AchievementModel(
        id: 3,
        completed: false,
        image: VdohnovitelyAsset.achivmentIcon3.image
      ),
      AchievementModel(
        id: 4,
        completed: false,
        image: VdohnovitelyAsset.achivmentIcon4.image
      ),
      AchievementModel(
        id: 5,
        completed: false,
        image: VdohnovitelyAsset.achivmentIcon5.image
      ),
    ],
    goalsCart: ChartsStatModel(completedCount: 4, count: 20),
    dreamsCart: ChartsStatModel(completedCount: 2, count: 10)
  )

  static let stub2 = ProfileModel(
    name: "",
    familyName: "",
    about: "",
    image: nil,
    achievements: [
      AchievementModel(
        id: 1,
        completed: true,
        image: VdohnovitelyAsset.achivmentIcon1.image
      ),
      AchievementModel(
        id: 2,
        completed: true,
        image: VdohnovitelyAsset.achivmentIcon2.image
      ),
      AchievementModel(
        id: 3,
        completed: false,
        image: VdohnovitelyAsset.achivmentIcon3.image
      ),
      AchievementModel(
        id: 4,
        completed: false,
        image: VdohnovitelyAsset.achivmentIcon4.image
      ),
      AchievementModel(
        id: 5,
        completed: false,
        image: VdohnovitelyAsset.achivmentIcon5.image
      ),
    ],
    goalsCart: ChartsStatModel(completedCount: 30, count: 40),
    dreamsCart: ChartsStatModel(completedCount: 2, count: 10)
  )
}
