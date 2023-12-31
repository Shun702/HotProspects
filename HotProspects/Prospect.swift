//
//  Prospect.swift
//  HotProspects
//
//  Created by Shun Le Yi Mon on 09/09/2023.
//

import SwiftUI

class Prospect: Identifiable, Codable {
    var id = UUID()
    var name = "Anonymous"
    var emailAddress = ""
    fileprivate(set) var isContacted = false
}
    @MainActor class Prospects: ObservableObject {
        @Published private(set) var people: [Prospect]
        let saveKey = "SavedData"
        
        init() {
            if let data = UserDefaults.standard.data(forKey: saveKey) {
                if let decoded = try? JSONDecoder().decode([Prospect].self, from: data) {
                    people = decoded
                    return
                }
            }
            
            people = []
        }
        
        func toggle(_ prospect: Prospect) {
            objectWillChange.send()
            prospect.isContacted.toggle()
            save()
        }
        
        private func save() {
            if let encoded = try? JSONEncoder().encode(people) {
                UserDefaults.standard.set(encoded, forKey: saveKey)
            }
        }
        
        func add(_ prospect: Prospect) {
            people.append(prospect)
            save()
        }
    }
