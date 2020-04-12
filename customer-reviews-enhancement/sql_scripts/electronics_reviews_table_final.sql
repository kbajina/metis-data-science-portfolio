----------------------------------------------------------------------------------------------------------|
/* Create cleaned Amazon data table for ELECTRONICS */
CREATE TABLE amazon_electronics_reviews_cleaned AS TABLE amazon_electronics_reviews;

-- Create new column with cleaned text for review_body */
ALTER TABLE amazon_electronics_reviews_cleaned
	ADD COLUMN clean_review_body text
;

UPDATE amazon_electronics_reviews_cleaned
	SET clean_review_body =

	regexp_replace(
		regexp_replace(
			regexp_replace(lower(review_body),
				'<br />', ' ', 'g'				    -- remove line break tags
				),
				 	'[^a-z\s\-]', '', 'g'		    -- remove non alphabet characters (except for dashes)
					),
						'[\-\s]{2,10}', ' ', 'g'   -- remove spaces or dashes that occur consecutively
						)
	;

-- Create new column with cleaned text for review_headline */
ALTER TABLE amazon_electronics_reviews_cleaned
	ADD COLUMN clean_review_headline text
;

UPDATE amazon_electronics_reviews_cleaned
	SET clean_review_headline =

	regexp_replace(
		regexp_replace(
			regexp_replace(lower(review_headline),
				'<br />', ' ', 'g'				    -- remove line break tags
				),
				 	'[^a-z\s\-]', '', 'g'		    -- remove non alphabet characters (except for dashes)
					),
						'[\-\s]{2,10}', ' ', 'g'   -- remove spaces or dashes that occur consecutively
						)
	;
