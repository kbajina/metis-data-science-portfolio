#!/bin/bash
# Script to create and load all database tables for project

psql -f application_data.sql

psql -f bureau_data.sql

psql -f bureau_balance.sql

psql -f previous_application.sql

psql -f installments_payments.sql

psql -f pos_cash_balance.sql

psql -f credit_card_balance.sql
