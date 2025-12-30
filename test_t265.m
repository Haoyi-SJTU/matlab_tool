close all; clear all; clc;
tic

%% define
% rgb_width = 1280;
% rgb_height = 720;
% rgb_colors = 3;
% 
% depthIM_width = 848;
% depthIM_height = 480;

%% 读取BAG文件
bagfile = rosbag('test_bag.bag');
rosbag info 'test_bag.bag'

% 保存 D435i数据包的AvailableTopics
AvailableTopics_D435i = bagfile.AvailableTopics;
AvailableTopics_D435i{1,1}   % data in table
class(AvailableTopics_D435i)   % "table"

rgb_info = select(bagfile,'Topic','device_0/info')

%提取RGB图像
% % source: https://blog.csdn.net/weixin_42459037/article/details/82772017
% rgb_im = select(bagfile,'Topic','device_0/sensor_1/Color_0/image/data');
% rgb_im_Structs = readMessages(rgb_im,'DataFormat','struct');
% N_rgb = rgb_im.NumMessages;     % RGB影像 帧数
% % x = readMessages(rgb_im,1);   % 单帧影像
% % class(x)
% save_path = strcat('.\RGB_im\');
% 
% for i = 1:N_rgb
%     RGB_im_s = readMessages(rgb_im,i);   % 单帧影像
%     tmp2 = RGB_im_s{1,1}.Data;           % 影像数据
%     imageArrayB = tmp2(1:3:end);
%     imageArrayG = tmp2(2:3:end);
%     imageArrayR = tmp2(3:3:end);
% 
%     imageMatrixB = rot90(flip(reshape(imageArrayB,[rgb_width, rgb_height]), 1),3);
%     imageMatrixG = rot90(flip(reshape(imageArrayG,[rgb_width, rgb_height]), 1),3);
%     imageMatrixR = rot90(flip(reshape(imageArrayR,[rgb_width, rgb_height]), 1),3);
% 
%     % D435i中RGB影像的编码方式是rgb8
%     % 之前，我的错误在于，图像的三位矩阵中，以R、G、B的顺序。正确的顺序是B、G、R
%     imageMatrix = uint8(zeros(rgb_height, rgb_width, rgb_colors));
%     imageMatrix(:,:,1) = imageMatrixB;
%     imageMatrix(:,:,2) = imageMatrixG;
%     imageMatrix(:,:,3) = imageMatrixR;
% 
%     name = num2str(i);
%     imwrite(imageMatrix,strcat(save_path,name,'.jpg'));
%     if mod(i,100)==0
%         disp(['RGB影像数据解析，任务处理进度%：', num2str(i/N_rgb*100)]);
%     end
% end


% 提取深度信息（跟红外影像，同分辨率和频帧）
% depthIm_info = select(bagfile,'Topic','device_0/sensor_0/info')
% 
% % source: https://blog.csdn.net/weixin_42459037/article/details/82772017
% Depth_data = select(bagfile,'Topic','device_0/sensor_0/Depth_0/image/data');
% N_Depth = Depth_data.NumMessages;     % Depth深度影像 帧数
% savepath4Depth = strcat('.\DepthData\');
% for k = 1:N_Depth
%     depth_data_single = readMessages(Depth_data,k);
%     depthArray = depth_data_single{1,1}.Data;
%     % size(depthArray)
% 
%     depthArrayLo = depthArray(1:2:end);
%     % size(depthArrayLo)
%     depthArrayHi = depthArray(2:2:end);
% 
%     depthMatrixLo = rot90(flip(reshape(depthArrayLo,[depthIM_width, depthIM_height]), 1),3);
%     depthMatrixHi = rot90(flip(reshape(depthArrayHi,[depthIM_width, depthIM_height]), 1),3);
% 
%     depthMatrixLo_U16 = uint16(depthMatrixLo(:,51:640));
%     depthMatrixHi_U16 = uint16(depthMatrixHi(:,51:640));
% 
%     depthMatrix_U16 = depthMatrixLo_U16 + (2^8)*depthMatrixHi_U16;
% 
%     % figure
%     % caxis([0 255]);
%     % image(depthMatrixHi_U16,'CDataMapping','scaled');
%     % colorbar
%     % 存储至image文件中
%     name = num2str(k);
%     % help:  https://blog.csdn.net/aaa8493077/article/details/102334855
%     % 示范： imwrite(data11,'image.png','png','bitdepth',16);
%     imwrite(depthMatrix_U16,strcat(savepath4Depth,name,'.png'),'png','bitdepth',16);
% 
%     if mod(k,500)==0
%         disp(['深度数据解析，任务处理进度%：', num2str(k/N_Depth*100)]);
%     end
% end


% 提取IMU数据
% % source: https://blog.csdn.net/weixin_42459037/article/details/82772017
% imu_im = select(bagfile,'Topic','device_0/sensor_2/Accel_0/imu/data');
% N_imu = imu_im.NumMessages;     % IMU数据 帧数
% x = readMessages(imu_im,1);     % 单帧  IMU
% x;   %

% for j = 1: N_imu
%     imu_im_s = readMessages(imu_im,j);     % 单帧 IMU数据
%     % Orientation
%     % tmp2 = imu_im_s{i,1}     ;           % Cell结构
%     Orientation_matrix(j,1) = imu_im_s{1,1}.Orientation.X; % Orientation: 4 * 1 (x,y,z,w)
%     Orientation_matrix(j,2) = imu_im_s{1,1}.Orientation.Y; % Orientation: 4 * 1 (x,y,z,w)
%     Orientation_matrix(j,3) = imu_im_s{1,1}.Orientation.Z; % Orientation: 4 * 1 (x,y,z,w)
%     Orientation_matrix(j,4) = imu_im_s{1,1}.Orientation.W; % Orientation: 4 * 1 (x,y,z,w)
% 
%     AngularVelocity_matrix(j,1) = imu_im_s{1,1}.AngularVelocity.X; % 3 * 1 (x,y,z)
%     AngularVelocity_matrix(j,2) = imu_im_s{1,1}.AngularVelocity.Y; % 3 * 1 (x,y,z)
%     AngularVelocity_matrix(j,3) = imu_im_s{1,1}.AngularVelocity.Z; % 3 * 1 (x,y,z)
% 
%     LinearAcceleration_matrix(j,1) = imu_im_s{1,1}.LinearAcceleration.X; % 3 * 1 (x,y,z)
%     LinearAcceleration_matrix(j,2) = imu_im_s{1,1}.LinearAcceleration.Y; % 3 * 1 (x,y,z)
%     LinearAcceleration_matrix(j,3) = imu_im_s{1,1}.LinearAcceleration.Z; % 3 * 1 (x,y,z)
% 
%     OrientationCovariance_matrix(j,:) = [imu_im_s{1,1}.OrientationCovariance]'; % 9 * 1
%     AngularVelocityCovariance_matrix(j,:) = [imu_im_s{1,1}.AngularVelocityCovariance]';  % 9 * 1
%     LinearAccelerationCovariance_matrix(j,:) = [imu_im_s{1,1}.LinearAccelerationCovariance]';  % 9 * 1
%     if mod(j,100)==0
%         disp(['IMU数据解析，任务处理进度%：', num2str(j/N_imu*100)]);
%     end
% end