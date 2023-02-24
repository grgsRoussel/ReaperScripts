--[[ This code create HOA bus from selected tracks --]]


-- User Params
HOAOrder = 3

_ , UserInputs = reaper.GetUserInputs( "HOA Order (Max Order = 7)", 1 , "HOA Order", HOAOrder)

HOAOrder = tonumber(UserInputs)


MaxChannelCountPerBus = 64
-- Get tracks from selection

OpenReceiveActionID = 40293

trackSelCount = reaper.CountSelectedTracks()

nb_channels = 0

for ti=0,trackSelCount-1 do
  CurTrack = reaper.GetSelectedTrack(0, ti)
  
  nb_channels = nb_channels + reaper.GetMediaTrackInfo_Value(CurTrack, "I_NCHAN")
  reaper.SetMediaTrackInfo_Value(CurTrack, "B_MAINSEND", 0)
  
end

-- create HOA Bus
HOAMinChannel = (HOAOrder + 1)^2

nbTotTracks = reaper.CountTracks(0)
HOATrackIdx = nbTotTracks
reaper.InsertTrackAtIndex(HOATrackIdx, false)
HOATrack = reaper.GetTrack(0, HOATrackIdx)

reaper.GetSetMediaTrackInfo_String(HOATrack, "P_NAME", "HOA_Bus", true)

reaper.SetTrackColor(HOATrack, reaper.ColorToNative(0,127,127))

HOABusChannels = math.floor(math.max(HOAMinChannel,nb_channels))

if(HOABusChannels > MaxChannelCountPerBus)
 then
  reaper.ShowMessageBox("Total Number of channel exceed MaxChannelCountPerBus \n ( ".. HOABusChannels .."/ ".. MaxChannelCountPerBus ..
  " Channels)  \n \n Some channels may not be mapped correctly ! \n \n You may reduce HOA Order or deselect some tracks .", "WARNING !", 0)

end

 reaper.SetMediaTrackInfo_Value(HOATrack, "I_NCHAN" , HOABusChannels)  -- change channel count to match channel count or HOAOrder

-- Create sends from selected tracks to HOA Bus

for ti=0,trackSelCount-1 do
  CurTrack = reaper.GetSelectedTrack(0, ti)
  reaper.CreateTrackSend(CurTrack, HOATrack )
end

-- Open Send Receive Window for HOA Bus
reaper.SetOnlyTrackSelected(HOATrack)
reaper.Main_OnCommandEx(OpenReceiveActionID, 0)



