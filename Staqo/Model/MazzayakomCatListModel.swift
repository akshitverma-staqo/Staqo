

import Foundation
struct MazzayakomCatListModel {
    var name : String = ""
    var icon_image : String = ""
    var description : String = ""
    var id : String = ""
    
    var Title : String = ""
     var Description : String = ""
   

   
    init(){
        
    }

    init(json:JSON) {
        //let values = try decoder.container(keyedBy: CodingKeys.self)
        
        name = json["LinkTitle"].stringValue
        icon_image = json["Image"].stringValue
       
        description = json["LinkTitleNoMenu"].stringValue
        
        id = json["id"].stringValue
        
        Title = json["Title"].stringValue
        
        Description = json["Description"].stringValue
        
       
       
      
    }

}
