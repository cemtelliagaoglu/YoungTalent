//
//  CoreDataManager.swift
//  YoungTalent
//
//  Created by admin on 28.03.2023.
//

import CoreData

class CoreDataManager {
    // MARK: - Properties

    static let shared = CoreDataManager()

    private lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "YoungTalent")
        container.loadPersistentStores(completionHandler: { storeDescription, error in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    private lazy var context = persistentContainer.viewContext

    // MARK: - Methods

    private init() {}

    func create<E>(type: E.Type) async throws -> E {
        do {
            guard let object = NSEntityDescription.insertNewObject(forEntityName: "\(E.self)", into: context) as? E
            else {
                throw CoreDataError.create
            }
            try context.save()
            return object
        } catch {
            throw CoreDataError.save
        }
    }

    func read<E>(type: E.Type) async throws -> [E] {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "\(E.self)")
        do {
            guard let objects = try context.fetch(fetchRequest) as? [E]
            else {
                throw CoreDataError.fetch
            }
            return objects
        } catch {
            throw CoreDataError.read
        }
    }

    func update() async throws {
        do {
            try context.save()
            return
        } catch {
            throw CoreDataError.update
        }
    }

    func delete(objects: [some NSManagedObject]) async throws {
        do {
            for object in objects {
                context.delete(object)
            }
            try context.save()
            return
        } catch {
            throw CoreDataError.delete
        }
    }
}
