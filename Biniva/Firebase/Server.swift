//
//  File.swift
//  GreenerCo
//
//  Created by Никита Олтян on 23.01.2021.
//

import Foundation
import Firebase
import GeoFire
import CoreLocation

class Server {

    /// Database reference
    let db = Firestore.firestore()
    
    func loadPoints(minXminYlat: CLLocationDegrees,
                    minXminYlong: CLLocationDegrees,
                    maxXminYlong: CLLocationDegrees,
                    minXmaxYlat: CLLocationDegrees){
//        points: @escaping (_ result: [TrashBin]) -> Void
        print("Server, loadPoints")
        print(minXminYlat, minXminYlong, maxXminYlong, minXmaxYlat)
        db.collection("points")
            .whereField("latitude", isGreaterThan: Float(minXmaxYlat))
            .whereField("latitude", isLessThan: Float(minXminYlat))
            .whereField("longitude", isGreaterThan: Float(minXminYlong))
            .whereField("longitude", isLessThan: Float(maxXminYlong))
            .getDocuments(completion: { (querySnapshot, err) in
                if let err = err {
                    print("Error getting documents: \(err)")
                } else {
                    for document in querySnapshot!.documents {
                        print("\(document.documentID) => \(document.data())")
                    }
                }
            })
    }
    
    
    // That works and should be extended.
    func addGeoPoint() {
        let latitude = 55.794698
        let longitude = 37.929111
        let location = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)

        let hash = GFUtils.geoHash(forLocation: location)

        // Add the hash and the lat/lng to the document. We will use the hash
        // for queries and the lat/lng for distance comparisons.
        let documentData: [String: Any] = [
            "geohash": hash,
            "lat": latitude,
            "lng": longitude
        ]

        db.collection("points").addDocument(data: documentData)
    }
    
    /// - parameter radius: Should be in meters.
    func getGeoPoints(centerCoordinate center: CLLocationCoordinate2D, radius: Double) {
        let queryBounds = GFUtils.queryBounds(forLocation: center,
                                              withRadius: radius)
        
        let queries = queryBounds.map { bound -> Query in
            return db.collection("points")
                .order(by: "geohash")
                .start(at: [bound.startValue])
                .end(at: [bound.endValue])
        }
        
        var matchingDocs = [QueryDocumentSnapshot]()
        func getDocumentsCompletion(snapshot: QuerySnapshot?,  error: Error?) -> () {
            guard let documents = snapshot?.documents else {
                print("Unable to fetch snapshot data. \(String(describing: error))")
                return
            }

            for document in documents {
                let lat = document.data()["lat"] as? Double ?? 0
                let lng = document.data()["lng"] as? Double ?? 0
                let coordinates = CLLocation(latitude: lat, longitude: lng)
                let centerPoint = CLLocation(latitude: center.latitude, longitude: center.longitude)

                // We have to filter out a few false positives due to GeoHash accuracy, but most will match
                let distance = GFUtils.distance(from: centerPoint, to: coordinates)
                if distance <= radius {
                    matchingDocs.append(document)
                    print(matchingDocs)
                }
            }
        }
        
        for query in queries {
            query.getDocuments(completion: getDocumentsCompletion)
        }
        
    }
    
    
    
    func test() {
        var ref: DocumentReference? = nil
        // Thats add location properly.
        // I will not use it. It doesnt allow me to iterate through data.
        let geoPoint: GeoPoint = Firebase.GeoPoint(latitude: 54.456, longitude: 54.456)
        ref = db.collection("users").addDocument(data: [
            "first": "Ada",
            "last": "Lovelace",
            "born": 1815,
            "location": geoPoint
        ]) { err in
            if let err = err {
                print("Error adding document: \(err)")
            } else {
                print("Document added with ID: \(ref!.documentID)")
            }
        }
        ref?.delete()
    }
    
    func testGet() {
        db.collection("users").getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents {
                    // String
                    print(type(of: document.documentID))
                    // [String: Any]
                    print(type(of: document.data()))
                }
            }
        }
    }
    
    /// That custome getDocument works! That's how I can retrieve only iformation for right locations.
    func testAnother() {
        db.collection("users")
            .whereField("born", isGreaterThan: 1800)
            .whereField("born", isLessThan: 1900)
            .getDocuments(completion: { (querySnapshot, err) in
                if let err = err {
                    print("Error getting documents: \(err)")
                } else {
                    for document in querySnapshot!.documents {
                        print("\(document.documentID) => \(document.data())")
                    }
                }
            })
    }
    
    /// Authentificate user via Email and pssword by Firebase Auth.
    /// - warning: Function also add User ID into UserDefaults.
