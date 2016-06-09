//
//  ViewController.swift
//  Whatssenger
//
//  Created by Estudiantes on 6/3/16.
//  Copyright © 2016 edu.co.javerianacali. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var conexion :Conexion = Conexion()

    
    
    @IBOutlet var IDtxtF: UITextField!
    var txt:Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        IDtxtF.keyboardType = UIKeyboardType.NumberPad
       
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    @IBAction func Ontouch(sender: AnyObject) {
        
        conexion.DropDB()
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "Login"){
            txt = Int(IDtxtF.text!)
        }
        (segue.destinationViewController as! ContactsViewController).userID = txt!
        
    }


}

