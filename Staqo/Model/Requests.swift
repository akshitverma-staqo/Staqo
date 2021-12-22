/* 
Copyright (c) 2021 Swift Models Generated from JSON powered by http://www.json4swift.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar

*/

import Foundation
struct Requests : Codable {
    var created_time : String?
    var requestid : String?
    var subject : String?
    var description : String?
    var due_by_time : String?
    var status : String?

    enum CodingKeys: String, CodingKey {

        case created_time = "created_time"
        case requestid = "requestid"
        case subject = "subject"
        case description = "description"
        case due_by_time = "due_by_time"
        case status = "status"
    }
    init() {
        
    }
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        created_time = try values.decodeIfPresent(String.self, forKey: .created_time)
        requestid = try values.decodeIfPresent(String.self, forKey: .requestid)
        subject = try values.decodeIfPresent(String.self, forKey: .subject)
        description = try values.decodeIfPresent(String.self, forKey: .description)
        due_by_time = try values.decodeIfPresent(String.self, forKey: .due_by_time)
        status = try values.decodeIfPresent(String.self, forKey: .status)
    }

}
