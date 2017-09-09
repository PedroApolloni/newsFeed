//
//  Connectivity.swift
//  newsFeedApp
//
//  Created by Pedro  Apolloni on 08/09/17.
//  Copyright © 2017 Pedro  Apolloni. All rights reserved.
//

import Foundation
import Alamofire

class Connectivity {
    class var isConnectedToInternet:Bool {
        return NetworkReachabilityManager()!.isReachable
    }
}
