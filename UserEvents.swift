//
//  UserEvents.swift
//  Calendar
//
//  Created by Ted on 2015/10/24.
//  Copyright © 2015年 Ted Chuang. All rights reserved.
//

import UIKit
import CoreData

@objc(UserEvents)
class UserEvents: NSManagedObject {
    @NSManaged var date: String
    @NSManaged var info: String
    @NSManaged var title: String
}
