oringin_data_dir=./test

for file in $oringin_data_dir/*
do
	echo $file
	if [ ! -d $file ] &&  [ ${file:0-2:2} == "gz" ];
	then

		mv $file $oringin_data_dir"/prediction_"${file##*/}
	fi
done
cd $oringin_data_dir 
zip predictions.zip prediction_*.nii.gz
