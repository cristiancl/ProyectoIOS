//
//  ConsumeService.swift
//  Whatsengger
//
//  Created by Estudiantes on 6/4/16.
//  Copyright © 2016 sistemas. All rights reserved.
//
import Foundation
import SQLite
import Alamofire
import SwiftyJSON

class ConsumeService
{
    var contactos:[Contacto]
    var mensajes:[Mensaje]
    var conexion_db:Conexion = Conexion()
    
    init(){
        self.contactos=[Contacto]()
        self.mensajes=[Mensaje]()
        
    }
    
    let todoEndpoint: String = "http://10.5.99.102:8191/rest/"
    
    
    func GETContactos(nume:Int) -> Void
    {
        var salida:[String]=[String]()
        
        
        
        
        Alamofire.request(.GET, todoEndpoint+"contacts/"+String(nume))
            .responseJSON
            { response in
                print(response.request)  // original URL request
                print(response.response) // URL response
                print(response.data)     // server data
                print(response.result)   // result of response serialization
                
                
                if let value = response.result.value
                {
                    print("JSON: \(value)")
                    let todo = JSON(value)
                    
                    
                    
                    if let cosas = todo.array {
                        for m in cosas
                        {
                            self.contactos.append(Contacto(nombre2: m["userName"].stringValue,numero2: Int(m["userId"].stringValue)!))
                            
                        
                            self.conexion_db.addContacto(Int(m["userId"].stringValue)!, nome:m["userName"].stringValue)
                            
                            salida.append(m["userName"].stringValue)
                        
                        }
                        
                    }
                    
                    
                }
                
                debugPrint(self.contactos.first?.nombre1,self.conexion_db.count())
                
                
        }
    }
    
    func GETmensajes(de:Int,para:Int) -> Void
    {
        var salida:[String]=[String]()
        
        
        
        
        Alamofire.request(.GET, todoEndpoint+"messages/"+String(de)+"/"+String(para))
            .responseJSON
            { response in
                print(response.request)  // original URL request
                print(response.response) // URL response
                print(response.data)     // server data
                print(response.result)   // result of response serialization
                
                
                if let value = response.result.value
                {
                    print("JSON: \(value)")
                    let todo = JSON(value)
                    
                    // now we have the results, let's just print them though a tableview would definitely be better UI:
                    
                    if let cosas = todo.array {
                        for m in cosas
                        {
                            self.mensajes.append(Mensaje(receptor2: Int(m["from"].stringValue)!,remitente2: Int(m["to"].stringValue)!,mensaje2: m["text"].stringValue))
                            debugPrint(m["text"])
                            
                            self.conexion_db.addMensaje(Int(m["from"].stringValue)!, receptor1: Int(m["to"].stringValue)!, mensaje1: m["text"].stringValue);
                            //debugPrint(self.conexion_db.count())
                            salida.append(m["from"].stringValue)
                            //debugPrint(m["to"].stringValue)
                            
                        }
                        
                    }
                    
                    
                }
                
                debugPrint(self.mensajes.first?.mensaje,self.conexion_db.count())
                
                
        }
    }
    
    
    
    func POSTmensajes(de:Int,para:Int,mens:String){
        
        typealias Model = [[String:AnyObject]]
        
        let mensaje : Dictionary<String,AnyObject> = Dictionary<String,AnyObject>(dictionaryLiteral:("from",de),("to",para),("text",mens))
        Alamofire.request(.POST,"http://10.5.99.102:8191/rest/messages/",parameters: mensaje,encoding: .JSON)
        debugPrint(mensaje)
    
    }
}
    
        