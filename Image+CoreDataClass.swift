//
//  Image+CoreDataClass.swift
//  Targeter
//
//  Created by mac on 3/14/17.
//  Copyright © 2017 Alder. All rights reserved.
//

import Foundation
import CoreData

@objc(Image)
public class Image: NSManagedObject {
    convenience init(url:String,imageData: Data?, context: NSManagedObjectContext) {
        
        // An EntityDescription is an object that has access to all
        // the information you provided in the Entity part of the model
        // you need it to create an instance of this class.
        if let ent = NSEntityDescription.entity(forEntityName: "Image", in: context) {
            self.init(entity: ent, insertInto: context)
            if let imageData = imageData {
                self.imageData = imageData
            }
            self.url = url
        } else {
            fatalError("Unable to find Entity name!")
        }
    }

}
