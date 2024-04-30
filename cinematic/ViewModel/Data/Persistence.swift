import CoreData

struct PersistenceController {
    static let shared = PersistenceController()

    let container: NSPersistentContainer

    init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "cinematic")
        if inMemory {
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.

                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        container.viewContext.automaticallyMergesChangesFromParent = true
    }
    
    var context: NSManagedObjectContext {
        container.viewContext
    }
    
    /// Fetches results.
    func fetch<Result : NSFetchRequestResult, T>(
        request: NSFetchRequest<Result>,
        orDefault: () -> T,
        result: ([Result]) -> T?
    ) -> T {
        do {
            let fetched: [Result] = try context.fetch(request)
            return result(fetched) ?? orDefault()
        } catch {
            print("Error while fetching: \(error)")
            return orDefault()
        }
    }
    
    /// Fetches results without returning them.
    func fetch<Result : NSFetchRequestResult>(
        request: NSFetchRequest<Result>,
        result: ([Result]) -> ()
    ) {
        do {
            let fetched: [Result] = try context.fetch(request)
            result(fetched)
        } catch {
            print("Error while fetching: \(error)")
        }
    }
    
    func save() {
        do {
            try context.save()
        } catch {
            print("Error saving: \(error)")
        }
    }
}
