function crop_video()
    local screen_width = mp.get_property_number("osd-width")
    local screen_height = mp.get_property_number("osd-height")
    local video_width = mp.get_property_number("width")
    local video_height = mp.get_property_number("height")

    local target_aspect_ratio = 4 / 3
    local video_aspect_ratio = video_width / video_height

    local crop_width, crop_height, crop_x, crop_y

    if video_aspect_ratio > target_aspect_ratio then
        crop_height = video_height
        crop_width = math.floor(video_height * target_aspect_ratio)
        crop_x = math.floor((video_width - crop_width) / 2)
        crop_y = 0
    else
        crop_width = video_width
        crop_height = math.floor(video_width / target_aspect_ratio)
        crop_x = 0
        crop_y = math.floor((video_height - crop_height) / 2)
    end

    local crop_command = string.format("crop=%d:%d:%d:%d", crop_width, crop_height, crop_x, crop_y)
    mp.set_property("video-zoom", 0)
    mp.set_property("video-align-x", 0)
    mp.set_property("video-align-y", 0)
    mp.set_property("vf", crop_command)
end

mp.register_event("file-loaded", crop_video)
mp.register_event("window-resize", crop_video)