//    static func AuthUser(withEmail: String, password: String, success: @escaping (_ result: Bool) -> Void) {
//        Auth.auth().signIn(withEmail: withEmail, password: password) { (authResult, error) in
//            guard (error == nil) else {
//                success(false)
//                return
//            }
//            print("Auth user")
//            SetUserDailyNormFromServer(forUserID: authResult?.user.uid, success: { result in
//                guard (result) else { return }
//                Defaults.SetUserId(userId: authResult?.user.uid)
//                Defaults.SetHasLaunched(launched: true)
//                success(true)
//            })
//        }
//    }
    
    
//    static func ReturnArrayWithPostDictonaries(postDetails: @escaping (_ result: Array<Dictionary<String, Any>>) -> Void) {
//        self.GetMeetingsIDs(meetingsArray: { result in
//            var returnArray: Array<Dictionary<String, Any>> = []
//            for element in result! {
//                self.PostDetails(postWithId: element, postDetails: { data in
//                    returnArray.append(data)
//                    postDetails(returnArray)
//                })
//            }
//        })
//    }
//
//
//    static func GetUserDailyNotm(userId uid: String, result: @escaping (_ result: Int) -> Void) {
//        let useRef = ref.child("users").child(uid)
//        useRef.observe(.value, with: { (snapshot) in
//            let data = snapshot.value as? [String : Any] ?? [:]
//            result(data["daily_norm"] as! Int)
//        })
//    }

    
    /// Function returns dictionary with post details (including username and user avatar link).
    /// - parameter mid: Meeting ID
    /// - parameter postDetails: Returning Dictionary
//    static func PostDetails(postWithId mid: String, postDetails: @escaping (_ result: [String : Any]) -> Void) {
//        let postRef = ref.child("meetings").child(mid)
//        postRef.observe(DataEventType.value, with: { (snapshot) in
//            var postDict = snapshot.value as? [String : Any] ?? [:]
//            postDict.merge(dict: ["mid": mid])
//            self.ReturnUserData(userId: postDict["user_id"] as! String, userDetails: { returnDict in
//                postDict.merge(dict: returnDict)
//                postDetails(postDict)
//            })
//        })
//    }
    
    
    /// Function for returning a Dictionary with two user data: username and image url. That dictionary can be added to post or message details.
    /// - warning: There must be not nil User ID.
    /// - parameter uid: requested User ID
    /// - parameter userDetails: Function return
    /// - returns: Dictionary with two user data: Username and Image URL.
//    static func ReturnUserData(userId uid: String, userDetails: @escaping (_ result: [String : Any]) -> Void) {
//        let userRef = ref.child("users").child(uid)
//        userRef.observe(DataEventType.value, with: { (snapshot) in
//            let userDict = snapshot.value as? [String : Any] ?? [:]
//            var returnDict: Dictionary<String, Any> = [:]
//            returnDict.merge(dict: ["username": userDict["username"] as Any])
//            returnDict.merge(dict: ["image": userDict["image"] as Any])
//            userDetails(returnDict)
//        })
//    }
    
    
//    private static func GetMeetingsIDs(meetingsArray: @escaping (_ result: Array<String>?) -> Void) {
//        Function that returns array with meetings ids. Can be used on the main screen.
//        let meetingsRef = ref.child("meetings")
//        meetingsRef.observe(.value, with: {snapshot in
//            var returnArray: Array<String> = []
//            for child in snapshot.children{
//                let snap = child as! DataSnapshot
//                returnArray.append(snap.key)
//            }
//            meetingsArray(returnArray)
//        })
//    }

    
    
    
//    static func GetUserMeetingsArray(withUserId uid: String, withType: String, postDetails: @escaping (_ result: Array<String>?) -> Void) {
//        Working function that returns special array. Can be used for any purposes.
//        let postRef = ref.child("users").child(uid).child("meetings").child(withType)
//        postRef.observeSingleEvent(of: DataEventType.value, with: { (snapshot) in
//            let userArray = snapshot.value as? Array<String> ?? []
//            postDetails(userArray)
//        })
//    }
    
    
    /// Returns Array with User ID of joined users.
