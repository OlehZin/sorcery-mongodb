json.array! @articles do |article|
  json.id article.id
  json.title article.title
  json.body article.body
  json.url article_url(article)
end
