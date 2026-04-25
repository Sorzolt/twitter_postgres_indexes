CREATE INDEX tweets_jsonb_hashtags_gin_idx
ON tweets_jsonb
USING gin (
  (
    COALESCE(data->'entities'->'hashtags', '[]'::jsonb) ||
    COALESCE(data->'extended_tweet'->'entities'->'hashtags', '[]'::jsonb)
  )
);

CREATE INDEX tweets_jsonb_text_english_gin_idx
ON tweets_jsonb
USING gin (
  to_tsvector('english', COALESCE(data->'extended_tweet'->>'full_text', data->>'text'))
);

CREATE INDEX tweets_jsonb_lang_idx
ON tweets_jsonb ((data->>'lang'));
