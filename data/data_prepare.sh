# =================== settings =====================
oringin_data_dir=/mnt/sda2/kits19/data
current_data_dir=`pwd`

training_image_dir=$current_data_dir"/imagesTr"
training_label_dir=$current_data_dir"/labelsTr"
testing_image_dir=$current_data_dir"/imagesTs"

test_idx=209


# =============== file re-ordering =================
time=$(date "+%Y-%m-%d %H:%M:%S")
echo -e "\033[33m ${time}:Data from kits19 will be re-ordered and stored here (`pwd`) only by soft-link \033[0m"


if [ ! -d $training_image_dir ];then
  mkdir $training_image_dir
  else
  echo "folder already exist"
fi

if [ ! -d $training_label_dir ];then
  mkdir $training_label_dir
  else
  echo "folder already exist"
fi

if [ ! -d $testing_image_dir ];then
  mkdir $testing_image_dir
  else
  echo "folder already exist"
fi

for file in $oringin_data_dir/*
do
	if test -d $file
	then
		cd $file
		imaging_file=`ls *imaging*`
		if [ ${file:0-5:5} -gt $test_idx ];then
			echo "link to testing case in "${file}
			ln -s ${file}"/"${imaging_file} ${testing_image_dir}"/"${file##*/}"_imaging.nii.gz"
		else
			echo "link to traing case in "${file}
			segmentation_file=`ls segmentation*`
			ln -s ${file}"/"${imaging_file} ${training_image_dir}"/"${file##*/}"_imaging.nii.gz"
			ln -s ${file}"/"${segmentation_file} ${training_label_dir}"/"${file##*/}"_segmentation.nii.gz"
		fi
	fi
done
