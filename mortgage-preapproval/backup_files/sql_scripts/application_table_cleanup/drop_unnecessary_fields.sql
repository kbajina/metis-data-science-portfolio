/* Script to drop all unecessary fields from applications_cleaned table */

ALTER TABLE applications_cleaned
DROP COLUMN reg_region_not_live_region,
DROP COLUMN reg_region_not_work_region,
DROP COLUMN live_region_not_work_region,
DROP COLUMN reg_city_not_live_city,
DROP COLUMN reg_city_not_work_city,
DROP COLUMN live_city_not_work_city,
DROP COLUMN ext_source_1,
DROP COLUMN ext_source_2,
DROP COLUMN ext_source_3,
DROP COLUMN days_last_phone_change,
DROP COLUMN flag_document_2,
DROP COLUMN flag_document_3,
DROP COLUMN flag_document_4,
DROP COLUMN flag_document_5,
DROP COLUMN flag_document_6,
DROP COLUMN flag_document_7,
DROP COLUMN flag_document_8,
DROP COLUMN flag_document_9,
DROP COLUMN flag_document_10,
DROP COLUMN flag_document_11,
DROP COLUMN flag_document_12,
DROP COLUMN flag_document_13,
DROP COLUMN flag_document_14,
DROP COLUMN flag_document_15,
DROP COLUMN flag_document_16,
DROP COLUMN flag_document_17,
DROP COLUMN flag_document_18,
DROP COLUMN flag_document_19,
DROP COLUMN flag_document_20,
DROP COLUMN flag_document_21,
DROP COLUMN organization_type,  -- add back later once you've determined mapping to be used
-- fields below may be needed in second pass of modelling process
DROP COLUMN apartments_avg,
DROP COLUMN basementarea_avg,
DROP COLUMN years_beginexpluatation_avg,
DROP COLUMN years_build_avg,
DROP COLUMN commonarea_avg,
DROP COLUMN elevators_avg,
DROP COLUMN entrances_avg,
DROP COLUMN floorsmax_avg,
DROP COLUMN floorsmin_avg,
DROP COLUMN landarea_avg,
DROP COLUMN livingapartments_avg,
DROP COLUMN livingarea_avg,
DROP COLUMN nonlivingapartments_avg,
DROP COLUMN nonlivingarea_avg,
DROP COLUMN apartments_mode,
DROP COLUMN basementarea_mode,
DROP COLUMN years_beginexpluatation_mode,
DROP COLUMN years_build_mode,
DROP COLUMN commonarea_mode,
DROP COLUMN elevators_mode,
DROP COLUMN entrances_mode,
DROP COLUMN floorsmax_mode,
DROP COLUMN floorsmin_mode,
DROP COLUMN landarea_mode,
DROP COLUMN livingapartments_mode,
DROP COLUMN livingarea_mode,
DROP COLUMN nonlivingapartments_mode,
DROP COLUMN nonlivingarea_mode,
DROP COLUMN apartments_medi,
DROP COLUMN basementarea_medi,
DROP COLUMN years_beginexpluatation_medi,
DROP COLUMN years_build_medi,
DROP COLUMN commonarea_medi,
DROP COLUMN elevators_medi,
DROP COLUMN entrances_medi,
DROP COLUMN floorsmax_medi,
DROP COLUMN floorsmin_medi,
DROP COLUMN landarea_medi,
DROP COLUMN livingapartments_medi,
DROP COLUMN livingarea_medi,
DROP COLUMN nonlivingapartments_medi,
DROP COLUMN nonlivingarea_medi,
DROP COLUMN fondkapremont_mode,
DROP COLUMN housetype_mode,
DROP COLUMN totalarea_mode,
DROP COLUMN wallsmaterial_mode,
DROP COLUMN emergencystate_mode
;
