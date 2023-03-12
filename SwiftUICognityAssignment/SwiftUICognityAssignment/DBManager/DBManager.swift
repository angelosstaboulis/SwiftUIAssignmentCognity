//
//  DBManager.swift
//  SwiftUICognityAssignment
//
//  Created by Angelos Staboulis on 10/3/23.
//

import Foundation
import RealmSwift
import Combine
class StoreManager: ObservableObject {
    var objectWillChange: ObservableObjectPublisher = .init()
    private(set) var itemEntities: Results<DBStruct> = DBManager().fetchRecord()
    private var notificationTokens: [NotificationToken] = []
    
    init() {
        notificationTokens.append(itemEntities.observe { _ in
            self.objectWillChange.send()
        })
    }
    
    deinit {
        notificationTokens.forEach { $0.invalidate() }
    }
}


class DBManager:NSObject,ObservableObject{
    var realm:Realm
    private var token: NotificationToken? = nil
    override init() {
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
            super.init()
        
    }
    private func addObserver() {
          token = realm.observe { notification, realm in
               self.fetchRecord()
           }
    }
    deinit {
           token?.invalidate()
    }
    func insertRecord(dbStruct:DBStruct) {
        do{
            realm.beginWrite()
            realm.add(dbStruct)
            try realm.commitWrite()
        }
        catch{
            debugPrint("database error with login something went wrong!!!")
        }
    }


    func fetchRecord() -> Results<DBStruct> {
        return realm.objects(DBStruct.self)
    }
    
   
  
   
}
