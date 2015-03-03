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
        var countNoQuestion = 0
        var power = true
    
        let otherAnswers = [
            "Я тебя не понял!",
            "Может тебе стоит отдохнуть?",
            "Попробуй сказать что-то более оригинальное!",
            "Банальщина!",
            "Говори по-русски.",
            "Не надо меня цифрами грузить!"]
    
        let conversation = [
            "Иди советуй кому-нибудь другому!",
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
            
            let inputString = input()
            var string = inputString.componentsSeparatedByString(" ")
            
            if (inputString.rangeOfString("-help") != nil) {
                println("\nHELP:\n")
                println("-exit - прекратить диалог\n-help - вызвать справку")
                return "Чем я могу быть полезен?"
            }
            
            if (inputString.rangeOfString("-exit") != nil) {
                power = false
                return "До свидания. Приятно было поболтать!"
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
                
                return otherAnswers[4]
                
            } else if !question {
                
                if countNoQuestion < 3 {
                    
                    countNoQuestion++
                    return conversation[Int(arc4random() % 4)]
                    
                } else {
                    
                    countNoQuestion = 0
                    return conversation[4]
                    
                }
                
            } else if number {
                
                return otherAnswers[5]
                
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
            
            
            return otherAnswers[Int(arc4random() % 4)]
            
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
