//
//  File.swift
//  GreenerCo
//
//  Created by Никита Олтян on 23.01.2021.
//

import Foundation
import Firebase

class Server {

    static var ref: DatabaseReference {
           return Database.database(url: "https://greener-964fe-default-rtdb.europe-west1.firebasedatabase.app/").reference()
    }
    
    
    static func PostDetails(postWithId id: String, postDetails: @escaping (_ result: [String : AnyObject]) -> Void) {
//        Function isn't ready yet! There's test sample with user info, but should be post.
        let postRef = ref.child("users").child("user_example")
        postRef.observe(DataEventType.value, with: { (snapshot) in
            let userDict = snapshot.value as? [String : AnyObject] ?? [:]
            postDetails(userDict)
        })
    }

    
    static func TestArray(postDetails: @escaping (_ result: Array<AnyObject>?) -> Void) {
//        Working function that returns special array. Can be used for any purposes.
        let postRef = ref.child("users").child("user_example").child("array")
        postRef.observe(DataEventType.value, with: { (snapshot) in
            let userArray = snapshot.value as? Array<AnyObject>
            postDetails(userArray)
        })
    }
}
