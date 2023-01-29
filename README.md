# Vessel detection in colour eye fundus images


Eye fundus images are photographs of the retina (i.e. the fundus of the eye). They are captured by ophthalmologists with a specialised camera. In these images, ophthalmologist are looking for vessels and lesions that are related fro example to diabetic retinopathy or to maculopathy.
The images present contains vessels (which include veins and arteries) that must be detected for further analysis.
The aim of this project is to segment the vessels in these images and compare it to the ground-truth.

The train set is composed of 20 images with their ground-truth given by experts.

The project is divided in two folders:

## Code : for the code. This directory contains:
	- a MATLAB file "Script_Analysis_EyeFundusImages.m" which is the script that you will use. 
	To run this script, the MATLAB working directory must be set at the path of this directory 
	(e.g. .../Name-TPX/Code);
	- a directory named "Functions" with the MATLAB functions.

## Data : for the data. This directory contains:
	- a directory named "InputData" with the input dataset. This directory contains:
		* a directory named "training" with the train set of the DRIVE database. This directory contains:
			# a directory named "1st_manual" with the reference segmentation given by an expert;
			# a directory named "images" with the eye funuds images to be processed;
	- a directory named "Res" wherev you will write your results.

