//
//  ArrayProcessingModel.swift
//  Collections
//
//  Created by Dmytro Ivanchuk on 11.08.2022.
//

import Foundation

class ArrayProcessingModel {
    var array: [Int] = []
    var arrayGenerationStatus = OperationStatus.idle
    let arrayOperations = [
        
        Operation(description: "Insert 1000 elements at the beginning of the array one-by-one.", closureToExecute: {
            var newArray = $0
            for int in 0 ..< 1000 {
                newArray.insert(int, at: 0)
            }
        }),
        
        Operation(description: "Insert 1000 elements at the beginning of the array at once.", closureToExecute: {
            var newArray = $0
            newArray.insert(contentsOf: 0 ..< 1000, at: 0)
        }),
        
        Operation(description: "Insert 1000 elements in the middle of the array one-by-one.", closureToExecute: {
            var newArray = $0
            for int in 0 ..< 1000 {
                newArray.insert(int, at: newArray.count / 2)
            }
        }),
        
        Operation(description: "Insert 1000 elements in the middle of the array at once.", closureToExecute: {
            var newArray = $0
            newArray.insert(contentsOf: 0 ..< 1000, at: newArray.count / 2)
        }),
        
        Operation(description: "Insert 1000 elements at the end of the array one-by-one.", closureToExecute: {
            var newArray = $0
            for int in 0 ..< 1000 {
                newArray.append(int)
            }
        }),
        
        Operation(description: "Insert 1000 elements at the end of the array at once.", closureToExecute: {
            var newArray = $0
            newArray.append(contentsOf: 0 ..< 1000)
        }),
        
        Operation(description: "Remove 1000 elements at the beginning of the array one-by-one.", closureToExecute: {
            var newArray = $0
            for _ in 0 ..< 1000 {
                newArray.remove(at: 0)
            }
        }),
        
        Operation(description: "Remove 1000 elements at the beginning of the array at once.", closureToExecute: {
            var newArray = $0
            newArray.removeSubrange(0 ..< 1000)
        }),
        
        Operation(description: "Remove 1000 elements in the middle of the array one-by-one.", closureToExecute: {
            var newArray = $0
            for _ in 0 ..< 1000 {
                newArray.remove(at: newArray.count / 2)
            }
        }),
        
        Operation(description: "Remove 1000 elements in the middle of the array at once.", closureToExecute: {
            var newArray = $0
            newArray.removeSubrange(newArray.count / 2 ..< newArray.count / 2 + 1000)
        }),
        
        Operation(description: "Remove 1000 elements at the end of the array one-by-one.", closureToExecute: {
            var newArray = $0
            for _ in 0 ..< 1000 {
                newArray.removeLast()
            }
        }),
        
        Operation(description: "Remove 1000 elements at the end of the array at once.", closureToExecute: {
            var newArray = $0
            newArray.removeSubrange(newArray.count - 1000 ..< newArray.count)
        })
    ]

    func generateArray(initialization initializationHandler: () -> Void, completion completionHandler: @escaping () -> Void) {
        arrayGenerationStatus = .executing
        initializationHandler()
        
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
    
    func executeOperation(_ operation: Operation, initialization initializationHandler: () -> Void, completion completionHandler: @escaping () -> Void) {
        operation.status = .executing
        initializationHandler()
        
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

enum OperationStatus: Equatable {
    case idle
    case executing
    case finished(executionTime: Double)
}
