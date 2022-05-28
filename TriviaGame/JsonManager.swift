//
//  JsonManager.swift
//  TriviaGame
//
//  Created by Nir Shervi on 26/05/2022.
//
import Foundation

public class JsonManager {
    
    var question = [Question]()
    
    init(){
        load()
    }
    
    func load(){
        
        if let fileLocation = Bundle.main.url(forResource: "questionBank", withExtension: "json"){
            
            do{
                let data = try Data(contentsOf: fileLocation)
                let jsonDecoder = JSONDecoder()
                let dataFromJson = try jsonDecoder.decode([Question].self, from: data)
                
                self.question = dataFromJson
            } catch {
                print(error)
            }
        }
        
    }
    
    func sort() {
        
        self.question = self.question.sorted(by: { $0.correct < $1.correct })
        
    }
}
