# Instagram User Analysis 
![image](https://github.com/user-attachments/assets/9e38f31e-ecf9-434e-81d1-ba2f256f6764)

## Objective 
The objective of this project is to analyze Instagram user interactions using SQL and MySQL Workbench to extract meaningful insights. These insights will support informed decisions by the product, marketing, and development teams, guiding the future direction of the app and enhancing user experience.
## Approach
In this project, I leveraged MySQL to extract and analyze data from the provided database. 

## Tech Stack Used
- SQL
- MySQL Workbench

## Marketing Analysis
###  1.Loyal User Reward
**Task:** Identify the five oldest users on Instagram from the provided database.
```sql
SELECT 
    username
FROM
    users
ORDER BY created_at
LIMIT 5;
```

### 2.Inactive User Engagement
**Task:** Identify users who have never posted a single photo on Instagram.

```sql
SELECT 
    username
FROM
    users
WHERE
    id NOT IN (SELECT DISTINCT
            user_id
        FROM
            photos);

# Alter
SELECT 
    users.username
FROM
    users
        LEFT JOIN
    photos ON users.id = photos.user_id
WHERE
    photos.id IS NULL;
```

### 3.Contest Winner Declaration
**Task:** Determine the winner of the contest and provide their details to the team.

```sql
SELECT 
    username, 
    photos.id,
    photos.image_url,
    COUNT(likes.user_id) AS total
FROM 
    photos
INNER JOIN 
    likes ON likes.photo_id = photos.id
INNER JOIN 
    users ON photos.user_id = users.id
GROUP BY 
    photos.id
ORDER BY 
    total DESC
LIMIT 1;
```
### 4.Hashtag Research
**Task:** Identify and suggest the top five most commonly used hashtags on the platform.
```sql
select
tags.tag_name, count(photo_tags.photo_id) as tags_count 
from tags
inner join photo_tags
on tags.id = photo_tags.tag_id
group by tags.tag_name
order by tags_count desc
limit 5;
```
### 5.Ad Campaign Launch
Task: Determine the day of the week when most users register on Instagram. Provide insights on when to schedule an ad campaign.

```sql
SELECT 
    DAYNAME(created_at) AS days,
    COUNT(id) AS days_count
FROM
    users
GROUP BY days
ORDER BY days_count DESC;
```

## Sales & Insight
- Targeting long-term users for loyalty programs enhances retention and engagement.
- Re-engagement campaigns for users who haven’t posted can boost activity and platform interaction.
- Recognizing highly engaged users motivates participation and generates more user content.
- Identifying trending hashtags informs content strategy, driving greater engagement with popular topics.
- Analyzing peak user registration days helps optimize ad campaign timing for maximum reach and effectiveness.
