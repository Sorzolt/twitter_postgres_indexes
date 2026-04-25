SELECT
    data->>'lang' AS lang,
    count(*) AS count
FROM tweets_jsonb
WHERE (
    COALESCE(data->'entities'->'hashtags', '[]'::jsonb)
    ||
    COALESCE(data->'extended_tweet'->'entities'->'hashtags', '[]'::jsonb)
) @> '[{"text":"coronavirus"}]'
GROUP BY lang
ORDER BY count DESC, lang;
