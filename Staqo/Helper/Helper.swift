//
//  Helper.swift
//  Staqo
//
//  Created by SHAILY on 16/03/21.
//

import Foundation

class Helper {
    
    static func createTextReader(scannedText:String?) -> TextReader? {
        var textReader = TextReader()
        var document = Documents()
        document.id = "5"
        document.language = ""
        document.text = scannedText ?? ""
        textReader.documents?.append(document)
        return textReader
    }
    static func creatingRoomData(locID:Int, attendents:Int ,fromDateTime:String ,toDateTime:String,remarks:String,visitorType:String,roomType:String,arrangementType:String,roomCode:String,recurringDay:String ) -> RoomSearchModel? {
        var roomData = RoomSearchModel()
        roomData.locID = locID
        roomData.attendents = attendents
        roomData.fromDateTime = fromDateTime
        roomData.toDateTime = toDateTime
        roomData.roomStatus = "P"
        roomData.remarks = remarks
        roomData.visitorType = visitorType
        roomData.roomType = roomType
        roomData.arrangementType = arrangementType
        roomData.roomCode = roomCode
        roomData.recurringDay = recurringDay
        roomData.bookedBy = UserDefaults.standard.getProfile()?.email ?? ""
        
       return roomData
    }
    
    static func roomBookingData(roomId:Int ,attendents:Int ,fromDateTime:String,toDateTime:String,roomStatus:String,purpose:String,visitorType: String,roomType:String,arrangementType:String,notificationId:String,roomCode:String,recurringDay:String,bookedBy:String ) -> RoomBookModel? {
        var bookingdata = RoomBookModel()
        bookingdata.roomId = roomId
        bookingdata.attendents = attendents
        bookingdata.fromDateTime = fromDateTime
        bookingdata.toDateTime = toDateTime
        bookingdata.roomStatus = roomStatus
        bookingdata.purpose = purpose
        bookingdata.visitorType = visitorType
        bookingdata.roomType = roomType
        bookingdata.arrangementType = arrangementType
        bookingdata.notificationId = notificationId
        bookingdata.roomCode = roomCode
        bookingdata.recurringDay = recurringDay
        bookingdata.bookedBy = UserDefaults.standard.getProfile()?.email ?? ""
       return bookingdata
    }
    
    static func createTicket(desc:String , subj:String , catID:String , prioName:String , subID:String, email_ID:String, projName:String) -> ReqHelper?  {
        var reqHelper = ReqHelper()
        var request = Request()
        request.description = desc
        request.subject = subj
        request.impact_details = "Routine tasks are pending due to mail server problem"
        
        var category = Categories()
        category.id = catID
        request.category = category
        
        var priority = Priority()
        priority.name = prioName
        request.priority = priority
        
        var requester = Requester()
        requester.id = "4"
        requester.name = "administrator"
        request.requester = requester
        
        var status = Status()
        status.name = "Open"
        request.status = status
        
        var subCat = Subcategories()
        subCat.id = subID
        request.subcategory = subCat
        
        var resolution = Resolution()
        resolution.content = "Mail Fetching Server problem has been fixed"

        request.resolution = resolution
        
        reqHelper.request = request
        return reqHelper
    }
}
