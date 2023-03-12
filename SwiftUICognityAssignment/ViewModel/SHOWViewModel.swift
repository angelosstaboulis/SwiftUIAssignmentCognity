//
//  SHOWViewModel.swift
//  SwiftUICognityAssignment
//
//  Created by Angelos Staboulis on 10/3/23.
//

import Foundation
import RealmSwift
class SHOWViewModel:ObservableObject{
    @Published var shows:List<DBStruct>!
    var apishared:APIManager!
    var realm:Realm
    init(){
        apishared = APIManager.shared
        var config = Realm.Configuration()

           config.fileURL = config

               .fileURL!

               .deletingLastPathComponent()

               .appendingPathComponent("cognity.realm")

           config.schemaVersion = 56

           config.migrationBlock = { _, oldSchemaVersion in

               if oldSchemaVersion < 1 {}

           }
           do {

               realm = try! Realm(configuration: config)
              

           } catch let error as NSError {

               print(error)

           }
    }
    func fetchTVShows( ) async -> [SHOWModel]{
        return await apishared.fetchShows()
    }
    func insertRecord(dbStruct:DBStruct) {
        var config = Realm.Configuration()

           config.fileURL = config

               .fileURL!

               .deletingLastPathComponent()

               .appendingPathComponent("cognity.realm")

           config.schemaVersion = 56

           config.migrationBlock = { _, oldSchemaVersion in

               if oldSchemaVersion < 1 {}

           }
           do {

               realm = try! Realm(configuration: config)
              

           } catch let error as NSError {

               print(error)

           }
        DispatchQueue.main.async {
            do{
                
                self.realm.beginWrite()
                self.realm.add(dbStruct)
                
                try self.realm.commitWrite()
            }
            catch{
                debugPrint("database error with login something went wrong!!!")
            }
        }

    }
    func fetchRecords()->Results<DBStruct>{
        var config = Realm.Configuration()

           config.fileURL = config

               .fileURL!

               .deletingLastPathComponent()

               .appendingPathComponent("cognity.realm")

           config.schemaVersion = 56

           config.migrationBlock = { _, oldSchemaVersion in

               if oldSchemaVersion < 1 {}

           }
           do {

               realm = try! Realm(configuration: config)
              

           } catch let error as NSError {

               print(error)

           }
        return (realm.objects(DBStruct.self))
    }
    
   
}

