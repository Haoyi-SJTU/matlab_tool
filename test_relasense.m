
pipe = realsense.pipeline();% Make Pipeline object to manage streaming
colorizer = realsense.colorizer();% Make Colorizer object to prettify depth output

profile = pipe.start();% 使用默认设置在任意摄像机上传输
dev = profile.get_device();% Get streaming device's name
name = dev.get_info(realsense.camera_info.name);

figure;

% 获取帧。丢弃前几个，让相机时间稳定下来
for i = 1:500
    fs = pipe.wait_for_frames();
    depth = fs.get_depth_frame(); % Select depth frame
    % color = colorizer.colorize(depth);% Colorize depth frame
    % % Get actual data and convert into a format imshow can use
    % % (Color data arrives as [R, G, B, R, G, B, ...] vector)
    % data = color.get_data();
    % img = permute(reshape(data',[3,color.get_width(),color.get_height()]),[3 2 1]);
    % % Display image
    % imshow(img);
    % pause(0.05);
    % title(sprintf("Colorized depth frame from %s", name));
    % hold on;
end
pipe.stop();% Stop
