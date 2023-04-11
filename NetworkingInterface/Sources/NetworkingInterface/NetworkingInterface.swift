import Core
import Domain
import Moya

public protocol NetworkingModuleInterface: Module {
    @discardableResult
    func getSearch(query: String, completion: @escaping ([ItemDetail]?, Error?) -> Void) -> Cancellable?
}
