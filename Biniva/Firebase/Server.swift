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
    let storage = Storage.storage(url: "gs://greener-964fe.appspot.com")
    let coreDatabase = DataFunction()

    
    /// - parameter center: the center coordinate of the showen mapView.
    /// - parameter radius: Should be in meters.
    /// - parameter notInPoints: [Points] that already exist nad shouldn't be downloaded from the server.
    /// - returns: Escaping parameter about function success.
    /// - warning: Firestore Query gets only maximum 10 array at once. So the function is divided.
    /// - warning: GeoPoints are stored in Points CoreModel and should be gotten from there.
    func getGeoPoints(centerCoordinate center: CLLocationCoordinate2D,
                      radius: Double,
                      notInPoints: [Points],
                      result: @escaping(_ points: [Points]) -> Void) {
        
        // First elements is added because of unebling to query empty notIt array in some cases.
        let notInGeohashes: Array<[String]> = prepareGeohashes(forPoints: notInPoints)
        
        let queries = prepareQuery(forLocation: center, withRadius: radius, geohashes: notInGeohashes)
        
        for query in queries {
            query.getDocuments(completion: { (snapshot, error) in
                guard let documents = snapshot?.documents else {
                    print("Unable to fetch snapshot data. \(String(describing: error))")
                    return
                }
                guard documents.count > 0 else {
                    result([])
                    return
                }
                
                for document in documents {
                    DispatchQueue.main.async {
                        self.coreDatabase.addPoint(latitude: document.data()["lat"] as? Double ?? 0,
                                                   longitude: document.data()["lng"] as? Double ?? 0,
                                                   materials: document.data()["trash_types"] as? [Int] ?? [0],
                                                   geohash: document.data()["geohash"] as? String ?? "",
                                                   id: document.documentID, result: { (point) in
                                                    result(point)
                        })
                    }
                }
            })
        }
    }
    
    /// Function for preparing Geohashes for future extracting Queries.
    /// - parameter points: [Points] whose geohashes we going to extract and use as filter.
    /// - warning: Output is Array<[String]> because Firestore Query gets only maximum 10 count array at once.
    fileprivate
    func prepareGeohashes(forPoints points: [Points]) -> Array<[String]> {
        var resultArray: Array<[String]> = []
        var addArray: [String] = []
        
        for point in points {
            guard let geohash = point.geohash else { continue }
            addArray.append(geohash)
            
            if addArray.count > 9 {
                resultArray.append(addArray)
                addArray.removeAll()
            }
        }
        
        return resultArray
    }
    
    /// Function for preparing Queries for future extracting Points from the server.
    /// - parameter geohashes: Array<[String]>  with arrays 10-size array of Geohashes that used as filter for future extraction.
    fileprivate
    func prepareQuery(forLocation center: CLLocationCoordinate2D,
                      withRadius radius: Double,
                      geohashes: Array<[String]>) -> [Query] {
        let queryBounds = GFUtils.queryBounds(forLocation: center, withRadius: radius)
        
        var resultQuery: Set<Query> = []
        
        for part in geohashes {
            // Query only that geohashes that isn't storing.
            let queries = queryBounds.map { bound -> Query in
                return db.collection("points")
                    .whereField("geohash", notIn: part)
                    .order(by: "geohash")
                    .start(at: [bound.startValue])
                    .end(at: [bound.endValue])
            }
            
            resultQuery = resultQuery.union(queries)
        }
        
        return Array(resultQuery) as [Query]
    }
    
    
    /// Function for loading array with images URLs.
    /// - parameter pid: PointID in the server.
    /// - parameter result: escaping property with [String] image URLs.
    func getImagesArray(forPointID pid: String?, result: @escaping(_ images: [String]) -> Void) {
        guard let pid = pid else { return }
        let docRef = db.collection("points").document(pid)

        docRef.getDocument { (document, error) in
            guard (error == nil) else {
                result([])
                return
            }
            
            if let document = document, document.exists {
                let data = document.data()
                let imagesArray = data?["photos"] as? [String] ?? []
                result(imagesArray)
            } else {
                print("Document does not exist")
            }
        }
    }
    
    
    /// This function is called when user manualy add new Bin Point.
    /// - warning: The data uploading in the separate folder for future administration.
    func createNewPoint(forCoorinate coordinate: CLLocationCoordinate2D,
                        withMaterials materials: [Int],
                        andImages images: [UIImage?]) {
        let hash = GFUtils.geoHash(forLocation: coordinate)

        let documentData: [String: Any] = [
            "geohash": hash,
            "lat": coordinate.latitude,
            "lng": coordinate.longitude,
            "trash_types": materials
        ]

        var ref: DocumentReference? = nil
        ref = db.collection("points_moderation").addDocument(data: documentData) { (err) in
            guard (err == nil) else { return }
            guard (images.count > 0) else { return }
            
            self.addPointImage(forDocumentID: ref!.documentID, images: images, result: { (imageURLs) in
                self.db.collection("points_moderation").document(ref!.documentID).updateData([
                    "photos": imageURLs
                ])
            })
        }
    }
    
    
    fileprivate
    func addPointImage(forDocumentID documentID: String, images: [UIImage?], result: @escaping(_ strings: [String]) -> Void) {
        print("addPointImage for documentID: \(documentID)")
        let storageRef = storage.reference()
        var imageURLs: [String] = []
        for image in images {
            
            guard let image = image else { return }
            
            let data = image.jpegData(compressionQuality: 0.1)
            let imageRef = storageRef.child("Points").child(documentID).child("\(NSUUID().uuidString).jpg")
            
            _ = imageRef.putData(data!, metadata: nil) { (metadata, error) in
                if let error = error {
                    print("Upload error: \(error.localizedDescription)")
                    return
                }
                
                guard metadata != nil else { return }
                
                imageRef.downloadURL { (url, error) in
                    guard let addURL = url?.absoluteString else { return }
                    
                    imageURLs.append(addURL)
                    
                    if imageURLs.count == images.count {
                        result(imageURLs)
                    }
                }
                
            }
        }
        }

    
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
