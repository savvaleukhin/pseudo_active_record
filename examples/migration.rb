require 'pstore'

articles = PStore.new("../pseudo_db/articles.pstore")
comments = PStore.new("../pseudo_db/comments.pstore")

articles.transaction do
  articles[0] = {
    id: "INTEGER",
    title: "TEXT",
    body: "TEXT"
  }
end

comments.transaction do
  comments[0] = {
    id: "INTEGER",
    body: "TEXT",
    article_id: "INTEGER"
  }
end
