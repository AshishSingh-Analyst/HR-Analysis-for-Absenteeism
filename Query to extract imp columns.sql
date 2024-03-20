--create a join table
--1 connecting absentiesm table with compensation table
select * from Absenteeism_at_work a
left join compensation b
on a.ID=b.ID
left join [Hotel Revenue].[dbo].[Reasons] r
on a.Reason_for_absence=r.Number

--Finding the healthiest
select * from Absenteeism_at_work
where Social_drinker=0 and Social_smoker=0 and Body_mass_index<25
and Absenteeism_time_in_hours<(select avg(Absenteeism_time_in_hours) from Absenteeism_at_work)

--Compensation rat increase for non-smokers/budget-$983,221 so 0.68 increase per hour/ $1414.4 per year
select count(*) as non_smokers from Absenteeism_at_work 
where Social_smoker=0

--optimizing the query
select 
a.ID,
r.Reason ,
Month_of_absence,
Body_mass_index,
case when Body_mass_index <18.5					  then 'Under-Weight'
	 when Body_mass_index between 18.5 and 24.9   then 'Healthy'
	 when Body_mass_index between 25 and 29.9	  then 'Over-Weight'
	 when Body_mass_index >=30					  then 'Obese'
	 else 'UNKNOWN' end as BMI_Category ,
case when Month_of_absence in (12,1,2) then 'Winter'
	 when Month_of_absence in (3,4,5)  then 'Spring'
	 when Month_of_absence in (6,7,8)  then 'Summer'
	 when Month_of_absence in (9,10,11)  then 'Rainy'
	 else 'UNKNOWN' end as Seasons_Names
	 ,
	 [Day_of_the_week]
      ,[Seasons]
      ,[Transportation_expense]
      ,[Distance_from_Residence_to_Work]
      ,[Service_time]
      ,[Age]
      ,[Work_load_Average_day]
      ,[Hit_target]
      ,[Disciplinary_failure]
      ,[Education]
      ,[Son]
      ,[Social_drinker]
      ,[Social_smoker]
      ,[Pet]
      ,[Weight]
      ,[Height]
      ,[Absenteeism_time_in_hours]
from Absenteeism_at_work a
left join compensation b
on a.ID=b.ID
left join [Hotel Revenue].[dbo].[Reasons] r
on a.Reason_for_absence=r.Number