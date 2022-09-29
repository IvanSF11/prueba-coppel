//
//  PersonalDataBase.swift
//  prueba-coppel
//
//  Created by Pedro Soriano on 28/09/22.
//

import Foundation
import SQLite3

struct MoviesValue {
    let id: String
    let title: String
    let posterPath: String
    let overview: String
    let releaseDate: String
    let voteAverage: String
    let type: String
    
    public var posterURL: URL {
        return URL(string: "https://image.tmdb.org/t/p/w500\(posterPath)")!
    }
}

enum PersistenceError: Error {
    case failToCreateTable
    case failToInsertObject
    case failToSelectObject
    case failToDropTable
}

final class PersonalDataDataBase {
    static let incompleteFormKey = "save_local_personal_data"
    
    enum Table: String {
        case personalData = "movies_data"
        case educationData = "tv_data"
    }
    
    static let shared = PersonalDataDataBase()
    private init() {}
    
    internal var db: OpaquePointer?
    
    func assign() {
        setUpDataBase()
    }
    
    func tableName(_ table: Table) -> String? {
        return "\(table.rawValue)"
    }
    
    private func setUpDataBase() {
        do {
            let fileURL = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false).appendingPathComponent("prueba-coppel.sqlite")
            if sqlite3_open(fileURL.path, &db) != SQLITE_OK {
                debugPrint("DEBUG: DB Error opening the DB")
            }
            try createTable(.educationData)
            try createTable(.personalData)
        } catch {
            debugPrint("DEBUG: DB File doesn't exists")
        }
    }
    
    func createTable(_ table: Table) throws {
        guard let table = tableName(table) else { return }
        if sqlite3_exec(db, """
            CREATE TABLE IF NOT EXISTS `\(table)` (
              `id` TEXT(8) NOT NULL,
              `title` TEXT(50),
              `posterPath` TEXT(300),
              `overview` TEXT(300),
              `releaseDate` TEXT(20),
              `voteAverage` TEXT(20),
              `type` TEXT(20),
              PRIMARY KEY (`id`)
            );
            """, nil, nil, nil) != SQLITE_OK {
            let errorMessage = String(cString: sqlite3_errmsg(db))
            debugPrint("DEBUG: DB Error", errorMessage)
            throw PersistenceError.failToCreateTable
        }
    }
    
    func insert(_ value: MoviesValue, in table: Table) throws {
        guard let table = tableName(table) else { return }
        if sqlite3_exec(db,"""
            INSERT INTO `\(table)` (id, title, posterPath, overview, releaseDate, voteAverage, type)
            VALUES ('\(value.id)', '\(value.title)', '\(value.posterPath)', '\(value.overview)', '\(value.releaseDate)', '\(value.voteAverage)', '\(value.type)')
        """, nil, nil, nil) != SQLITE_OK {
            
            if sqlite3_exec(db, """
                UPDATE `\(table)`
                SET title='\(value.title)', posterPath='\(value.posterPath)', overview='\(value.overview)', releaseDate='\(value.releaseDate)', voteAverage='\(value.voteAverage)',
                    type='\(value.type)'
                WHERE id='\(value.id)'
            """, nil, nil, nil) != SQLITE_OK {
                let errorMessage = String(cString: sqlite3_errmsg(db))
                debugPrint("DEBUG: DB Error", errorMessage)
                throw PersistenceError.failToInsertObject
            }
        }
    }
    
    func getField(id: String, in table: Table) -> MoviesValue? {
        var selectionPointer: OpaquePointer?
        guard let table = tableName(table) else { return nil }
        
        if sqlite3_prepare(db, """
            SELECT * FROM `\(table)` WHERE id='\(id)'
        """, -1, &selectionPointer, nil) != SQLITE_OK {
            let errorMessage = String(cString: sqlite3_errmsg(db)!)
            debugPrint("DEBUG: DB Error", errorMessage)
            return nil
        }
        
        return MoviesValue(
            id: String(cString: sqlite3_column_text(selectionPointer, 0)),
            title: String(cString: sqlite3_column_text(selectionPointer, 1)),
            posterPath: String(cString: sqlite3_column_text(selectionPointer, 2)),
            overview: String(cString: sqlite3_column_text(selectionPointer, 3)),
            releaseDate: String(cString: sqlite3_column_text(selectionPointer, 4)),
            voteAverage: String(cString: sqlite3_column_text(selectionPointer, 5)),
            type: String(cString: sqlite3_column_text(selectionPointer, 6))
        )
    }
    
    func getAllFields(in table: Table) throws -> [MoviesValue] {
        var selectionPointer: OpaquePointer?
        guard let table = tableName(table) else { return [] }
        
        if sqlite3_prepare(db, """
            SELECT * FROM `\(table)`
        """, -1, &selectionPointer, nil) != SQLITE_OK {
            let errorMessage = String(cString: sqlite3_errmsg(db)!)
            debugPrint("DEBUG: DB Error", errorMessage)
            throw PersistenceError.failToSelectObject
        }
        
        var values = [MoviesValue]()
        //traversing through all the records
        while(sqlite3_step(selectionPointer) == SQLITE_ROW) {
            values.append(MoviesValue(
                id: String(cString: sqlite3_column_text(selectionPointer, 0)),
                title: String(cString: sqlite3_column_text(selectionPointer, 1)),
                posterPath: String(cString: sqlite3_column_text(selectionPointer, 2)),
                overview: String(cString: sqlite3_column_text(selectionPointer, 3)),
                releaseDate: String(cString: sqlite3_column_text(selectionPointer, 4)),
                voteAverage: String(cString: sqlite3_column_text(selectionPointer, 5)),
                type: String(cString: sqlite3_column_text(selectionPointer, 6))
            ))
        }
        
        return values
    }
    
    func dropTable(_ table: Table) throws {
        guard let table = tableName(table) else { return }
        
        if sqlite3_exec(db, """
            DROP TABLE `\(table)`
            """, nil, nil, nil) != SQLITE_OK {
            let errorMessage = String(cString: sqlite3_errmsg(db)!)
            debugPrint("DEBUG: DB Error", errorMessage)
            throw PersistenceError.failToSelectObject
        }
    }
    
    func deleteRow(_ table: Table, id: Int){
        guard let table = tableName(table) else { return }
        let deleteStatementStirng = "DELETE FROM `\(table)` WHERE id = ?;"
        var deleteStatement: OpaquePointer? = nil
        if sqlite3_prepare_v2(db, deleteStatementStirng, -1, &deleteStatement, nil) == SQLITE_OK {
            
            sqlite3_bind_int(deleteStatement, 1, Int32(id))            
            if sqlite3_step(deleteStatement) == SQLITE_DONE {
                debugPrint("Successfully deleted row.")
            } else {
                debugPrint("Could not delete row.")
            }
        } else {
            debugPrint("DELETE statement could not be prepared")
        }
        sqlite3_finalize(deleteStatement)
    }
}
