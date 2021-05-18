//
//  AsyncOperation.swift
//  FileImportApp
//
//  Created by Suto, Evelyne on 17/05/2021.
//

import Foundation

//https://www.avanderlee.com/swift/asynchronous-operations/

// Async operation subclasses need to override the execute function and call the completionBlock once the operation finished
class AsyncOperation: Operation {
    enum OperationState : Int {
        case ready
        case executing
        case finished
    }
    
    private var state : OperationState = .ready {
        willSet {
            self.willChangeValue(forKey: "isExecuting")
            self.willChangeValue(forKey: "isFinished")
        }
        
        didSet {
            self.didChangeValue(forKey: "isExecuting")
            self.didChangeValue(forKey: "isFinished")
        }
    }
    
    private(set) var executeCompleted: (() -> Void)?
    
    override init() {
        super.init()
        self.executeCompleted = { [weak self] in
            self?.state = .finished
        }
    }
    
    // override in subclass
    func execute() { }
    
    override func start() {
        guard !isCancelled else {
            state = .finished
            return
        }
        
        state = .executing
        execute()
    }
    
    override var isReady: Bool { return state == .ready }
    override var isExecuting: Bool { return state == .executing }
    override var isFinished: Bool { return state == .finished }
}
