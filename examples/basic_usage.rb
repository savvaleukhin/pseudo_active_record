require_relative "../lib/pseudo_active_record"

class Article
  include PseudoActiveRecord::Mapping

  map_to_table :articles

  has_many :comments, :key   => :article_id,
                      :class => "Comment"
end

class Comment
  include PseudoActiveRecord::Mapping

  map_to_table :comments

  belongs_to :article, :key   => :article_id,
                       :class => "Article"
end


article1 = Article.create(:title => "A great article",
                          :body  => "Short but sweet!")

Comment.create(:body => "Supportive comment!", :article_id => article1.id)
Comment.create(:body => "Friendly comment!",   :article_id => article1.id)

## Create an article with a few negative comments.

article2 = Article.create(:title => "A not so great article",
                          :body  => "Just as short")

Comment.create(:body => "Angry comment!",      :article_id => article2.id)
Comment.create(:body => "Frustrated comment!", :article_id => article2.id)
Comment.create(:body => "Irritated comment!",  :article_id => article2.id)

## Display all the articles and their comments

Article.all.each do |article|
  puts %{
    TITLE: #{article.title}
    BODY: #{article.body}
    COMMENTS:\n#{article.comments.map { |e| "    - #{e.body}" }.join("\n")
    }
  }
end
