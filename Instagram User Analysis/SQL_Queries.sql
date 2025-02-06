/*Description: In this project, we are supposed to provide a
detailed report for the Marketing department. This analysis will help them
make a decision based on different metrics and insights.*/

# Marketing Analysis
use ig_clone;

# 1.Loyal User Reward: The marketing team wants to reward those who have been using the platform for the longest time.
# Task: Identify the five oldest users on Instagram from the provided database.

SELECT 
    username
FROM
    users
ORDER BY created_at
LIMIT 5;

#2.Inactive User Engagement: The team wants to encourage inactive users by sending them promotional emails.
# Task: Identify users who have never posted a single photo on Instagram.

SELECT 
    users.username
FROM
    users
        LEFT JOIN
    photos ON users.id = photos.user_id
WHERE
    photos.id IS NULL;

# 3.Contest Winner Declaration: The team has organized a contest where the user with the most likes on a single photo wins.
# Task: Determine the winner of the contest and provide their details to the team.

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

# 4.Hashtag Research: A partner brand wants to know the most popular hashtags to use in their posts to reach the most people.
# Your Task: Identify and suggest the top five most commonly used hashtags on the platform.

select
tags.tag_name, count(photo_tags.photo_id) as tags_count 
from tags
inner join photo_tags
on tags.id = photo_tags.tag_id
group by tags.tag_name
order by tags_count desc
limit 5;

# 5.Ad Campaign Launch: The team wants to know the best day of the week to launch ads.
# Your Task: Determine the day of the week when most users register on Instagram. Provide insights on when to schedule an ad campaign.

SELECT 
    DAYNAME(created_at) AS days,
    COUNT(id) AS days_count
FROM
    users
GROUP BY days
ORDER BY days_count DESC;
