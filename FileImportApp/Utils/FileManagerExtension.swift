//
//  FileUtils.swift
//  FileImportApp
//
//  Created by Suto, Evelyne on 12/05/2021.
//

import Foundation

extension FileManager {
    class var documentsDirectory: String? {
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        return paths.first
    }
    
    class func fileExists(at url: URL?) -> Bool {
        guard let url = url else { return false }
        return FileManager.default.fileExists(atPath: url.path)
    }
    
    class func save(files: [URL], folder: String, dir: String? = documentsDirectory) -> [URL] {
        guard files.count > 0, let dir = dir, let docURL = URL(string: dir) else { return [] }
        
        let dataDir = createDirectoryIfNotExists(at: docURL, folder: folder)
        
        return files.compactMap {
            copyFile($0, to: dataDir)
        }
    }
    
    class func loadFileURLs(from folder: String, dir: String? = documentsDirectory) -> [URL] {
        guard let dir = dir else { return [] }
        let url = URL(fileURLWithPath: dir)
        let dataPath = url.appendingPathComponent(folder)
        
        do {
            let fileURLs = try FileManager.default.contentsOfDirectory(at: dataPath, includingPropertiesForKeys: nil, options: [])
            return fileURLs
        } catch {
            debugPrint(error.localizedDescription)
        }
        
        return []
    }
    
    class func copyFile(_ file: URL, to folder: URL) -> URL? {
        var tempURL = URL(fileURLWithPath: folder.absoluteString)
        tempURL.appendPathComponent(file.lastPathComponent)
        do {
            if FileManager.default.fileExists(atPath: tempURL.path) {
                try FileManager.default.removeItem(atPath: tempURL.path)
            }
            try FileManager.default.copyItem(atPath: file.path, toPath: tempURL.path)
            return tempURL
        } catch {
            debugPrint(error.localizedDescription)
        }
        
        return nil
    }
    
    class func absoluteDocumentDirURL(filePath: String) -> URL? {
        guard let dir = documentsDirectory else { return nil }
        let url = URL(fileURLWithPath: dir)
        return url.appendingPathComponent(filePath)
    }
    
    class func createDirectoryIfNotExists(at url: URL, folder: String) -> URL {
        let dataPath = url.appendingPathComponent(folder)
        if !FileManager.default.fileExists(atPath: dataPath.path) {
            do {
                try FileManager.default.createDirectory(atPath: dataPath.path, withIntermediateDirectories: true, attributes: nil)
            } catch {
                debugPrint(error.localizedDescription)
            }
        }
        
        return dataPath
    }
    
    class func createDirectoryIfNotExists(at url: URL) {
        if !FileManager.default.fileExists(atPath: url.path) {
            do {
                try FileManager.default.createDirectory(atPath: url.path, withIntermediateDirectories: true, attributes: nil)
            } catch {
                debugPrint(error.localizedDescription)
            }
        }
    }
}
