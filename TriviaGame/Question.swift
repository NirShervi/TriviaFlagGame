//
//  Question.swift
//  TriviaGame
//
//  Created by Nir Shervi on 26/05/2022.
//

import Foundation

struct Question: Codable {
    
    var answer1: String
    var answer2: String
    var answer3: String
    var answer4: String
    var image: String
    var correct: Int
    
}
