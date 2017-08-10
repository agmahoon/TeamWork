//
//  ClientManagerMock.swift
//  TeamWorkChallengeTests
//
//  Created by Abdul Ghafoor on 09/08/2017.
//  Copyright © 2017 Abdul Ghafoor. All rights reserved.
//

import Foundation
@testable import TeamWorkChallenge

/** Mocks client retrieval */
class ClientManagerMock: ClientManager {
    let sendRequest = SendRequestMock()
    
    func enqueueRequest(_ request: Request) {
        self.sendRequest.sendRequest(request, success: { (result, response) in
            request.handleSuccessResponse(result, response: response)
        }) { (error, response) in
            request.handleError(error, response: response)
        }
    }
}
