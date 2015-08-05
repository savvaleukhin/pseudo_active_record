require_relative "../lib/pseudo_active_record"

## create a couple table objects
articles = PseudoActiveRecord::Table.new(name: "articles")
comments = PseudoActiveRecord::Table.new(name: "comments")

## create an article with some positive comments
a1 = articles.insert(title: "First Article",
                     body: "Short body of the first article")

comments.insert(body: "First comment for Article 1", article_id: a1[:id])
comments.insert(body: "Second comment for Article 1",   article_id: a1[:id])

## create an article with some negative comments
a2 = articles.insert(title: "Second article",
                     body: "Shord body of the second article")

comments.insert(body: "First comment for Article 2", article_id: a2[:id])
comments.insert(body: "Second comment for Article 2", article_id: a2[:id])
comments.insert(body: "Third comment for Article 2", article_id: a2[:id])

## Display the articles and their comments
articles.all.each do |article|
  responses = comments.where(article_id: article[:id])

  puts %{
    TITLE: #{article[:title]}
    BODY: #{article[:body]}
    COMMENTS:\n#{responses.map { |e| "    - #{e[:body]}" }.join("\n") }
  }
end

comments.all.each do |comment|
  puts "delete comment: #{comment[:body]}"
  comments.delete({id: comment[:id]})
end

articles.all.each do |article|
  articles.delete({id: article[:id]})
end
