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

    
    static func GetArray(postDetails: @escaping (_ result: Array<String>?) -> Void) {
//        Working function that returns special array. Can be used for any purposes.
        let postRef = ref.child("users").child("user_example").child("joined_meetings")
        postRef.observeSingleEvent(of: DataEventType.value, with: { (snapshot) in
            let userArray = snapshot.value as? Array<String> ?? []
            postDetails(userArray)
        })
    }
    
    
    static func JoinMeeting(element: String) {
//        Working function that Add meeting id on the server. Should be extended be Meeting Id.
        let postRef = ref.child("users").child("user_example").child("joined_meetings")
        Server.GetArray() {postDetails in
            var newArray = postDetails
            newArray?.append(element)
            postRef.setValue(newArray)
            postRef.removeAllObservers()
        }
    }
    
    
    static func CreateMeeting(withData data: Dictionary<String, Any>) {
        let postRef = ref.child("meetings").childByAutoId()
        postRef.setValue(data)
    }
    
    
    static func CreateUser(withData data: Dictionary<String, Any>, andProfileImage image: UIImage) {
        let email: String = data["email"] as! String
        let password: String = data["password"] as! String
        Auth.auth().createUser(withEmail: email, password: password, completion: {(user,error) in
            if let error = error{ print(error.localizedDescription) }
            if let user = user{
                ref.child("users").child(user.user.uid).setValue(data)
                self.AddUserImage(forUserWith: user.user.uid, image: image)
            }
        })
    }
    
    
    static func AddUserImage(forUserWith userId: String, image: UIImage) {
        let storageRef = Storage.storage().reference()
        let data = image.jpegData(compressionQuality: 0.3)
        let avatarRef = storageRef.child("users").child("\(userId)_avatar.jpg")
        _ = avatarRef.putData(data!, metadata: nil) { (metadata, error) in
            guard metadata != nil else { return }
            avatarRef.downloadURL { (url, error) in
                guard url != nil else { return }
                ref.child("users/\(userId)/image").setValue(url?.absoluteString)
            }
        }
    }
}
