import Faro

class Post: NSObject, Codable {
    @objc let id: Int
    @objc let message: String?
    @objc let title: String
    @objc let userId: Int

    @objc init(id: Int, message: String?, title: String, userId: Int) {
        self.id = id
        self.message = message
        self.title = title
        self.userId = userId
    }

    private enum CodingKeys: String, CodingKey {
        case id
        case title
        case message = "body"
        case userId
    }

}

extension Post {

    @objc func foo () {

    }
}
