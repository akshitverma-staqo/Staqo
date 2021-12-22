/* 
Copyright (c) 2021 Swift Models Generated from JSON powered by http://www.json4swift.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar

*/

import Foundation
struct Request : Codable {
	var subject : String?
	var description : String?
	var requester : Requester?
	var impact_details : String?
    var resolution : Resolution?
    var status : Status?
    var category : Categories?
    var subcategory : Subcategories?
    var priority : Priority?
    var id:String?
	enum CodingKeys: String, CodingKey {

		case subject = "subject"
		case description = "description"
		case requester = "requester"
		case impact_details = "impact_details"
		case resolution = "resolution"
		case status = "status"
		case category = "category"
		case subcategory = "subcategory"
		case priority = "priority"
        case id = "id"
	}
    init() {
    
    }
    init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		subject = try values.decodeIfPresent(String.self, forKey: .subject)
		description = try values.decodeIfPresent(String.self, forKey: .description)
		requester = try values.decodeIfPresent(Requester.self, forKey: .requester)
		impact_details = try values.decodeIfPresent(String.self, forKey: .impact_details)
		resolution = try values.decodeIfPresent(Resolution.self, forKey: .resolution)
		status = try values.decodeIfPresent(Status.self, forKey: .status)
		category = try values.decodeIfPresent(Categories.self, forKey: .category)
		subcategory = try values.decodeIfPresent(Subcategories.self, forKey: .subcategory)
		priority = try values.decodeIfPresent(Priority.self, forKey: .priority)
        id = try values.decodeIfPresent(String.self, forKey: .id)
	}

}
