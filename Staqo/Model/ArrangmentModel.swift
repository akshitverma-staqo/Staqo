//
//  ArrangmentModel.swift
//  Staqo
//
//  Created by SHAILY on 02/04/21.
//


import Foundation
struct ArrangmentModel : Codable,Equatable {
   
    let id : String?
    let contentType : String?
    let title : String?
    let modified : String?
    let created : String?
    let authorLookupId : String?
    let editorLookupId : String?
    let _UIVersionString : String?
    let attachments : Bool?
    let edit : String?
    let linkTitleNoMenu : String?
    let linkTitle : String?
    let itemChildCount : String?
    let folderChildCount : String?
    let _ComplianceFlags : String?
    let _ComplianceTag : String?
    let _ComplianceTagWrittenTime : String?
    let _ComplianceTagUserId : String?
    let room_TypeLookupId : String?
    let room_Type_x003a_IDLookupId : String?
    let pattern_x002f_Design : String?
    let sequence_Number : Double?
    let webUrl: String?

    enum CodingKeys: String, CodingKey {

        
        case id = "id"
        case contentType = "ContentType"
        case title = "Title"
        case modified = "Modified"
        case created = "Created"
        case authorLookupId = "AuthorLookupId"
        case editorLookupId = "EditorLookupId"
        case _UIVersionString = "_UIVersionString"
        case attachments = "Attachments"
        case edit = "Edit"
        case linkTitleNoMenu = "LinkTitleNoMenu"
        case linkTitle = "LinkTitle"
        case itemChildCount = "ItemChildCount"
        case folderChildCount = "FolderChildCount"
        case _ComplianceFlags = "_ComplianceFlags"
        case _ComplianceTag = "_ComplianceTag"
        case _ComplianceTagWrittenTime = "_ComplianceTagWrittenTime"
        case _ComplianceTagUserId = "_ComplianceTagUserId"
        case room_TypeLookupId = "Room_TypeLookupId"
        case room_Type_x003a_IDLookupId = "Room_Type_x003a_IDLookupId"
        case pattern_x002f_Design = "Pattern_x002f_Design"
        case sequence_Number = "Sequence_Number"
        case webUrl = "webUrl"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        id = try values.decodeIfPresent(String.self, forKey: .id)
        contentType = try values.decodeIfPresent(String.self, forKey: .contentType)
        title = try values.decodeIfPresent(String.self, forKey: .title)
        modified = try values.decodeIfPresent(String.self, forKey: .modified)
        created = try values.decodeIfPresent(String.self, forKey: .created)
        authorLookupId = try values.decodeIfPresent(String.self, forKey: .authorLookupId)
        editorLookupId = try values.decodeIfPresent(String.self, forKey: .editorLookupId)
        _UIVersionString = try values.decodeIfPresent(String.self, forKey: ._UIVersionString)
        attachments = try values.decodeIfPresent(Bool.self, forKey: .attachments)
        edit = try values.decodeIfPresent(String.self, forKey: .edit)
        linkTitleNoMenu = try values.decodeIfPresent(String.self, forKey: .linkTitleNoMenu)
        linkTitle = try values.decodeIfPresent(String.self, forKey: .linkTitle)
        itemChildCount = try values.decodeIfPresent(String.self, forKey: .itemChildCount)
        folderChildCount = try values.decodeIfPresent(String.self, forKey: .folderChildCount)
        _ComplianceFlags = try values.decodeIfPresent(String.self, forKey: ._ComplianceFlags)
        _ComplianceTag = try values.decodeIfPresent(String.self, forKey: ._ComplianceTag)
        _ComplianceTagWrittenTime = try values.decodeIfPresent(String.self, forKey: ._ComplianceTagWrittenTime)
        _ComplianceTagUserId = try values.decodeIfPresent(String.self, forKey: ._ComplianceTagUserId)
        room_TypeLookupId = try values.decodeIfPresent(String.self, forKey: .room_TypeLookupId)
        room_Type_x003a_IDLookupId = try values.decodeIfPresent(String.self, forKey: .room_Type_x003a_IDLookupId)
        pattern_x002f_Design = try values.decodeIfPresent(String.self, forKey: .pattern_x002f_Design)
        sequence_Number = try values.decodeIfPresent(Double.self, forKey: .sequence_Number)
        webUrl = try values.decodeIfPresent(String.self, forKey: .webUrl)

    }

}
