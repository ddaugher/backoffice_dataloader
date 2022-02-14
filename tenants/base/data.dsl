--host --url $HOST
--tenant_login
--delete_tenant --name $TENANT
--delete_tenant_mapping --tenant $TENANT
--tenant_mapping --domain $DOMAIN --tenant $TENANT
--create_tenant --name $TENANT
--registration --email admin@$DOMAIN --pass 123123123 --api_access true --role admin --self_service_storage {'role':'admin'}
--registration --email user@$DOMAIN --pass 123123123 --api_access true --role user --self_service_storage {'role':'user'}
--login --username admin@$DOMAIN --password 123123123
--region --name All
--daily_expense_type --name Meals
--daily_expense_type --name Parking
--daily_expense_type --name Per Diem
--daily_expense_type --name Hotel
--daily_expense_type --name Mileage
--monthly_expense_type --name Computer
--monthly_expense_type --name Parking
--monthly_expense_type --name Mileage
--monthly_expense_type --name Meals
--monthly_expense_type --name Team Health
--employee_type --name 1099 --is_employee false --is_utilized false
--employee_type --name Hourly --is_employee false --is_utilized false
--employee_type --name Corp2Corp --is_employee false --is_utilized false
--employee_type --name W2 --is_employee true --is_utilized true
--work_exception_type --name PTO
--work_exception_type --name Bereavement
--work_exception_type --name Holiday
--work_exception_type --name UPTO
--work_exception_type --name Client Visit
--work_exception_type --name Conference
--work_exception_type --name Training
--holiday --date 2021-01-01 --description New Year's Day --hours 8 --work_exception_type_id 3
--holiday --date 2021-01-18 --description Martin Luther King Day --hours 8 --work_exception_type_id 3
--holiday --date 2021-05-31 --description Memorial Day --hours 8 --work_exception_type_id 3
--holiday --date 2021-06-19 --description Juneteenth --hours 8 --work_exception_type_id 3
--holiday --date 2021-07-04 --description July 4th --hours 8 --work_exception_type_id 3
--holiday --date 2021-09-06 --description Labor Day --hours 8 --work_exception_type_id 3
--holiday --date 2021-11-04 --description Diwali --hours 8 --work_exception_type_id 3
--holiday --date 2021-11-25 --description Thanksgiving Day --hours 8 --work_exception_type_id 3
--holiday --date 2021-12-24 --description Christmas Eve --hours 8 --work_exception_type_id 3
--holiday --date 2021-12-27 --description Christmas --hours 8 --work_exception_type_id 3
--holiday --date 2021-12-31 --description New Year's Eve --hours 8 --work_exception_type_id 3
--holiday --date 2022-01-01 --description New Year's Day --hours 8 --work_exception_type_id 3
--holiday --date 2022-02-17 --description Martin Luther King Day --hours 8 --work_exception_type_id 3
--holiday --date 2022-05-30 --description Memorial Day --hours 8 --work_exception_type_id 3
--holiday --date 2022-06-19 --description Juneteenth --hours 8 --work_exception_type_id 3
--holiday --date 2022-07-04 --description July 4th --hours 8 --work_exception_type_id 3
--holiday --date 2022-09-05 --description Labor Day --hours 8 --work_exception_type_id 3
--holiday --date 2022-09-26 --description Rosh Hashanah --hours 8 --work_exception_type_id 3
--holiday --date 2022-09-27 --description Rosh Hashanah --hours 8 --work_exception_type_id 3
--holiday --date 2022-10-04 --description Diwali --hours 8 --work_exception_type_id 3
--holiday --date 2022-11-24 --description Thanksgiving Day --hours 8 --work_exception_type_id 3
--holiday --date 2022-12-24 --description Christmas Eve --hours 8 --work_exception_type_id 3
--holiday --date 2022-12-25 --description Christmas --hours 8 --work_exception_type_id 3
--holiday --date 2022-12-31 --description New Year's Eve --hours 8 --work_exception_type_id 3
--position_type --name Engineer
--position_type --name Experience
--position_type --name Design
--position_type --name Product
--position_type --name Delivery
--position_type --name Account Manager
--position_type --name Baker
--position_type --name SME
--customer --name AM Jewels --is_active true
--customer --name DJs Dough Co --is_active true
--customer --name HHG2G --is_active true
--customer --name Phoenix Interactive --is_active true
--customer --name Vleet's Fleet --is_active true
--project_time_materials --name Jewel Designer --customer_id 1 --region_id 1 --status Forecasted
--project_time_materials --name Bread Buddy --customer_id 2 --region_id 1 --status Forecasted
--project_time_materials --name Project42 --customer_id 3 --region_id 1 --status Booked
--project_time_materials --name Daily Yoga App --customer_id 4 --region_id 1 --status Forecasted
--project_time_materials --name From The Ashes App --customer_id 4 --region_id 1 --status Imminent
--project_time_materials --name Fleet Manager --customer_id 5 --region_id 1 --status Draft
--project_time_materials --name Jewel Designer Extension --customer_id 1 --region_id 1 --status Draft
--project_time_materials --name Bread Buddy Phase 2 --customer_id 2 --region_id 1 --status Draft
--project_time_materials --name Project42 Extension --customer_id 3 --region_id 1 --status Forecasted
--project_time_materials --name Project42 Draft --customer_id 3 --region_id 1 --status Draft
--project_retainer --name Project43_Retainer Draft --customer_id 3 --region_id 1 --status Draft --monthly_amount 45000
--project_fixed_bid --name Project43_Fixed_Bid Draft --customer_id 3 --region_id 1 --status Draft --amount 1000000
--employee --first_name Ada --last_name Lovelace --email lovelace@nxogantrydemo.com --start_date 2021-01-01 --hourly_cost 200 --daily_billable_hours 8 --utilization_target 100 --employee_type_id 3 --region_id 1
--employee --first_name Andy --last_name Apprety --email apprety@nxogantrydemo.com --start_date 2021-01-02 --hourly_cost 89.74 --daily_billable_hours 8 --utilization_target 100 --employee_type_id 3 --region_id 1
--employee --first_name Arnold --last_name Devmeier --email devmeier@nxogantrydemo.com --start_date 2021-01-03 --hourly_cost 98.42 --daily_billable_hours 8 --utilization_target 100 --employee_type_id 1 --region_id 1
--employee --first_name Arthur --last_name Dent --email dent@nxogantrydemo.com --start_date 2021-01-04 --hourly_cost 53.56 --daily_billable_hours 8 --utilization_target 100 --employee_type_id 3 --region_id 1
--employee --first_name Chien-Shiung --last_name Wu --email wu@nxogantrydemo.com --start_date 2021-01-05 --hourly_cost 90.87 --daily_billable_hours 8 --utilization_target 100 --employee_type_id 3 --region_id 1
--employee --first_name Claude --last_name Monet --email monet@nxogantrydemo.com --start_date 2022-01-06 --hourly_cost 100.45 --daily_billable_hours 8 --utilization_target 100 --employee_type_id 3 --region_id 1
--employee --first_name DeeDee --last_name Leadersing --email leadersing@nxogantrydemo.com --start_date 2011-08-07 --hourly_cost 176.87 --daily_billable_hours 8 --utilization_target 100 --employee_type_id 3 --region_id 1
--employee --first_name Edgar --last_name Enart --email enart@nxogantrydemo.com --start_date 2011-08-08 --hourly_cost 123.32 --daily_billable_hours 8 --utilization_target 100 --employee_type_id 3 --region_id 1
--employee --first_name Edith --last_name Clarke --email clarke@nxogantrydemo.com --start_date 2011-08-09 --hourly_cost 190.98 --daily_billable_hours 8 --utilization_target 100 --employee_type_id 3 --region_id 1
--employee --first_name Ellen --last_name Ochoa --email ochoa@nxogantrydemo.com --start_date 2016-10-10 --hourly_cost 134.25 --daily_billable_hours 8 --utilization_target 100 --employee_type_id 3 --region_id 1
--employee --first_name Ford --last_name Prefect --email prefect@nxogantrydemo.com --start_date 2011-08-11 --hourly_cost 29.98 --daily_billable_hours 8 --utilization_target 100 --employee_type_id 3 --region_id 1
--employee --first_name Frida --last_name Kahlo --email kahlo@nxogantrydemo.com --start_date 2018-07-20 --hourly_cost 160.87 --daily_billable_hours 8 --utilization_target 100 --employee_type_id 3 --region_id 1
--employee --first_name Georgia --last_name OKeeffe --email okeeffe@nxogantrydemo.com --start_date 2018-07-21 --hourly_cost 160.87 --daily_billable_hours 8 --utilization_target 100 --employee_type_id 3 --region_id 1
--employee --first_name Jean-Michel --last_name Basquiat --email basquiat@nxogantrydemo.com --start_date 2018-07-22 --hourly_cost 160.87 --daily_billable_hours 8 --utilization_target 100 --employee_type_id 1 --region_id 1
--employee --first_name Joe --last_name Fre --email fre@nxogantrydemo.com --start_date 2018-07-23 --hourly_cost 120.9 --daily_billable_hours 8 --utilization_target 100 --employee_type_id 1 --region_id 1
--employee --first_name Junio --last_name Artiland --email artiland@nxogantrydemo.com --start_date 2018-07-24 --hourly_cost 143.72 --daily_billable_hours 8 --utilization_target 100 --employee_type_id 3 --region_id 1
--employee --first_name Leonardo --last_name DaVinci --email davinci@nxogantrydemo.com --start_date 2018-07-25 --hourly_cost 220 --daily_billable_hours 8 --utilization_target 100 --employee_type_id 1 --region_id 1
--employee --first_name Louise --last_name Bourgeois --email bourgeois@nxogantrydemo.com --start_date 2010-07-26 --hourly_cost 123.21 --daily_billable_hours 8 --utilization_target 100 --employee_type_id 1 --region_id 1
--employee --first_name Marilyn --last_name Monroe --email monroe@nxogantrydemo.com --start_date 2018-07-27 --hourly_cost 230 --daily_billable_hours 8 --utilization_target 100 --employee_type_id 1 --region_id 1
--employee --first_name Pablo --last_name Picasso --email picasso@nxogantrydemo.com --start_date 2010-12-07 --hourly_cost 189.9 --daily_billable_hours 8 --utilization_target 100 --employee_type_id 3 --region_id 1
--employee --first_name Seneca --last_name Englewood --email englewood@nxogantrydemo.com --start_date 2020-11-08 --hourly_cost 129.65 --daily_billable_hours 8 --utilization_target 100 --employee_type_id 1 --region_id 1
--employee --first_name Tricia --last_name McMillan --email mcmillan@nxogantrydemo.com --start_date 2021-12-09 --hourly_cost 130.98 --daily_billable_hours 8 --utilization_target 100 --employee_type_id 3 --region_id 1
--employee --first_name Vincent --last_name VanGogh --email vangogh@nxogantrydemo.com --start_date 2001-12-10 --hourly_cost 200.25 --daily_billable_hours 8 --utilization_target 100 --employee_type_id 3 --region_id 1
--employee --first_name Zaphod --last_name Beeblebrox --email beeblebrox@nxogantrydemo.com --start_date 2020-12-11 --hourly_cost 67.1 --daily_billable_hours 8 --utilization_target 100 --employee_type_id 1 --region_id 1
--employee --first_name Peeta --last_name Mellark --email mellark@nxogantrydemo.com --start_date 2008-09-14 --hourly_cost 150 --daily_billable_hours 8 --utilization_target 100 --employee_type_id 3 --region_id 1
--employee --first_name Katniss --last_name Everdeen --email everdeen@nxogantrydemo.com --start_date 2008-09-14 --hourly_cost 250 --daily_billable_hours 8 --utilization_target 100 --employee_type_id 3 --region_id 1
--open_position --name Apprentice Artisan --start_date 2021-06-21 --end_date 2021-10-14 --bill_rate 100 --cost 50 --daily_billable_hours 8 --project_id 6 --position_type_id 8
--open_position --name Artisan --start_date 2021-06-01 --end_date 2022-01-28 --bill_rate 150 --cost 100 --daily_billable_hours 8 --project_id 6 --position_type_id 1
--open_position --name Delivery Lead --start_date 2021-06-01 --end_date 2022-02-25 --bill_rate 200 --cost 150 --daily_billable_hours 8 --project_id 6 --position_type_id 5
--open_position --name Experience Lead --start_date 2021-06-07 --end_date 2022-01-28 --bill_rate 150 --cost 100 --daily_billable_hours 8 --project_id 6 --position_type_id 2
--open_position --name Senior Artisan --start_date 2021-07-05 --end_date 2022-01-28 --bill_rate 200 --cost 150 --daily_billable_hours 8 --project_id 6 --position_type_id 1
--open_position --name Tech Lead --start_date 2021-06-07 --end_date 2022-02-18 --bill_rate 175 --cost 125 --daily_billable_hours 8 --project_id 6 --position_type_id 1
--open_position --name Apprentice --start_date 2021-08-02 --end_date 2022-06-03 --bill_rate 100 --cost 75.25 --daily_billable_hours 8 --project_id 5 --position_type_id 5
--position_with_employee --name Master Artisan --start_date 2021-10-25 --end_date 2022-03-25 --bill_rate 0 --cost 100 --daily_billable_hours 8 --project_id 1 --position_type_id 1 --employee_id 9
--position_with_employee --name Physicist --start_date 2021-10-25 --end_date 2022-03-25 --bill_rate 0 --cost 100 --daily_billable_hours 8 --project_id 1 --position_type_id 8 --employee_id 5
--position_with_employee --name Artisan 3 --start_date 2021-10-25 --end_date 2022-03-26 --bill_rate 0 --cost 100 --daily_billable_hours 5 --project_id 1 --position_type_id 1 --employee_id 3
--position_with_employee --name Delivery Lead --start_date 2021-10-25 --end_date 2022-02-25 --bill_rate 0 --cost 125 --daily_billable_hours 8 --project_id 1 --position_type_id 5 --employee_id 7
--position_with_employee --name Experience Lead --start_date 2021-10-25 --end_date 2022-03-25 --bill_rate 0 --cost 150 --daily_billable_hours 8 --project_id 1 --position_type_id 2 --employee_id 12
--position_with_employee --name Jewelry Expert --start_date 2021-10-25 --end_date 2021-10-29 --bill_rate 0 --cost 200 --daily_billable_hours 4 --project_id 1 --position_type_id 8 --employee_id 19
--position_with_employee --name Tech Lead --start_date 2021-10-25 --end_date 2022-02-25 --bill_rate 0 --cost 150.25 --daily_billable_hours 8 --project_id 1 --position_type_id 1 --employee_id 1
--position_with_employee --name Artisan 2 --start_date 2021-06-14 --end_date 2021-12-17 --bill_rate 0 --cost 100 --daily_billable_hours 8 --project_id 2 --position_type_id 1 --employee_id 6
--position_with_employee --name Baker --start_date 2021-06-14 --end_date 2021-12-17 --bill_rate 0 --cost 135 --daily_billable_hours 8 --project_id 2 --position_type_id 7 --employee_id 25
--position_with_employee --name Chef_ --start_date 2021-06-14 --end_date 2021-12-17 --bill_rate 0 --cost 150 --daily_billable_hours 8 --project_id 2 --position_type_id 8 --employee_id 22
--position_with_employee --name Delivery Lead --start_date 2021-06-14 --end_date 2021-12-17 --bill_rate 0 --cost 100 --daily_billable_hours 8 --project_id 2 --position_type_id 5 --employee_id 21
--position_with_employee --name Master Artisan --start_date 2022-03-28 --end_date 2023-03-25 --bill_rate 0 --cost 100 --daily_billable_hours 8 --project_id 7 --position_type_id 1 --employee_id 9
--position_with_employee --name Physicist --start_date 2022-03-28 --end_date 2023-03-25 --bill_rate 0 --cost 100 --daily_billable_hours 8 --project_id 7 --position_type_id 1 --employee_id 5
--position_with_employee --name Artisan 3 --start_date 2022-03-28 --end_date 2023-03-25 --bill_rate 0 --cost 100 --daily_billable_hours 8 --project_id 7 --position_type_id 1 --employee_id 3
--position_with_employee --name Delivery Lead --start_date 2022-03-28 --end_date 2023-03-25 --bill_rate 0 --cost 125 --daily_billable_hours 8 --project_id 7 --position_type_id 5 --employee_id 7
--position_with_employee --name Experience Lead --start_date 2022-03-28 --end_date 2023-03-25 --bill_rate 0 --cost 150 --daily_billable_hours 8 --project_id 7 --position_type_id 2 --employee_id 12
--position_with_employee --name Jewelry Expert --start_date 2022-03-28 --end_date 2023-03-25 --bill_rate 0 --cost 200 --daily_billable_hours 4 --project_id 7 --position_type_id 8 --employee_id 19
--position_with_employee --name Tech Lead --start_date 2022-03-28 --end_date 2023-03-25 --bill_rate 0 --cost 150.25 --daily_billable_hours 8 --project_id 7 --position_type_id 1 --employee_id 1
--position_with_employee --name Artisan 2 --start_date 2021-12-20 --end_date 2022-05-27 --bill_rate 0 --cost 100 --daily_billable_hours 8 --project_id 8 --position_type_id 1 --employee_id 6
--position_with_employee --name Baker --start_date 2021-12-20 --end_date 2022-05-27 --bill_rate 0 --cost 135 --daily_billable_hours 8 --project_id 8 --position_type_id 7 --employee_id 25
--position_with_employee --name Chef_ --start_date 2021-12-20 --end_date 2022-05-27 --bill_rate 0 --cost 150 --daily_billable_hours 8 --project_id 8 --position_type_id 8 --employee_id 22
--position_with_employee --name Delivery Lead --start_date 2021-12-20 --end_date 2022-05-27 --bill_rate 0 --cost 100 --daily_billable_hours 8 --project_id 8 --position_type_id 5 --employee_id 21
--position_with_employee --name Assistant Baker --start_date 2021-12-20 --end_date 2022-05-27 --bill_rate 0 --cost 100 --daily_billable_hours 8 --project_id 8 --position_type_id 7 --employee_id 4
--position_with_employee --name Artisan --start_date 2021-05-03 --end_date 2021-10-01 --bill_rate 0 --cost 100 --daily_billable_hours 8 --project_id 3 --position_type_id 5 --employee_id 24
--position_with_employee --name Chief Engineer --start_date 2021-05-03 --end_date 2021-10-01 --bill_rate 0 --cost 125 --daily_billable_hours 8 --project_id 3 --position_type_id 1 --employee_id 11
--position_with_employee --name Delivery --start_date 2021-05-03 --end_date 2021-10-29 --bill_rate 0 --cost 150 --daily_billable_hours 8 --project_id 3 --position_type_id 5 --employee_id 22
--position_with_employee --name Tester --start_date 2021-05-03 --end_date 2021-10-01 --bill_rate 0 --cost 100 --daily_billable_hours 8 --project_id 3 --position_type_id 5 --employee_id 4
--position_with_employee --name Artisan --start_date 2021-10-04 --end_date 2021-12-31 --bill_rate 0 --cost 100 --daily_billable_hours 8 --project_id 9 --position_type_id 5 --employee_id 24
--position_with_employee --name Chief Engineer --start_date 2021-10-04 --end_date 2021-12-31 --bill_rate 0 --cost 125 --daily_billable_hours 8 --project_id 9 --position_type_id 1 --employee_id 11
--position_with_employee --name Delivery --start_date 2021-10-04 --end_date 2021-12-31 --bill_rate 0 --cost 150 --daily_billable_hours 8 --project_id 9 --position_type_id 5 --employee_id 22
--position_with_employee --name Tester --start_date 2021-10-04 --end_date 2021-12-31 --bill_rate 0 --cost 100 --daily_billable_hours 8 --project_id 9 --position_type_id 5 --employee_id 4
--position_with_employee --name Assistant Engineer --start_date 2021-10-04 --end_date 2021-12-31 --bill_rate 0 --cost 90 --daily_billable_hours 8 --project_id 9 --position_type_id 1 --employee_id 4
--position_with_employee --name Artisan --start_date 2022-01-03 --end_date 2023-01-13 --bill_rate 0 --cost 100 --daily_billable_hours 8 --project_id 10 --position_type_id 5 --employee_id 24
--position_with_employee --name Chief Engineer --start_date 2022-01-03 --end_date 2023-01-13 --bill_rate 0 --cost 125 --daily_billable_hours 8 --project_id 10 --position_type_id 1 --employee_id 11
--position_with_employee --name Delivery --start_date 2022-01-03 --end_date 2023-01-13 --bill_rate 0 --cost 150 --daily_billable_hours 8 --project_id 10 --position_type_id 5 --employee_id 22
--position_with_employee --name Tester --start_date 2022-01-03 --end_date 2023-01-13 --bill_rate 0 --cost 100 --daily_billable_hours 8 --project_id 10 --position_type_id 5 --employee_id 4
--position_with_employee --name Assistant Engineer --start_date 2022-01-03 --end_date 2023-01-13 --bill_rate 0 --cost 90 --daily_billable_hours 8 --project_id 10 --position_type_id 1 --employee_id 4
--position_with_employee --name Apprentice Artisan --start_date 2021-12-06 --end_date 2022-04-29 --bill_rate 100 --cost 150 --daily_billable_hours 8 --project_id 4 --position_type_id 1 --employee_id 8
--position_with_employee --name Artisan --start_date 2021-12-06 --end_date 2022-04-29 --bill_rate 150 --cost 150.25 --daily_billable_hours 8 --project_id 4 --position_type_id 1 --employee_id 16
--position_with_employee --name Artisan 02 --start_date 2021-12-06 --end_date 2022-04-29 --bill_rate 150 --cost 50.5 --daily_billable_hours 8 --project_id 4 --position_type_id 5 --employee_id 15
--position_with_employee --name Artisan 03 --start_date 2021-12-06 --end_date 2022-04-29 --bill_rate 150 --cost 125 --daily_billable_hours 8 --project_id 4 --position_type_id 1 --employee_id 4
--position_with_employee --name Delivery --start_date 2021-12-06 --end_date 2022-04-29 --bill_rate 200 --cost 50 --daily_billable_hours 8 --project_id 4 --position_type_id 5 --employee_id 20
--position_with_employee --name Tech Lead --start_date 2021-12-06 --end_date 2022-04-29 --bill_rate 250 --cost 150 --daily_billable_hours 8 --project_id 4 --position_type_id 5 --employee_id 23
--position_with_employee --name Artisan --start_date 2021-08-02 --end_date 2021-08-20 --bill_rate 125 --cost 50 --daily_billable_hours 8 --project_id 5 --position_type_id 1 --employee_id 10
--position_with_employee --name Delivery Lead --start_date 2021-08-02 --end_date 2022-06-03 --bill_rate 150 --cost 100 --daily_billable_hours 8 --project_id 5 --position_type_id 5 --employee_id 13
--position_with_employee --name Artisan 2 --start_date 2021-08-02 --end_date 2022-06-03 --bill_rate 150 --cost 100 --daily_billable_hours 8 --project_id 5 --position_type_id 1 --employee_id 14
--position_with_employee --name Design --start_date 2021-07-05 --end_date 2022-07-22 --bill_rate 250 --cost 200 --daily_billable_hours 8 --project_id 5 --position_type_id 3 --employee_id 17
--position_with_employee --name DX Lead --start_date 2021-07-05 --end_date 2022-07-22 --bill_rate 200 --cost 150 --daily_billable_hours 8 --project_id 5 --position_type_id 2 --employee_id 18
--position_with_employee --name Tech Lead --start_date 2021-07-05 --end_date 2022-06-17 --bill_rate 200 --cost 150 --daily_billable_hours 8 --project_id 5 --position_type_id 5 --employee_id 22
