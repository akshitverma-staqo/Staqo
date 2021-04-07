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
    static func creatingRoomData(attendents:Int ,fromDateTime:String ,toDateTime:String,remarks:String,visitorType:String,roomType:String,arrangementType:String,roomCode:String,recurringDay:String ) -> RoomSearchModel? {
        var roomData = RoomSearchModel()
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
}
