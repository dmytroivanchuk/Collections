//
//  DictionaryArrayOperation.swift
//  Collections
//
//  Created by Dmytro Ivanchuk on 19.08.2022.
//

class DictionaryArrayOperation {

    let description: String
    var status = DictionaryArrayOperationStatus.idle
    let closureToExecute: ([(String, String)], [String: String]) -> String?

    init(description: String, closureToExecute: @escaping ([(String, String)], [String: String]) -> String?) {
        self.description = description
        self.closureToExecute = closureToExecute
    }
}
