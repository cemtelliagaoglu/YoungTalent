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

    func create<E>(type: E.Type, completion: @escaping ((Result<E, CoreDataError>) -> Void)) {
        do {
            guard let object = NSEntityDescription.insertNewObject(forEntityName: "\(E.self)", into: context) as? E
            else {
                completion(.failure(.create))
                return
            }
            try context.save()
            completion(.success(object))
        } catch {
            completion(.failure(.save))
        }
    }

    func read<E>(type: E.Type, completion: @escaping ((Result<[E], CoreDataError>) -> Void)) {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "\(E.self)")
        do {
            guard let objects = try context.fetch(fetchRequest) as? [E]
            else {
                completion(.failure(.fetch))
                return
            }
            completion(.success(objects))
        } catch {
            completion(.failure(.read))
        }
    }

    func update(completion: @escaping ((Result<Void, CoreDataError>) -> Void)) {
        do {
            try context.save()
            completion(.success(()))
        } catch {
            completion(.failure(.update))
        }
    }

    func delete(objects: [some NSManagedObject], completion: @escaping ((Result<Void, CoreDataError>) -> Void)) {
        do {
            for object in objects {
                context.delete(object)
            }
            try context.save()
            completion(.success(()))
        } catch {
            completion(.failure(.delete))
        }
    }
}
