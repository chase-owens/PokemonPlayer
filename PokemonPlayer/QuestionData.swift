//
//  QuestionData.swift
//  PokemonPlayer
//
//  Created by Chase Owens on 12/12/17.
//  Copyright © 2017 Chase Owens. All rights reserved.
//

import Foundation

struct Question {
    var text: String
    var responseType: ResponseType
    var answers: [Answer]
}
    
enum ResponseType {
    case single, multiple, range
}


struct Answer {
    var text: String
    var type: PokemonCharacters
}

//Altaria: others > self, Blissy: sensitive to others feelings, Zygaarde: protector of ecosystem, Bronzon: people think you're a diety
enum PokemonCharacters {
    case Abomasnow, Blissy, Zygarde, Bronzon
    
    var description: String {
        switch self {
        case .Abomasnow:
            return "You enjoy being in anywhere in nature, but if they aren't now, the mountains is where you will eventually call home. "
        case .Blissy:
            return "You are a true empath. Like Blissy, you are more sensitive to others feelings than you are your own. You spend your time uplifting others more than yourself."
        case .Zygarde:
            return "You spend a lot of time reflecting on life and what you can do to improve the world today. Like Zygarda, protecting the ecosystem drives you."
        case .Bronzon:
            return "You could be from out of this world, yet you cherish this world. Most who get to know you think you're a diety."
        }
    }
    
    
}
