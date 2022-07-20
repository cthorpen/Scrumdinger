//
//  ScrumStore.swift
//  Scrumdinger
//
//  Created by Cole Thorpen on 7/20/22.
//

import Foundation

// ObservableObject is a class-constrained protocol for connecting external model data to SwiftUI views.
class ScrumStore: ObservableObject {
    /// An ObservableObject includes an objectWillChange publisher that emits when one of its
    /// @Published properties is about to change. Any view observing an instance of
    /// ScrumStore will render again when the scrums value changes.
    @Published var scrums: [DailyScrum] = []
    
    private static func fileURL() throws -> URL {
        // You use the shared instance of the FileManager class to
        // get the location of the Documents directory for the current user.
        try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
            .appendingPathComponent("scrums.data") // to return the URL of a file named scrums.data.
    }
    
    /// Result is a single type that represents the outcome of an operation,
    /// whether it’s a success or failure. The load function accepts a
    /// completion closure that it calls asynchronously with either an array of scrums or an error.
    static func load(completion: @escaping (Result<[DailyScrum], Error>) -> Void) {
        DispatchQueue.global(qos: .background).async {
            do {
                let fileURL = try fileURL()
                //file handle for reading scrums.data
                /// Because scrums.data doesn’t exist when a user launches the
                /// app for the first time, you call the completion handler with
                /// an empty array if there’s an error opening the file handle.
                guard let file = try? FileHandle(forReadingFrom: fileURL) else {
                    DispatchQueue.main.async {
                        completion(.success([]))
                    }
                    return
                }
                // decode files available data
                let dailyScrums = try JSONDecoder().decode([DailyScrum].self, from: file.availableData)
                // pass decoded scrums to completion handler on main queue
                DispatchQueue.main.async {
                    completion(.success(dailyScrums))
                }
            } catch {
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
            }
        }
    }
    
    // this method accepts a completion handler that accepts either the number of save scrums or an error
    static func save(scrums: [DailyScrum], completion: @escaping (Result<Int, Error>) -> Void) {
        do {
            let data = try JSONEncoder().encode(scrums)
            let outfile = try fileURL()
            try data.write(to: outfile)
            DispatchQueue.main.async {
                completion(.success(scrums.count))
            }
        } catch {
            DispatchQueue.main.async {
                completion(.failure(error))
            }
        }
    }
    
}
