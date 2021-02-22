//
//  Answer.swift
//  NatPersonalQuiz
//
//  Created by HappyLiya on 07.02.2021.
//

struct Answer {
    let text: String
    let type: AnimalType
}

enum AnimalType: Character {
    case cat = "🐱"
    case dog = "🐶"
    case rabbit = "🐰"
    case turtle = "🐢"
    
    var definition: String {
        switch self {
        
        case .cat:
            return "Вы себе на уме. Любите гулять сами по себе. Вы цените одиночество."
        case .dog:
            return "Вам нравится быть с друзьями. Вы окружаете себя людьми, которые вам нравятся и всегда готовы помочь"
        case .rabbit:
        return "Вам нравится всё мягкое. Вы здоровы и полны энергии."
        case .turtle:
        return "Ваша сила - в мудрости. Медленный и вдумчивый выигрывает на больших дистанциях."
        }
}
}
