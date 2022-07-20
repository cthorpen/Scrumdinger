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
    
    static func load() async throws -> [DailyScrum] {
        // Calling withCheckedThrowingContinuation suspends the load function,
        // then passes a continuation into a closure that you provide.
        // A continuation is a value that represents the code after an awaited function
        try await withCheckedThrowingContinuation { continuation in
            load { result in
                switch result {
                // Upon failure, send the error to the continuation closure.
                case .failure(let error):
                    continuation.resume(throwing: error)
                // Upon success, send the scrums to the continuation closure.
                case .success(let scrums):
                    continuation.resume(returning: scrums)
                }
            }
        }
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
    
    // static function that asynchronously returns an Int
    // The save function returns a value that callers of the function may not use.
    // The @discardableResult attribute disables warnings about the unused return value.
    @discardableResult
    static func save(scrums: [DailyScrum]) async throws -> Int {
        try await withCheckedThrowingContinuation { continuation in
            // legacy save function
            save(scrums: scrums) { result in
                //Finish the function by switching over the result, following the same pattern as the load function
                switch result {
                case .failure(let error):
                    continuation.resume(throwing: error)
                case .success(let scrumsSaved):
                    continuation.resume(returning: scrumsSaved)
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
