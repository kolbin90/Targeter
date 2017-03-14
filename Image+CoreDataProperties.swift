//
//  Image+CoreDataProperties.swift
//  Targeter
//
//  Created by mac on 3/14/17.
//  Copyright © 2017 Alder. All rights reserved.
//

import Foundation
import CoreData


extension Image {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Image> {
        return NSFetchRequest<Image>(entityName: "Image");
    }

    @NSManaged public var url: String?
    @NSManaged public var imageData: Data?
    @NSManaged public var imageSearch: ImageSearch?

}