//    static func GetMeetingJoinedArray(withMeetingId mid: String?, result: @escaping (_ result: Array<String>?) -> Void) {
//        guard (mid != nil) else { return }
//        let postRef = ref.child("meetings").child(mid!).child("joined")
//        postRef.observeSingleEvent(of: DataEventType.value, with: { (snapshot) in
//            let meetArray = snapshot.value as? Array<String> ?? []
//            result(meetArray)
//            postRef.removeAllObservers()
//        })
//    }
//
//
//    static func JoinMeeting(withUserId uid: String, meetingId mid: String, andType type: String) {
//        Working function that Add meeting id on the server. Should be extended be Meeting Id.
//        let userRef = ref.child("users").child(uid).child("meetings")
//        switch type {
//        case "join":
//            Server.GetUserMeetingsArray(withUserId: uid, withType: "joined_meetings") {postDetails in
//                var newArray = postDetails
//                newArray?.append(mid)
//                userRef.child("joined_meetings").setValue(newArray)
//                userRef.removeAllObservers()
//            }
//            Server.GetMeetingJoinedArray(withMeetingId: mid) {postDetails in
//                var newArray = postDetails
//                newArray?.append(uid)
//                ref.child("meetings").child(mid).child("joined").setValue(newArray)
//            }
//        default:
//            print("Join Meeting default")
//            Server.GetUserMeetingsArray(withUserId: uid, withType: "created_meetings") {postDetails in
//                var newArray = postDetails
//                newArray?.append(mid)
//                userRef.child("created_meetings").setValue(newArray)
//                userRef.removeAllObservers()
//            }
//        }
//    }
//
//
//    static func CreateMeeting(withData data: Dictionary<String, Any>, andUserId uid: String) {
//        let postRef = ref.child("meetings").childByAutoId()
//        postRef.setValue(data)
//        JoinMeeting(withUserId: uid, meetingId: postRef.key!, andType: "creat")
//    }
    
    
    /// Function for returning an Array with Dictionaries. Each dictonary –– one message information.
    /// - warning: Multiple returns. After each got message dictionary function returns updated Array.
    /// - parameter mid: requested Meeting ID
    /// - parameter messages: Return
    /// - returns: Array with Dictionaries. Each dictonary –– one message information.
//    static func GetMessages(meetingId mid: String, messages: @escaping (_ result: Array<Dictionary<String, Any>>) -> Void) {
//        let messagesRef = ref.child("meetings").child(mid).child("messages")
//        var returnArray: Array<Dictionary<String, Any>> = []
//        messagesRef.queryOrdered(byChild: "date").observe( .childAdded, with: { (snapshot) in
//            var messageDict = snapshot.value as? [String: Any] ?? [:]
//            self.ReturnUserData(userId: messageDict["uid"] as! String, userDetails: { returnDict in
//                messageDict.merge(dict: returnDict)
//                returnArray.append(messageDict)
//                messages(returnArray)
//            })
//        })
//    }
    
    
    /// Function for posting message into meeting.
    /// - parameter uid: User ID
    /// - parameter mid: Meeting ID
    /// - parameter text: Text of the sending massage
