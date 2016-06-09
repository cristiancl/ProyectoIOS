//
//  ContactsViewController.swift
//  Whatssenger
//
//  Created by Estudiantes on 6/4/16.
//  Copyright © 2016 edu.co.javerianacali. All rights reserved.
//

import UIKit


class ContactsViewController: UIViewController, UITableViewDataSource {
    @IBOutlet weak var TituloContactos: UILabel!
    
    @IBOutlet var tableView: UITableView!
    
    var conexion = Conexion()
    var servicio = ConsumeService()
    
    
    var userID:Int = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        servicio.GETContactos(self.userID)
        viewWillAppear(true)
        
        let seconds = 1.0
        let delay = seconds * Double(NSEC_PER_SEC)  // nanoseconds per seconds
        let dispatchTime = dispatch_time(DISPATCH_TIME_NOW, Int64(delay))
        
        dispatch_after(dispatchTime, dispatch_get_main_queue(), {
            self.viewWillAppear(true)
        })
        
        
           }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    override func viewWillAppear(animated: Bool) {
        tableView.reloadData()
        
    }
    
    
    func tableView(tableView:UITableView, numberOfRowsInSection section:Int) -> Int
    {
        
        return servicio.contactos.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell:ContactosTablewViewCell = tableView.dequeueReusableCellWithIdentifier("Custom1") as! ContactosTablewViewCell
        let contactoact = servicio.contactos[indexPath.row]
        
        
        cell.labelContact?.text=contactoact.nombre1
        return cell
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?)
    {
        
        if (segue.identifier == "ChatContacto"){
            let tabView = segue.destinationViewController as! TabController
            let viewChat = tabView.viewControllers![0] as! ChatViewController
            debugPrint((tableView.indexPathForSelectedRow?.row)!)
            debugPrint(servicio.contactos[(tableView.indexPathForSelectedRow?.row)!].nombre1)
            let nombre = servicio.contactos[(tableView.indexPathForSelectedRow?.row)!].nombre1
            viewChat.algo = nombre
            viewChat.ENTRADA = servicio.contactos[(tableView.indexPathForSelectedRow?.row)!]
            viewChat.usuarioenvia = userID
            
        }
        
    }

    
}
