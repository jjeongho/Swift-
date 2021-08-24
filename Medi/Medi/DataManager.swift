//
//  DataManager.swift
//  Medi
//
//  Created by 황정호 on 2021/08/24.
//

import Foundation
import CoreData

class DataManager {
    //싱글톤 객체
    static let shared = DataManager()
    private init() {}
    
    var mainContext: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    
    var memoList = [Memo]()
    
    func fetchMemo() {
        let request: NSFetchRequest<Memo> = Memo.fetchRequest()
        
        let sortByDateDesc = NSSortDescriptor(key: "insertDate", ascending: false)
        
        request.sortDescriptors = [sortByDateDesc]
        
        do{
            memoList = try mainContext.fetch(request)
        }catch{
            print(error)
        }
        
    }
    
    func addNewMemo(_ memo: String?){
        let newMemo = Memo(context: mainContext)
        newMemo.content = memo
        newMemo.insertDate = Date()
        saveContext()
    }
    
    func deleteMemo(_ memo: Memo?){
        if let memo = memo {
            mainContext.delete(memo)
            saveContext()
        }
    }
    
    lazy var persistentContainer: NSPersistentCloudKitContainer = {
        let container = NSPersistentCloudKitContainer(name: "Medi")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support

    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }

}
