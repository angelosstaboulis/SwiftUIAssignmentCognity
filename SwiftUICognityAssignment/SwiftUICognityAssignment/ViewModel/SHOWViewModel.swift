//
//  SHOWViewModel.swift
//  SwiftUICognityAssignment
//
//  Created by Angelos Staboulis on 10/3/23.
//

import Foundation
import RealmSwift
class SHOWViewModel:ObservableObject{
    var apishared:APIManager!
    var realm:Realm!
    init(){
        apishared = APIManager.shared
        var config = Realm.Configuration()

           config.fileURL = config

               .fileURL!

               .deletingLastPathComponent()

               .appendingPathComponent("cognity.realm")
       
     

           config.schemaVersion = 59

           config.migrationBlock = { _, oldSchemaVersion in

               if oldSchemaVersion < 1 {}
           }
        do{
            realm = try Realm(configuration: config)
        }
        catch{
            
        }
    }
    func fetchTVShows( ) async -> [SHOWModel]{
        return await apishared.fetchShows()
    }
    func insertRecord(dbStruct:DBStruct) {
           do {
              
               try! realm?.write{
                   realm?.create(DBStruct.self,value:dbStruct,update: .all)

               }

           } catch let error as NSError {

               print(error)

           }
         

    }
    func fetchRecords()->Results<DBStruct>{
       
        return (realm?.objects(DBStruct.self))!
    }
    
   
}

