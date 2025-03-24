MeiliSearch::Rails.configuration = {
  meilisearch_url: ENV.fetch("MEILISEARCH_URL"),
  meilisearch_api_key: ENV.fetch("MEILISEARCH_API_KEY"),
  timeout: 2,
  max_retries: 1,
  pagination_backend: :kaminari
}
