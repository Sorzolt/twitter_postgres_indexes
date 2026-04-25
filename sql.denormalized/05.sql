SELECT
    tag,
    count(*) AS count
FROM (
    SELECT DISTINCT
        data->>'id' AS id_tweets,
        '#' || (hashtag->>'text') AS tag
    FROM tweets_jsonb
    CROSS JOIN LATERAL jsonb_array_elements(
        COALESCE(data->'entities'->'hashtags', '[]'::jsonb)
        ||
        COALESCE(data->'extended_tweet'->'entities'->'hashtags', '[]'::jsonb)
    ) AS hashtag
    WHERE to_tsvector('english', COALESCE(data->'extended_tweet'->>'full_text', data->>'text'))
          @@ to_tsquery('english', 'coronavirus')
      AND data->>'lang' = 'en'
) t
GROUP BY tag
ORDER BY count DESC, tag
LIMIT 1000;
