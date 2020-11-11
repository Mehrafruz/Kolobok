//
//  WhereGoPark.swift
//  WhereGoWithoutSB
//
//  Created by Мехрафруз on 23.10.2020.
//  Copyright © 2020 Мехрафруз. All rights reserved.
//

import Foundation

struct whereGo{
    let eventName: String
    let location: String
    let timeTable: String
    let phone: String
    let description: String
    let subWay: String
    let favoriteCount: Int
    var imagesLinks: [String] = []
    let link: String
    //эти элементы структуры будут необходимы для обработки мероприятий которые длятся определенное количество времени
    //    let startDate: String
    //    let endDate: String
    
    
    //хороший тон для обработки ошибок
    enum SerializationError:Error {
        case missing(String)
        case invalid(String, Any)
    }
    
    init(json:[String:Any]) throws {
        
        guard let eventName = json["title"] as? String else {throw SerializationError.missing("eventName is missing")}
        guard let location = json["address"] as? String else {throw SerializationError.missing("location is missing")}
        guard let timeTable = json["timetable"] as? String else {throw SerializationError.missing("timetable is missing")}
        guard let phone = json["phone"] as? String else {throw SerializationError.missing("phone is missing")}
        guard let description = json["description"] as? String else {throw SerializationError.missing("description is missing")}
        guard let subWay = json["subway"] as? String else {throw SerializationError.missing("subway is missing")}
        guard let favoriteCount = json["favorites_count"] as? Int else {throw SerializationError.missing("favoriteCount is missing")}
        //        guard let startDate = json["start_date"] as? String else {throw SerializationError.missing("startDate is missing")}
        //        guard let endDate = json["end_date"] as? String else {throw SerializationError.missing("endDate is missing")}
        guard let link = json["foreign_url"] as? String else {throw SerializationError.missing("link is missing")}
        
        
        self.eventName = eventName
        self.location = location
        self.timeTable = timeTable
        self.phone = phone
        self.description = description
        self.link = link
        self.subWay = subWay
        self.favoriteCount = favoriteCount
        
    }
    
}
