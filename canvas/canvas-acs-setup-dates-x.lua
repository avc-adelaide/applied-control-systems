#!/usr/local/bin/lua

local lms  = require("canvas-lms")
local canvas = lms:new()

local pretty  = require("pl.pretty")

local function duedate(sem,week,day,hour)
  _,wkdate = canvas:datetime{
    sem = sem , week = week , day = day  , hour = hour ,
  }
  return wkdate
end


print("Update announcement semA dates? 'y' to do so, anything else to skip")
if io.read() == "y" then

  canvas:get_announcements{download="ask"}

  local str = duedate(1,0,"mon-3wk",09)
  canvas:update_announcement("Welcome to ENG 4002",
    {posted_at=str,delayed_post_at=str})

  local str = duedate(1,0,"mon",09)
  canvas:update_announcement("Completing your Engineering Internship Requirements (Part A)",
    {posted_at=str,delayed_post_at=str})

  for ii = 0,14 do
    local ann = "Week A"..ii.." update"
    if not(canvas.announcements[ann] == nil) then
      local str = duedate(1,ii,"mon",09)
      canvas:update_announcement(ann,{posted_at=str,delayed_post_at=str})
    end
  end

end

print("Update announcement semB dates? 'y' to do so, anything else to skip")
if io.read() == "y" then

  canvas:get_announcements{download="ask"}

  for ii = 1,14 do
    local ann = "Week B"..ii.." update"
    if not(canvas.announcements[ann] == nil) then
      local str = duedate(2,ii,"mon",09)
      canvas:update_announcement(ann,{posted_at=str,delayed_post_at=str})
    end
  end

  local str = duedate(1,0,"mon",09)
  canvas:update_announcement("Completing your Engineering Internship Requirements (Part B)",
    {posted_at=str,delayed_post_at=str})

end



print("Update assignment dates? 'y' to do so, anything else to skip")
if io.read() == "y" then

  canvas:get_assignments{download="ask"}
  canvas:get_quizzes{download="ask"}

  canvas:update_assignment( "Submission: Project plan"  ,                        { due_at = duedate(1, 4,"mon",15) , lock_at = duedate(1, 4,"mon-next",24) } )
  canvas:update_quiz      ( "Submission: Technical Resources Quiz" ,             { due_at = duedate(1, 4,"mon",15) , lock_at = duedate(1, 4,"mon-next",24) } )
  canvas:update_assignment( "Group evaluation - Part A - Formative"  ,           { due_at = duedate(1, 6,"fri",15) , lock_at = duedate(1, 6,"fri-next",24) } )
  canvas:update_assignment( "Submission: Intellectual Property form"  ,          { due_at = duedate(1, 6,"fri",15) , lock_at = duedate(1, 6,"fri-next",24) } )
  canvas:update_assignment( "Seminar details and abstract"  ,                    { due_at = duedate(1, 7,"fri",15) , lock_at = duedate(1, 7,"fri-next",24) } )
  canvas:update_assignment( "Submission: Progress report draft"  ,               { due_at = duedate(1,10,"mon",15) , lock_at = duedate(1,10,"mon-next",24) } )
  canvas:update_assignment( "Submission: Progress report (supervisor assessed)" ,{ due_at = duedate(1,12,"mon",15) , lock_at = duedate(1,12,"mon-next",24) } )
  canvas:update_assignment( "Submission: Progress report (moderator assessed)"  ,{ due_at = duedate(1,12,"mon",15) , lock_at = duedate(1,12,"mon-next",24) } )
  canvas:update_assignment( "Group evaluation - Part A - Progress report"  ,     { due_at = duedate(1,12,"fri",15) , lock_at = duedate(1,12,"fri-next",24) } )
  canvas:update_assignment( "Group evaluation - Part B - Formative"  ,           { due_at = duedate(2, 4,"mon",15) , lock_at = duedate(2, 4,"mon-next",24) } )
  canvas:update_assignment( "Submission: Final report draft"  ,                  { due_at = duedate(2,10,"mon",15) , lock_at = duedate(2,10,"mon-next",24) } )
  canvas:update_assignment( "Submission: Final report (supervisor assessed)"  ,  { due_at = duedate(2,12,"mon",15) , lock_at = duedate(2,12,"mon-next",24) } )
  canvas:update_assignment( "Submission: Final report (moderator assessed)"  ,   { due_at = duedate(2,12,"mon",15) , lock_at = duedate(2,12,"mon-next",24) } )
  canvas:update_assignment( "Group evaluation - Part B - Final report"  ,        { due_at = duedate(2,12,"fri",15) , lock_at = duedate(2,12,"fri-next",24) } )
  canvas:update_assignment( "Submission: Project completion form"  ,             { due_at = duedate(2,14,"fri",15) } )


end

print("Update minutes dates? 'y' to do so, anything else to skip")
if io.read() == "y" then

  canvas:get_assignments{download="cache"}

  canvas:update_assignment( "Submission: Meeting minutes Week A01-A02"  , { due_at = duedate(1, 2,"mon-next",15) ,  lock_at = duedate(1, 2,"mon-next",24)} )
  canvas:update_assignment( "Submission: Meeting minutes Week A03-A04"  , { due_at = duedate(1, 4,"mon-next",15) ,  lock_at = duedate(1, 4,"mon-next",24)} )
  canvas:update_assignment( "Submission: Meeting minutes Week A05-A06"  , { due_at = duedate(1, 6,"mon-next",15) ,  lock_at = duedate(1, 6,"mon-next",24)} )
  canvas:update_assignment( "Submission: Meeting minutes Week A07-A08"  , { due_at = duedate(1, 8,"mon-next",15) ,  lock_at = duedate(1, 8,"mon-next",24)} )
  canvas:update_assignment( "Submission: Meeting minutes Week A09-A10"  , { due_at = duedate(1,10,"mon-next",15) ,  lock_at = duedate(1,10,"mon-next",24)} )
  canvas:update_assignment( "Submission: Meeting minutes Week A11-A12"  , { due_at = duedate(1,12,"mon-next",15) ,  lock_at = duedate(1,12,"mon-next",24)} )
  canvas:update_assignment( "Submission: Meeting minutes Week B01-B02"  , { due_at = duedate(2, 2,"mon-next",15) ,  lock_at = duedate(2, 2,"mon-next",24)} )
  canvas:update_assignment( "Submission: Meeting minutes Week B03-B04"  , { due_at = duedate(2, 4,"mon-next",15) ,  lock_at = duedate(2, 4,"mon-next",24)} )
  canvas:update_assignment( "Submission: Meeting minutes Week B05-B06"  , { due_at = duedate(2, 6,"mon-next",15) ,  lock_at = duedate(2, 6,"mon-next",24)} )
  canvas:update_assignment( "Submission: Meeting minutes Week B07-B08"  , { due_at = duedate(2, 8,"mon-next",15) ,  lock_at = duedate(2, 8,"mon-next",24)} )
  canvas:update_assignment( "Submission: Meeting minutes Week B09-B10"  , { due_at = duedate(2,10,"mon-next",15) ,  lock_at = duedate(2,10,"mon-next",24)} )
  canvas:update_assignment( "Submission: Meeting minutes Week B11-B12"  , { due_at = duedate(2,12,"mon-next",15) ,  lock_at = duedate(2,12,"mon-next",24)} )

end


