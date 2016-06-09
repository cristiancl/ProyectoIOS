//
//  ChatViewController.swift
//  Whatssenger
//
//  Created by Estudiantes on 6/3/16.
//  Copyright © 2016 edu.co.javerianacali. All rights reserved.
//

import UIKit

class ChatViewController: UIViewController, UITableViewDataSource {
    
    
    @IBOutlet weak var textoB: UILabel!
    @IBOutlet weak var textoA: UILabel!
    @IBOutlet weak var TextBoxchat: UITextField!
    var conexion: Conexion = Conexion()
    var servicio = ConsumeService()

    var ENTRADA : Contacto? = Contacto(nombre2: "Rada_x",numero2: 987)
    var algo : String? = ""
    var usuarioenvia:Int = 0
    var mensajesotro:[Mensaje]=[Mensaje]()
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
            super.viewDidLoad()
            mensajesotro=servicio.mensajes
            servicio.GETmensajes( (self.ENTRADA?.numero1)!, para: usuarioenvia)
            textoB.text = algo
            servicio.GETmensajes(self.usuarioenvia, para: (self.ENTRADA?.numero1)!)
        
            viewWillAppear(true)
            
            let seconds = 1.0
            let delay = seconds * Double(NSEC_PER_SEC)  // nanoseconds per seconds
            let dispatchTime = dispatch_time(DISPATCH_TIME_NOW, Int64(delay))
            
            dispatch_after(dispatchTime, dispatch_get_main_queue(), {
                self.viewWillAppear(true)
            })
            
        
    }
        

    
    override func viewWillAppear(animated: Bool) {
        tableView.reloadData()
        
    }
    
    
    func tableView(tableView:UITableView, numberOfRowsInSection section:Int) -> Int
    {
        
        return servicio.mensajes.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    
        let cell:MsgTableViewCell = tableView.dequeueReusableCellWithIdentifier("Custom1") as! MsgTableViewCell
        
        let mensaje = servicio.mensajes[indexPath.row]
        debugPrint(mensaje)
        cell.textoA.text?=(mensaje.mensaje)
        return cell
    }
    
    
    
    @IBAction func Enviarmensaje(sender: AnyObject) {
        
        servicio.POSTmensajes(usuarioenvia, para: (ENTRADA?.numero1)!, mens: TextBoxchat.text!)
        TextBoxchat.text=" "
        self.viewWillAppear(true)
        
        
        
        
    }
    @IBAction func Resfreshmensajes(sender: AnyObject) {
        
    servicio.GETmensajes((ENTRADA?.numero1)! , para:usuarioenvia)
      self.viewWillAppear(true)
        
        
        
        
        
    }
    
    
}
