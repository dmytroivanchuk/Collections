//
//  ArrayOperation.swift
//  Collections
//
//  Created by Dmytro Ivanchuk on 11.08.2022.
//

class ArrayOperation {
    let description: String
    let closureToExecute: ([Int]) -> Void
    var status = ArrayOperationStatus.idle
    
    init(description: String, closureToExecute: @escaping ([Int]) -> Void) {
        self.description = description
        self.closureToExecute = closureToExecute
    }
}
