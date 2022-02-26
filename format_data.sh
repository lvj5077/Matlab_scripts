base_dir="/Volumes/black_2T/Dreame/testDataTwoCam/data/short2"
updata_dir="/Volumes/black_2T/Dreame/testDataTwoCam/data/temp/up"
dndata_dir="/Volumes/black_2T/Dreame/testDataTwoCam/data/temp/down"

mkdir -p $base_dir

cp -r /Users/jin/Desktop/Dreame/template/ $base_dir

mv $updata_dir"/cam0_d455/" $base_dir"/up/d455/"
mv $updata_dir"/cam1_d455" $base_dir"/up/d455/"
mv $updata_dir"/cam0_t265" $base_dir"/up/t265/"
mv $updata_dir"/cam1_t265" $base_dir"/up/t265/"
mv $updata_dir"/cam0_fisheye" $base_dir"/top/"

cp $updata_dir"/timestamp_d455.txt" $base_dir"/up/d455/timestamp.txt"
cp $updata_dir"/timestamp_t265.txt" $base_dir"/up/t265/timestamp.txt"
cp $updata_dir"/timestamp_fisheye.txt" $base_dir"/top/timestamp.txt"

mv $dndata_dir"/cam0_d455" $base_dir"/down/d455/"
mv $dndata_dir"/cam1_d455" $base_dir"/down/d455/"
mv $dndata_dir"/cam0_t265" $base_dir"/down/t265/"
mv $dndata_dir"/cam1_t265" $base_dir"/down/t265/"

cp $dndata_dir"/timestamp_d455.txt" $base_dir"/down/d455/timestamp.txt"
cp $dndata_dir"/timestamp_t265.txt" $base_dir"/down/t265/timestamp.txt"