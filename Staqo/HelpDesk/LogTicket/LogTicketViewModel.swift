//
//  LogTicketViewModel.swift
//  Staqo
//
//  Created by SHAILY on 01/04/21.
//

import Foundation


protocol TSModelDelegate:class {
    func ticketUploadStatus()
    func didStopLoader()
}
class LogTicketViewModel: ViewModelType {
    var _delegate:TSModelDelegate?

    var delegate: ViewModelDelegate?
    var rows : [Categories]?
    var prjectrows : [ProjectModel]?
    var rowsSubCat : [Subcategories]?
    var helpdesk : [HelpdeskModel]?
    //var imageUploadData :(file: String, ID: String, fileName:String)?
    var file:String?
    var fileName:String?
    private let dataSource:LogTicketDataSourceDelegate?
    init(dataSource: LogTicketDataSourceDelegate) {
        self.dataSource = dataSource
    }
    
    func bootstrap() {
        getCatergoryData()
        //getCompanyyData()
    }
    
    func ticketImageUpload(file: String, ID:String, fileName:String){
        delegate?.willLoadData()
        dataSource?.ticketImageUpload(file: file, ID:ID, fileName:fileName, completion: {[weak self] result in
            guard let ws = self else{return}
            
            switch result {
            case .success(let baseModel):
                print(baseModel)
           ///   ws.rowsSubCat = baseModel.subcategories
                ws._delegate?.ticketUploadStatus()

              ws.delegate?.didLoadData()
            case .failure(let error):
                ws.delegate?.didFail(error: error)
            }
            
        })
    }
    
    func submitTicketData(desc: String, subj: String, catID: String, prioName: String, subID: String, email_ID:String, projName:String)
    {
        delegate?.willLoadData()
        dataSource?.submitTicketData(desc: desc, subj: subj, catID: catID, prioName: prioName, subID: subID, email_ID: email_ID, projName: projName, completion: {[weak self] result in
            guard let ws = self else{return}
            
            switch result {
            case .success(let baseModel):
                print(baseModel)
           ///   ws.rowsSubCat = baseModel.subcategories
                if ws.fileName == nil {
                    ws._delegate?.ticketUploadStatus()
                }else{
                    ws.ticketImageUpload(file: ws.file ?? "", ID: baseModel.helpdesk_request1?.request?.id ?? "", fileName: ws.fileName ?? "")
                }
                
               
            //  ws.delegate?.didLoadData()
            case .failure(let error):
                ws.delegate?.didFail(error: error)
            }
            
        })
    }
    
    func getSubCatType(ID:String){
          
      delegate?.willLoadData()
      dataSource?.getSubCatData(ID:ID ,completion: {[weak self] result in
          guard let ws = self else{return}
          
          switch result {
          case .success(let baseModel):
              print(baseModel)
            ws.rowsSubCat = baseModel.subcategories
            ws._delegate?.didStopLoader()
          case .failure(let error):
              ws.delegate?.didFail(error: error)
          }
          
      })

}
    
    
  
    
    func getCatergoryData(){
          
      delegate?.willLoadData()
      dataSource?.getCatData(completion: {[weak self] result in
          guard let ws = self else{return}
          
          switch result {
          case .success(let baseModel):
              print(baseModel)
            if baseModel.status == "fail" {
                ws.delegate?.didLoadData()
            }else{
                ws.rows = baseModel.categories
                ws.delegate?.didLoadData()
            }
            
             
          case .failure(let error):
              ws.delegate?.didFail(error: error)
          }
          
      })

}
    
    
    func getCompanyyData(){
          
      delegate?.willLoadData()
      dataSource?.getCompanyData(completion: {[weak self] result in
          guard let ws = self else{return}
          
          switch result {
          case .success(let baseModel):
              print(baseModel)
            ws.prjectrows = baseModel
            ws.delegate?.didLoadData()
             
          case .failure(let error):
              ws.delegate?.didFail(error: error)
          }
          
      })

}
    
    
   
    
}

