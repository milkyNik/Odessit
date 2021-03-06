//
//  Odessit.swift
//  Odessit
//
//  Created by iMac on 03.03.15.
//  Copyright (c) 2015 MilNik. All rights reserved.
//

import Foundation


class Odessit {
        
        let name = "Odessit"
        var countNoQuestion = 0 // the number of claims
        var power = true // exit
        var lastQuestion = "" // repetition
    
        let otherAnswers = [
            "Я тебя не понял!",
            "Может тебе стоит подумать над вопросом?",
            "Кто занимался твоим воспитанием?",
            "Хватит болтать! Спрашивай по-существу!",
            "Попробуй сказать что-то более оригинальное!",
            "Бла-бла-бла!",
            "Ты тратишь мое время!",
            "Банальщина!",
            "Говори по-русски.",
            "Не надо меня цифрами грузить!",
            "Ты повторяешься!"]
    
        let conversation = [
            "Иди советуй кому-нибудь другому!",
            "Я слышу агрессию в голосе. Или мне показалось?",
            "Не надо меня пытаться унизить!",
            "Это разве вопрос?",
            "В следующий раз думай, что говоришь!",
            "Ты не догоняешь? Я же тебе говорил, что буду только отвечать на вопросы, а не болтать тут с тобой!"]
    
        func input() -> String {
            
            var keyboard = NSFileHandle.fileHandleWithStandardInput()
            var inputData = keyboard.availableData
            
            if NSString(data: inputData, encoding:NSUTF8StringEncoding) != nil {
                
                return NSString(data: inputData, encoding:NSUTF8StringEncoding)!
                
            }
            
            return ""
            
        }
    
        func usersQuestions() -> String {
            
            let inputString = input().lowercaseString
            var string = inputString.componentsSeparatedByString(" ")
            
            if inputString.hasPrefix("-help") || inputString.hasPrefix("-h") {
                println("\nHELP:\n")
                println("-exit(-e) - прекратить диалог\n-help(-h) - вызвать справку")
                return "Чем я могу быть полезен?"
            }
            
            if inputString.hasPrefix("-exit") || inputString.hasPrefix("-e") {
                power = false
                return "До свидания. Приятно было поболтать!"
            }
            
            if inputString == lastQuestion {
                
                return otherAnswers[10]
                
            } else {
                
                lastQuestion = inputString
                
            }
            
            var count = 0
            var rus = true
            var question = true
            var number = false
            
            for ch in inputString.lowercaseString {
                
                switch ch {
            
                case "а"..."я":
                    rus = true
                case "a"..."z":
                    rus = false
                case "!":
                    question = false
                case "0"..."9":
                    number = true
                default:break
                    
                }
            }
            
            if !rus {
                
                return otherAnswers[8]
                
            } else if !question {
                
                if countNoQuestion < 3 {
                    
                    countNoQuestion++
                    return conversation[Int(arc4random() % 5)]
                    
                } else {
                    
                    countNoQuestion = 0
                    return conversation[5]
                    
                }
                
            } else if number {
                
                return otherAnswers[9]
                
            } else {
                
                for word in string {
                
                switch word {
                    
                case let word where word == "ты" || word == "тебе":
                    
                    string.removeAtIndex(count)
                    string.insert(word, atIndex: 0)
                    
                    var questionString = "А "
                        
                        for str in string {
                            questionString += str + " "
                        }
                        
                    return questionString
                    
                case let word where word == "у":
                    
                    var str = String()
                    var questionString = "А у "
                    
                    string.removeAtIndex(count)
                    str = string[count]
                    string.removeAtIndex(count)
                    
                    questionString += str + " "
                    
                        for str in string {
                            questionString += str + " "
                        }
                    
                    return questionString
                    
                case let word where word == "тебя":
                    
                    string.removeAtIndex(count)
                    string.insert(word, atIndex: 0)
                    
                    var questionString = "А "
                    
                        for str in string {
                            questionString += str + " "
                        }
                    
                    return questionString
                    
                default:break
                    
                    }
                
               count++
                    
                }
                
            }
            
            return otherAnswers[Int(arc4random() % 8)]
            
        }
        
        func chat() -> () {
            
            let stringAnswer = usersQuestions()
            println("\n" + "\(name): " + stringAnswer + "\n")
            
            if power {
                
               chat()
                
            }
        }
        
    init(){
        println("Меня зовут \(name).\nХорошенько подумай, перед тем как задавать мне вопросы!\n")
    }
}
