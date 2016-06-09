//
//  Contactos.swift
//  Whatssenger
//
//  Created by Estudiantes on 6/3/16.
//  Copyright © 2016 sistemas. All rights reserved.
//


import UIKit
import SQLite
import Alamofire
import SwiftyJSON


class Conexion {
    
    private var db:Connection
    
    private var Contactos: Table
    private var numero: Expression <Int>
    private var nombre: Expression <String>
    
    private var Mensajes: Table
    private var idmensaje :Expression <Int>
    private var remitente: Expression <Int>
    private var receptor: Expression <Int>
    private var mensaje: Expression <String>
    
    
    init(){
        let path = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true).first!
        
        db = try! Connection("\(path)/db.sqlite3")
        
        Contactos = Table ("Contactos")
        numero = Expression <Int>("Numero")
        nombre = Expression <String>("Nombre")
        
        Mensajes = Table ("Mensajes")
        idmensaje = Expression<Int>("IdMensaje")
        receptor = Expression <Int>("Receptor")
        remitente = Expression <Int>("Remitente")
        mensaje = Expression <String>("Mensaje")
    
        try! db.run(Contactos.create(ifNotExists: true) { t in
            t.column(numero, primaryKey: true)
            t.column(nombre)
            
            })
        
        try! db.run(Mensajes.create(ifNotExists: true) { t in
            t.column(idmensaje , primaryKey: PrimaryKey.Autoincrement)
            t.column(remitente)
            t.column(receptor)
            t.column(mensaje)
            
            })
    }
    
    
    func addContacto(nume:Int, nome:String) {
        try! db.run(Contactos.insert(  numero <- nume, nombre <- nome))
    }
    
    func getContacto(numeroC:Int) -> Contacto{
        let query = Contactos.limit(20, offset: numeroC)
        let contactos = Array(try! db.prepare(query))[0]
        
        return Contacto(nombre2: contactos.get(nombre), numero2: contactos.get(numero));
    }
    
    func removeContacto(numeroC:Int) {
        let query = Contactos.limit(1, offset: numeroC)
        let contactos = Array(try! db.prepare(query))[0]
        
        try! db.run(Contactos.filter(numero == contactos.get(numero)).delete())
    }
    
    func count() -> Int {
        return db.scalar(Contactos.count)
    }
    
    
    func addMensaje(remitente1:Int, receptor1:Int, mensaje1:String) {
        try! db.run(Mensajes.insert( remitente <- remitente1 , receptor <- receptor1, mensaje <- mensaje1))
    }
    
    func getMensaje(remitente1:Int) -> [Mensaje]{
        let query = Mensajes.limit(1, offset: remitente1)
        let mensajes = Array(try! db.prepare(query))
        var mes = [Mensaje]()
        for m in mensajes{
            mes.append(Mensaje(receptor2:m.get(receptor), remitente2: m.get(remitente), mensaje2: m.get(mensaje)))
        }
        return mes
    }
    

    
    func DropDB (){
        
        let query = "DROP TABLE Contactos"
        try! db.run(query)
        let query2 = "DROP TABLE Mensajes"
        try! db.run(query2)
    
    
    }
    
    
}
