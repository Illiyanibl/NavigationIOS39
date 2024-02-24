//
//  CoreDataServise.swift
//  BlinoviOS-39_Navigation_0
//
//  Created by Illya Blinov on 22.02.24.
//

import CoreData
protocol ICoreDataService {
    var viewContext: NSManagedObjectContext { get }
    var backgraundContext: NSManagedObjectContext { get }
}

final class CoreDataService: ICoreDataService {
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "FavoritePostModel")
        container.loadPersistentStores { (persistent, error) in
            if let error = error {
                fatalError("Error: " + error.localizedDescription)
            }
        }
        return container
    }()
    lazy var viewContext = persistentContainer.viewContext
    lazy var backgraundContext  = persistentContainer.newBackgroundContext()
}

extension String {
    static let dataBaseName: String = "FavoritePost"
}
