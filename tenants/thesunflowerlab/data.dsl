HEADER
--registration --email dhaval@thesunflowerlab.com  --pass dhaval123 --api_access true --role admin --self_service_storage {'role':'admin'}
LOGIN
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
--holiday --date 2022-01-01 --description New Year's Day --hours 8 --work_exception_type_id 3
--holiday --date 2022-01-14 --description Uttrayan --hours 8 --work_exception_type_id 3
--holiday --date 2022-01-15 --description Vasi Uttrayan --hours 8 --work_exception_type_id 3
--holiday --date 2022-01-26 --description Republic Day --hours 8 --work_exception_type_id 3
--holiday --date 2022-03-29 --description Dhuleti --hours 8 --work_exception_type_id 3
--holiday --date 2022-05-14 --description Ramzan Eid --hours 8 --work_exception_type_id 3
--holiday --date 2022-07-20 --description Bakari Eid --hours 8 --work_exception_type_id 3
--holiday --date 2022-08-15 --description Independence Day --hours 8 --work_exception_type_id 3
--holiday --date 2022-08-22 --description Raksha Bandhan --hours 8 --work_exception_type_id 3
--holiday --date 2022-09-10 --description Ganesh Chaturthi --hours 8 --work_exception_type_id 3
--holiday --date 2022-10-15 --description Dusshera --hours 8 --work_exception_type_id 3
--holiday --date 2022-11-02 --description Dhanteras --hours 8 --work_exception_type_id 3
--holiday --date 2022-11-04 --description Diwali --hours 8 --work_exception_type_id 3
--holiday --date 2022-11-05 --description New Year --hours 8 --work_exception_type_id 3
--holiday --date 2022-11-06 --description Bhai Duj --hours 8 --work_exception_type_id 3
--position_type --name Polyglot Dev
--position_type --name Engineer
--position_type --name UI/UX
--position_type --name Delivery Lead
--position_type --name Account Manager
--position_type --name Solution Architecture 
--position_type --name QA Engineer
--position_type --name DevOps
--customer --name QE Solar  --is_active true
--customer --name Nomad Bite --is_active true
--customer --name OGantry --is_active true
--customer --name VICI --is_active true
--customer --name ResolvedX --is_active true
--customer --name Vishay Lab --is_active true
--customer --name BriskHeat --is_active true
--customer --name eHumanize --is_active true
--customer --name SoAct --is_active true
--customer --name Groove --is_active true
--customer --name Aura --is_active true
--customer --name Capex --is_active true
--customer --name DPH --is_active true
--customer --name Peerzle --is_active true
--customer --name Spex  --is_active true
--customer --name Turk --is_active true
--customer --name Olah --is_active true
--customer --name Breaker Paradise --is_active true
--customer --name Teachers on Reserve --is_active true
--customer --name Covest --is_active true
--customer --name Legacy Vault --is_active true
--customer --name RideTrip --is_active true
--customer --name CNG --is_active true
--customer --name Hilliard School --is_active true
--customer --name WorthPoint --is_active true
--customer --name Wearable Device  --is_active true
--project_retainer --name QE Solar Tools --customer_id 1 --region_id 1 --status Booked --monthly_amount 17375
--project_time_materials --name Nomad Bite --customer_id 2 --region_id 1 --status Booked
--project_retainer --name OGantry --customer_id 3 --region_id 1 --status Booked --monthly_amount 675
--project_time_materials --name VICI T3 Athlete --customer_id 4 --region_id 1 --status Booked
--project_retainer --name ResolvedX --customer_id 5 --region_id 1 --status Booked --monthly_amount 2000
--project_time_materials --name Vishay --customer_id 6 --region_id 1 --status Booked
--project_fixed_bid --name BriskHeat --customer_id 7 --region_id 1 --status Booked --amount 1000
--project_fixed_bid --name eHumanize (Support) --customer_id 8 --region_id 1 --status Booked --amount 5000
--project_time_materials --name SoAct --customer_id 9 --region_id 1 --status Booked
--project_retainer --name Groove Studio --customer_id 10 --region_id 1 --status Booked --monthly_amount 4000
--project_retainer --name Aura Wireless --customer_id 11 --region_id 1 --status Booked --monthly_amount 8000
--project_retainer --name Storopack --customer_id 12 --region_id 1 --status Booked --monthly_amount 4750
--project_time_materials --name Think Like a Girl  --customer_id 13 --region_id 1 --status Booked
--project_time_materials --name PEERZLE --customer_id 14 --region_id 1 --status Booked
--project_retainer --name Groove redesign --customer_id 10 --region_id 1 --status Booked --monthly_amount 8000
--project_retainer --name Spex Local --customer_id 15 --region_id 1 --status Booked --monthly_amount 5500
--project_time_materials --name Turk_ --customer_id 16 --region_id 1 --status Booked
--project_retainer --name Olah_ --customer_id 17 --region_id 1 --status Booked --monthly_amount 30000
--project_time_materials --name Breaker Paradise --customer_id 18 --region_id 1 --status Booked
--project_time_materials --name Teachers on Reserve --customer_id 19 --region_id 1 --status Booked
--project_retainer --name Covest --customer_id 20 --region_id 1 --status Booked --monthly_amount 4875
--project_fixed_bid --name eHumanize (development) --customer_id 8 --region_id 1 --status Booked --amount 5000
--project_time_materials --name Legacy Vault --customer_id 21 --region_id 1 --status Booked
--project_fixed_bid --name RideTrip --customer_id 22 --region_id 1 --status Imminent --amount 50000
--project_time_materials --name Charter Next Generatin  --customer_id 23 --region_id 1 --status Booked
--project_time_materials --name Hilliard School --customer_id 24 --region_id 1 --status Booked
--project_fixed_bid --name WorthPoint --customer_id 25 --region_id 1 --status Draft --amount 50000
--project_fixed_bid --name Wearable Device Application  --customer_id 26 --region_id 1 --status Draft --amount 50000
--project_retainer --name QE Solar Automation --customer_id 1 --region_id 1 --status Booked --monthly_amount 20000
--employee --first_name Vilesh --last_name Shah --email vilesh.shah@thesunflowerlab.com --start_date 2022-01-01 --hourly_cost 15 --daily_billable_hours 8 --utilization_target 100 --employee_type_id 4 --region_id 1
--employee --first_name Banti --last_name Parikh --email banti.parikh@thesunflowerlab.com --start_date 2022-01-01 --hourly_cost 15 --daily_billable_hours 8 --utilization_target 100 --employee_type_id 4 --region_id 1
--employee --first_name Nirav --last_name Shah --email nirav@thesunflowerlab.com --start_date 2022-01-01 --hourly_cost 15 --daily_billable_hours 8 --utilization_target 100 --employee_type_id 4 --region_id 1
--employee --first_name Shailendra --last_name Parmar --email shailendra.parmar@thesunflowerlab.com --start_date 2022-01-01 --hourly_cost 15 --daily_billable_hours 8 --utilization_target 100 --employee_type_id 4 --region_id 1
--employee --first_name Dhruvin --last_name Patel --email dhruvin.patel@thesunflowerlab.com --start_date 2022-01-01 --hourly_cost 15 --daily_billable_hours 8 --utilization_target 100 --employee_type_id 4 --region_id 1
--employee --first_name Purvik --last_name Rana --email purvik.rana@thesunflowerlab.com --start_date 2022-01-01 --hourly_cost 15 --daily_billable_hours 8 --utilization_target 100 --employee_type_id 4 --region_id 1
--employee --first_name Aditi --last_name Banerjee --email aditi.banerjee@thesunflowerlab.com --start_date 2022-01-01 --hourly_cost 15 --daily_billable_hours 8 --utilization_target 100 --employee_type_id 4 --region_id 1
--employee --first_name Ashish --last_name Kumar --email ashish.kumar@thesunflowerlab.com --start_date 2022-01-01 --hourly_cost 15 --daily_billable_hours 8 --utilization_target 100 --employee_type_id 4 --region_id 1
--employee --first_name Prashant --last_name Gameti --email prashant.gameti@thesunflowerlab.com --start_date 2022-01-01 --hourly_cost 15 --daily_billable_hours 8 --utilization_target 100 --employee_type_id 4 --region_id 1
--employee --first_name Ankit --last_name Patel --email ankit@thesunflowerlab.com --start_date 2022-01-01 --hourly_cost 15 --daily_billable_hours 8 --utilization_target 100 --employee_type_id 4 --region_id 1
--employee --first_name Kandarp --last_name Bhatt --email kandarp.bhatt@thesunflowerlab.com --start_date 2022-01-01 --hourly_cost 15 --daily_billable_hours 8 --utilization_target 100 --employee_type_id 4 --region_id 1
--employee --first_name Antony --last_name Mathew --email antony.mathew@thesunflowerlab.com --start_date 2022-01-01 --hourly_cost 15 --daily_billable_hours 8 --utilization_target 100 --employee_type_id 4 --region_id 1
--employee --first_name Bhavani --last_name Pandey --email bhavani.pandey@thesunflowerlab.com --start_date 2022-01-01 --hourly_cost 15 --daily_billable_hours 8 --utilization_target 100 --employee_type_id 4 --region_id 1
--employee --first_name Jinal --last_name Jaguwala --email jinal.jaguwala@thesunflowerlab.com --start_date 2022-01-01 --hourly_cost 15 --daily_billable_hours 8 --utilization_target 100 --employee_type_id 4 --region_id 1
--employee --first_name Sagar --last_name Kapadia --email sagar.kapadia@thesunflowerlab.com --start_date 2022-01-01 --hourly_cost 15 --daily_billable_hours 8 --utilization_target 100 --employee_type_id 4 --region_id 1
--employee --first_name Vishal --last_name Goswami --email vishal.goswami@thesunflowerlab.com --start_date 2022-01-01 --hourly_cost 15 --daily_billable_hours 8 --utilization_target 100 --employee_type_id 4 --region_id 1
--employee --first_name Kalyan --last_name Patel --email kalyan.patel@thesunflowerlab.com --start_date 2022-01-01 --hourly_cost 15 --daily_billable_hours 8 --utilization_target 100 --employee_type_id 4 --region_id 1
--employee --first_name Dhaval --last_name Pancholi --email dhaval.pancholi@thesunflowerlab.com --start_date 2022-01-01 --hourly_cost 15 --daily_billable_hours 8 --utilization_target 100 --employee_type_id 4 --region_id 1
--employee --first_name Jigar --last_name Tewar --email jigar.tewar@thesunflowerlab.com --start_date 2022-01-01 --hourly_cost 15 --daily_billable_hours 8 --utilization_target 100 --employee_type_id 4 --region_id 1
--employee --first_name Mitesh --last_name Bhanushali --email mitesh.bhanushali@thesunflowerlab.com --start_date 2022-01-01 --hourly_cost 15 --daily_billable_hours 8 --utilization_target 100 --employee_type_id 4 --region_id 1
--employee --first_name Krunal --last_name Shah --email krunal.shah@thesunflowerlab.com --start_date 2022-01-01 --hourly_cost 15 --daily_billable_hours 8 --utilization_target 100 --employee_type_id 4 --region_id 1
--employee --first_name Devang --last_name Purohit --email devang.purohit@thesunflowerlab.com --start_date 2022-01-01 --hourly_cost 15 --daily_billable_hours 8 --utilization_target 100 --employee_type_id 4 --region_id 1
--employee --first_name Arpita --last_name Patel --email arpita.patel@thesunflowerlab.com --start_date 2022-01-01 --hourly_cost 15 --daily_billable_hours 8 --utilization_target 100 --employee_type_id 4 --region_id 1
--employee --first_name Nitin --last_name Raval --email nitin.raval@thesunflowerlab.com --start_date 2022-01-01 --hourly_cost 15 --daily_billable_hours 8 --utilization_target 100 --employee_type_id 4 --region_id 1
--employee --first_name Mayur --last_name Gohel --email mayur.gohel@thesunflowerlab.com --start_date 2022-01-01 --hourly_cost 15 --daily_billable_hours 8 --utilization_target 100 --employee_type_id 4 --region_id 1
--employee --first_name Richa --last_name Shah --email richa.shah@thesunflowerlab.com --start_date 2022-01-01 --hourly_cost 15 --daily_billable_hours 8 --utilization_target 100 --employee_type_id 4 --region_id 1
--employee --first_name Ridham --last_name Desai --email ridham.desai@thesunflowerlab.com --start_date 2022-01-01 --hourly_cost 15 --daily_billable_hours 8 --utilization_target 100 --employee_type_id 4 --region_id 1
--employee --first_name Monik --last_name Kacha --email monik.kacha@thesunflowerlab.com --start_date 2022-01-01 --hourly_cost 15 --daily_billable_hours 8 --utilization_target 100 --employee_type_id 4 --region_id 1
--employee --first_name Jaydeep --last_name Dave --email jaydeep.dave@thesunflowerlab.com --start_date 2022-01-01 --hourly_cost 15 --daily_billable_hours 8 --utilization_target 100 --employee_type_id 4 --region_id 1
--employee --first_name Siddhi --last_name Shah --email siddhi.shah@thesunflowerlab.com --start_date 2022-01-01 --hourly_cost 15 --daily_billable_hours 8 --utilization_target 100 --employee_type_id 4 --region_id 1
--employee --first_name Faisal --last_name Saiyed --email faisal.saiyed@thesunflowerlab.com --start_date 2022-01-01 --hourly_cost 15 --daily_billable_hours 8 --utilization_target 100 --employee_type_id 4 --region_id 1
--employee --first_name Dhruv --last_name Prajapati --email dhruv.prajapati@thesunflowerlab.com --start_date 2022-01-01 --hourly_cost 15 --daily_billable_hours 8 --utilization_target 100 --employee_type_id 4 --region_id 1
--employee --first_name Akhil --last_name Patel --email akhil.patel@thesunflowerlab.com --start_date 2022-01-01 --hourly_cost 15 --daily_billable_hours 8 --utilization_target 100 --employee_type_id 4 --region_id 1
--employee --first_name Sakshee --last_name Ajwalia --email sakshee.ajwalia@thesunflowerlab.com --start_date 2022-01-01 --hourly_cost 15 --daily_billable_hours 8 --utilization_target 100 --employee_type_id 4 --region_id 1
--employee --first_name Vishva --last_name Shah --email vishva.shah@thesunflowerlab.com --start_date 2022-01-01 --hourly_cost 15 --daily_billable_hours 8 --utilization_target 100 --employee_type_id 4 --region_id 1
--employee --first_name Bansari --last_name Shah --email bansari.shah@thesunflowerlab.com --start_date 2022-01-01 --hourly_cost 15 --daily_billable_hours 8 --utilization_target 100 --employee_type_id 4 --region_id 1
--employee --first_name Rucha --last_name Mer --email rucha.mer@thesunflowerlab.com --start_date 2022-01-01 --hourly_cost 15 --daily_billable_hours 8 --utilization_target 100 --employee_type_id 4 --region_id 1
--employee --first_name Yogita --last_name Jain --email yogita.jain@thesunflowerlab.com --start_date 2022-01-01 --hourly_cost 15 --daily_billable_hours 8 --utilization_target 100 --employee_type_id 4 --region_id 1
--employee --first_name Nandini --last_name Dalal --email nandini.dalal@thesunflowerlab.com --start_date 2022-01-01 --hourly_cost 15 --daily_billable_hours 8 --utilization_target 100 --employee_type_id 4 --region_id 1
--employee --first_name Hiral --last_name Tamboli --email hiral.tamboli@thesunflowerlab.com --start_date 2022-01-01 --hourly_cost 15 --daily_billable_hours 8 --utilization_target 100 --employee_type_id 4 --region_id 1
--employee --first_name Kishan --last_name Bagiya --email kishan.bagiya@thesunflowerlab.com --start_date 2022-01-01 --hourly_cost 15 --daily_billable_hours 8 --utilization_target 100 --employee_type_id 4 --region_id 1
--employee --first_name Hardeep --last_name Yadav --email hardeep.yadav@thesunflowerlab.com --start_date 2022-01-01 --hourly_cost 15 --daily_billable_hours 8 --utilization_target 100 --employee_type_id 4 --region_id 1
--employee --first_name Ronak --last_name Trivedi --email ronak.trivedi@thesunflowerlab.com --start_date 2022-01-01 --hourly_cost 15 --daily_billable_hours 8 --utilization_target 100 --employee_type_id 4 --region_id 1
--employee --first_name Maitri --last_name Soni --email maitri.soni@thesunflowerlab.com --start_date 2022-01-01 --hourly_cost 15 --daily_billable_hours 8 --utilization_target 100 --employee_type_id 4 --region_id 1
--employee --first_name Bhavesh --last_name Desai --email bhavesh.desai@thesunflowerlab.com --start_date 2022-01-01 --hourly_cost 15 --daily_billable_hours 8 --utilization_target 100 --employee_type_id 4 --region_id 1
--employee --first_name Pratik --last_name Rajmin --email pratik.rajmin@thesunflowerlab.com --start_date 2022-01-01 --hourly_cost 15 --daily_billable_hours 8 --utilization_target 100 --employee_type_id 4 --region_id 1
--employee --first_name Nikunj --last_name Patel --email nikunj.patel@thesunflowerlab.com --start_date 2022-01-01 --hourly_cost 15 --daily_billable_hours 8 --utilization_target 100 --employee_type_id 4 --region_id 1
--employee --first_name Namaskar --last_name Shah --email namaskar.shah@thesunflowerlab.com --start_date 2022-01-01 --hourly_cost 15 --daily_billable_hours 8 --utilization_target 100 --employee_type_id 4 --region_id 1
--employee --first_name Nency --last_name Patel --email nency.patel@thesunflowerlab.com --start_date 2022-01-01 --hourly_cost 15 --daily_billable_hours 8 --utilization_target 100 --employee_type_id 4 --region_id 1
--employee --first_name Krishalsinh --last_name Raj --email krishalsinh.raj@thesunflowerlab.com --start_date 2022-01-01 --hourly_cost 15 --daily_billable_hours 8 --utilization_target 100 --employee_type_id 4 --region_id 1
--employee --first_name Bijal --last_name Tailor --email bijal.tailor@thesunflowerlab.com --start_date 2022-01-01 --hourly_cost 15 --daily_billable_hours 8 --utilization_target 100 --employee_type_id 4 --region_id 1
--employee --first_name Purvi --last_name Shah --email purvi.shah@thesunflowerlab.com --start_date 2022-01-01 --hourly_cost 15 --daily_billable_hours 8 --utilization_target 100 --employee_type_id 4 --region_id 1
--employee --first_name Nimit --last_name Tamboli --email nimit@thesunflowerlab.com --start_date 2022-01-01 --hourly_cost 15 --daily_billable_hours 8 --utilization_target 100 --employee_type_id 4 --region_id 1
--employee --first_name Arjun --last_name Kaushal --email arjun.kaushal@thesunflowerlab.com --start_date 2022-01-01 --hourly_cost 15 --daily_billable_hours 8 --utilization_target 100 --employee_type_id 4 --region_id 1
--employee --first_name Nufail --last_name LNLeftBlank --email nufail@thesunflowerlab.com --start_date 2022-01-01 --hourly_cost 15 --daily_billable_hours 8 --utilization_target 100 --employee_type_id 4 --region_id 1
--employee --first_name Kamil --last_name Patel --email kamil.patel@thesunflowerlab.com --start_date 2022-01-01 --hourly_cost 15 --daily_billable_hours 8 --utilization_target 100 --employee_type_id 4 --region_id 1
--employee --first_name Sneha --last_name Jaiswal --email sneha.jaiswal@thesunflowerlab.com --start_date 2022-01-01 --hourly_cost 15 --daily_billable_hours 8 --utilization_target 100 --employee_type_id 4 --region_id 1
--employee --first_name Faizan --last_name Saiyed --email faizan.saiyed@thesunflowerlab.com --start_date 2022-01-01 --hourly_cost 15 --daily_billable_hours 8 --utilization_target 100 --employee_type_id 4 --region_id 1
--employee --first_name Ishan --last_name Mohan --email ishan.mohan@thesunflowerlab.com --start_date 2022-01-01 --hourly_cost 15 --daily_billable_hours 8 --utilization_target 100 --employee_type_id 4 --region_id 1
--employee --first_name Piyush --last_name Chokshi --email piyush.chokshi@thesunflowerlab.com --start_date 2022-01-01 --hourly_cost 15 --daily_billable_hours 8 --utilization_target 100 --employee_type_id 4 --region_id 1
--employee --first_name Jay --last_name Patel --email jay.patel@thesunflowerlab.com --start_date 2022-01-01 --hourly_cost 15 --daily_billable_hours 8 --utilization_target 100 --employee_type_id 4 --region_id 1
--employee --first_name Khushali --last_name Shah --email khushali.shah@thesunflowerlab.com --start_date 2022-01-01 --hourly_cost 15 --daily_billable_hours 8 --utilization_target 100 --employee_type_id 4 --region_id 1
--employee --first_name Mihir --last_name Patel --email mihir.patel@thesunflowerlab.com --start_date 2022-01-01 --hourly_cost 15 --daily_billable_hours 8 --utilization_target 100 --employee_type_id 4 --region_id 1
--employee --first_name Aayushi --last_name Shah --email aayushi.shah@thesunflowerlab.com --start_date 2022-01-01 --hourly_cost 15 --daily_billable_hours 8 --utilization_target 100 --employee_type_id 4 --region_id 1
--employee --first_name Mrugesh --last_name Shah --email mrugesh.shah@thesunflowerlab.com --start_date 2022-01-01 --hourly_cost 15 --daily_billable_hours 8 --utilization_target 100 --employee_type_id 4 --region_id 1
--employee --first_name Deepak --last_name Pandey --email deepak.pandey@thesunflowerlab.com --start_date 2022-01-01 --hourly_cost 15 --daily_billable_hours 8 --utilization_target 100 --employee_type_id 4 --region_id 1
--employee --first_name Aamir --last_name Vahora --email aamir.vahora@thesunflowerlab.com --start_date 2022-01-01 --hourly_cost 15 --daily_billable_hours 8 --utilization_target 100 --employee_type_id 4 --region_id 1
--employee --first_name Urmil --last_name Patel --email urmil.patel@thesunflowerlab.com --start_date 2022-01-01 --hourly_cost 15 --daily_billable_hours 8 --utilization_target 100 --employee_type_id 4 --region_id 1
--employee --first_name Shubham --last_name Pagare --email shubham.pagare@thesunflowerlab.com --start_date 2022-01-01 --hourly_cost 15 --daily_billable_hours 8 --utilization_target 100 --employee_type_id 4 --region_id 1
--employee --first_name Jagadish --last_name Alle --email jagadish.alle@thesunflowerlab.com --start_date 2022-01-01 --hourly_cost 15 --daily_billable_hours 8 --utilization_target 100 --employee_type_id 4 --region_id 1
--employee --first_name Ashish --last_name Prajapati --email ashish.prajapati@thesunflowerlab.com --start_date 2022-01-01 --hourly_cost 15 --daily_billable_hours 8 --utilization_target 100 --employee_type_id 4 --region_id 1
--position_with_employee --name Delivery Lead --start_date 2022-01-01 --end_date 2023-03-05 --bill_rate 60 --cost 15 --daily_billable_hours 2 --project_id 18 --position_type_id 4 --employee_id 5
--position_with_employee --name Engineer --start_date 2022-01-01 --end_date 2023-03-05 --bill_rate 25 --cost 15 --daily_billable_hours 8 --project_id 18 --position_type_id 2 --employee_id 17
--position_with_employee --name Engineer --start_date 2022-01-01 --end_date 2023-03-05 --bill_rate 25 --cost 15 --daily_billable_hours 8 --project_id 18 --position_type_id 2 --employee_id 20
--position_with_employee --name Engineer --start_date 2022-01-01 --end_date 2023-03-05 --bill_rate 25 --cost 15 --daily_billable_hours 8 --project_id 18 --position_type_id 2 --employee_id 21
--position_with_employee --name Engineer --start_date 2022-01-01 --end_date 2023-03-05 --bill_rate 25 --cost 15 --daily_billable_hours 8 --project_id 18 --position_type_id 2 --employee_id 22
--position_with_employee --name Engineer --start_date 2022-01-01 --end_date 2023-03-05 --bill_rate 25 --cost 15 --daily_billable_hours 8 --project_id 18 --position_type_id 2 --employee_id 23
--position_with_employee --name Engineer --start_date 2022-01-01 --end_date 2023-03-05 --bill_rate 25 --cost 15 --daily_billable_hours 8 --project_id 18 --position_type_id 2 --employee_id 24
--position_with_employee --name Delivery Lead --start_date 2022-01-01 --end_date 2022-04-01 --bill_rate 60 --cost 15 --daily_billable_hours 2 --project_id 16 --position_type_id 4 --employee_id 5
--position_with_employee --name Engineer --start_date 2022-01-01 --end_date 2022-04-01 --bill_rate 25 --cost 15 --daily_billable_hours 8 --project_id 16 --position_type_id 2 --employee_id 26
--position_with_employee --name Engineer --start_date 2022-01-01 --end_date 2022-04-01 --bill_rate 25 --cost 15 --daily_billable_hours 8 --project_id 16 --position_type_id 2 --employee_id 28
--position_with_employee --name Delivery Lead --start_date 2022-01-01 --end_date 2022-09-01 --bill_rate 60 --cost 15 --daily_billable_hours 2 --project_id 25 --position_type_id 4 --employee_id 5
--position_with_employee --name Engineer --start_date 2022-01-01 --end_date 2022-09-01 --bill_rate 25 --cost 15 --daily_billable_hours 8 --project_id 25 --position_type_id 2 --employee_id 35
--position_with_employee --name Engineer --start_date 2022-01-01 --end_date 2022-09-01 --bill_rate 25 --cost 15 --daily_billable_hours 8 --project_id 25 --position_type_id 2 --employee_id 25
--position_with_employee --name Engineer --start_date 2022-01-01 --end_date 2022-09-01 --bill_rate 25 --cost 15 --daily_billable_hours 1 --project_id 25 --position_type_id 2 --employee_id 37
--position_with_employee --name Delivery Lead --start_date 2022-01-01 --end_date 2023-01-01 --bill_rate 60 --cost 15 --daily_billable_hours 1 --project_id 6 --position_type_id 4 --employee_id 5
--position_with_employee --name Engineer --start_date 2022-01-01 --end_date 2023-01-01 --bill_rate 25 --cost 15 --daily_billable_hours 4 --project_id 6 --position_type_id 2 --employee_id 31
--position_with_employee --name Engineer --start_date 2022-01-01 --end_date 2023-01-01 --bill_rate 25 --cost 15 --daily_billable_hours 4 --project_id 6 --position_type_id 2 --employee_id 33
--position_with_employee --name Delivery Lead --start_date 2022-01-01 --end_date 2023-04-01 --bill_rate 25 --cost 15 --daily_billable_hours 1 --project_id 2 --position_type_id 4 --employee_id 7
--position_with_employee --name Delivery Lead --start_date 2022-01-01 --end_date 2022-12-01 --bill_rate 25 --cost 15 --daily_billable_hours 1 --project_id 3 --position_type_id 4 --employee_id 4
--position_with_employee --name Engineer --start_date 2022-01-01 --end_date 2022-12-01 --bill_rate 25 --cost 15 --daily_billable_hours 2 --project_id 3 --position_type_id 2 --employee_id 8
--position_with_employee --name Engineer --start_date 2022-01-01 --end_date 2022-12-01 --bill_rate 25 --cost 15 --daily_billable_hours 8 --project_id 3 --position_type_id 2 --employee_id 36
--position_with_employee --name Delivery Lead --start_date 2022-01-01 --end_date 2022-12-01 --bill_rate 25 --cost 15 --daily_billable_hours 1 --project_id 3 --position_type_id 3 --employee_id 19
--position_with_employee --name Engineer --start_date 2022-01-01 --end_date 2022-12-01 --bill_rate 25 --cost 15 --daily_billable_hours 8 --project_id 5 --position_type_id 4 --employee_id 6
--position_with_employee --name Engineer --start_date 2022-01-01 --end_date 2022-12-01 --bill_rate 25 --cost 15 --daily_billable_hours 8 --project_id 5 --position_type_id 2 --employee_id 40
--position_with_employee --name Engineer --start_date 2022-01-01 --end_date 2022-12-01 --bill_rate 25 --cost 15 --daily_billable_hours 8 --project_id 5 --position_type_id 2 --employee_id 42
--position_with_employee --name Delivery Lead --start_date 2022-01-01 --end_date 2022-12-01 --bill_rate 25 --cost 15 --daily_billable_hours 2 --project_id 5 --position_type_id 2 --employee_id 28
--position_with_employee --name Engineer --start_date 2022-01-01 --end_date 2022-12-01 --bill_rate 25 --cost 15 --daily_billable_hours 8 --project_id 22 --position_type_id 4 --employee_id 4
--position_with_employee --name Engineer --start_date 2022-01-01 --end_date 2022-12-01 --bill_rate 25 --cost 15 --daily_billable_hours 1 --project_id 22 --position_type_id 2 --employee_id 9
--position_with_employee --name Ui/UX --start_date 2022-01-01 --end_date 2022-12-01 --bill_rate 25 --cost 15 --daily_billable_hours 1 --project_id 22 --position_type_id 2 --employee_id 14
--position_with_employee --name Ui/UX --start_date 2022-01-01 --end_date 2022-12-01 --bill_rate 25 --cost 15 --daily_billable_hours 1 --project_id 22 --position_type_id 3 --employee_id 19
--position_with_employee --name Engineer --start_date 2022-01-01 --end_date 2022-12-01 --bill_rate 25 --cost 15 --daily_billable_hours 8 --project_id 22 --position_type_id 2 --employee_id 44
--position_with_employee --name Delivery Lead --start_date 2022-01-01 --end_date 2022-03-30 --bill_rate 25 --cost 15 --daily_billable_hours 8 --project_id 11 --position_type_id 4 --employee_id 7
--position_with_employee --name Engineer --start_date 2022-01-01 --end_date 2022-03-30 --bill_rate 25 --cost 15 --daily_billable_hours 2 --project_id 11 --position_type_id 2 --employee_id 71
--position_with_employee --name DevOps --start_date 2022-01-01 --end_date 2022-03-30 --bill_rate 25 --cost 15 --daily_billable_hours 2 --project_id 11 --position_type_id 8 --employee_id 18
--position_with_employee --name QA___ --start_date 2022-01-01 --end_date 2022-03-30 --bill_rate 25 --cost 15 --daily_billable_hours 8 --project_id 11 --position_type_id 7 --employee_id 66
--position_with_employee --name Delivery Lead --start_date 2022-01-01 --end_date 2022-12-01 --bill_rate 25 --cost 15 --daily_billable_hours 2 --project_id 12 --position_type_id 4 --employee_id 1
--position_with_employee --name Engineer --start_date 2022-01-01 --end_date 2022-12-01 --bill_rate 25 --cost 15 --daily_billable_hours 8 --project_id 12 --position_type_id 2 --employee_id 29
--position_with_employee --name Engineer --start_date 2022-01-01 --end_date 2022-12-01 --bill_rate 25 --cost 15 --daily_billable_hours 8 --project_id 12 --position_type_id 2 --employee_id 15
--position_with_employee --name Engineer --start_date 2022-01-01 --end_date 2022-12-01 --bill_rate 25 --cost 15 --daily_billable_hours 8 --project_id 12 --position_type_id 2 --employee_id 30
--position_with_employee --name QA___ --start_date 2022-01-01 --end_date 2022-12-01 --bill_rate 25 --cost 15 --daily_billable_hours 4 --project_id 12 --position_type_id 7 --employee_id 13
--position_with_employee --name DevOps --start_date 2022-01-01 --end_date 2022-12-01 --bill_rate 25 --cost 15 --daily_billable_hours 1 --project_id 12 --position_type_id 8 --employee_id 61
--position_with_employee --name Delivery Lead --start_date 2022-01-01 --end_date 2022-12-01 --bill_rate 25 --cost 15 --daily_billable_hours 3 --project_id 10 --position_type_id 4 --employee_id 10
--position_with_employee --name Engineer --start_date 2022-01-01 --end_date 2022-12-01 --bill_rate 25 --cost 15 --daily_billable_hours 8 --project_id 10 --position_type_id 2 --employee_id 63
--position_with_employee --name Engineer --start_date 2022-01-01 --end_date 2022-12-01 --bill_rate 25 --cost 15 --daily_billable_hours 8 --project_id 10 --position_type_id 2 --employee_id 52
--position_with_employee --name Delivery Lead --start_date 2022-01-01 --end_date 2022-12-01 --bill_rate 25 --cost 15 --daily_billable_hours 2 --project_id 21 --position_type_id 4 --employee_id 4
--position_with_employee --name Engineer --start_date 2022-01-01 --end_date 2022-12-01 --bill_rate 25 --cost 15 --daily_billable_hours 2 --project_id 21 --position_type_id 2 --employee_id 8
--position_with_employee --name Engineer --start_date 2022-01-01 --end_date 2022-12-01 --bill_rate 25 --cost 15 --daily_billable_hours 7 --project_id 21 --position_type_id 2 --employee_id 37
--position_with_employee --name Engineer --start_date 2022-01-01 --end_date 2022-12-01 --bill_rate 25 --cost 15 --daily_billable_hours 8 --project_id 21 --position_type_id 2 --employee_id 48
--position_with_employee --name Ui/UX --start_date 2022-01-01 --end_date 2022-12-01 --bill_rate 25 --cost 15 --daily_billable_hours 8 --project_id 21 --position_type_id 3 --employee_id 38
--position_with_employee --name Delivery Lead --start_date 2022-01-01 --end_date 2022-12-01 --bill_rate 25 --cost 15 --daily_billable_hours 2 --project_id 23 --position_type_id 4 --employee_id 1
--position_with_employee --name Delivery Lead --start_date 2022-01-01 --end_date 2022-12-01 --bill_rate 25 --cost 15 --daily_billable_hours 2 --project_id 23 --position_type_id 4 --employee_id 7
--position_with_employee --name Engineer --start_date 2022-01-01 --end_date 2022-12-01 --bill_rate 25 --cost 15 --daily_billable_hours 8 --project_id 23 --position_type_id 2 --employee_id 67
--position_with_employee --name Engineer --start_date 2022-01-01 --end_date 2022-12-01 --bill_rate 25 --cost 15 --daily_billable_hours 8 --project_id 23 --position_type_id 2 --employee_id 27
--position_with_employee --name Engineer --start_date 2022-01-01 --end_date 2022-12-01 --bill_rate 25 --cost 15 --daily_billable_hours 8 --project_id 23 --position_type_id 2 --employee_id 68
--position_with_employee --name QA___ --start_date 2022-01-01 --end_date 2022-12-01 --bill_rate 25 --cost 15 --daily_billable_hours 4 --project_id 23 --position_type_id 7 --employee_id 13
--position_with_employee --name Delivery Lead --start_date 2022-01-01 --end_date 2022-09-01 --bill_rate 25 --cost 15 --daily_billable_hours 2 --project_id 24 --position_type_id 4 --employee_id 2
--position_with_employee --name Engineer --start_date 2022-01-01 --end_date 2022-09-01 --bill_rate 25 --cost 15 --daily_billable_hours 1 --project_id 24 --position_type_id 2 --employee_id 6
--position_with_employee --name UI/UX --start_date 2022-01-01 --end_date 2022-09-01 --bill_rate 25 --cost 15 --daily_billable_hours 8 --project_id 24 --position_type_id 3 --employee_id 49
--position_with_employee --name Delivery Lead --start_date 2022-01-01 --end_date 2022-09-01 --bill_rate 25 --cost 15 --daily_billable_hours 2 --project_id 27 --position_type_id 4 --employee_id 2
--position_with_employee --name UI/UX --start_date 2022-01-01 --end_date 2022-09-01 --bill_rate 25 --cost 15 --daily_billable_hours 4 --project_id 27 --position_type_id 3 --employee_id 19
--position_with_employee --name UI/UX --start_date 2022-01-01 --end_date 2022-09-01 --bill_rate 25 --cost 15 --daily_billable_hours 2 --project_id 27 --position_type_id 3 --employee_id 49
--position_with_employee --name Delivery Lead --start_date 2022-01-01 --end_date 2022-09-01 --bill_rate 25 --cost 15 --daily_billable_hours 2 --project_id 28 --position_type_id 4 --employee_id 2
--position_with_employee --name Delivery Lead --start_date 2022-01-01 --end_date 2022-09-01 --bill_rate 25 --cost 15 --daily_billable_hours 1 --project_id 9 --position_type_id 4 --employee_id 3
--position_with_employee --name Engineer --start_date 2022-01-01 --end_date 2022-09-01 --bill_rate 25 --cost 15 --daily_billable_hours 8 --project_id 9 --position_type_id 2 --employee_id 27
--position_with_employee --name QA___ --start_date 2022-01-01 --end_date 2022-09-01 --bill_rate 25 --cost 15 --daily_billable_hours 8 --project_id 9 --position_type_id 7 --employee_id 34
--position_with_employee --name Delivery Lead --start_date 2022-01-01 --end_date 2022-09-01 --bill_rate 25 --cost 15 --daily_billable_hours 1 --project_id 4 --position_type_id 4 --employee_id 3
--position_with_employee --name Engineer --start_date 2022-01-01 --end_date 2022-09-01 --bill_rate 25 --cost 15 --daily_billable_hours 4 --project_id 4 --position_type_id 2 --employee_id 31
--position_with_employee --name Engineer --start_date 2022-01-01 --end_date 2022-09-01 --bill_rate 25 --cost 15 --daily_billable_hours 4 --project_id 4 --position_type_id 2 --employee_id 27
--position_with_employee --name Delivery Lead --start_date 2022-01-01 --end_date 2022-09-01 --bill_rate 25 --cost 15 --daily_billable_hours 1 --project_id 13 --position_type_id 4 --employee_id 3
--position_with_employee --name Delivery Lead --start_date 2022-01-01 --end_date 2022-09-01 --bill_rate 25 --cost 15 --daily_billable_hours 1 --project_id 14 --position_type_id 4 --employee_id 3
--position_with_employee --name Delivery Lead --start_date 2022-01-01 --end_date 2022-09-01 --bill_rate 25 --cost 15 --daily_billable_hours 1 --project_id 17 --position_type_id 4 --employee_id 3
--position_with_employee --name Delivery Lead --start_date 2022-01-01 --end_date 2022-09-01 --bill_rate 25 --cost 15 --daily_billable_hours 1 --project_id 19 --position_type_id 4 --employee_id 3
--position_with_employee --name Engineer --start_date 2022-01-01 --end_date 2022-09-01 --bill_rate 25 --cost 15 --daily_billable_hours 8 --project_id 19 --position_type_id 2 --employee_id 37
--position_with_employee --name Engineer --start_date 2022-01-01 --end_date 2022-09-01 --bill_rate 25 --cost 15 --daily_billable_hours 8 --project_id 19 --position_type_id 2 --employee_id 25
--position_with_employee --name QA___ --start_date 2022-01-01 --end_date 2022-09-01 --bill_rate 25 --cost 15 --daily_billable_hours 8 --project_id 19 --position_type_id 7 --employee_id 34
--position_with_employee --name Delivery Lead --start_date 2022-01-01 --end_date 2022-09-01 --bill_rate 25 --cost 15 --daily_billable_hours 1 --project_id 20 --position_type_id 4 --employee_id 4
--position_with_employee --name Engineer --start_date 2022-01-01 --end_date 2022-09-01 --bill_rate 25 --cost 15 --daily_billable_hours 4 --project_id 20 --position_type_id 2 --employee_id 45
--position_with_employee --name Delivery Lead --start_date 2022-01-01 --end_date 2022-12-01 --bill_rate 25 --cost 15 --daily_billable_hours 2 --project_id 1 --position_type_id 4 --employee_id 4
--position_with_employee --name Engineer --start_date 2022-01-01 --end_date 2022-12-01 --bill_rate 25 --cost 15 --daily_billable_hours 8 --project_id 1 --position_type_id 2 --employee_id 50
--position_with_employee --name Engineer --start_date 2022-01-01 --end_date 2022-12-01 --bill_rate 25 --cost 15 --daily_billable_hours 8 --project_id 1 --position_type_id 2 --employee_id 43
--position_with_employee --name Engineer --start_date 2022-01-01 --end_date 2022-12-01 --bill_rate 25 --cost 15 --daily_billable_hours 8 --project_id 1 --position_type_id 2 --employee_id 51