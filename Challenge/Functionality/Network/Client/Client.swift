import Foundation
import Alamofire

/**
 Responsible for sending up coming request to server
 */
class Client: ClientManager {
    let sendRequest = SendRequest()
    
    /**
     Send request to alamofire.
     - parameter request: The request that is going to send to server.
     Note: Alamofire will handle the rest of the stuff ( like queue etc. )
     */
    func enqueueRequest(_ request: Request) {
        self.sendRequest.sendRequest(request, success: { (result, response) in
            request.handleSuccessResponse(result, response: response)
        }) { (error, response) in
            request.handleError(error, response: response)
        }
    }
}
