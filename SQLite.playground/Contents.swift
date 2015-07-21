import SQLite

let db = try! Connection()

db.trace(print)

let users = Table("users")

let id = Expression<Int64>("id")
let email = Expression<String>("email")
let name = Expression<String?>("name")

try! db.run(users.create { t in
    t.column(id, primaryKey: true)
    t.column(email, unique: true, check: email.like("%@%"))
    t.column(name)
})

try! db.run(users.insert(email <- "alice@mac.com"))

let emails = VirtualTable("emails")

let subject = Expression<String?>("subject")
let body = Expression<String?>("body")

try! db.run(emails.create(.FTS4(subject, body)))

try! db.run(emails.insert(
    subject <- "Hello, world!",
    body <- "This is a hello world message."
))

let row = try! db.pluck(emails.match("hello"))

let query = try! db.prepare(emails.match("hello"))
for row in query {
    print(row[subject])
}
