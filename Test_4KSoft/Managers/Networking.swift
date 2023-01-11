//
//  Networking.swift
//  Test_4KSoft
//
//  Created by  Sasha Khomenko on 10.01.2023.
//


import Foundation

class JsonManager {
    
    static let shared = JsonManager()
    
    func fetchEquipment(success: @escaping ([Door]) -> (), failure: @escaping (String) -> ()) {
        if let localData = self.readLocalFile(forName: "Doors") {
            let demoData = self.getEquipment(jsonData: localData)
            demoData != nil ? success(demoData!) : failure("Oops! Something went wrong.")
        }
    }
    
    private func readLocalFile(forName name: String) -> Data? {
        do {
            if let bundlePath = Bundle.main.path(forResource: name,ofType: "json"),
               let jsonData = try String(contentsOfFile: bundlePath).data(using: .utf8) {
                return jsonData
            }
        } catch {
            print("JSON Read Error:\(error.localizedDescription)")
        }
        return nil
    }
    
    // Decode Equipment
    private func getEquipment(jsonData: Data) -> [Door]? {
        do {
            let decodedData = try JSONDecoder().decode([Door].self,from: jsonData)
            return decodedData
        } catch {
            print("JSON Parse error: \(error.localizedDescription)")
            return nil
        }
    }
}
