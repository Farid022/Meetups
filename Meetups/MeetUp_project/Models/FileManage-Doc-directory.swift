//
//  FileManage-Doc-directory.swift
//  Meetups
//
//  Created by Muhammad Farid Ullah on 19/01/2023.
//

import Foundation
//to support loading and saving of data for future use and to be persistent.
extension FileManager {
    //create a URL to a file in our documents directory wherever we want.
    static var documentsDirectory: URL {
            let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
            return paths[0]
        }
}
