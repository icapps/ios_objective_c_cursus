import Foundation

/// The perform methods are preferred but these methods are for convenience.
/// They do some default error handling.
/// These functions are deprecated!!!
extension Service {

    // MARK: - Results transformed to Model(s)

    // MARK: - Update

    /// Performs the call to the server. Provide a model
    /// - parameter call: where can the server be found?
    /// - parameter fail: if we cannot initialize the model this call will fail and print the failure.
    /// - parameter ok: returns initialized model
    @available(*, deprecated: 1.1, obsoleted: 2.0, message: "You should use the `perform` functions in `Service` with result enum.")
    open func performUpdate<ModelType: Deserializable & Updatable>(_ call: Call, on updateModel: ModelType, autoStart: Bool = true, fail: @escaping (FaroError)->(), ok:@escaping (ModelType)->()) {
        perform(call, on: updateModel, autoStart: autoStart) { (result) in
            switch result {
            case .model(let model):
                guard let model = model else {
                    let faroError = FaroError.malformed(info: "UpdateModel \(updateModel) could not be updated. Maybe you did not implement update correctly failed?")
                    self.print(faroError, and: fail)
                    return
                }
                ok(model)
            case .models( _ ):
                let faroError = FaroError.malformed(info: "Requested a single response be received a collection.")
                self.print(faroError, and: fail)
            default:
                self.handle(result, and: fail)
            }
        }
    }

    // MARK: - Create

    // MARK: - Single model response

    /// Performs the call to the server. Provide a model
    /// - parameter call: where can the server be found?
    /// - parameter fail: if we cannot initialize the model this call will fail and print the failure.
    /// - parameter ok: returns initialized model
    @available(*, deprecated: 1.1, obsoleted: 2.0, message: "You should use the `perform` functions in `Service` with result enum.")
    open func performSingle<ModelType: Deserializable>(_ call: Call, autoStart: Bool = true, fail: @escaping (FaroError)->(), ok:@escaping (ModelType)->()) {
        perform(call, autoStart: autoStart) { (result: Result<ModelType>) in
            switch result {
            case .model(let model):
                guard let model = model else {
                    let faroError = FaroError.malformed(info: "Model could not be initialized. Maybe your init(from raw:) failed?")
                    self.print(faroError, and: fail)
                    return
                }
                ok(model)
            case .models( _ ):
                let faroError = FaroError.malformed(info: "Requested a single response be received a collection.")
                self.print(faroError, and: fail)
            default:
                self.handle(result, and: fail)
            }
        }
    }

    // MARK: - Collection model response

    /// Performs the call to the server. Provide a model
    /// - parameter call: where can the server be found?
    /// - parameter fail: if we cannot initialize the model this call will fail and print the failure.
    /// - parameter ok: returns initialized array of models
    @available(*, deprecated: 1.1, obsoleted: 2.0, message: "You should use the `perform` functions in `Service` with result enum.")
    open func performCollection<ModelType: Deserializable>(_ call: Call, autoStart: Bool = true, fail: @escaping (FaroError)->(), ok:@escaping ([ModelType])->()) {
        perform(call, autoStart: autoStart) { (result: Result<ModelType>) in
            switch result {
            case .models(let models):
                guard let models = models else {
                    let faroError = FaroError.malformed(info: "Model could not be initialized. Maybe your init(from raw:) failed?")
                    self.print(faroError, and: fail)
                    return
                }
                ok(models)
            default:
                self.handle(result, and: fail)
            }
        }
    }

    // MARK: - With Paging information

    @available(*, deprecated: 1.1, obsoleted: 2.0, message: "You should use the `perform` functions in `Service` with result enum.")
    open func performSingle<ModelType: Deserializable, PagingType: Deserializable>(_ call: Call, autoStart: Bool = true, page: @escaping(PagingType?)->(), fail: @escaping (FaroError)->(), ok:@escaping (ModelType)->()) {
        perform(call, page: page, autoStart: autoStart) { (result: Result<ModelType>) in
            switch result {
            case .model(let model):
                guard let model = model else {
                    let faroError = FaroError.malformed(info: "Model could not be initialized. Maybe your init(from raw:) failed?")
                    self.print(faroError, and: fail)
                    return
                }
                ok(model)
            default:
                self.handle(result, and: fail)
            }
        }
    }

    @available(*, deprecated: 1.1, obsoleted: 2.0, message: "You should use the `perform` functions in `Service` with result enum.")
    open func performCollection<ModelType: Deserializable, PagingType: Deserializable>(_ call: Call, page: @escaping(PagingType?)->(), fail: @escaping (FaroError)->(), ok:@escaping ([ModelType])->()) {
        perform(call, page: page) { (result: Result<ModelType>) in
            switch result {
            case .models(let models):
                guard let models = models else {
                    let faroError = FaroError.malformed(info: "Models could not be initialized. Maybe your init(from raw:) failed?")
                    self.print(faroError, and: fail)
                    return
                }
                ok(models)
            default:
                self.handle(result, and: fail)
            }
        }
    }

}
