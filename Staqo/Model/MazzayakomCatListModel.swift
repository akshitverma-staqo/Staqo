

import Foundation
struct MazzayakomCatListModel {
    var name : String = ""
    var icon_image : String = ""
    var description : String = ""
    var id : String = ""
    
//    var Title : String = ""
//     var Description : String = ""
   

   
    init(){
        
    }

    init(json:JSON) {
        //let values = try decoder.container(keyedBy: CodingKeys.self)
        
        name = json["name"].stringValue
        icon_image = json["icon_image"].stringValue
       
        description = json["description"].stringValue
        
        id = json["id"].stringValue
        
       
       
      
    }

}
