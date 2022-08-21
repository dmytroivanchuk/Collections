//
//  DictionaryOperation.swift
//  Collections
//
//  Created by Dmytro Ivanchuk on 19.08.2022.
//

class DictionaryOperation {

    let description: String
    var status = DictionaryOperationStatus.idle
    let closureToExecute: ([(String, String)], [String: String]) -> String?

    init(description: String, closureToExecute: @escaping ([(String, String)], [String: String]) -> String?) {
        self.description = description
        self.closureToExecute = closureToExecute
    }
}
