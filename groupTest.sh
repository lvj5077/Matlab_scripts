# rural_straight
# rural_follow_passage
# rural_follow_wall
# rural_turn
# rural_turn_wall



output_dir="/Users/jin/Desktop/Dreame/Code/frontend_analysis/output"

# rm -r $output_dir
# mkdir -p $output_dir
# scene="/short1"



for scene in "long2" #"short1" "short2" "long1" 
do
	data_dir="/Volumes/black_2T/Dreame/testDataTwoCam/data/"$scene
	mkdir -p $output_dir"/"$scene
	for camera in "top" "down/t265" "up/t265" "down/d455" "up/d455" 
	do
		for stepN in 1 #1 2 
		do
			for cutN in 1 #1 2 3
			do
				/Users/jin/Desktop/Dreame/Code/frontend_analysis/bin/startTest $data_dir"/"$camera $cutN $stepN
				dest_dir=$output_dir"/"$scene"/"$camera"/cut"$cutN"_step"$stepN
				mkdir -p $dest_dir
				mv $output_dir/checkFeatureDetection.png $output_dir/checkStereo.png $output_dir/checkLifespan.png $output_dir/BAverify.txt $output_dir/GoodFeature.txt \
				$output_dir/checkLifespan.txt $output_dir/timestamp.txt $output_dir/checkRANSAC.png $output_dir/checkTracking.png $dest_dir
			done
		done
	done

done

# zip -r $output_dir$scene".zip" $output_dir$scene
# mv $output_dir$scene".zip" "/Volumes/black_2T/Dreame/testDataTwoCam/results"$scene".zip"
# mv $output_dir$scene "/Volumes/black_2T/Dreame/testDataTwoCam/results/"