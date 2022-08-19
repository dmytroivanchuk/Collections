//
//  ArrayProcessingModel.swift
//  Collections
//
//  Created by Dmytro Ivanchuk on 11.08.2022.
//

import Foundation

class ArrayProcessingModel {
    var array: [Int] = []
    var arrayGenerationStatus = ArrayOperationStatus.idle
    let arrayOperations = [
        
        ArrayOperation(description: "Insert 1000 elements at the beginning of the array one-by-one.", closureToExecute: {
            var newArray = $0
            for int in 0 ..< 1000 {
                newArray.insert(int, at: 0)
            }
        }),
        
        ArrayOperation(description: "Insert 1000 elements at the beginning of the array at once.", closureToExecute: {
            var newArray = $0
            newArray.insert(contentsOf: 0 ..< 1000, at: 0)
        }),
        
        ArrayOperation(description: "Insert 1000 elements in the middle of the array one-by-one.", closureToExecute: {
            var newArray = $0
            for int in 0 ..< 1000 {
                newArray.insert(int, at: newArray.count / 2)
            }
        }),
        
        ArrayOperation(description: "Insert 1000 elements in the middle of the array at once.", closureToExecute: {
            var newArray = $0
            newArray.insert(contentsOf: 0 ..< 1000, at: newArray.count / 2)
        }),
        
        ArrayOperation(description: "Insert 1000 elements at the end of the array one-by-one.", closureToExecute: {
            var newArray = $0
            for int in 0 ..< 1000 {
                newArray.append(int)
            }
        }),
        
        ArrayOperation(description: "Insert 1000 elements at the end of the array at once.", closureToExecute: {
            var newArray = $0
            newArray.append(contentsOf: 0 ..< 1000)
        }),
        
        ArrayOperation(description: "Remove 1000 elements at the beginning of the array one-by-one.", closureToExecute: {
            var newArray = $0
            for _ in 0 ..< 1000 {
                newArray.remove(at: 0)
            }
        }),
        
        ArrayOperation(description: "Remove 1000 elements at the beginning of the array at once.", closureToExecute: {
            var newArray = $0
            newArray.removeSubrange(0 ..< 1000)
        }),
        
        ArrayOperation(description: "Remove 1000 elements in the middle of the array one-by-one.", closureToExecute: {
            var newArray = $0
            for _ in 0 ..< 1000 {
                newArray.remove(at: newArray.count / 2)
            }
        }),
        
        ArrayOperation(description: "Remove 1000 elements in the middle of the array at once.", closureToExecute: {
            var newArray = $0
            newArray.removeSubrange(newArray.count / 2 ..< newArray.count / 2 + 1000)
        }),
        
        ArrayOperation(description: "Remove 1000 elements at the end of the array one-by-one.", closureToExecute: {
            var newArray = $0
            for _ in 0 ..< 1000 {
                newArray.removeLast()
            }
        }),
        
        ArrayOperation(description: "Remove 1000 elements at the end of the array at once.", closureToExecute: {
            var newArray = $0
            newArray.removeSubrange(newArray.count - 1000 ..< newArray.count)
        })
    ]

    func generateArray(completion completionHandler: @escaping () -> Void) {
        arrayGenerationStatus = .executing
        
        DispatchQueue.global(qos: .userInitiated).async {
            
            let arrayGenerationTime = self.measureExecutionTime {
                for int in 0 ..< 10_000_000 {
                    self.array.append(int)
                }
            }
            DispatchQueue.main.async {
                self.arrayGenerationStatus = .finished(executionTime: arrayGenerationTime)
                completionHandler()
            }
        }
    }
    
    func executeOperation(_ operation: ArrayOperation, completion completionHandler: @escaping () -> Void) {
        operation.status = .executing
        
        DispatchQueue.global(qos: .userInitiated).async {
            let executionTime = self.measureExecutionTime {
                operation.closureToExecute(self.array)
            }
            DispatchQueue.main.async {
                operation.status = .finished(executionTime: executionTime)
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
}

enum ArrayOperationStatus: Equatable {
    case idle
    case executing
    case finished(executionTime: Double)
}
