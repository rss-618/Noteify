//
//  SharedModelContainer.swift
//  Noteify
//
//  Created by Ryan Schildknecht on 1/25/25.
//

import Foundation
import SwiftData

protocol SwiftDataService {
    func fetchNotepads(predicate: Predicate<Notepad>?, sortBy: [SortDescriptor<Notepad>]) -> [Notepad]
    func addNotepad(_ expense: Notepad)
}

extension SwiftDataService {
    func fetchNotepads(predicate: Predicate<Notepad>? = nil,
                       sortBy: [SortDescriptor<Notepad>] = .init()) -> [Notepad] {
        self.fetchNotepads(predicate: predicate, sortBy: sortBy)
    }
}


extension SwiftDataService where Self == SwiftDataServiceImpl {
    @MainActor
    static var live: SwiftDataServiceImpl {
        SwiftDataServiceImpl.shared
    }
}
