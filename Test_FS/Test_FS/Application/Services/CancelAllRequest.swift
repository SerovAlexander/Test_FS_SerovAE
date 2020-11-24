// ----------------------------------------------------------------------------
//
//  CancelAllRequest.swift
//  Test_FS
//
//  Created by Aleksandr Serov on 24.11.2020.
//
// ----------------------------------------------------------------------------

import Alamofire
import Foundation

// ----------------------------------------------------------------------------

// Cancel all request in session.

final class CancelAllRequest {
    static func cancel() {
        Alamofire.Session.default.session.getTasksWithCompletionHandler({ dataTasks, uploadTasks, downloadTasks in
            dataTasks.forEach { $0.cancel() }
            uploadTasks.forEach { $0.cancel() }
            downloadTasks.forEach { $0.cancel() }
        })
    }
}
