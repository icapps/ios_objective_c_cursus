import Faro

class Post: NSObject, Codable {
    @objc let id: Int

    init(id: Int) {
        self.id = id
    }
}
