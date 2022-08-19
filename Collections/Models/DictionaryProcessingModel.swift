//
//  DictionaryProcessingModel.swift
//  Collections
//
//  Created by Dmytro Ivanchuk on 19.08.2022.
//

import Foundation

class DictionaryProcessingModel {
    var array: [(String, String)] = []
    var dictionary: [String: String] = [:]
    var dictionaryGenerationStatus = DictionaryOperationStatus.idle
    var dictionaryOperations: [DictionaryOperation] = [
        
        DictionaryOperation(description: "Find the first contact", closureToExecute: { array, _ in
            array.first { $0.0 == "Name0" }?.1
        }),
        
        DictionaryOperation(description: "Find the first contact", closureToExecute: { _, dictionary in
            dictionary["Name0"]
        }),
        
        DictionaryOperation(description: "Find the last contact", closureToExecute: { array, _ in
            array.first { $0.0 == "Name9999999" }?.1
        }),
        
        DictionaryOperation(description: "Find the last contact", closureToExecute: { _, dictionary in
            dictionary["Name9999999"]
        }),
        
        DictionaryOperation(description: "Find the non-existing element", closureToExecute: { array, _ in
            array.first { $0.0 == "NameQwerty" }?.1
        }),
        
        DictionaryOperation(description: "Find the non-existing element", closureToExecute: { _, dictionary in
            dictionary["NameQwerty"]
        })
    ]

    func generateDictionaryArray(completionHandler: @escaping () -> Void) {
        dictionaryGenerationStatus = .executing
        
        DispatchQueue.global(qos: .userInitiated).async {
            
            let dictionaryArrayGenerationTime = self.measureExecutionTime {
                for int in 0 ..< 10_000_000 {
                    self.array.append(("Name\(int)", String(int)))
                    self.dictionary.updateValue(String(int), forKey: "Name\(int)")
                }
            }
            DispatchQueue.main.async {
                self.dictionaryGenerationStatus = .finished(executionTime: dictionaryArrayGenerationTime, resultNumber: "None")
                completionHandler()
            }
        }
    }
    
    func executeOperation(_ operation: DictionaryOperation, completion completionHandler: @escaping () -> Void) {
        operation.status = .executing
        
        DispatchQueue.global(qos: .userInitiated).async {
            let executionTimeAndResultNumber = self.measureExecutionTimeAndSearchNumber {
                operation.closureToExecute(self.array, self.dictionary)
            }
            DispatchQueue.main.async {
                operation.status = .finished(executionTime: executionTimeAndResultNumber.0, resultNumber: executionTimeAndResultNumber.1 ?? "Not Found")
                completionHandler()
            }
        }
    }

    func measureExecutionTime(_ closureToExecute: () -> Void) -> Double {
        let startExecutionTime = CFAbsoluteTimeGetCurrent()
        closureToExecute()
        let finishExecutionTime = CFAbsoluteTimeGetCurrent()

        return finishExecutionTime - startExecutionTime
    }
    
    func measureExecutionTimeAndSearchNumber(_ closureToExecute: () -> String?) -> (Double, String?) {
        let startExecutionTime = CFAbsoluteTimeGetCurrent()
        let resultNumber = closureToExecute()
        let finishExecutionTime = CFAbsoluteTimeGetCurrent()

        return (finishExecutionTime - startExecutionTime, resultNumber)
    }
}

enum DictionaryOperationStatus: Equatable {
    case idle
    case executing
    case finished(executionTime: Double, resultNumber: String)
}
