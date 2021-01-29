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
    
    
    static func AuthUser(withEmail: String, password: String) {
        Auth.auth().signIn(withEmail: withEmail, password: password) { (authResult, error) in
            guard (error == nil) else { return }
            UserInformation.userId = authResult?.user.uid
        }
    }
    
    
    static func ReturnArrayWithPostDictonaties(postDetails: @escaping (_ result: Array<Dictionary<String, Any>>) -> Void) {
        self.GetMeetingsIDs(meetingsArray: { result in
            var returnArray: Array<Dictionary<String, Any>> = []
            for element in result! {
                self.PostDetails(postWithId: element, postDetails: { data in
                    returnArray.append(data)
                    postDetails(returnArray)
                })
            }
        })
    }

    
    
    private static func PostDetails(postWithId mid: String, postDetails: @escaping (_ result: [String : Any]) -> Void) {
//        Function returns dictionary with post details.
        let postRef = ref.child("meetings").child(mid)
        postRef.observe(DataEventType.value, with: { (snapshot) in
            var userDict = snapshot.value as? [String : Any] ?? [:]
            userDict.merge(dict: ["mid": mid])
            postDetails(userDict)
        })
    }
    
    private static func GetMeetingsIDs(meetingsArray: @escaping (_ result: Array<String>?) -> Void) {
//        Function that returns array with meetings ids. Can be used on the main screen.
        let meetingsRef = ref.child("meetings")
        meetingsRef.observe(.value, with: {snapshot in
            var returnArray: Array<String> = []
            for child in snapshot.children{
                let snap = child as! DataSnapshot
                returnArray.append(snap.key)
            }
            meetingsArray(returnArray)
        })
    }

    
    
    
    static func GetUserMeetingsArray(withUserId uid: String, withType: String, postDetails: @escaping (_ result: Array<String>?) -> Void) {
//        Working function that returns special array. Can be used for any purposes.
        let postRef = ref.child("users").child(uid).child("meetings").child(withType)
        postRef.observeSingleEvent(of: DataEventType.value, with: { (snapshot) in
            let userArray = snapshot.value as? Array<String> ?? []
            postDetails(userArray)
        })
    }
    
    
    static func GetMeetingJoinedArray(withMeetingId mid: String, postDetails: @escaping (_ result: Array<String>?) -> Void) {
//        Working function that returns special array. Can be used for any purposes.
        let postRef = ref.child("meetings").child(mid).child("joined")
        postRef.observeSingleEvent(of: DataEventType.value, with: { (snapshot) in
            let meetArray = snapshot.value as? Array<String> ?? []
            postDetails(meetArray)
            postRef.removeAllObservers()
        })
    }
    
    
    static func JoinMeeting(withUserId uid: String, meetingId mid: String, andType type: String) {
//        Working function that Add meeting id on the server. Should be extended be Meeting Id.
        let userRef = ref.child("users").child(uid).child("meetings")
        switch type {
        case "join":
            Server.GetUserMeetingsArray(withUserId: uid, withType: "joined_meetings") {postDetails in
                var newArray = postDetails
                newArray?.append(mid)
                userRef.child("joined_meetings").setValue(newArray)
                userRef.removeAllObservers()
            }
            Server.GetMeetingJoinedArray(withMeetingId: mid) {postDetails in
                var newArray = postDetails
                newArray?.append(uid)
                ref.child("meetings").child(mid).child("joined").setValue(newArray)
            }
        default:
            print("Join Meeting default")
            Server.GetUserMeetingsArray(withUserId: uid, withType: "created_meetings") {postDetails in
                var newArray = postDetails
                newArray?.append(mid)
                userRef.child("created_meetings").setValue(newArray)
                userRef.removeAllObservers()
            }
        }
    }
    
    
    static func CreateMeeting(withData data: Dictionary<String, Any>, andUserId uid: String) {
        let postRef = ref.child("meetings").childByAutoId()
        postRef.setValue(data)
        print("Created meeting id: \(postRef.key), userId: \(uid)")
        JoinMeeting(withUserId: uid, meetingId: postRef.key!, andType: "creat")
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
