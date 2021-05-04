/* 
Copyright (c) 2021 Swift Models Generated from JSON powered by http://www.json4swift.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar

*/

import Foundation
struct Fields : Codable {
	let data : String?
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
	let appAuthorLookupId : String?
	let appEditorLookupId : String?
	let organizationidLookupId : String?
	let name : String?
	let department : String?
	let mobileno2 : String?
	let emailid : String?
	let ipaddress : String?
    let Description: String?
    var isRead:Bool?
    let addressline1: String?
    let mobileno1: String?

	enum CodingKeys: String, CodingKey {

		case data = "@odata.etag"
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
		case appAuthorLookupId = "AppAuthorLookupId"
		case appEditorLookupId = "AppEditorLookupId"
		case organizationidLookupId = "organizationidLookupId"
		case name = "name"
		case department = "department"
		case mobileno2 = "mobileno2"
		case emailid = "emailid"
		case ipaddress = "ipaddress"
        case Description = "Description"
        case isRead = "isRead"
        case addressline1 = "addressline1"
        case mobileno1 = "mobileno1"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		data = try values.decodeIfPresent(String.self, forKey: .data)
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
		appAuthorLookupId = try values.decodeIfPresent(String.self, forKey: .appAuthorLookupId)
		appEditorLookupId = try values.decodeIfPresent(String.self, forKey: .appEditorLookupId)
		organizationidLookupId = try values.decodeIfPresent(String.self, forKey: .organizationidLookupId)
		name = try values.decodeIfPresent(String.self, forKey: .name)
		department = try values.decodeIfPresent(String.self, forKey: .department)
		mobileno2 = try values.decodeIfPresent(String.self, forKey: .mobileno2)
		emailid = try values.decodeIfPresent(String.self, forKey: .emailid)
		ipaddress = try values.decodeIfPresent(String.self, forKey: .ipaddress)
        Description = try values.decodeIfPresent(String.self, forKey: .Description)
        addressline1 = try values.decodeIfPresent(String.self, forKey: .addressline1)
        isRead = try values.decodeIfPresent(Bool.self, forKey: .isRead)
        mobileno1 = try values.decodeIfPresent(String.self, forKey: .mobileno1)

	}

}
