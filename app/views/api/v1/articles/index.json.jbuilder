json.array! @articles do |article|
  json.id article.id
  json.title article.title
  json.title_image article.title_image_url(:thumb)
  json.body article.body
  json.url article_url(article)
end
