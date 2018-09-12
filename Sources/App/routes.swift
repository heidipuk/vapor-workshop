import Vapor

/// Register your application's routes here.
public func routes(_ router: Router) throws {
    // Basic "Hello, world!" example
    router.get("hello") { req in
        return "Hello, world!"
    }

    // Example of configuring a controller
    let todoController = TodoController()
    let todos = router.grouped("todos")
    let todo = todos.grouped(Todo.parameter)
    
    let secureTodos = todos.grouped(SecretMiddleware.self)
    let secureTodo = todo.grouped(SecretMiddleware.self)
    todos.get(use: todoController.index)
    todo.get(use: todoController.view)
    secureTodos.post(use: todoController.create)
    secureTodo.patch(use: todoController.update)
    todo.delete(use: todoController.delete)
    todos.delete(use: todoController.clear)
}
