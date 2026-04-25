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
    WHERE (
        COALESCE(data->'entities'->'hashtags', '[]'::jsonb)
        ||
        COALESCE(data->'extended_tweet'->'entities'->'hashtags', '[]'::jsonb)
    ) @> '[{"text":"coronavirus"}]'
) t
GROUP BY (1)
ORDER BY count DESC, tag
LIMIT 1000;
