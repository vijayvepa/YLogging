//
//  Logging.swift
//  YLogging
//
//  Created by VIJAY VEPAKOMMA on 4/8/18.
//  Copyright © 2018 VIJAY VEPAKOMMA. All rights reserved.
//

import Foundation

public class YLog{

    private var isDebug: Bool!
    
    public init() {
        self.isDebug = false
    }
    
    public func setup(isDebug: Bool){
        self.isDebug = isDebug;
        print("Logging is in debug mode: \(isDebug)");
    }
    
    public func YPrint<T>(value: T){
        if(self.isDebug == true){
            print(value)
        }else{
            //Do any stuff in prod mode.
        }
    }

}
