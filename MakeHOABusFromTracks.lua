--[[ This code create HOA bus from selected tracks --]]


-- User Params
HOAOrder = 3

-- Get tracks from selection
trackSelCount = reaper.CountSelectedTracks()

nb_channels = 0

for ti=0,trackSelCount-1 do
  CurTrack = reaper.GetSelectedTrack(0, ti)
  
  nb_channels = nb_channels + reaper.GetMediaTrackInfo_Value(CurTrack, "I_NCHAN")
  reaper.SetMediaTrackInfo_Value(CurTrack, "B_MAINSEND", 0)
  
end

-- TODO : CREATE ERROR MESSAGE IF CHANNEL COUNT TO HIGH

-- create HOA Bus
HOAMinChannel = (HOAOrder + 1)^2

nbTotTracks = reaper.CountTracks(0)
HOATrackIdx = nbTotTracks
reaper.InsertTrackAtIndex(HOATrackIdx, false)
HOATrack = reaper.GetTrack(0, HOATrackIdx)

reaper.GetSetMediaTrackInfo_String(HOATrack, "P_NAME", "HOA_Bus", true)

reaper.SetTrackColor(HOATrack, reaper.ColorToNative(0,127,127))

HOABusChannels = math.max(HOAMinChannel,nb_channels)

reaper.SetMediaTrackInfo_Value(HOATrack, "I_NCHAN" , HOABusChannels)  -- change channel count to match channel count or HOAOrder

-- Create sends from selected tracks to HOA Bus

for ti=0,trackSelCount-1 do
  CurTrack = reaper.GetSelectedTrack(0, ti)
  
end


