/*Question 1

Write an instead-of trigger that enables updates to the title attribute of view 
LateRating.

Policy: Updates to attribute title in LateRating should update Movie.title for 
the corresponding movie. (You may assume attribute mID is a key for table Movie.) 
Make sure the mID attribute of view LateRating has not also been updated -- if 
it has been updated, don't make any changes. Don't worry about updates to stars 
or ratingDate.

    Remember you need to use an instead-of trigger for view modifications as 
    supported by SQLite.
*/
create trigger LateRatingUpdate
instead of update on LateRating
for each row
begin
    update Movie
    set title = New.title
    where mID = New.mID;
end;

/*Question 2

Write an instead-of trigger that enables updates to the stars attribute of view 
LateRating.

Policy: Updates to attribute stars in LateRating should update Rating.stars for 
the corresponding movie rating. (You may assume attributes [mID,ratingDate] 
together are a key for table Rating.) Make sure the mID and ratingDate attributes 
of view LateRating have not also been updated -- if either one has been updated, 
don't make any changes. Don't worry about updates to title.

    Remember you need to use an instead-of trigger for view modifications as 
    supported by SQLite.
*/
create trigger LateRatingUpdate
instead of update on LateRating
for each row
begin
    update Rating
    set stars = New.stars
    where (mID = New.mID) and (ratingDate = New.RatingDate);
end;

/*Question 3

Write an instead-of trigger that enables updates to the mID attribute of view 
LateRating.

Policy: Updates to attribute mID in LateRating should update Movie.mID and 
Rating.mID for the corresponding movie. Update all Rating tuples with the 
old mID, not just the ones contributing to the view. Don't worry about updates 
to title, stars, or ratingDate.

    Remember you need to use an instead-of trigger for view modifications as 
    supported by SQLite.
*/
create trigger LateRatingUpdate
instead of update on LateRating
for each row
begin
    update Movie
    set mID = New.mID
    where title = New.title;
    update Rating
    set mID = New.mID
    where mID = Old.mID;
end;

/*Question 4

Write an instead-of trigger that enables deletions from view HighlyRated.

Policy: Deletions from view HighlyRated should delete all ratings for the 
corresponding movie that have stars > 3.

    Remember you need to use an instead-of trigger for view modifications as 
    supported by SQLite.
*/
create trigger HighlyRatedDelete
instead of delete on HighlyRated
for each row
begin
    delete from Rating
    where (mid = Old.mID) and (stars > 3);
end;

/*Question 5

Write an instead-of trigger that enables deletions from view HighlyRated.

Policy: Deletions from view HighlyRated should update all ratings for the 
corresponding movie that have stars > 3 so they have stars = 3.

    Remember you need to use an instead-of trigger for view modifications as 
    supported by SQLite.
*/
create trigger HighlyRatedDeleteUpdate
instead of delete on HighlyRated
for each row
begin
    update Rating
    set stars = 3
    where (mid = Old.mID) and (stars > 3);
end;
