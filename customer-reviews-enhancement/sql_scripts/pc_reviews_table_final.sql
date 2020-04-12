----------------------------------------------------------------------------------------------------------|
/* Create cleaned Amazon data table for PCs */
CREATE TABLE amazon_pc_reviews_cleaned AS TABLE amazon_pc_reviews;


/* Create new column with cleaned text for review_body */
ALTER TABLE amazon_pc_reviews_cleaned
	ADD COLUMN clean_review_body text
;

UPDATE amazon_pc_reviews_cleaned
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


/* Create new column with cleaned text for review_headline */
ALTER TABLE amazon_pc_reviews_cleaned
	ADD COLUMN clean_review_headline text
;

UPDATE amazon_pc_reviews_cleaned
	SET clean_review_headline =

	regexp_replace(
		regexp_replace(
			regexp_replace(lower(review_headline),
				'<br />', ' ', 'g'				     -- remove line break tags
				),
				 	'[^a-z\s\-]', '', 'g'		     -- remove non alphabet characters (except for dashes)
					),
						'[\-\s]{2,10}', ' ', 'g'    -- remove spaces or dashes that occur consecutively
						)
	;


/* Create new column to determine "helpfulness ratio" of each review */
ALTER TABLE amazon_pc_reviews_cleaned
	ADD COLUMN helpfullness_ratio NUMERIC
	;

UPDATE amazon_pc_reviews_cleaned
	SET helpfullness_ratio =
		CASE
			WHEN (helpful_votes > 0 and total_votes > helpful_votes)
				THEN ROUND(helpful_votes::NUMERIC/total_votes::NUMERIC,2)
			ELSE 0
		END
	;


/* Create new columns to determine word count of review_headline and review_body */
ALTER TABLE amazon_pc_reviews_cleaned
	ADD COLUMN wc_review_headline TEXT,
	ADD COLUMN wc_review_body TEXT
	;


UPDATE amazon_pc_reviews_cleaned
	SET wc_review_headline = array_length(regexp_split_to_array(clean_review_headline, '\s+'), 1),
		wc_review_body = array_length(regexp_split_to_array(clean_review_body, '\s+'), 1)
	;

/* Create "TARGET" field to indicate whether review was helpful or not (>0.5 helpfullness ratio) */
ALTER TABLE amazon_pc_reviews_cleaned
	ADD COLUMN target INTEGER
	;

UPDATE amazon_pc_reviews_cleaned
	SET target =
		CASE
			WHEN helpfullness_ratio > 0.5 THEN 1
			ELSE 0
		END
;


/* Remove unecessary columns for nlp classification & topic modeling */
ALTER TABLE amazon_pc_reviews_cleaned
	DROP COLUMN review_headline,
	DROP COLUMN review_body,
	DROP COLUMN marketplace
	;

/* Update vine & verified_purchase fields to binary values (0,1) */
UPDATE amazon_pc_reviews_cleaned
	SET vine = 
		CASE
			WHEN vine = 'Y' THEN 1 
			ELSE 0
		END,
		
		verified_purchase = 
		CASE 
			WHEN verified_purchase = 'Y' THEN 1
			ELSE 0
		END
	;

