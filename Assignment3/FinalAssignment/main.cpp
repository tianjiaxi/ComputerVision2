#include <iostream>
#include <vector>
#include <pcl/point_types.h>
#include <pcl/point_cloud.h>
#include <opencv2/core/core.hpp>
#include <opencv2/highgui/highgui.hpp>
#include <opencv2/core/mat.hpp>
#include <opencv2/core/eigen.hpp>
#include <Frame3D.h>
#include <FileUtils.h>
#include <FileUtils.cpp>
#include <Frame3D.h>

using namespace cv;
using namespace std;

//utils::
pcl::PointCloud<pcl::PointXYZ> ::Ptr Mat2IntegralPointCloud( const cv::Mat& depth_mat, const float focal_length, const float max_depth)
{
assert(depth_mat.type() == CV_16U);
pcl::PointCloud<pcl::PointXYZ> ::Ptr point_cloud(new pcl::PointCloud<pcl::PointXYZ> ());
const int half_width = depth_mat.cols / 2;
const int half_height = depth_mat.rows / 2;
const float inv_focal_length = 1.0 / focal_length;
point_cloud->points.reserve( depth_mat.rows * depth_mat.cols);

for (int y = 0; y < depth_mat.rows; y++) {
    for (int x = 0; x < depth_mat.cols; x++) {
        float z = depth_mat.at<ushort>(cv:: Point(x, y)) * 0.001;
        if (z < max_depth && z > 0) {
            point_cloud->points.emplace_back(static_cast<float>(x - half_width)  * z * inv_focal_length,
             static_cast<float>(y - half_height) * z * inv_focal_length,
             z);
        } else {
            point_cloud->points.emplace_back(x,y,NAN);
        }
    }
}

point_cloud->width = depth_mat.cols;
point_cloud->height = depth_mat.rows;
return point_cloud;
}

int main()
{
    //for (int i=0; i < 8; ++i) {
    //    std::cout << "../3dframes/" << "0000" << i << ".3df" << endl;
    //
    //}
    std::vector<Frame3D> frames;
    std::string frame_dir_path = "../3dframes/";

    frames = Frame3D::loadFrames(frame_dir_path);
    return 0;
}