//    static func SendMessage(user uid: String, meetingId mid: String, massageText text: String) {
//        let date = Date()
//        let useDay: String = "\(date.day) \(date.month)"
//        let messagesRef = ref.child("meetings").child(mid).child("messages").childByAutoId()
//        let useDict: Dictionary<String, Any> = ["uid": uid, "text": text, "timestamp": ServerValue.timestamp(), "date": useDay]
//        messagesRef.setValue(useDict)
//    }
    
    
    /// Function for creating user.
    /// To add user profile image that function calling another after user creation complited.
    /// After user creation complitedfunction also set user ID from the server to "uid" key for UserDefaults and "daily_norm" to "dailyNorm".
    /// - parameter data: All user data got from registration fields.
    /// - parameter image: User profile image.
//    static func CreateUser(withData data: Dictionary<String, Any>, andProfileImage image: UIImage) {
//        let email: String = data["email"] as! String
//        let password: String = data["password"] as! String
//        Auth.auth().createUser(withEmail: email, password: password, completion: {(user,error) in
//            if let error = error{ print(error.localizedDescription) }
//            if let user = user{
//                Defaults.RegistrateUser(withID: user.user.uid, andDailyNorm: data["daily_norm"] as! Int)
//                ref.child("users").child(user.user.uid).setValue(data)
//                self.AddUserImage(forUserWith: user.user.uid, image: image)
//            }
//        })
//    }
    
    
//    static func AddUserImage(forUserWith userId: String, image: UIImage) {
//        let storageRef = Storage.storage().reference()
//        let data = image.jpegData(compressionQuality: 0.3)
//        let avatarRef = storageRef.child("users").child("\(userId)_avatar.jpg")
//        _ = avatarRef.putData(data!, metadata: nil) { (metadata, error) in
//            guard metadata != nil else { return }
//            avatarRef.downloadURL { (url, error) in
//                guard url != nil else { return }
//                ref.child("users/\(userId)/image").setValue(url?.absoluteString)
//            }
//        }
//    }
    
    
    ///Seting user daily norm from server.
    /// - warning: Call Defults to set data to UserDefaults.
//    static func SetUserDailyNormFromServer(forUserID uid: String?, success: @escaping (_ result: Bool) -> Void) {
//        guard (uid != nil) else { return }
//        let userRef = ref.child("users").child(uid!)
//        userRef.observeSingleEvent(of: DataEventType.value, with: { (snapshot) in
//            let userData = snapshot.value as? [String: Any] ?? [:]
//            Defaults.SetUserDailyNorm(userNorm: userData["daily_norm"] as! Int)
//            success(true)
//        })
//    }
//
//
//
//    static func GetUserMainData(forUserId uid: String?, userData: @escaping (_ result: Dictionary<String, Any>) -> Void) {
//        guard (uid != nil) else { return }
//        var resultDict: Dictionary<String, Any> = [:]
//        let userRef = ref.child("users").child(uid!)
//        userRef.observe(DataEventType.value, with: { (snapshot) in
//            let userDict = snapshot.value as? [String : Any] ?? [:]
//            resultDict["email"] = userDict["email"] as! String
//            self.ReturnUserData(userId: uid!, userDetails: { result in
//                resultDict.merge(dict: result)
//                userData(resultDict)
//            })
//            userRef.removeAllObservers()
//        })
//    }
    
    /// Function for returning all user data for given uid.
    /// - parameter uid: User ID
    /// - parameter userData: Returning Dictionary.
//    static func GetAllUserData(forUserId uid: String?, userData: @escaping (_ result: Dictionary<String, Any>) -> Void) {
//        guard (uid != nil) else { return }
//        let userRef = ref.child("users").child(uid!)
//        userRef.observe(DataEventType.value, with: { (snapshot) in
//            let userDict = snapshot.value as? [String : Any] ?? [:]
//            userData(userDict)
//            userRef.removeAllObservers()
//        })
//    }
//
//
//    static func GetLastSevenDaysLoggedData(forUserId uid: String?, data: @escaping (_ result: Dictionary<String, Any>) -> Void){
//        guard (uid != nil) else { return }
//        let userRef = ref.child("users").child(uid!).child("data_logged").queryOrdered(byChild: "timestamp").queryLimited(toLast: 7)
//        userRef.observe(.childAdded, with: { (snapshot) in
//            let dataDict = snapshot.value as? [String : Any] ?? [:]
//            data(dataDict)
//        })
//    }
}