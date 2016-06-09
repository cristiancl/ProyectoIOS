//
//  Mensaje.swift
//  Whatssenger
//
//  Created by Estudiantes on 6/4/16.
//  Copyright © 2016 sistemas. All rights reserved.
//


import UIKit
import SQLite
import Alamofire
import SwiftyJSON


class Mensaje {
    
    
    var receptor:Int
    var remitente:Int
    var mensaje:String
    
    init(receptor2:Int,remitente2:Int,mensaje2:String){
        
        self.receptor=receptor2
        self.remitente=remitente2
        self.mensaje=mensaje2
    }
}
