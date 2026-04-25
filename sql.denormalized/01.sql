SELECT count(*)
FROM tweets_jsonb
WHERE (
    COALESCE(data->'entities'->'hashtags', '[]'::jsonb)
    ||
    COALESCE(data->'extended_tweet'->'entities'->'hashtags', '[]'::jsonb)
) @> '[{"text":"coronavirus"}]';
