//
//  SetProcessingModel.swift
//  Collections
//
//  Created by Dmytro Ivanchuk on 15.08.2022.
//

struct SetProcessingModel {
    
    func executeOperation(withIdentifier identifier: String, _ string1: String?, _ string2: String?) -> String {
        if let str1 = string1, let str2 = string2 {
            
            switch identifier {
            case "matchingCharacters":
                return String(Set(str1).intersection(Set(str2)))
            case "nonMatchingCharacters":
                return String(Set(str1).symmetricDifference(Set(str2)))
            case "uniqueCharacters":
                return String(Set(str1).subtracting(Set(str2)))
            default:
                return ""
            }
        } else {
            return ""
        }
    }
}
