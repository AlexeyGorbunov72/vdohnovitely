import Foundation

let SuperModel = CaregoryModel(
    id: 0,
    title: "Sound design",
    text: "Мы постоянно окружены звуками: повседневные дела, кино, телевидение или радиовещание. Звук – это одна из важнейших частей нашего восприятия окружающей среды, нашей картины мира.",
    imageName: "soundDesign",
    topUsers: [
        User(id: 1, login: "Алексей Попков", imageName: "man1"),
        User(id: 2, login: "Даниил Акулов", imageName: "man2"),
        User(id: 3, login: "Анатолий Янчев", imageName: "man3")
    ],
    links: [
        LinkOnMaterial(
            id: 1,
            title: "Sound design на Wiki",
            urlString: "https://ru.wikipedia.org/wiki/%D0%97%D0%B2%D1%83%D0%BA%D0%BE%D0%B2%D0%BE%D0%B9_%D0%B4%D0%B8%D0%B7%D0%B0%D0%B9%D0%BD",
            description: "Звуковой дизайн (саунд-дизайн) — это процесс определения, управления или создания звуковых элементов",
            imageName: "soundDesign2"
        ),
        LinkOnMaterial(
            id: 2,
            title: "Язык звук. дизайна",
            urlString: "https://wiki5.ru/wiki/Kyma_(sound_design_language)",
            description: "Kyma - это язык визуального программирования для звукового дизайна",
            imageName: "soundDesign3"
        )
    ],
    conferences: [
        Сonference(
            id: 1,
            title: "zoom",
            urlString: "https://zoom.us/",
            text: "Обсуждаем как не перегорать и продолжать сочинять музыку несмотря ни на что",
            date: "21.12.2022",
            time: "11:30"
        ),
        Сonference(
            id: 2,
            title: "discord",
            urlString: "https://discord.com/",
            text: "Просто общаемся на наболевшие темы",
            date: "04.09.2022",
            time: "18:00"
        ),
        Сonference(
            id: 3,
            title: "zoom",
            urlString: "https://zoom.us/",
            text: "ссылка туда",
            date: "24.10.2022",
            time: "20:00"
        )
    ],
    masterminds: [
        User(
            id: 1,
            login: "Александр Иванов",
            imageName: "man4",
            description: "Музыкант, участник группы Dead Cat"
        ),
        User(
            id: 2,
            login: "Михаил Борисович",
            imageName: "man5",
            description: "Профессиональный режисер, основатель школы FreeSound"
        ),
        User(
            id: 3,
            login: "Виталий",
            imageName: "man6",
            description: "Музыкант любитель, организатор sound ивентов в Москве"
        )
    ]
)

let SuperCategories = [
    SuperModel,
    CaregoryModel(
        id: 1,
        title: "Исскуство",
        text: "Иску́сство (от церк.-слав. искусьство, ст.‑слав. искоусъ — искушение, опыт, испытание) — одна из наиболее общих категорий эстетики, искусствознания и художественной практики. Обычно под искусством подразумевают образное осмысление действительности; процесс и итог выражения внутреннего и внешнего",
        imageName: "isskustvo"
    ),

    CaregoryModel(
        id: 2,
        title: "Теннис",
        text: "Те́ннис (англ. tennis) или большо́й теннис — вид спорта, в котором соперничают либо два игрока («одиночная игра»), либо две команды, состоящие из двух игроков («парная игра»). ",
        imageName: "card"
    ),
    CaregoryModel(
        id: 3,
        title: "Break dance",
        text: "Брейк-данс (англ. breakdance) — спортивный стиль уличных танцев, созданный в США афроамериканской и пуэрториканской молодёжью в начале 1970-х годов. К концу семидесятых танец начал распространяться в других сообществах и становился всё более популярным.",
        imageName: "dance"
    ),
    CaregoryModel(
        id: 4,
        title: "Каллиграфия",
        text: "Каллигра́фия (от греч. καλλιγραφία — «красивое письмо») — одна из отраслей изобразительного искусства. Ещё каллиграфию часто называют искусством красивого письма. Современное определение каллиграфии звучит следующим образом: «искусство оформления знаков в экспрессивной, гармоничной и искусной манере».",
        imageName: "kall"
    )
]


struct CaregoryModel: Identifiable, Equatable {
    // Основное
    let id: Int
    let title: String
    let text: String
    let imageName: String


    // Дополнительное
    var topUsers = [User]()
    var links = [LinkOnMaterial]()
    var conferences = [Сonference]()
    var masterminds = [User]()
}

struct LinkOnMaterial: Identifiable, Equatable {

    let id: Int
    let title: String
    let urlString: String
    let description: String
    let imageName: String
}

struct User: Identifiable, Equatable {

    let id: Int
    let login: String
    let imageName: String
    var description: String = ""
}

struct Сonference: Identifiable, Equatable {

    let id: Int
    let title: String
    let urlString: String
    let text: String
    let date: String
    let time: String
}
