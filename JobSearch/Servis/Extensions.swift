//
//  Extensions.swift
//  JobSearch
//
//  Created by Vasiliy Vygnych on 13.11.2023.
//

import Foundation

extension String {
    var htmlToString: NSAttributedString? {
        guard let data = data(using: .utf8) else { return nil }
        do {
            return try NSAttributedString(data: data,
                                          options: [.documentType: NSAttributedString.DocumentType.html,
                                                    .characterEncoding: String.Encoding.utf8.rawValue],
                                          documentAttributes: nil)
        }
        catch {
            return nil
        }
    }
}

extension Data {
    func prettyPrintJson() {
        do {
            let json = try JSONSerialization.jsonObject(with: self,
                                                        options: [])
            let data = try JSONSerialization.data(withJSONObject: json,
                                                  options: .prettyPrinted)
            guard let jsonString = String(data: data,
                                          encoding: .utf8) else {
                print("Inavlid data")
                return
            }
            print(jsonString)
        } catch {
            print("Error: \(error.localizedDescription)")
        }
    }
}
