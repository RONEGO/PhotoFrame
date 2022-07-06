//
//  ImageInfo+CoreDataProperties.swift
//  PhotoFrame
//
//  Created by Yegor Geronin on 06.07.2022.
//
//

import Foundation
import CoreData


extension ImageInfo {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ImageInfo> {
        return NSFetchRequest<ImageInfo>(entityName: "ImageInfo")
    }

    @NSManaged public var image: Data?
    @NSManaged public var added: Date?
    @NSManaged public var index: Int16

}

extension ImageInfo : Identifiable {

}
