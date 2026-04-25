CREATE INDEX tweet_tags_tag_id_tweets_idx
ON tweet_tags (tag, id_tweets);

CREATE INDEX tweet_tags_id_tweets_tag_idx
ON tweet_tags (id_tweets, tag);

CREATE INDEX tweets_id_tweets_lang_idx
ON tweets (id_tweets, lang);

CREATE INDEX tweets_text_english_gin_idx
ON tweets
USING gin (to_tsvector('english', text));
